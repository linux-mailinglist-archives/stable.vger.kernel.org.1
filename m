Return-Path: <stable+bounces-57065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31543925AFB
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE0829EA56
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4FA16EC0C;
	Wed,  3 Jul 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ieh0xkC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EF13D61B;
	Wed,  3 Jul 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003737; cv=none; b=jTjKhTHtENVPnMCWQbnrMQ7e4pj9aIemwKeytonU/L4aWdEcsAmn10ZGa384ltbZXt+QxyPaHQMxO1Amx98uKm+vQDBHDnsIwzR7DwWUOAK4+wjgMdLh0ops1ComKw05hIpwhEN2yerf+BkMyVFDZS0T8TVPAFwpXoKothbIjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003737; c=relaxed/simple;
	bh=Q9P+tM1KaPwIqsBGhjGMISpuuRNgggEu2umHTtGtzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0iLz5plYrDIvDyEdMxgrUbObD59tg57YZ7zcaDjgt7j9S/nlUfWpGiDr2NBcBZhNjNip4SxisewXFqWFt9N8H5jIpQZgz1Q2RAJDdGCni7e06AhsZnkmktlDqMCDkLCj7vr9LBHAkfaARp+i8QvX5Of7i8Hsc3HcEJQh2TvBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ieh0xkC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E307C2BD10;
	Wed,  3 Jul 2024 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003737;
	bh=Q9P+tM1KaPwIqsBGhjGMISpuuRNgggEu2umHTtGtzD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ieh0xkC/BLHq1FZXEE8MMt4Ktzw5AJCFAGmiixmkJRvKale3gklIna8vek8rXZ91E
	 eqhKfFZPbUEeZLEt0/kiincijFGhlvRFABhWWFzEsaviuro6aIqNFKAdp5Vqk4OhyC
	 +6uVGJi9bwxc2Z11gTKGqozUW0KRtZtPhPzfFL6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 4.19 131/139] drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes
Date: Wed,  3 Jul 2024 12:40:28 +0200
Message-ID: <20240703102835.383193918@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 6d411c8ccc0137a612e0044489030a194ff5c843 upstream.

In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_mode_duplicate(). The same applies to drm_cvt_mode().
Add a check to avoid null pointer dereference.

Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625081029.2619437-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -259,6 +259,8 @@ static int nv17_tv_get_hd_modes(struct d
 		if (modes[i].hdisplay == output_mode->hdisplay &&
 		    modes[i].vdisplay == output_mode->vdisplay) {
 			mode = drm_mode_duplicate(encoder->dev, output_mode);
+			if (!mode)
+				continue;
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		} else {
@@ -266,6 +268,8 @@ static int nv17_tv_get_hd_modes(struct d
 					    modes[i].vdisplay, 60, false,
 					    (output_mode->flags &
 					     DRM_MODE_FLAG_INTERLACE), false);
+			if (!mode)
+				continue;
 		}
 
 		/* CVT modes are sometimes unsuitable... */



