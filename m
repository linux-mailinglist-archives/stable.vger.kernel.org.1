Return-Path: <stable+bounces-99066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCD9E6F0C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AD28101C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A372066EF;
	Fri,  6 Dec 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtJG32Wy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4F46426
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490851; cv=none; b=BisquBOi45RCGuH14qAWEe3kMS2evMJgix750QLjNwB1dGlSWiqfd5fsxthrPL9jlo0iZbd/YFKw4Iaoux0gScU1t0Tka8QnLXcOZc3LLN0ey0hN8nauQRiuFGaIqyFx5naPuT6K2FHs41gjSqv+0M0ePvPrEtgXV2wmShhwk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490851; c=relaxed/simple;
	bh=M7rH1ATcMb55Jbsa9K7kzg3FksVFYotUIItbaQBEiSs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ReKhs1+iXxgOUvQ3l7GBG7vv/2NK+dG+/CyyxiJOgKGg+bHixBfA3bmU5VgjqruWqigZIf2RddiI2B70LK/UYENH58EFm+/WRC4xXQOB0kOsq+dqJB+jUIVBf3ek+cF2jw00VbaBP6GoIP/TcpL8t/e9jdJ9B7Ionqk3vI9wLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtJG32Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5B0C4CED1;
	Fri,  6 Dec 2024 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490851;
	bh=M7rH1ATcMb55Jbsa9K7kzg3FksVFYotUIItbaQBEiSs=;
	h=Subject:To:Cc:From:Date:From;
	b=TtJG32WyjTsSZBaPiOo4agMSH4t9Yo3RfZ7yOG1BhZgt1oTIMfQBaclFya+0mKGhN
	 NHSeq9+YhaUlnU9lYW4cHJBAA0O86fJhA7PzkBXAQPxpvzqsM7qvzzB4f55WShC+IM
	 fApo4z9azAds6faVhNUC5R9QzCZzJ0PHCoq5eGzo=
Subject: FAILED: patch "[PATCH] drm/sti: avoid potential dereference of error pointers in" failed to apply to 5.10-stable tree
To: make24@iscas.ac.cn,alain.volmat@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:14:08 +0100
Message-ID: <2024120608-resonant-hedging-7692@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e965e771b069421c233d674c3c8cd8c7f7245f42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120608-resonant-hedging-7692@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e965e771b069421c233d674c3c8cd8c7f7245f42 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Mon, 9 Sep 2024 14:33:59 +0800
Subject: [PATCH] drm/sti: avoid potential dereference of error pointers in
 sti_gdp_atomic_check

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Cc: stable@vger.kernel.org
Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240909063359.1197065-1-make24@iscas.ac.cn
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 43c72c2604a0..f046f5f7ad25 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -638,6 +638,9 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
 
 	mixer = to_sti_mixer(crtc);
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;


