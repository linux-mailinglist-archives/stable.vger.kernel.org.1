Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69C77ABA9
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHMVYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHMVYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE810DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B76628E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B715C433C7;
        Sun, 13 Aug 2023 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961861;
        bh=HXglDCR0bXRO0+kfU3gmDgzDz5YsPpMcER/unWMgpKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgMZHiWdlW9E6xizzZLyVwm6aSy+tf74A4MC1rcRbF5WepsVZtvpWnws++Dbl9w2K
         iEp3H9HbYGeGc0R/s66vMQhi9ofXiK7k7PhleBu5zQwFmPBsLrOEYe1NvjCEhCz3Vg
         sWwCaYVD0P+YFtLhBg+LNtM9IszqyPKM2kekH0JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan McDowell <noodles@meta.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 003/206] tpm/tpm_tis: Disable interrupts for Lenovo P620 devices
Date:   Sun, 13 Aug 2023 23:16:13 +0200
Message-ID: <20230813211725.072395309@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Jonathan McDowell <noodles@meta.com>

commit e117e7adc637e364b599dc766f1d740698e7e027 upstream.

The Lenovo ThinkStation P620 suffers from an irq storm issue like various
other Lenovo machines, so add an entry for it to tpm_tis_dmi_table and
force polling.

It is worth noting that 481c2d14627d (tpm,tpm_tis: Disable interrupts after
1000 unhandled IRQs) does not seem to fix the problem on this machine, but
setting 'tpm_tis.interrupts=0' on the kernel command line does.

[jarkko@kernel.org: truncated the commit ID in the description to 12
characters]
Cc: stable@vger.kernel.org # v6.4+
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -164,6 +164,14 @@ static const struct dmi_system_id tpm_ti
 	},
 	{
 		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P620",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
+		},
+	},
+	{
+		.callback = tpm_tis_disable_irq,
 		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),


