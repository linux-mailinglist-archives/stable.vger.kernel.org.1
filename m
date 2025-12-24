Return-Path: <stable+bounces-203381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA43CDCF32
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498FE303BBF3
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432C30C378;
	Wed, 24 Dec 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lsN/xG7J"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC02D7DE7;
	Wed, 24 Dec 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597653; cv=none; b=DM5J4Mz0bAY+XB6eeomB6BYr9sxYDipXYclZYihxYovENfYiXfbcJ/oIEtvY3nXGAdycU1NsReYjnD0ylTE4/Mre6g5PmDdcnEdDF9h5sRTuWYGgre4lXFWwdkzvEFv4B9ZMAzvz2oLSobo23CFIeoFp+4eCWXsIHrHJ247Am8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597653; c=relaxed/simple;
	bh=jHIw6fuuqnPdfwefaQ7wrYoLlPRp++hhrLRfTPJk9AE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqNhVOwe2npqPl1ysmHBDCCD6EYmoCPfbzG5cdrvOtEr15/yRIHBeYK4DOFrwjgavdynR1GQxy0FNTWw3Rdm3NIHceZf5E84h2CssdQOwlhytDRJ9w+GvhTcedwHuCgv0GdXLvuJNb0nNAE/H9+zM9Jn/Rn0DIrBA9rWbIm2QxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lsN/xG7J; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766597645;
	bh=0/mQaUiHM70bBczLVLafy0D3SjjlawsO2OOWMSQWL5A=;
	h=From:To:Cc:Subject:Date:From;
	b=lsN/xG7JJcUpgZ1+8MQ69LoqMCE2OzrJMR+NToR/r+zJAKYvq7lMQaYXloj5oyZhk
	 MB6b3AOBcXhUP+5CGFNQ5b3xE3LTuFY7g5WsieZ13kGTq7gkfMP0hUeoNjhQ7I5JaG
	 Yyt0fxVkGayDExYqrK37CBtNF/EzTWgiq5tyg9/vIpw5yMaAq4dkcRl/HhDSYyBJiJ
	 cTo99VJfi09klCAWnh+I5foY96IUMN3ncxBPpbPyjV2nUah5oI+GuW9DHnD2Ask4Yb
	 U47d174ndv3fPqPwpiz0qvFVtgc+hWXc0xVkMXFb0WUxKO/tSRezozu6vq6bRzJdZ9
	 LMJpPkmwTOZuA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dbzWd1xMjzfHn;
	Wed, 24 Dec 2025 12:34:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 0/3] mm: mm_cid static initialization fixes
Date: Wed, 24 Dec 2025 12:33:55 -0500
Message-Id: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Here are 2 fixes for missing mm_cid fields for init_mm and efi_mm static
initialization. The renaming of cpu_bitmap to flexible_array (patch 2)
is needed for patch 3.

Those are relevant for mainline, with CC stable. They are based on
v6.19-rc2.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org

Mathieu Desnoyers (3):
  mm: Add missing static initializer for init_mm::mm_cid.lock
  mm: Rename cpu_bitmap field to flexible_array
  mm: Take into account mm_cid size for mm_struct static definitions

 drivers/firmware/efi/efi.c |  2 +-
 include/linux/mm_types.h   | 18 +++++++++++++-----
 mm/init-mm.c               |  5 ++++-
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.39.5

