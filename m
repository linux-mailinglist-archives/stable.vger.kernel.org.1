Return-Path: <stable+bounces-195123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0985C6B318
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACAAF4E12B7
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27D3612CE;
	Tue, 18 Nov 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud8H5qWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C4328632;
	Tue, 18 Nov 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490263; cv=none; b=mCdN3GnFv9YCbmXNYcXGKmesMQjkkSlRpYXwtJvI7v77G4Be1KqovoUGd0T1OtafCSUP5Peuv5cMf2ImcR7wq0AJXOL5lB3UIGHOHsJSwzgsKODyXXRjrIu5ZHVbviv54QwW4G6jj21YzPNDSmeaxoZ2J40JCj/bDG9VleJtRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490263; c=relaxed/simple;
	bh=fyLPAFBoJghiBCAB3NIk/qOCqx6vFu5htUaGPEmW1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i84XHUrHMsax+r9qVyEeamjOJFJxEWzQQut2rkck903TwI4+U/hGnYNvtUHsKxHQ+dzgwAowAmKnPeAcMLCnRHdF+RjA7P7t8ZrpW/ENtRUkN+JVrvqcDK8xIRkEMTy+pGeYgEDgCMZhPDK4Dn6LLHdx6dv/hO6K4vK3hWBdd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud8H5qWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01115C4CEF1;
	Tue, 18 Nov 2025 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490263;
	bh=fyLPAFBoJghiBCAB3NIk/qOCqx6vFu5htUaGPEmW1JU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ud8H5qWjDYrgvHTvxseFOcZjgnjvjPGE1Fykjj2L3tZ23bYArNT/loOO2SCHFtK5P
	 w8elLHh/xQkRtb7pm9R/ENzwvEJ/Q4jdibfgTTbSUuxcoYp5161ptrIgl9lVTpfiKe
	 XAcBZjmcqoVSU4XlyyFhMLA5EQV3TzQRwtGMQFIa4w/oxdiBpJj3Ua7Tv8kx13dmTj
	 RKJ7Cd1LN20q19SqqR44PqI7P7ME7BLMvghYPQQxjJDdeLA8Q2Fl72kd7/E6EbBChw
	 B1pX3lxVWLtHFLwTLvQonK4zdPySJTLBVj4hTzXoKXOo4Lmb7uCB8hEvX5Xwq9VNKG
	 4wnNBXcBob2fw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Date: Tue, 18 Nov 2025 19:24:15 +0100
Message-ID: <20251118182416.70660-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
KHO maintainers can get patches for its test.

Cc: stable@vger.kernel.org
Fixes: b753522bed0b7 ("kho: add test for kexec handover")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e336174ede5..b0873f8ebcda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13799,6 +13799,7 @@ F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	kernel/liveupdate/kexec_handover*
+F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
-- 
2.47.3


