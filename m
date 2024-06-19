Return-Path: <stable+bounces-53708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EEF90E5C1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B2281DE5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB279945;
	Wed, 19 Jun 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3C9lQzR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872715FBB1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786192; cv=none; b=hUYotnExapD+91yFnD+rsy6RYzMwYzbW2NGPFJodXxXROEWnTNMymU/4IKNy2ncG5+kVxMxZozTUwx+rj34rG1oG4xn0YB4rt1ZWp/WLBhgU3IxgPn/N/fQeDJLkvPAfVNe3iATIk0z0/k7LVPw/W/VfNO1RkvgMUezubtgup9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786192; c=relaxed/simple;
	bh=VIQmNS/IyU1Rk3rcy1vcq2I2ql2O8CeN3n9yZJnN/Ac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L12aQZOZ6XZDLW4jd3ABNeca3gqwkAXpOx9H1uB8m1wNc/zqW84ItGzV96zqJ510OjahD6wFfqF6F+E5DVsQXtgW9VFnBfcnG3guBGdc6VAjCBdi4Mqc9GpRMNDMdag/Q6xr1/FbQR6gavPh8GKQLoiujUeaWNv4es9tZ4qrfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3C9lQzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876FCC2BBFC;
	Wed, 19 Jun 2024 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786192;
	bh=VIQmNS/IyU1Rk3rcy1vcq2I2ql2O8CeN3n9yZJnN/Ac=;
	h=Subject:To:Cc:From:Date:From;
	b=L3C9lQzRxSY6edO0NMTyHuq62JvHNBW/ios5dHEi4QCp3r9ciAc4DaL+x4XYNBPdL
	 uvAXAztEfQt99WdCQhuq4y6gjdOPf/a9WUjQuUZ+NZpQtP8wqGsZvkNTC/BHPdygdp
	 17Ld2KiPzqUe50oYtjC/+0dE6Q1SKHXogHdzDyHY=
Subject: FAILED: patch "[PATCH] drm/ast: Set DDC timeout in milliseconds" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,jfalempe@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:36:24 +0200
Message-ID: <2024061924-pelt-electable-b3f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c0cd6925856f661e1a37278660ccae551cef7077
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061924-pelt-electable-b3f9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c0cd6925856f ("drm/ast: Set DDC timeout in milliseconds")
42f4980da575 ("drm/ast: Rename struct ast_i2c_chan to struct ast_ddc")
0a7f04b433fc ("drm/ast: Move DDC code to ast_ddc.{c,h}")
e14ab3037383 ("drm/ast: Allocate instance of struct ast_i2c_chan with managed helpers")
c0af492c872b ("drm/ast: Remove struct ast_{vga,sil165}_connector")
d66cdb638a49 ("drm/ast: Fail probing if DDC channel could not be initialized")
ed8d84530ab0 ("Merge tag 'i2c-for-6.8-rc1-rebased' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0cd6925856f661e1a37278660ccae551cef7077 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 3 Apr 2024 12:31:28 +0200
Subject: [PATCH] drm/ast: Set DDC timeout in milliseconds

Compute the i2c timeout in jiffies from a value in milliseconds. The
original values of 2 jiffies equals 2 milliseconds if HZ has been
configured to a value of 1000. This corresponds to 2.2 milliseconds
used by most other DRM drivers. Update ast accordingly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240403103325.30457-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/ast/ast_ddc.c b/drivers/gpu/drm/ast/ast_ddc.c
index b7718084422f..3e156a6b6831 100644
--- a/drivers/gpu/drm/ast/ast_ddc.c
+++ b/drivers/gpu/drm/ast/ast_ddc.c
@@ -153,7 +153,7 @@ struct ast_ddc *ast_ddc_create(struct ast_device *ast)
 
 	bit = &ddc->bit;
 	bit->udelay = 20;
-	bit->timeout = 2;
+	bit->timeout = usecs_to_jiffies(2200);
 	bit->data = ddc;
 	bit->setsda = ast_ddc_algo_bit_data_setsda;
 	bit->setscl = ast_ddc_algo_bit_data_setscl;


