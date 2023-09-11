Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF279AEF8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353928AbjIKVvg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjIKOts (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E4125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F1C433C7;
        Mon, 11 Sep 2023 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443784;
        bh=vK9cmj/kVQNYttGmpe1dAbeka/bzJeZqpW92JrES1iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/jfrCZ5ch2B6ib8aD5CoIdsLbiEtG4cwbTjRc4p8mbSIB44kq+lnQaWWvBVYydzM
         z6TK2I+uLVpo33hpHRoRcPKJ7e+fWbHwHDGIR6iDQ9JIM3P3HxnUKGw7Dy8KZMucLF
         F8V/hahz0udFmn95Gm6jIgztlW/jKdSp9BYlglY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 500/737] media: rkvdec: increase max supported height for H.264
Date:   Mon, 11 Sep 2023 15:45:59 +0200
Message-ID: <20230911134704.539066048@linuxfoundation.org>
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

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit f000e6ca2d60fefd02a180a57df2c4162fa0c1b7 ]

After testing it is possible for the hardware to decode H264
bistream with a height up to 2560.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkvdec/rkvdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 134e2b9fa7d9a..84a41792cb4b8 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -120,7 +120,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 			.max_width = 4096,
 			.step_width = 16,
 			.min_height = 48,
-			.max_height = 2304,
+			.max_height = 2560,
 			.step_height = 16,
 		},
 		.ctrls = &rkvdec_h264_ctrls,
-- 
2.40.1



