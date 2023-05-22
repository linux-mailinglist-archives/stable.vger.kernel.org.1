Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF070CA0F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjEVTya (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjEVTy3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0667F95
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9008C62B68
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF45CC433EF;
        Mon, 22 May 2023 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785268;
        bh=QrCSDrnby/P7VpBpaW/a1mmjlKr+8oDMqe+xJkOiMu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPDBVSjKIyNvJDKUMCwq+EMr0+RmudGHCnNEtOf3It8D+8ah4h8nR7uI015jAeA3W
         kKQlfU07OBhe3ZaANfIpumBafueoy0f+Ke8+mK9iWE0X608BOU/FSCEq01EMqxhI7q
         +0w1DZ/B11kfdPS3M1FLqQ5eZwJ6lb2VJSyogWmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.3 347/364] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Date:   Mon, 22 May 2023 20:10:52 +0100
Message-Id: <20230522190421.463198357@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

commit e7d3e5c4b1dd50a70b31524c3228c62bb41bbab2 upstream.

The P360 Tiny suffers from an irq storm issue like the T490s, so add
an entry for it to tpm_tis_dmi_table, and force polling. There also
previously was a report from the previous attempt to enable interrupts
that involved a ThinkPad L490. So an entry is added for it as well.

Cc: stable@vger.kernel.org
Reported-by: Peter Zijlstra <peterz@infradead.org> # P360 Tiny
Closes: https://lore.kernel.org/linux-integrity/20230505130731.GO83892@hirez.programming.kicks-ass.net/
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -83,6 +83,22 @@ static const struct dmi_system_id tpm_ti
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P360 Tiny",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
+		},
+	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad L490",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
+		},
+	},
 	{}
 };
 


