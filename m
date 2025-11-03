Return-Path: <stable+bounces-192126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23460C29BCF
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A1F3AB3D4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F321D5B3;
	Mon,  3 Nov 2025 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r7cLY0sF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E21D3E4
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131096; cv=none; b=Ky2554UDWbY5A2P9Tdchr/IU5cK6gS/APn9nQcu6CzVcMKkmpdzaC9Zb3Rq9zLmvPXhHNcW0t6RrvzOa8K2BQv7zNx82ZuQ8SbVmEchCGIE5170hZKFKtSTm0nyQjuTsU34hSyyqnusRdkOdTabKLot/JmtiGa445oau1qgbBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131096; c=relaxed/simple;
	bh=VgB8PIBvERTtBYJPJCY0vRI1r6EIp1EtsrLTNP4vqx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wbmz+JTlXIrbh9NkWsbPCoxCGBMMO9sNxizX9v3ufkhqx0J+VAXtMGCNrNh5Z9j0FuT/LpaqkvL+a45KUtXlSoTsv7L1cxZvAYBsAyTX7Zbs1yG4/IxkVhTHO9ORlDD9Thx+IcqZ9tIl9A0+qja6YuE95TJ9HF2icjzhqfpFXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r7cLY0sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094D2C4CEF7;
	Mon,  3 Nov 2025 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131096;
	bh=VgB8PIBvERTtBYJPJCY0vRI1r6EIp1EtsrLTNP4vqx8=;
	h=Subject:To:Cc:From:Date:From;
	b=r7cLY0sFFUn6TuMCd1my5mlaCdNK2YYU5L0teTgFqzj9mOHTnlH4RrruFXCPqFNde
	 f0BVhlZl1UJmOOSUzXwnXlxPJMa4k/zgdn5JEnAoApgmguieUBhXTsg3kwtBq6fnhD
	 FQizZ0TY0DYlz3RFAX/GFmIq8oYAmMFzmOMqylJE=
Subject: FAILED: patch "[PATCH] drm/ast: Clear preserved bits from register output value" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,dianders@chromium.org,jfalempe@redhat.com,nbowler@draconx.ca,pschneider1968@googlemail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:51:28 +0900
Message-ID: <2025110328-chaplain-zippy-8d38@gregkh>
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
git cherry-pick -x a9fb41b5def8e1e0103d5fd1453787993587281e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110328-chaplain-zippy-8d38@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


