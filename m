Return-Path: <stable+bounces-100880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA5C9EE450
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7091889A56
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B023211493;
	Thu, 12 Dec 2024 10:38:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31A211470
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999927; cv=none; b=sZzHvBblh3wPo397YxOK0CsEkK/vitw0JpxxPhpJcMX0t8PEbGjcPoYf4E1oEgS9Zdb7ZtImZTWzcINayJI0l+YGrYry7VClH1KTlpG29LVvghQ/FCibCaJ3WvctE0BqFtJpnvU1f0qwZFNufcHOnn127fu0skL95hK9o01uu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999927; c=relaxed/simple;
	bh=tEKhjoM7yfd+8Vt2bSFl1WD/ymRVgf/t4NMj+y7F0cY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=r4TyigxggOnJNzQZORwblYg0Zs8jE2n/aov5gwIu14ldTQnopVeBuqzQppzqco8l+KgbX+owRFLvRFZNmQcTuK7sxgSzmM0EoLbnT12NDwk+hHRPrSvLmoQFhC6eyd4+hXau/+R3jCHi2wggj5BdwXjx0EpDL6WTWuZloWe0y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 34A5EEC005B;
	Thu, 12 Dec 2024 11:33:00 +0100 (CET)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 17CB7EC0057;
	Thu, 12 Dec 2024 11:33:00 +0100 (CET)
Date: Thu, 12 Dec 2024 11:32:59 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Heming Zhao <heming.zhao@suse.com>, Su Yue <glass.su@suse.com>, 
    Joseph Qi <joseph.qi@linux.alibaba.com>
cc: stable@vger.kernel.org
Subject: ocfs2 broken for me in 6.6.y since 6.6.55
Message-ID: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.4.1/27484/Wed Dec 11 10:42:35 2024


Hi,

ocfs2 on a drbd device, writing something to it, then unmount ends up in:


[ 1135.766639] OCFS2: ERROR (device drbd0): ocfs2_block_group_clear_bits:
Group descriptor # 4128768 has bit count 32256 but claims 33222 are freed.
num_bits 996
[ 1135.766645] On-disk corruption discovered. Please run fsck.ocfs2 once
the filesystem is unmounted.
[ 1135.766647] (umount,10751,3):_ocfs2_free_suballoc_bits:2490 ERROR:
status = -30
[ 1135.766650] (umount,10751,3):_ocfs2_free_clusters:2573 ERROR: status =
-30
[ 1135.766652] (umount,10751,3):ocfs2_sync_local_to_main:1027 ERROR:
status = -30
[ 1135.766654] (umount,10751,3):ocfs2_sync_local_to_main:1032 ERROR:
status = -30
[ 1135.766656] (umount,10751,3):ocfs2_shutdown_local_alloc:449 ERROR:
status = -30
[ 1135.965908] ocfs2: Unmounting device (147,0) on (node 2)


This is since 6.6.55, reverting this patch helps:

commit e7a801014726a691d4aa6e3839b3f0940ea41591
Author: Heming Zhao <heming.zhao@suse.com>
Date:   Fri Jul 19 19:43:10 2024 +0800

     ocfs2: fix the la space leak when unmounting an ocfs2 volume

     commit dfe6c5692fb525e5e90cefe306ee0dffae13d35f upstream.


Linux 6.1.119 is also broken, but 6.12.4 is fine.

I guess there is something missing?


     Thomas


