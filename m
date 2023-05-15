Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA623703601
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbjEORFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjEORFB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7625CA27B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BCB62A83
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949FCC433D2;
        Mon, 15 May 2023 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170193;
        bh=TPCEFs6Gs0KWg4bFSeNpTS70JR5mYKAK7iYjeH5spc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mh4GlOvMVqmJUEx5sEcfAd4mr2gT0XxxgVl4tiijT3+LO9MItX7+FrfXsTVbttvpr
         6yJFe1ceP4iMpgpfePuwo7xuCwKJTumGfa2nMw5Z9M9tc7bcLM3noTJqiKIZJ1Ek1C
         cz8q77B/znF3G0yvl7FpWA8U8nWufH++dtKYmpuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/239] ASoC: Intel: soc-acpi-byt: Fix "WM510205" match no longer working
Date:   Mon, 15 May 2023 18:24:48 +0200
Message-Id: <20230515161722.343995397@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c963e2ec095cb3f855890be53f56f5a6c6fbe371 ]

Commit 7e1d728a94ca ("ASoC: Intel: soc-acpi-byt: Add new WM5102 ACPI HID")
added an extra HID to wm5102_comp_ids.codecs, but it forgot to bump
wm5102_comp_ids.num_codecs, causing the last codec HID in the codecs list
to no longer work.

Bump wm5102_comp_ids.num_codecs to fix this.

Fixes: 7e1d728a94ca ("ASoC: Intel: soc-acpi-byt: Add new WM5102 ACPI HID")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230421183714.35186-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-byt-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index db5a92b9875a8..87c44f284971a 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -124,7 +124,7 @@ static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
 };
 
 static const struct snd_soc_acpi_codecs wm5102_comp_ids = {
-	.num_codecs = 2,
+	.num_codecs = 3,
 	.codecs = { "10WM5102", "WM510204", "WM510205"},
 };
 
-- 
2.39.2



