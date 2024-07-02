Return-Path: <stable+bounces-56657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CA924569
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764DBB218D3
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCB1BBBD7;
	Tue,  2 Jul 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FahKWJkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789414293;
	Tue,  2 Jul 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940915; cv=none; b=R/DaLjxW9bKniPjurRpIfMLS2ecUFY/Sg3484QDDV+kxOFkzteo01jZve1S9m/hI2CuA6Ead8mi2/xiNy3igRtYCCdwRZc+AZxl57mq69ii4ND98FH4jCQSyH6Q8K2wO+KL0liK8tWOR8aJmkbE0FmMxWHj9mmrdGvV8cni4JuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940915; c=relaxed/simple;
	bh=hdXozXLfdRnvok+0HCY5FdA/YfFQySySf6mAKJGgAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5BVygDuOa+Ctgh4afRmchpOseiwR25xcr8om9lA8vt56gwAY+pIZ3Uiu7YxUWA5fTYOPoIl6ziVqz4/uXX7FfXtSOJtEZmBZls7RJWG4cHDorJs88W20n0nP2mrE9CEsD6bwLiufM1OHtPcYdK2phZ8wuZF8agz5oNY/Kny4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FahKWJkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12508C116B1;
	Tue,  2 Jul 2024 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940915;
	bh=hdXozXLfdRnvok+0HCY5FdA/YfFQySySf6mAKJGgAeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FahKWJkDtm5ryk0aNOQRQu1vsiSzo1ekGXmoqFGKF8A/4x9TdQd2T7rrhfiyhpG2m
	 zDbRw75lAvn6ehAMArG4glo+LppU0NI4Aa1fesBewWPVYlDE4cWqM0OKoqqxv0QebU
	 ncwT5OJoQuz8zIg4pTmnjIc5t+6YQ14+MELq2nUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/163] parisc: use correct compat recv/recvfrom syscalls
Date: Tue,  2 Jul 2024 19:02:38 +0200
Message-ID: <20240702170234.730134031@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 20a50787349fadf66ac5c48f62e58d753878d2bb ]

Johannes missed parisc back when he introduced the compat version
of these syscalls, so receiving cmsg messages that require a compat
conversion is still broken.

Use the correct calls like the other architectures do.

Fixes: 1dacc76d0014 ("net/compat/wext: send different messages to compat tasks")
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175b56f96..47b3bb90080de 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -108,7 +108,7 @@
 95	common	fchown			sys_fchown
 96	common	getpriority		sys_getpriority
 97	common	setpriority		sys_setpriority
-98	common	recv			sys_recv
+98	common	recv			sys_recv			compat_sys_recv
 99	common	statfs			sys_statfs			compat_sys_statfs
 100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101	common	stat64			sys_stat64
@@ -135,7 +135,7 @@
 120	common	clone			sys_clone_wrapper
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
-123	common	recvfrom		sys_recvfrom
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 124	32	adjtimex		sys_adjtimex_time32
 124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
-- 
2.43.0




