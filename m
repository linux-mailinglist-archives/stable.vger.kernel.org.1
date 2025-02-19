Return-Path: <stable+bounces-117231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C102A3B59B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD090178F13
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B91E1A2B;
	Wed, 19 Feb 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQ7Td/f6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1B1DE4D7;
	Wed, 19 Feb 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954617; cv=none; b=pLYGtkuJr5lOxRZXiFXAf1OOR99iLkkFLhpKNss9sZvpLfMX/u5KkFog/vTNdm2x1x034ryxh5RAVUXuKbPaofAzOuA+TBUjWq/pCuWMqgpAoDKigVhrRFeTKisbtSj+kULsJYeSdkiACjYwajXd4fljOrDUNNWStih5s5n+/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954617; c=relaxed/simple;
	bh=2xh6Y2mmmRxkObgjHOgAaNMYVuzoUjT8u9uKUXld3xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbp5S0M8YMHbuz3CBBdEJSJU3OISJNmjRwPvWt+KblVudbpAq282FlTRhEe5SS1jz09agf11NMsOJBFhY+o2e7EZPjZ8Xa0pC4O+OnWCYHp8hXL23+Mh4+DmD9R4OCwhX6R5xyAtV2Xjc+HGlXIF7A6Jh/nI1f5PXExlMTnJuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQ7Td/f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD94C4CED1;
	Wed, 19 Feb 2025 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954617;
	bh=2xh6Y2mmmRxkObgjHOgAaNMYVuzoUjT8u9uKUXld3xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQ7Td/f6mdY1nfvgEOsL+1TjfQKPjSY6MarCPFC05a/uMpihTKylb2cvrbr0OWRGR
	 iS6RBsars7Y48GTzhq64esNvKCBBeZxln8OkUumGSc8npEp0jimpKij1s5aYt9no7x
	 hhSBTKmKLCcvoxogdA+5gLbLFMF3cg6CaOY/ZDjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Gmeiner <cgmeiner@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.13 259/274] drm/v3d: Stop active perfmon if it is being destroyed
Date: Wed, 19 Feb 2025 09:28:33 +0100
Message-ID: <20250219082619.722845232@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Gmeiner <cgmeiner@igalia.com>

commit 21f1435b1e6b012a07c42f36b206d2b66fc8f13b upstream.

If the active performance monitor (`v3d->active_perfmon`) is being
destroyed, stop it first. Currently, the active perfmon is not
stopped during destruction, leaving the `v3d->active_perfmon` pointer
stale. This can lead to undefined behavior and instability.

This patch ensures that the active perfmon is stopped before being
destroyed, aligning with the behavior introduced in commit
7d1fd3638ee3 ("drm/v3d: Stop the active perfmon before being destroyed").

Cc: stable@vger.kernel.org # v5.15+
Fixes: 26a4dc29b74a ("drm/v3d: Expose performance counters to userspace")
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241118221948.1758130-1-christian.gmeiner@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -384,6 +384,7 @@ int v3d_perfmon_destroy_ioctl(struct drm
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_destroy *req = data;
+	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct v3d_perfmon *perfmon;
 
 	mutex_lock(&v3d_priv->perfmon.lock);
@@ -393,6 +394,10 @@ int v3d_perfmon_destroy_ioctl(struct drm
 	if (!perfmon)
 		return -EINVAL;
 
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;



