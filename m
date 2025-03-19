Return-Path: <stable+bounces-125607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F7A69BFF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B717B00D4
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1595215F63;
	Wed, 19 Mar 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fUGv+Xve"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEF21C177;
	Wed, 19 Mar 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423152; cv=none; b=js0OYMEQKOEiktu7qZmYg69+G+dYxiz8oK1DvO56Qr5FphChP2vgdyJUkTOqE1mUl3eBGVxln8sI11m+tQldrallVOExW6gJucoYVI83bB+e8G+IV26jB2Zbjw8HhyvgsFL6weOVdJsL0wQgr2jvBWMxCM4XzHJ0Gli4kKN85Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423152; c=relaxed/simple;
	bh=/DnXj7sM/hLH45jFZvnswxZZ5+2GzTWmiSt7GfwFTeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=boPQJq1/qQKa5041JCyJRJ/7oB8hEAvKdAio7J+yvbpgboXsjqKPBPTWG5Kw7c1EKqlQX+fsPvq/mw5AsdcL2YrTwubipDQwt+eVXVAlGhQytt9gt8ZL/0XccDbKthHw5U+DPKlqpfMOzLmBEoNfoU1lYl28I/rUsigO76lkIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fUGv+Xve; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 9C6202116B2E; Wed, 19 Mar 2025 15:25:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C6202116B2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742423150;
	bh=XMFT8EH3mSyVgesDwkhGIBj4pkS8bIEYZ5xxGIAAWPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUGv+XveaHdkgGyPHlkLf3SdCfeDxcbMPdlZhpwyo0lkTYJPczEPaFrNNdqudWFVs
	 Nzafx0ikb4J5RTshNlrUVhhuAoZwZZgj3n8gZicbHYqDlOAuaBbFAu5p3Wp/h56ppe
	 jIj98P82ELB2Y24jxz15ixnrBM3O65mPLqbQcevM=
From: Hardik Garg <hargar@linux.microsoft.com>
To: frank.scheiner@web.de
Cc: dchinner@redhat.com,
	djwong@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: 6.1.132-rc1 build regression on Azure x86 and arm64 VM
Date: Wed, 19 Mar 2025 15:25:50 -0700
Message-Id: <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de>
References: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

v6.1.132-rc1 build fails on Azure x86 and arm64 VM:

fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use in this function); did you mean 'tp'?
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~
./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
fs/xfs/libxfs/xfs_alloc.c:2551:51: note: each undeclared identifier is reported only once for each function it appears in
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~
./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
In file included from ./fs/xfs/xfs.h:22,
                 from fs/xfs/libxfs/xfs_alloc.c:6:
./fs/xfs/xfs_linux.h:225:63: warning: left-hand operand of comma expression has no effect [-Wunused-value]
  225 |                                                __this_address), \
      |                                                               ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
  CC [M]  net/ipv4/netfilter/arpt_mangle.o
  CC      net/unix/scm.o
make[3]: *** [scripts/Makefile.build:250: fs/xfs/libxfs/xfs_alloc.o] Error 1
make[2]: *** [scripts/Makefile.build:503: fs/xfs] Error 2



Tested-by: Hardik Garg <hargar@linux.microsoft.com>



Thanks,
Hardik


