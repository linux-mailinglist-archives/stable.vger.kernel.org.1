Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4F7E2325
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKFNJR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjKFNJQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:09:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863791
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:09:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C6C433C8;
        Mon,  6 Nov 2023 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276154;
        bh=TjbzbevQ5e4lVQmHt6pnKS0pXzAyxgRfxQewyZqpp+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLVXknMGtB9yFJqMlsDd0Ib6gbFDdF7vw/iRxnU8WtcEa0pRoCXk2tzV+jICFjWew
         n6OxYO+tUD15po+ZKWTopkNZvNWqGpskXXJs58LcPuHmsh4VpKZWDVhvp015DrCUM+
         N4cW7g2jHGRKDdp4m4JOFmI5qzMu6jAYFOknQPs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Hasemeyer <markhas@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 30/30] ASoC: SOF: sof-pci-dev: Fix community key quirk detection
Date:   Mon,  6 Nov 2023 14:03:48 +0100
Message-ID: <20231106130258.936216794@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Hasemeyer <markhas@chromium.org>

commit 7dd692217b861a8292ff8ac2c9d4458538fd6b96 upstream.

Some Chromebooks do not populate the product family DMI value resulting
in firmware load failures.

Add another quirk detection entry that looks for "Google" in the BIOS
version. Theoretically, PRODUCT_FAMILY could be replaced with
BIOS_VERSION, but it is left as a quirk to be conservative.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Acked-by: Curtis Malainey <cujomalainey@chromium.org>
Link: https://lore.kernel.org/r/20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/sof-pci-dev.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -145,6 +145,13 @@ static const struct dmi_system_id commun
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
 		}
 	},
+	{
+		.ident = "Google firmware",
+		.callback = chromebook_use_community_key,
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+		}
+	},
 	{},
 };
 


