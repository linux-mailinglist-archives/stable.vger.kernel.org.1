Return-Path: <stable+bounces-71937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4F967871
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A49B2227A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D80181B87;
	Sun,  1 Sep 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTCWMtPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A705381A;
	Sun,  1 Sep 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208308; cv=none; b=C+UU4v3WFrv5eAbg0VbU/2uqvv0TwK0+jOLYTwaIfFUGhvhSpDMW6W5bsfP9A6aTHpsND6I2BFE80Jko4vZ/MQ3D/LSoE3yfb0gUQBlNjXx/lFeW05/nLFdSWitAa7GZ3FBwaYl2EKpEtmeqZWGGLmUqa6Kp6oIgdUJmx+btNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208308; c=relaxed/simple;
	bh=QA378Zlkowog8BJugdPguQL19MAgqOyUvTpy2U6RhUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxj18flOOjC6Pya7QthGDiiG+95/e/MVzBb/JVHLi3lJCmYvzzaFdbdDwg5Ct6TkKiUn47jN7fWXnA2TnD6DgQgxNQMKGDlV/zVNnzq3WHNqEkU+jv+ia3tgA7X2IBsGQ7DpZzTtxrJcB9U0vGzlMJWumDQ/NjmLh7H/j4wXltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTCWMtPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E6BC4CECE;
	Sun,  1 Sep 2024 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208308;
	bh=QA378Zlkowog8BJugdPguQL19MAgqOyUvTpy2U6RhUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTCWMtPi9siChZYVB6A+H/7MrjxGY6zVrYEdL5tKjkCTAWPSI3wtl4va8vi3ue7Wz
	 Ogd48F9fWmw+9KH8PpsSMyf9VJjNb2k2w1tcnN2enqcFrjwU7lgerg5a2E6C+/X4nY
	 09LbSpAMa45QiqMRPBB6LXAoyf+VaUybjnPPDNTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>,
	Christian Heusel <christian@heusel.eu>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH 6.10 042/149] drm/vmwgfx: Disable coherent dumb buffers without 3d
Date: Sun,  1 Sep 2024 18:15:53 +0200
Message-ID: <20240901160819.047253101@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zack Rusin <zack.rusin@broadcom.com>

commit e9fd436bb8fb9b9d31fdf07bbcdba6d30290c5e4 upstream.

Coherent surfaces make only sense if the host renders to them using
accelerated apis. Without 3d the entire content of dumb buffers stays
in the guest making all of the extra work they're doing to synchronize
between guest and host useless.

Configurations without 3d also tend to run with very low graphics
memory limits. The pinned console fb, mob cursors and graphical login
manager tend to run out of 16MB graphics memory that those guests use.

Fix it by making sure the coherent dumb buffers are only used on
configs with 3d enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
Link: https://patchwork.freedesktop.org/patch/msgid/20240816183332.31961-4-zack.rusin@broadcom.com
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2283,9 +2283,11 @@ int vmw_dumb_create(struct drm_file *fil
 	/*
 	 * Without mob support we're just going to use raw memory buffer
 	 * because we wouldn't be able to support full surface coherency
-	 * without mobs
+	 * without mobs. There also no reason to support surface coherency
+	 * without 3d (i.e. gpu usage on the host) because then all the
+	 * contents is going to be rendered guest side.
 	 */
-	if (!dev_priv->has_mob) {
+	if (!dev_priv->has_mob || !vmw_supports_3d(dev_priv)) {
 		int cpp = DIV_ROUND_UP(args->bpp, 8);
 
 		switch (cpp) {



