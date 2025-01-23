Return-Path: <stable+bounces-110245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CCA19DE1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 06:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2448F169F72
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 05:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE41B87EC;
	Thu, 23 Jan 2025 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3dbNw9+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF080034
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609101; cv=none; b=DULwjXtC7PrUYyePuGzhA9GwLUHSkNRkSCiYaxWqHAldx6Plm49QXpPMMHDNPJiXfegjMnNaHTftr2/AB7MPQ8Q14BZLq/ouqnSC+JRZg/fZSnu+eQF/fhw8nswZaT4xFFjQk5FZKjBO9TiKeDgH8c65p2HaB3d1Ywnr39UQpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609101; c=relaxed/simple;
	bh=Ssycmhs/rEg6CF5reOHte6X9HdlzuBr5hWiWb/bRQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcMXQFUWx3VCLgh6OPC7RhvzIvdBfoHBuZqQlRhY5yVaX5/jSTesk/tIYInIw26f+5Z7r+BreaYwWVMlnBdhvNHMmfV0PkM8BWELVeyvs2eCSQ64Uh2uNHxwt+RKyWgpRp//qAArveQe8YRhSYipkW2SYJkGioEZi/vB6EcojBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3dbNw9+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737609099; x=1769145099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ssycmhs/rEg6CF5reOHte6X9HdlzuBr5hWiWb/bRQmY=;
  b=j3dbNw9+gjzsiuyTTNtO7oqytobFF/z6zWUNTXC7PwWP5H5PC6PF/O0Q
   1G6iTqOZns+ZvH/DUP/7zbk6q9SDuw9coUUnYjFl5otZVTg/AxEXUccAa
   oM8ScI2a1tbA2LNfQJ/ZbjLMXPDnqR3P9Aehf8O+npnjCU8hqIj74HmDz
   /ckICRK59oRLb7+G5GnkdvwFWqZbpg1+q3ePa8RBVUmo5a+tKoRWxh/0g
   ix6Y6YANDBv/bWCljq8RJZ73BKT8cKhbqywSnuHRa4gl61DyoaZHMGT4m
   p114wsFduc3vl2g/f69Jvd1ci4LkMNqqYG2DhEVjqZ+i25YvTlkzE3Y58
   w==;
X-CSE-ConnectionGUID: 88nDoQZtSYy/K3uCEsZowA==
X-CSE-MsgGUID: EC5cTF38SUSU7w/MNw7nYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37353642"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37353642"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 21:11:38 -0800
X-CSE-ConnectionGUID: tMvg4AZURamEYAZqEovHDw==
X-CSE-MsgGUID: uOuCLHphQWmrWK4uW6D9OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107459877"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 21:11:37 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: John Harrison <John.C.Harrison@Intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to Contexts section
Date: Wed, 22 Jan 2025 21:11:11 -0800
Message-ID: <20250123051112.1938193-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250123051112.1938193-1-lucas.demarchi@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Having the exec queue snapshot inside a "GuC CT" section was always
wrong.  Commit c28fd6c358db ("drm/xe/devcoredump: Improve section
headings and add tile info") tried to fix that bug, but with that also
broke the mesa tool that parses the devcoredump, hence it was reverted
in commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
debug tool").

With the mesa tool also fixed, this can propagate as a fix on both
kernel and userspace side to avoid unnecessary headache for a debug
feature.

Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 81dc7795c0651..a7946a76777e7 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -119,11 +119,7 @@ static ssize_t __xe_devcoredump_read(char *buffer, size_t count,
 	drm_puts(&p, "\n**** GuC CT ****\n");
 	xe_guc_ct_snapshot_print(ss->guc.ct, &p);
 
-	/*
-	 * Don't add a new section header here because the mesa debug decoder
-	 * tool expects the context information to be in the 'GuC CT' section.
-	 */
-	/* drm_puts(&p, "\n**** Contexts ****\n"); */
+	drm_puts(&p, "\n**** Contexts ****\n");
 	xe_guc_exec_queue_snapshot_print(ss->ge, &p);
 
 	drm_puts(&p, "\n**** Job ****\n");
-- 
2.48.0


