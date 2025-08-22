Return-Path: <stable+bounces-172516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80DB32399
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C60F1D632B3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD32D4B69;
	Fri, 22 Aug 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI3SNKYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCC275AF5
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894639; cv=none; b=H4IVyL3hMka1VCKQXZuAUtXNN/5roDWbQh+PjmjiVDBL3N54p0wD2oNbyFjWWzBehJUtGU3DPeAQz9i5y8bd2wcMIinWnuO1hKU/883BHgablQsHzCBFGXRmUjjoH06/nmTv5Tdhn/0RUj6t1AA/xby7o8aEXUUBZtdSVQLDeP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894639; c=relaxed/simple;
	bh=/gJFjQtYWx3/IT+F087pN4ijB3lrIIObqeOfJmVqx+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkp45kbKiaBKcC1QUAONU63KD8zlPotqpjr/wCvnCBkMiD3CvkE5XVEETBVjngaAFuq867BuKTQ7wRC2XQl51Z5fIdZF2Ls6kzMT1mRdkOWAuskwIw++HsgoWW5LB/nvGjVd7BD4lmUnJEYmvXA7wFzAu9HgYF9K6DzD8UBGjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI3SNKYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E437C4CEED;
	Fri, 22 Aug 2025 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755894639;
	bh=/gJFjQtYWx3/IT+F087pN4ijB3lrIIObqeOfJmVqx+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NI3SNKYtvU2/m4ksGdqET1x0F+vbuQaAElXHo9jiVeUTQHYSsm+SEnhyCB30wcMwL
	 pEiGvj8ksPQLgMVJcfEStlEM9YvQ98OQnfK31M9RYu8xXghGoYXoQcJ9uRkfJTEbQO
	 OyJg9sBpET7SziZicSmABBI2jd069U5zXYJuB1xb6E5rioEsAfBXkoqffE06bX40Yv
	 GqLqJV7veN9ZtppNKUr+qGq+VO0XEH0V/pc3qjqG3eHt5HgF58w/ZxhdBEdC0sS681
	 B0KYKAwN7NSlm3is/X/vcLF89sSG+whcx6F5p65PH8EXZr6IVLdp84jbCX5DGTJSFz
	 c5kXQMuPUxR+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] Mark xe driver as BROKEN if kernel page size is not 4kB
Date: Fri, 22 Aug 2025 16:30:36 -0400
Message-ID: <20250822203036.1485683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082117-juicy-abrasion-1549@gregkh>
References: <2025082117-juicy-abrasion-1549@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Simon Richter <Simon.Richter@hogyros.de>

[ Upstream commit 022906afdf90327bce33d52fb4fb41b6c7d618fb ]

This driver, for the time being, assumes that the kernel page size is 4kB,
so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with 64kB
pages.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://lore.kernel.org/r/20250802024152.3021-1-Simon.Richter@hogyros.de
(cherry picked from commit 0521a868222ffe636bf202b6e9d29292c1e19c62)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 93e742c1f21e..f15c27070ff4 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -3,6 +3,7 @@ config DRM_XE
 	tristate "Intel Xe Graphics"
 	depends on DRM && PCI && MMU
 	depends on KUNIT || !KUNIT
+	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
-- 
2.50.1


