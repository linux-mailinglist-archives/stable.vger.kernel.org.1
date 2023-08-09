Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1D77594F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjHIK7X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjHIK7W (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE71FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C1762BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878AFC433C8;
        Wed,  9 Aug 2023 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578760;
        bh=fuAG/aautlX2TX97i0dkGrXJEbWc0zxu6wDrDAaaX0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZL82Kp+einTvo+dg3IJ82oDKAka8kefvXdggYI00zaU7eVeK76Funf8G48GRwhAo
         B2zLB1KB59BAyr7N7FINGCVsQDpJ3vP26rfAJaqu39DPTwjFfJj2SQw4sKNVSA85Ow
         ErgHLwoBebNPb/2lOBeP07tEJsSjdoEZr/GECwoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@bisdn.de>,
        Elad Nachman <enachman@marvell.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 47/92] prestera: fix fallback to previous version on same major version
Date:   Wed,  9 Aug 2023 12:41:23 +0200
Message-ID: <20230809103635.230116892@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonas Gorski <jonas.gorski@bisdn.de>

[ Upstream commit b755c25fbcd568821a3bb0e0d5c2daa5fcb00bba ]

When both supported and previous version have the same major version,
and the firmwares are missing, the driver ends in a loop requesting the
same (previous) version over and over again:

    [   76.327413] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   76.339802] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.352162] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.364502] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.376848] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.389183] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.401522] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.413860] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.426199] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    ...

Fix this by inverting the check to that we aren't yet at the previous
version, and also check the minor version.

This also catches the case where both versions are the same, as it was
after commit bb5dbf2cc64d ("net: marvell: prestera: add firmware v4.0
support").

With this fix applied:

    [   88.499622] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   88.511995] Prestera DX 0000:01:00.0: failed to request previous firmware: mrvl/prestera/mvsw_prestera_fw-v4.0.img
    [   88.522403] Prestera DX: probe of 0000:01:00.0 failed with error -2

Fixes: 47f26018a414 ("net: marvell: prestera: try to load previous fw version")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
Acked-by: Elad Nachman <enachman@marvell.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Taras Chornyi <taras.chornyi@plvision.eu>
Link: https://lore.kernel.org/r/20230802092357.163944-1-jonas.gorski@bisdn.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index a8d7b889ebeee..6bef633aa6330 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -645,7 +645,8 @@ static int prestera_fw_get(struct prestera_fw *fw)
 
 	err = request_firmware_direct(&fw->bin, fw_path, fw->dev.dev);
 	if (err) {
-		if (ver_maj == PRESTERA_SUPP_FW_MAJ_VER) {
+		if (ver_maj != PRESTERA_PREV_FW_MAJ_VER ||
+		    ver_min != PRESTERA_PREV_FW_MIN_VER) {
 			ver_maj = PRESTERA_PREV_FW_MAJ_VER;
 			ver_min = PRESTERA_PREV_FW_MIN_VER;
 
-- 
2.40.1



