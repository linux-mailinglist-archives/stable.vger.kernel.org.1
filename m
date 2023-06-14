Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062CE726EB0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjFGUwF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjFGUv5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4F1BF0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED2064753
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A38C433D2;
        Wed,  7 Jun 2023 20:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171113;
        bh=ukY5IaZOltv/5bgpz5UzECc+kBOxfziILZkJS2cerCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNddEUsGYG25uS6qtvTTi/rzq/iJ6Q5OQXMO4tLUFU4jbhVhsrPmb8Hwu07bMNwUe
         UmCZv2kV74GWt1clKybIVyH7CVVWE8cG1zX/VqHf/PA5XuHq6tpsEfh/CQPpoJvaa2
         tD96WkghgoDiRivHqaunu5lT21hGPuplqwvPOego=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.10 115/120] crypto: ccp: Play nice with vmallocd memory for SEV command structs
Date:   Wed,  7 Jun 2023 22:17:11 +0200
Message-ID: <20230607200904.553996090@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 8347b99473a313be6549a5b940bc3c56a71be81c upstream.

Copy the incoming @data comman to an internal buffer so that callers can
put SEV command buffers on the stack without running afoul of
CONFIG_VMAP_STACK=y, i.e. without bombing on vmalloc'd pointers.  As of
today, the largest supported command takes a 68 byte buffer, i.e. pretty
much every command can be put on the stack.  Because sev_cmd_mutex is
held for the entirety of a transaction, only a single bounce buffer is
required.

Use the internal buffer unconditionally, as the majority of in-kernel
users will soon switch to using the stack.  At that point, checking
virt_addr_valid() becomes (negligible) overhead in most cases, and
supporting both paths slightly increases complexity.  Since the commands
are all quite small, the cost of the copies is insignificant compared to
the latency of communicating with the PSP.

Allocate a full page for the buffer as opportunistic preparation for
SEV-SNP, which requires the command buffer to be in firmware state for
commands that trigger memory writes from the PSP firmware.  Using a full
page now will allow SEV-SNP support to simply transition the page as
needed.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210406224952.4177376-5-seanjc@google.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/sev-dev.c |   28 +++++++++++++++++++++++-----
 drivers/crypto/ccp/sev-dev.h |    2 ++
 2 files changed, 25 insertions(+), 5 deletions(-)

--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -170,12 +170,17 @@ static int __sev_do_cmd_locked(int cmd,
 	if (WARN_ON_ONCE(!data != !buf_len))
 		return -EINVAL;
 
-	if (data && WARN_ON_ONCE(!virt_addr_valid(data)))
-		return -EINVAL;
+	/*
+	 * Copy the incoming data to driver's scratch buffer as __pa() will not
+	 * work for some memory, e.g. vmalloc'd addresses, and @data may not be
+	 * physically contiguous.
+	 */
+	if (data)
+		memcpy(sev->cmd_buf, data, buf_len);
 
 	/* Get the physical address of the command buffer */
-	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
-	phys_msb = data ? upper_32_bits(__psp_pa(data)) : 0;
+	phys_lsb = data ? lower_32_bits(__psp_pa(sev->cmd_buf)) : 0;
+	phys_msb = data ? upper_32_bits(__psp_pa(sev->cmd_buf)) : 0;
 
 	dev_dbg(sev->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
 		cmd, phys_msb, phys_lsb, psp_timeout);
@@ -219,6 +224,13 @@ static int __sev_do_cmd_locked(int cmd,
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
 			     buf_len, false);
 
+	/*
+	 * Copy potential output from the PSP back to data.  Do this even on
+	 * failure in case the caller wants to glean something from the error.
+	 */
+	if (data)
+		memcpy(data, sev->cmd_buf, buf_len);
+
 	return ret;
 }
 
@@ -979,6 +991,10 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev)
 		goto e_err;
 
+	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!sev->cmd_buf)
+		goto e_sev;
+
 	psp->sev_data = sev;
 
 	sev->dev = dev;
@@ -990,7 +1006,7 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev->vdata) {
 		ret = -ENODEV;
 		dev_err(dev, "sev: missing driver data\n");
-		goto e_sev;
+		goto e_buf;
 	}
 
 	psp_set_sev_irq_handler(psp, sev_irq_handler, sev);
@@ -1005,6 +1021,8 @@ int sev_dev_init(struct psp_device *psp)
 
 e_irq:
 	psp_clear_sev_irq_handler(psp);
+e_buf:
+	devm_free_pages(dev, (unsigned long)sev->cmd_buf);
 e_sev:
 	devm_kfree(dev, sev);
 e_err:
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -51,6 +51,8 @@ struct sev_device {
 	u8 api_major;
 	u8 api_minor;
 	u8 build;
+
+	void *cmd_buf;
 };
 
 int sev_dev_init(struct psp_device *psp);


