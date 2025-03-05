Return-Path: <stable+bounces-121050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9E1A509A1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8216216BB84
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB42566CC;
	Wed,  5 Mar 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXhXqaJM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7025290E;
	Wed,  5 Mar 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198737; cv=none; b=i9SlXRM2v63RicQ1ELqgo3c1QXd/npC7qOoCvfKlvgc8m3+6+24qWkl8r1E4e7VpNqAJNbjl5s6gyI1OaDnioogVtBKMn4M+ZcBbkrRHxWkxulozgDrsrbAlVTuBVdh922ZriJGhzXBiCO53zocw1uVp5N4ZHnJtCiwOM1DFKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198737; c=relaxed/simple;
	bh=0nIDdsjLzIFPCBeygra29Jd1iI2kPnhtib7IYdRx898=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB4x4aLbetOU5xejAAKQo+V/IoT2Ow9jnQptGKP3RJpDLE1KFBwvHYpe2a6iGDGO+ZansgbmUvcC++M7ZSVW30YJXq1NSq4yH+Zh49iQpAz3YXpBwoLTN3DWjPqMwY2lVdrnKKRwfFBLBYc/wLMBSIgGViR6qOfsTD0INGqXnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXhXqaJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B65C4CEE9;
	Wed,  5 Mar 2025 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198736;
	bh=0nIDdsjLzIFPCBeygra29Jd1iI2kPnhtib7IYdRx898=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wXhXqaJMbCM3Ra5b52ZE7ZK5w8vjRdH/CnSIZQl+9/g++3SUjzZpHglQ+SUnQ49M6
	 Sp/lR3RXaXWfp3Ny04zz0m1ArHXNMcVTTLmlADNBbBMVlH55pUz8FF3pJccuCNIFJ9
	 0R4hVOSo4hyf9aCLJ1VvWTWJxZCy9cD0BCAcetKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.13 089/157] drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)
Date: Wed,  5 Mar 2025 18:48:45 +0100
Message-ID: <20250305174508.884466894@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
 



