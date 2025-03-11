Return-Path: <stable+bounces-123646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971DAA5C643
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D73A7A9C03
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FC25BAAC;
	Tue, 11 Mar 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Re8fR9Rq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143931EA80;
	Tue, 11 Mar 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706552; cv=none; b=NWEbHxui9GW+wcMYbShdPRw9/8M/Xmvbsjr5efKGQkxFMKXH/njP51BQcl3/du64SkQelDxw162oKCKbts/KojMI/ywcYWD3Vx8UhkA+aUAvTaAcRTxcZSWeIyVHtG+dHdWe5BbO82/TesIPOekv0XWw4Ft3jZbaIMljnni9+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706552; c=relaxed/simple;
	bh=vOfRs41frOn8ICbus7T47GjrC9wyrXL7p9CZaGQu7Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO5kQCrugI2rmEMSajD7s6sgM6sGlNfmp/0jl4kF8YsvD/qBVKsvfFOhXhS6NlLUZrIc6px+eR4piKJ7ZUoZeDdqK8qaMYfKIGZite5+JwWVa22AyUqr9kwjxwuASxQF4FYPw5W69ZoumfAsafUE4qnXNAlEXAJT9lnRVfH+lEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Re8fR9Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92374C4CEE9;
	Tue, 11 Mar 2025 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706552;
	bh=vOfRs41frOn8ICbus7T47GjrC9wyrXL7p9CZaGQu7Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re8fR9Rq3iicM+gJfVcjllcCO1pJp8BPYY2lcbvnspZMyKtiW4l+vvtnpMHbxEEN6
	 fJ79sUYeqBVy5cINhW7eM6YhFDtpVranxBS0Rb0p9lMHNcP6lkUuYzAyx+YlwZjbqU
	 PFBbVp37EB1ZZxsSVOL9vjpAGJTjIYd3gbOWwois=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 088/462] staging: media: imx: fix OF node leak in imx_media_add_of_subdevs()
Date: Tue, 11 Mar 2025 15:55:54 +0100
Message-ID: <20250311145801.827383936@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 094f5c315f756b19198e6c401aa821ac0e868750 ]

imx_media_add_of_subdevs() calls of_parse_phandle() and passes the
obtained node to imx_media_of_add_csi(). The passed node is used in
v4l2_async_nf_add_fwnode(), which increments the refcount of the node.
Therefore, while the current implementation only releases the node when
imx_media_of_add_csi() fails, but should always release it. Call
of_node_put() right after imx_media_of_add_csi().

Fixes: dee747f88167 ("media: imx: Don't register IPU subdevs/links if CSI port missing")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/imx/imx-media-of.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index 82e13e972e233..566e133ad3f42 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -55,22 +55,18 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
 			break;
 
 		ret = imx_media_of_add_csi(imxmd, csi_np);
+		of_node_put(csi_np);
 		if (ret) {
 			/* unavailable or already added is not an error */
 			if (ret == -ENODEV || ret == -EEXIST) {
-				of_node_put(csi_np);
 				continue;
 			}
 
 			/* other error, can't continue */
-			goto err_out;
+			return ret;
 		}
 	}
 
 	return 0;
-
-err_out:
-	of_node_put(csi_np);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(imx_media_add_of_subdevs);
-- 
2.39.5




