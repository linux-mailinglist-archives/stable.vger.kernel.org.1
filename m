Return-Path: <stable+bounces-120860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC0A508C7
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2C518849BA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D08251785;
	Wed,  5 Mar 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RsniSFxN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29C24887A;
	Wed,  5 Mar 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198183; cv=none; b=UiK6LrXOp5KEjREYPwz0rnrM2aZ8f2Zls7koGHNm8k1P4oUxndmyHXveKlu5j5RWpiirhlwG1qNgJFJo4Dtqp4PsFnd2l+HW4nl/NiqThp2dv6K7TwKlX16Y1HLB2lnqNvJAatoKQx6zXsKrs/599EVVTVwRZoy5EJW3FXWTSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198183; c=relaxed/simple;
	bh=l1HYFf9StVRhduSejHgkm/sepkYzIp+n3Kb9sCt4VVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThihXgesnS9rfxs3YhtZxQubNod+ide3vcKdTkq5qe2ZHmeu1Z1hv/+12JowzyMxdsbFWZWTpdwgYhPKhsMnOyZCILiz9a2m76yBmurxRemYvKN7RXNr4h1wnjm3EfXaiPAW1jdJ3lvE4TZKLu0Adt8CYBzOATsun08wbliiraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RsniSFxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB68DC4CED1;
	Wed,  5 Mar 2025 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198183;
	bh=l1HYFf9StVRhduSejHgkm/sepkYzIp+n3Kb9sCt4VVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsniSFxN5L0iRNwggaILngp045CAPnTaijWITfmBw6NRI9bCHkJuWA3jRmVxVNVMC
	 XNgn60yRTY0wFJUSkhJErsrGY4qP0Mw4Xidc6TKBCMyg9CGz+il1gKrD6bQtJBACe4
	 uMiooxUsyuhyUqqnhPvQVtLDtd5ITywLyb7wNNzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 093/150] drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)
Date: Wed,  5 Mar 2025 18:48:42 +0100
Message-ID: <20250305174507.544314012@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingcong Bai <jeffbai@aosc.io>

commit f2ba0cf1ca32e075617813de98c826ab55d57f11 upstream.

Commit b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
introduced an internal set of engine registers, however, as part of this
change, it has also introduced two duplicate `define' lines for
`RING_CTL_SIZE(size)'. This commit was introduced to the tree in v6.8-rc1.

While this is harmless as the definitions did not change, so no compiler
warning was observed.

Drop this line anyway for the sake of correctness.

Cc: stable@vger.kernel.org # v6.8-rc1+
Fixes: b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250225073104.865230-1-jeffbai@aosc.io
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 6b68c4542ffecc36087a9e14db8fc990c88bb01b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/regs/xe_engine_regs.h |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -53,7 +53,6 @@
 
 #define RING_CTL(base)				XE_REG((base) + 0x3c)
 #define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
-#define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
 
 #define RING_START_UDW(base)			XE_REG((base) + 0x48)
 



