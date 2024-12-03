Return-Path: <stable+bounces-96779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5A9E226C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F7ABA1BE4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A31F893C;
	Tue,  3 Dec 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oB4YpFhi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A71F890E;
	Tue,  3 Dec 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238569; cv=none; b=enl7brvnPExfGuzFUG3Hoid2HFdwAShn7YKF0sLLyjawBH6o71Su9ysKZDJJCvXWSTiiODUCW94b4hyxkknGJ0qZfg/IUZVOMRSNiPU9wS69Bq6FaN5azP5drAwfOJw/4K0x/lXHTYdcwYyq5IXc4+n5vDI452YPLZniEjPD2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238569; c=relaxed/simple;
	bh=KXjZDVQbrfpbfmv6A/gvS4E7wN0qwI3/cEh6Fd2aA7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWuSd6/6T5JpKF6KUZ3hhOlXX6xrj/fZxiNt3CJF4zDcSXYFVO4m4INqke3idUzXtTXxZRM3aw3qL1qEXAGJc2VV4WvDic0wolkd5zrotdsbdlDDNCyJlWpA0eLxlM2MYF8aeI8WyUtIB+p6VhQ7H6zB0qRvXIm/CXoPjWrdkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oB4YpFhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C7C4CEDD;
	Tue,  3 Dec 2024 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238568;
	bh=KXjZDVQbrfpbfmv6A/gvS4E7wN0qwI3/cEh6Fd2aA7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB4YpFhi7HDyY+zmUGCeeh930MYNyAPf8jhihpMSx4jQQ0bDI11iUBPX5I09aqFTH
	 aIf37pgdoKTVazvnuAfRsqT90SOm2tBbE0hI5u5pu9WbuHCzZSBLtVavyX3EwlhSt1
	 ZUgNH+T9wQMtXz290fjGF4n6+wBrHK0O0Jp9zqLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 305/817] drm: xlnx: zynqmp_disp: layer may be null while releasing
Date: Tue,  3 Dec 2024 15:37:57 +0100
Message-ID: <20241203144007.722083317@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

[ Upstream commit 223842c7702b52846b1c5aef8aca7474ec1fd29b ]

layer->info can be null if we have an error on the first layer in
zynqmp_disp_create_layers

Fixes: 1836fd5ed98d ("drm: xlnx: zynqmp_dpsub: Minimize usage of global flag")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241028133941.54264-1-lists@steffen.cc
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 9368acf56eaf7..e4e0e299e8a7d 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1200,6 +1200,9 @@ static void zynqmp_disp_layer_release_dma(struct zynqmp_disp *disp,
 {
 	unsigned int i;
 
+	if (!layer->info)
+		return;
+
 	for (i = 0; i < layer->info->num_channels; i++) {
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 
-- 
2.43.0




