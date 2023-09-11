Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052779B01D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjIKV6y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbjIKPCI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:02:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09E1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:02:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40285C433C9;
        Mon, 11 Sep 2023 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444523;
        bh=Y8VnIeHJk7nfX7Oi5DUWceZHLg5jZDw4gKYuHrMqIZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoESj9hQba+6Gvbcyoi+Px6LoonNxiWLTmbSCz/I27ZqlkfxVJEtTgZ1vHQHZD0ON
         WF1XKCy0A+9CwJ5Y9+61w87KFzxvFnKmbsFO91+6RXEUPC9QtrndBixrajI+PZvI5t
         7y4exx5y9hutaAo3FKtUukkqvHPHu2utJLuFmwCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/600] media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field
Date:   Mon, 11 Sep 2023 15:40:41 +0200
Message-ID: <20230911134633.865620166@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit ae440c5da33cdb90a109f2df2a0360c67b3fab7e ]

Some drivers firmwares parse by themselves slice header and need
num_delta_pocs_of_ref_rps_idx value to parse slice header
short_term_ref_pic_set().
Use one of the 4 reserved bytes to store this value without
changing the v4l2_ctrl_hevc_decode_params structure size and padding.

This value also exist in DXVA API.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: fix typo in num_delta_pocs_of_ref_rps_idx doc]
Stable-dep-of: 297160d411e3 ("media: mediatek: vcodec: move core context from device to each instance")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 +++++++
 include/uapi/linux/v4l2-controls.h                         | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index cd33857d947d3..0ef49647c90bd 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -2923,6 +2923,13 @@ This structure contains all loop filter related parameters. See sections
       - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - PocLtCurr as described in section 8.3.2 "Decoding process for reference
         picture set": provides the index of the long term references in DPB array.
+    * - __u8
+      - ``num_delta_pocs_of_ref_rps_idx``
+      - When the short_term_ref_pic_set_sps_flag in the slice header is equal to 0,
+        it is the same as the derived value NumDeltaPocs[RefRpsIdx]. It can be used to parse
+        the RPS data in slice headers instead of skipping it with @short_term_ref_pic_set_size.
+        When the value of short_term_ref_pic_set_sps_flag in the slice header is
+        equal to 1, num_delta_pocs_of_ref_rps_idx shall be set to 0.
     * - struct :c:type:`v4l2_hevc_dpb_entry`
       - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The decoded picture buffer, for meta-data about reference frames.
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b5e7d082b8adf..d4a4e3cab3c2a 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -2411,6 +2411,9 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  *		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @num_delta_pocs_of_ref_rps_idx: same as the derived value NumDeltaPocs[RefRpsIdx],
+ *				   can be used to parse the RPS data in slice headers
+ *				   instead of skipping it with @short_term_ref_pic_set_size.
  * @reserved: padding field. Should be zeroed by applications.
  * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
@@ -2426,7 +2429,8 @@ struct v4l2_ctrl_hevc_decode_params {
 	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	reserved[4];
+	__u8	num_delta_pocs_of_ref_rps_idx;
+	__u8	reserved[3];
 	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u64	flags;
 };
-- 
2.40.1



