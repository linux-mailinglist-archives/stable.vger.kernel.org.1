Return-Path: <stable+bounces-206017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F31CFA3A5
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C98030477ED
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C780343D71;
	Tue,  6 Jan 2026 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEEHoYsG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CA33B6CF;
	Tue,  6 Jan 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722623; cv=none; b=PwshbzzSVaurQz+4ZRvVJED9coOhnntdLbYCy8tnaIiEgVO1O8ir0NRzvft/dw25KwsB+fIr7SWCMMVGWx6xuR1U4YyIqx1pLbmk/KjcE1AEz+c0Q/zeraXnObM+E9Ayq0Ct3p4wTQfwBT7uSoM+4Zp8vRGM2OTaRfuG+bzVKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722623; c=relaxed/simple;
	bh=xLUK5qT+7Ei2wl5iIxXoArLQXoLhkX4qDOuphxpeci0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPnj1O8Fn3oCwzqhq/GvNCTAQ8Vk9ED4b9YJl/8QTVeIW69z9V1RiZW8ndE5r5pQwq4LyDueUwN7sad+yX1XTHseVNod+r026ccLPbo2fK+bqVLNe1Mp65jY+kcDG3v5p6+6j6nt9TDRHCdlwCjxZ5vEdkiyghyHDoe7GHEKr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEEHoYsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB7C116C6;
	Tue,  6 Jan 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767722623;
	bh=xLUK5qT+7Ei2wl5iIxXoArLQXoLhkX4qDOuphxpeci0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xEEHoYsGvz4qGJ83B89/f6FWYweUmY/QMZ+fvJa6R1050BDEwjfUa/l6rwyO433IS
	 9misymzsMRPzosbZkxGcfVK/pFRRqDGGBzawNsYITVbaHPv26Tc+o1i7L4EWpHF03z
	 V0DIm2n7Q9pv+dQXfnbIGN9OUEIMpAiS5qxtwcwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18 301/312] drm/xe/svm: Fix a debug printout
Date: Tue,  6 Jan 2026 18:06:15 +0100
Message-ID: <20260106170558.747037375@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit d2d7f5636f0d752a1e0e7eadbbc1839c29177bba upstream.

Avoid spamming the log with drm_info(). Use drm_dbg() instead.

Fixes: cc795e041034 ("drm/xe/svm: Make xe_svm_range_needs_migrate_to_vram() public")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patch.msgid.link/20251219113320.183860-2-thomas.hellstrom@linux.intel.com
(cherry picked from commit 72aee5f70ba47b939345a0d3414b51b0639c5b88)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_svm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -942,7 +942,7 @@ bool xe_svm_range_needs_migrate_to_vram(
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 



