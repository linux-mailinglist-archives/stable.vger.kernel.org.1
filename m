Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DB77AB97
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHMVXe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjHMVXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A7010DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9672462890
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C83C433C7;
        Sun, 13 Aug 2023 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961815;
        bh=VYffoFa1P89M3jpYt6WZK7qm30iMTQN5Kd5QW2phFPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltntMl42aSC9kx62444bVkGySV20RolphZDjw/qKVywNDedK56hf4AAvXGYu176SL
         saKILg6UvgmY685f2qACzHaRK4xRs7UsS9/HkI5HUadhXRPwSXqUcRAeoU5vlwtup+
         dr16yL4dEzLOuza/Utf0YBajdposkKpGSl/BBAzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 001/206] tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7
Date:   Sun, 13 Aug 2023 23:16:11 +0200
Message-ID: <20230813211725.016943773@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 0b15afc9038146bb2009e7924b1ead2e919b2a56 upstream.

TUXEDO InfinityBook S 15/17 Gen7 suffers from an IRQ problem on
tpm_tis like a few other laptops.  Add an entry for the workaround.

Cc: stable@vger.kernel.org
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1213645
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index cc42cf3de960..a98773ac2e55 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "UPX-TGL",
-- 
2.41.0



