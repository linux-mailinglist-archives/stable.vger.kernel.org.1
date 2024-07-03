Return-Path: <stable+bounces-57204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD4925B77
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C0A1C22384
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED381862BE;
	Wed,  3 Jul 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckX5KnCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F1862A9;
	Wed,  3 Jul 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004172; cv=none; b=TacOwTqYAkeCWEo2VG9AR9VdZw1aGrllMyH5NuBU8so1iZOQSt7u5QKY7VhniXfjLB2SDK6XmMHTPOXRNtwXPGOLpgA+wg+touWdGlm2LxA3uZe3fpRRH+gKOxJPYj1uC8cxcBRVlFXf1qa6aVmlOJj0Kwv5g1kjPXiTszE+3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004172; c=relaxed/simple;
	bh=EvBXb1EZl2cFc0p5d2SzydjMP9nhVmN/LcKQAfKE+JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSm0vOS5y9qUdxxGUbM3BVd0Gq/Fmwxrrymw6jjnLiZl5lxAoKDV3BC5WlIA7Xm6Li3in3XgOYaqjJpIr/7D4TJLnRNkF+IeYgHk+j8JGfJ1wnZYDMD4ZSO2IufpurFgIo+RrL162Z2U2DJkJbJoC8b6pm5QfPJaRL8EuawdpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckX5KnCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CC5C4AF0D;
	Wed,  3 Jul 2024 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004172;
	bh=EvBXb1EZl2cFc0p5d2SzydjMP9nhVmN/LcKQAfKE+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckX5KnCJk/UCkJmvkJdqnpIyxkn3tQ43WamANX9MN7SvYYGKB2/hTXi5UOT4KpCUn
	 Fot68gsuDv5j4hQUCUfFBvS3vD1P1ONBtbRmaOpqPRZsfcL0QglWI7gdHNR0U12pTx
	 sS4JxprBUe+mCtoWkbzZz6y71dHrmtHEtnYTjkeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 144/189] sparc: fix old compat_sys_select()
Date: Wed,  3 Jul 2024 12:40:05 +0200
Message-ID: <20240703102846.914291444@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bae6428a9fffb2023191b0723e276cf1377a7c9f ]

sparc has two identical select syscalls at numbers 93 and 230, respectively.
During the conversion to the modern syscall.tbl format, the older one of the
two broke in compat mode, and now refers to the native 64-bit syscall.

Restore the correct behavior. This has very little effect, as glibc has
been using the newer number anyway.

Fixes: 6ff645dd683a ("sparc: add system call table generation support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c8cc7537fb27..8235655e03221 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -117,7 +117,7 @@
 90	common	dup2			sys_dup2
 91	32	setfsuid32		sys_setfsuid
 92	common	fcntl			sys_fcntl			compat_sys_fcntl
-93	common	select			sys_select
+93	common	select			sys_select			compat_sys_select
 94	32	setfsgid32		sys_setfsgid
 95	common	fsync			sys_fsync
 96	common	setpriority		sys_setpriority
-- 
2.43.0




