Return-Path: <stable+bounces-50831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3EE906D0A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E94B25C4E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E21459FA;
	Thu, 13 Jun 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Upsy25Pg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DF14386B;
	Thu, 13 Jun 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279513; cv=none; b=dP15t/f4atI/6j7fwuivw7lUGg/lBWOgiydSOGkqXwZOT/xDu7LUPdjOyXTyX16Dh3KAKq9yfjKeChICrv1I8Li/19M0q8515ZAqoP/pMrdgK230EBKNCh6pN5GZe+MSRkd3tyksDwYLwjJ6KWyNZhn/Rl8X1amX8nAcOLxa8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279513; c=relaxed/simple;
	bh=P4vy0wa+6vTv9VJrPowp9JpPBv3nyuAOqUo/128aHG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUwGNs2nVm0unWer9AXtEDU1qJ7Qt3hJkpnRkOwiAj5br4d5G9YRz/ccR19AxlctwQcLxNKOGNdTuKEUwLHqnRNEgn9AEPEKtfE8jMmXjwe1qUQU3j/Yu4b9YhtHa47h+K8i0pgDx9O5CiI11xUmjM5vgrF/EvnUX4vJ53bFrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Upsy25Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF3C2BBFC;
	Thu, 13 Jun 2024 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279513;
	bh=P4vy0wa+6vTv9VJrPowp9JpPBv3nyuAOqUo/128aHG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Upsy25PgSiQ7bV2BCjk1i50CHd1WNvrDnVC5gT3DsQQoHa5aH9wKvyU1oLYJmeXwz
	 J91ZgNItukd/Bg0FGG01HHqrI0ORoybKLgOVgkZhw6s6LGdy1qxq3YWgl5B6eRu0aX
	 xeQeUZmCiDQYHxplopSCXecuo+8Aaxl3CmOdvRH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9 102/157] selftests/mm: fix build warnings on ppc64
Date: Thu, 13 Jun 2024 13:33:47 +0200
Message-ID: <20240613113231.366266784@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 1901472fa880e5706f90926cd85a268d2d16bf84 upstream.

Fix warnings like:

  In file included from uffd-unit-tests.c:8:
  uffd-unit-tests.c: In function `uffd_poison_handle_fault':
  uffd-common.h:45:33: warning: format `%llu' expects argument of type
  `long long unsigned int', but argument 3 has type `__u64' {aka `long
  unsigned int'} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Link: https://lkml.kernel.org/r/20240521030219.57439-1-mpe@ellerman.id.au
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/gup_test.c    |    1 +
 tools/testing/selftests/mm/uffd-common.h |    1 +
 2 files changed, 2 insertions(+)

--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -1,3 +1,4 @@
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <errno.h>
 #include <stdio.h>
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -8,6 +8,7 @@
 #define __UFFD_COMMON_H__
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>



