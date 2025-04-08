Return-Path: <stable+bounces-128976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1879DA7FD7D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0FF1693F1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F0269D1D;
	Tue,  8 Apr 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sqEwODWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAA269836;
	Tue,  8 Apr 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109784; cv=none; b=KBJ/VSACGHuFZIl23OsiZnWOTmhEpcxtRvVemqQLx5/XtPcQkMBTKAlSnjxBiHNMHyh/sv+DMyVh7iq+apBbXTV3R7Mgzw2iPKWBMCqC73sz1JrvYhGz+mBfB9rJqNM2GJ/psbXcfG/yyQFhYS4WgTi2GSGdG2wafw3tJ79/AWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109784; c=relaxed/simple;
	bh=8UDLuR4F2MMCKbJUSssgEgrWPbw9XLMISONPv2lswL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV4Pv5V6bdmITg+FTysuCX0CjgkrFZbqj/ZrT8jPds2q+sNid4xnBbZRj9HqDL91wg0A0lyqNijm90l45IlOPXxV080oN/MuzJm1bJRrYOgGAlt/XqwCPBnQIx6ZmsXwrwQPdYKJr5YS1pEThywluspohcpt/SYonwf0Ek0Yn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqEwODWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A8BC4CEE7;
	Tue,  8 Apr 2025 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109784;
	bh=8UDLuR4F2MMCKbJUSssgEgrWPbw9XLMISONPv2lswL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqEwODWFkpYifP34RMAcuGfwfwhddOCIpgQbyAwLINEkivTbTKBTcPirNOl0DFXNs
	 +HajjQ+NLjtd7hXLVuIHlvBnI6pAAxyvUJgI05SHdQodj4PoesW9zA+FxEK/kOdll/
	 uaf4YXGHFb4K2EplXjKEp4MkSQewJ0OZoPVbAa+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 5.10 052/227] drm/atomic: Filter out redundant DPMS calls
Date: Tue,  8 Apr 2025 12:47:10 +0200
Message-ID: <20250408104821.960623166@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit de93ddf88088f7624b589d0ff3af9effb87e8f3b upstream.

Video players (eg. mpv) do periodic XResetScreenSaver() calls to
keep the screen on while the video playing. The modesetting ddx
plumbs these straight through into the kernel as DPMS setproperty
ioctls, without any filtering whatsoever. When implemented via
atomic these end up as empty commits on the crtc (which will
nonetheless take one full frame), which leads to a dropped
frame every time XResetScreenSaver() is called.

Let's just filter out redundant DPMS property changes in the
kernel to avoid this issue.

v2: Explain the resulting commits a bit better (Sima)
    Document the behaviour in uapi docs (Sima)

Cc: stable@vger.kernel.org
Testcase: igt/kms_flip/flip-vs-dpms-on-nop
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250219160239.17502-1-ville.syrjala@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c |    4 ++++
 drivers/gpu/drm/drm_connector.c   |    4 ++++
 2 files changed, 8 insertions(+)

--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -936,6 +936,10 @@ int drm_atomic_connector_commit_dpms(str
 
 	if (mode != DRM_MODE_DPMS_ON)
 		mode = DRM_MODE_DPMS_OFF;
+
+	if (connector->dpms == mode)
+		goto out;
+
 	connector->dpms = mode;
 
 	crtc = connector->state->crtc;
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -990,6 +990,10 @@ static const struct drm_prop_enum_list d
  * 	callback. For atomic drivers the remapping to the "ACTIVE" property is
  * 	implemented in the DRM core.
  *
+ * 	On atomic drivers any DPMS setproperty ioctl where the value does not
+ * 	change is completely skipped, otherwise a full atomic commit will occur.
+ * 	On legacy drivers the exact behavior is driver specific.
+ *
  * 	Note that this property cannot be set through the MODE_ATOMIC ioctl,
  * 	userspace must use "ACTIVE" on the CRTC instead.
  *



