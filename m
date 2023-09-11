Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C379BACE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbjIKVHs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjIKOxn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2A118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F6C433C8;
        Mon, 11 Sep 2023 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444019;
        bh=iZkrdpgftTl08C/9zbvSMNSbFqyGo+asS9E+jf0kub0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b11r/IjIfayX6s+j0J9DUuX8vAj3Cqsjwvvw2i4Fs4Lnykulkk6f+IZqze4HJAkqr
         2V0T/EizX0x3PgkDngd8NIQGFE7gBQfYWSuSD6NRC3GK9f1bhjHT2+oHJAjOMotRKg
         foaebINdJnSNIvr5IjRtuyqsOZyqhiHJ9KjPmmSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 553/737] arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA
Date:   Mon, 11 Sep 2023 15:46:52 +0200
Message-ID: <20230911134706.004516826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 0ca2fbab99b12bb81fceaafe5495c00d76789a37 ]

CONFIG_VIDEO_IMX_MEDIA isn't needed on arm64 platforms since commit
9f257f502c2e ("media: imx: Unstage the imx7-media-csi driver") which
moved the last arm64 driver depending on that Kconfig symbol out of
staging. Drop it from the arm64 defconfig.

Fixes: 9f257f502c2e ("media: imx: Unstage the imx7-media-csi driver")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3cea343a4c3d..fdfe54f35cf8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1107,7 +1107,6 @@ CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
-CONFIG_VIDEO_IMX_MEDIA=m
 CONFIG_VIDEO_MAX96712=m
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
-- 
2.40.1



