Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD25755399
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGPUUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGPUUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3630126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6266E60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB8FC433C8;
        Sun, 16 Jul 2023 20:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538847;
        bh=G3ylqh69nfF3OpmlpvALLxUEzrfgD5fwzWFe6tDaFDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgSHA3mdVaaSO876HcHsLmrhBBL+ar2dIvCbyLYJxidt+o1XJGukI709hVITm8KT1
         ntij/3Rhw6OQopUZgYIVmAZOHTCV6nlil7iqUffPXXADpoB2g/4U0qVtcUb5GxsEym
         L4eTTaD/HrYmbFRojiJ98Ew3klnp8Ir5WRBKGGbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Lundberg Pedersen <dlp@qtec.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 569/800] media: videodev2.h: Fix p_s32 and p_s64 pointer types
Date:   Sun, 16 Jul 2023 21:47:02 +0200
Message-ID: <20230716195002.303729430@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Lundberg Pedersen <dlp@qtec.com>

[ Upstream commit 3f6375a2d1956739c6c8ffa3a862c9278d346940 ]

Use the intended pointer types for p_s32 and p_64 in the union of the
struct v4l2_ext_control.

Fixes: e77eb66342c7 ("videodev2.h: add p_s32 and p_s64 pointers")
Signed-off-by: Daniel Lundberg Pedersen <dlp@qtec.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/videodev2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index aee75eb9e6863..9e7cf1d369456 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1807,8 +1807,8 @@ struct v4l2_ext_control {
 		__u8 __user *p_u8;
 		__u16 __user *p_u16;
 		__u32 __user *p_u32;
-		__u32 __user *p_s32;
-		__u32 __user *p_s64;
+		__s32 __user *p_s32;
+		__s64 __user *p_s64;
 		struct v4l2_area __user *p_area;
 		struct v4l2_ctrl_h264_sps __user *p_h264_sps;
 		struct v4l2_ctrl_h264_pps *p_h264_pps;
-- 
2.39.2



