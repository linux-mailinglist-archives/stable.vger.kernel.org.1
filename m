Return-Path: <stable+bounces-34372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5A893F12
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E9A1C21364
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41647A62;
	Mon,  1 Apr 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCfZo4ER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D33F8F4;
	Mon,  1 Apr 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987900; cv=none; b=E+c+YXSgimScJm23Kt5VF55NefaZev6E8ReraLnQ0H+9zItmv4AaVJ4VZbRfAAI6fr+DGRoHg0pr3FpRVt2uSrp4qWvnQYUh4ijA+zCdOmP7uiqsEWGoQCYsFBXZWfUigV8ajGarZDscWw2sVIsSncYygitwy2tMod1vdfQr6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987900; c=relaxed/simple;
	bh=1tyOy+GDkMQ9n8ZpIvqrcf51lf7EAa0V9szhuwG+gGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF+1QkGtqR0MWe0Wn+rtw8vGrmpDzbDENfNeo070ZrKENwYamanEC84MqYFjMQSnAqw4cHeoqnSv9qAfFLOI2ZoQDjOZnwwPgxpkS8IoufVCt/T8tVeYKgu2M9IKy1HHGclycpJzvYta+U8N4wsOculRWazi+rNyWmZhkeWawAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCfZo4ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27907C433C7;
	Mon,  1 Apr 2024 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987899;
	bh=1tyOy+GDkMQ9n8ZpIvqrcf51lf7EAa0V9szhuwG+gGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCfZo4ERfjZyCy3rPco4ZpSFSsaXU02oxaw89FC8fI19OBUdw7C59OsR8/cQ5VN9B
	 rTLpUjoEdL6ptDtDS4Ute4+CMe9dFU7U/GiuFNUq/nMJk6kde+SuItKh8/V6wagDlE
	 cRNDjOM4BqcLVSKmdNj2DFuODowqNHXSEXCt0Mxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 025/432] media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT
Date: Mon,  1 Apr 2024 17:40:12 +0200
Message-ID: <20240401152553.883363456@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 9b71021b2ea537632b01e51e3f003df24a637858 ]

All the sink pads of the crossbar switch require an active link if
they're part of the pipeline. Mark them with the
MEDIA_PAD_FL_MUST_CONNECT flag to fail pipeline validation if they're
not connected. This allows removing a manual check when translating
streams.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-crossbar.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 44354931cf8a1..c9a4d091b5707 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -160,13 +160,6 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	}
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
-	if (!pad) {
-		dev_dbg(xbar->isi->dev,
-			"no pad connected to crossbar input %u\n",
-			sink_pad);
-		return ERR_PTR(-EPIPE);
-	}
-
 	sd = media_entity_to_v4l2_subdev(pad->entity);
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
@@ -471,7 +464,8 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 	}
 
 	for (i = 0; i < xbar->num_sinks; ++i)
-		xbar->pads[i].flags = MEDIA_PAD_FL_SINK;
+		xbar->pads[i].flags = MEDIA_PAD_FL_SINK
+				    | MEDIA_PAD_FL_MUST_CONNECT;
 	for (i = 0; i < xbar->num_sources; ++i)
 		xbar->pads[i + xbar->num_sinks].flags = MEDIA_PAD_FL_SOURCE;
 
-- 
2.43.0




