Return-Path: <stable+bounces-71807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB219677D7
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4671C20F46
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209117F394;
	Sun,  1 Sep 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7jFAPSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5E33987;
	Sun,  1 Sep 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207882; cv=none; b=P51ySPxit/AqGVb9mfpxJMpVKWK487QvfmPxeSv1bpx3dPogk5Aia55KwL5Usx0QAtLJx+11M+DtuaCoRaGRXOOd/NIb4rHdiDE2LhTD7xFx5fZ/vja72ndv2eLiwDl3yGJAX4ryNraC3x5Tv3RSG6FQY/+TaaaCzuWIDBlz/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207882; c=relaxed/simple;
	bh=+Ev+dviDJP/J437tFQAZ2Qr6GJZ7ZEcCgXLWJSQ0vT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4zSXotD0yHIvMR4lS4jbWMLXc+RpR0A8Z42KpKI7pLCDF6RdqWdzkW2bb4h8UD+T+niXZ4ismo26+PMJ0kzAlqGpTQu3rvQO6+XGUKgU0ndWZsZLS25G3/pcq1OwfequqneXIUlnJAs0pK/4PxnImKNmUrFDNUrL0Ff0pBt+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7jFAPSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA5AC4CEC3;
	Sun,  1 Sep 2024 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207882;
	bh=+Ev+dviDJP/J437tFQAZ2Qr6GJZ7ZEcCgXLWJSQ0vT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7jFAPSfkRUhSYSYSoUIwGoHtnmdedW+6zoQtY8vwcYvGBp0NbmrB8YpMXRJACIaI
	 0g/Fmf1l+SFAg/7BvZQN32hHq8qPHnfDc5XW3mVTgstFPU9Ywf0z6Z1jmgID5shRnI
	 OETO9cEN6dkVLaXR0T0CM7AAHVrsTBDGjcaS5Ar0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+20dcf81733d43ddff661@syzkaller.appspotmail.com,
	Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4.19 98/98] drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var
Date: Sun,  1 Sep 2024 18:17:08 +0200
Message-ID: <20240901160807.393310648@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 1935f0deb6116dd785ea64d8035eab0ff441255b upstream.

Drivers are supposed to fix this up if needed if they don't outright
reject it. Uncovered by 6c11df58fd1a ("fbmem: Check virtual screen
sizes in fb_set_var()").

Reported-by: syzbot+20dcf81733d43ddff661@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=c5faf983bfa4a607de530cd3bb008888bf06cefc
Cc: stable@vger.kernel.org # v5.4+
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230404194038.472803-1-daniel.vetter@ffwll.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_fb_helper.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1713,6 +1713,9 @@ int drm_fb_helper_check_var(struct fb_va
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a



