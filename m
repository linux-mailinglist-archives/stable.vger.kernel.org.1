Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB556713CD9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjE1TTN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjE1TTN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F88A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1425161A8B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AAFC433D2;
        Sun, 28 May 2023 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301551;
        bh=1QDPKVswq73fwiya8lW2M9dHLicBA+Ah42wWJ0CXtWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSg1/y7XM8oiMfPTsL2HI1da5C3Bjl7PCX6g4npqm5oFyeruTeEN7VrzxX0oAuKpV
         VLMqG8tLlWxNTGbhycaSs3qXVVgHxWUf1PLC0sJAgwbFNlmCpEoxv6AcQx6M9sB5yY
         adKrDnumUNm9ewmtXhMSXDe/q98rI2qCR42pYAY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.19 074/132] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Date:   Sun, 28 May 2023 20:10:13 +0100
Message-Id: <20230528190835.795158741@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
@@ -87,6 +87,22 @@ static const struct dmi_system_id tpm_ti
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
 


