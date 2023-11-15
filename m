Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7117ED513
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjKOU77 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbjKOU7D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:59:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C419BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:58:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA19DC433C8;
        Wed, 15 Nov 2023 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081893;
        bh=aWsjg2nbl8cJqsVYF3B0CfyL+VgRl7Eiz3SZ2FE3ceg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCqn3qa0bIXDI5505BHignMwDKnlMkWhI27pIklhnUo4ovogOoCmRqPThXe9UipqR
         5ulSLuyr+2jOdEb7qxPHtL7CzKxdW4Yp9+h90Vs9Q8bVE98mHpndLIGrETwPHs/sxb
         lrkjkvwqGxbKvJ2PI/qxb4GfXLB4E8FbbaOYNy0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 157/191] media: vidtv: mux: Add check and kfree for kstrdup
Date:   Wed, 15 Nov 2023 15:47:12 -0500
Message-ID: <20231115204653.902824409@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 1fd6eb12642e0c32692924ff359c07de4b781d78 ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.
Moreover, use kfree() in the later error handling in order to avoid
memory leak.

Fixes: c2f78f0cb294 ("media: vidtv: psi: add a Network Information Table (NIT)")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_mux.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index b51e6a3b8cbeb..f99878eff7ace 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -504,13 +504,16 @@ struct vidtv_mux *vidtv_mux_init(struct dvb_frontend *fe,
 	m->priv = args->priv;
 	m->network_id = args->network_id;
 	m->network_name = kstrdup(args->network_name, GFP_KERNEL);
+	if (!m->network_name)
+		goto free_mux_buf;
+
 	m->timing.current_jiffies = get_jiffies_64();
 
 	if (args->channels)
 		m->channels = args->channels;
 	else
 		if (vidtv_channels_init(m) < 0)
-			goto free_mux_buf;
+			goto free_mux_network_name;
 
 	/* will alloc data for pmt_sections after initializing pat */
 	if (vidtv_channel_si_init(m) < 0)
@@ -527,6 +530,8 @@ struct vidtv_mux *vidtv_mux_init(struct dvb_frontend *fe,
 	vidtv_channel_si_destroy(m);
 free_channels:
 	vidtv_channels_destroy(m);
+free_mux_network_name:
+	kfree(m->network_name);
 free_mux_buf:
 	vfree(m->mux_buf);
 free_mux:
-- 
2.42.0



