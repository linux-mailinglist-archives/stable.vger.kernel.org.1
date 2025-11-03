Return-Path: <stable+bounces-192125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073BC29BF4
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD14EADF4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B01A9F84;
	Mon,  3 Nov 2025 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Dqdl1Ol"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98E21CC58
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131094; cv=none; b=U7UdCTKyHtezRT3eAHWzjMe6A4oVZLueoFRqBpFGqordKkA0gKfRYmWvbEPdni0KDziZDMrCrgl0XJk62praYmtInXg/RVgUsuephBKgGWUxu0zAV5yoJh/vX7w+SIgkKrav8lS/T3sGETEJXM8jSpTrVFkILhfekBpCImK+69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131094; c=relaxed/simple;
	bh=Cy6Q00ItbsDTfRqhpYLKtMHKnmeLg/9xUpKEd3TnDxk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MpzYWV5VopA48K4P2H88Am9tcsRfEJmNQMicg/9CFEfjAox6conhOVXioOz1+Q9CFP41GJ/Ox+AjlSexlvfaolOXRGLAEPPeBFEMKMmgtBSjXQGoICKtHkNflc/KanBuIFGbc27ROYwFYdKiGA8hXkmEukDjECKWNoiWYA04XFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Dqdl1Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C008EC4CEFB;
	Mon,  3 Nov 2025 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131094;
	bh=Cy6Q00ItbsDTfRqhpYLKtMHKnmeLg/9xUpKEd3TnDxk=;
	h=Subject:To:Cc:From:Date:From;
	b=0Dqdl1Ol6tbof1gsyPwT/dCREGHv/rf6zshyz/7ZFb21eYp1A5zkvGD8pj2qwzuGK
	 ZV+rZBVrn8HPb81Pb2ecqeIxszYPmhdnDQwY4AS9BGTUQTepatxxlVN9ws6pA6IkWs
	 m67wvslzyAQozl2FuAX2228T/qz9y3mxunderovk=
Subject: FAILED: patch "[PATCH] drm/ast: Clear preserved bits from register output value" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,dianders@chromium.org,jfalempe@redhat.com,nbowler@draconx.ca,pschneider1968@googlemail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:51:27 +0900
Message-ID: <2025110327-tidal-outwit-e591@gregkh>
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
git cherry-pick -x a9fb41b5def8e1e0103d5fd1453787993587281e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110327-tidal-outwit-e591@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9fb41b5def8e1e0103d5fd1453787993587281e Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 09:35:53 +0200
Subject: [PATCH] drm/ast: Clear preserved bits from register output value

Preserve the I/O register bits in __ast_write8_i_masked() as specified
by preserve_mask. Accidentally OR-ing the output value into these will
overwrite the register's previous settings.

Fixes display output on the AST2300, where the screen can go blank at
boot. The driver's original commit 312fec1405dd ("drm: Initial KMS
driver for AST (ASpeed Technologies) 2000 series (v2)") already added
the broken code. Commit 6f719373b943 ("drm/ast: Blank with VGACR17 sync
enable, always clear VGACRB6 sync off") triggered the bug.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Closes: https://lore.kernel.org/dri-devel/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Nick Bowler <nbowler@draconx.ca>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
Link: https://patch.msgid.link/20251024073626.129032-1-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index c15aef014f69..d41bd876167c 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -282,13 +282,13 @@ static inline void __ast_write8_i(void __iomem *addr, u32 reg, u8 index, u8 val)
 	__ast_write8(addr, reg + 1, val);
 }
 
-static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 read_mask,
+static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 preserve_mask,
 					 u8 val)
 {
-	u8 tmp = __ast_read8_i_masked(addr, reg, index, read_mask);
+	u8 tmp = __ast_read8_i_masked(addr, reg, index, preserve_mask);
 
-	tmp |= val;
-	__ast_write8_i(addr, reg, index, tmp);
+	val &= ~preserve_mask;
+	__ast_write8_i(addr, reg, index, tmp | val);
 }
 
 static inline u32 ast_read32(struct ast_device *ast, u32 reg)


