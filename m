Return-Path: <stable+bounces-273894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AvbAFusdVWqWkAAAu9opvQ
	(envelope-from <stable+bounces-273894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4374DF32
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:18:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=gwrgITpl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273894-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273894-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6315930CC8FC
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285A2701BB;
	Mon, 13 Jul 2026 17:15:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B3346A01
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962942; cv=none; b=UhrP1hhIWnNcltoM/cXCCQW3nwl07PYWoBKHvsIS1pDJlD2B5wmFlZXm2/j4BUpG9WnPb/+1X9w8BKjzVRFBlOLjt8j/73DtKTQr9A58GgwjeprXm2EkpIXrwS5eEmsARzcae+tUxLa5UxT8M5v5JlskXsq+wlzMPNmVJZ8bgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962942; c=relaxed/simple;
	bh=5xqdn2MG8EMbx57mqkJmkxO2vcQq47DaGhOVz3FDHIM=;
	h=Date:Content-Type:Subject:Message-Id:Mime-Version:To:Cc:From; b=Vvrq/1HDRp6RM3FcKE74CfVPUM0Tuf4pWzDSLoX4BlUcUR9KZDtZ46DY+WwhofcZXhMIfcbqF0V5NJ5yTNUu08mx77gqp32FeGWP+WQr7FlA47C428k2d85KDgFEIu/ZFSX98KAQvSLIElbLnddKQQBXMjMm1FwHbBhp22Ruhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gwrgITpl; arc=none smtp.client-ip=209.127.231.111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783962926; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EhzDAb+qkscwAvcITNaP5V9HM6bbzYTebqCVp/u0Das=;
 b=gwrgITplNd33XsQaP+yqa9caiECxYCIGgRU/ssSuQl/uVsdfxnzkOD+OUVtRfJAxHqSU/+
 3BPlO6k930EWwCVgCbw48hLMJ98TI+jEmIMJsbY+fTGDxQ3dC4PZTg3+smdnf/yy2xYhfo
 P8edRo5KCzeYUGcf7SQOdqzkU51SfO65UDmWuFcLLjSeg0zG88z/mSiP5AKOMoI+NkiDBb
 o1lQVvMs9wNTi56iAYXcMiAZYYTKo4GM5VWWZJJt9T/m4QPobF5fHGcyzx4PKGA/N5hkul
 WNBImWL8bBVCtcVyzARtUgMAUvXqRHYj4Qpldtw5+d1ixvhbkS8PP6Vyj/dTgQ==
Date: Tue, 14 Jul 2026 01:14:54 +0800
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
X-Original-From: Xiangfeng Cai <caixiangfeng@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 0/2] mm/hugetlb: fix list corruption in allocate_file_region_entries()
Message-Id: <20260713171456.300518-1-caixiangfeng@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, 
	<osalvador@suse.de>, <david@kernel.org>
X-Lms-Return-Path: <lba+26a551d2d+92f900+vger.kernel.org+caixiangfeng@bytedance.com>
Cc: <caixiangfeng@bytedance.com>, <richard.weiyang@linux.alibaba.com>, 
	<baoquan.he@linux.dev>, <shuah@kernel.org>, <linux-mm@kvack.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
From: "Xiangfeng Cai" <caixiangfeng@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273894-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[caixiangfeng@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:caixiangfeng@bytedance.com,m:richard.weiyang@linux.alibaba.com,m:baoquan.he@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixiangfeng@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,bytedance.com:from_mime,bytedance.com:dkim,bytedance.com:mid,suse.de:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EA4374DF32

To: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

allocate_file_region_entries() refills resv->region_cache with freshly
allocated file_region descriptors.  It allocates with GFP_KERNEL, so it
drops resv->lock, gathers the new entries on a stack-local list head, and
on regaining the lock moves them into resv->region_cache with
list_splice().  list_splice() does not re-initialize the source head, so
if the retry loop iterates again -- which happens when a concurrent
region_* operation on the same shared resv_map consumes cache entries
during the unlocked window -- the next list_add() operates on the stale,
already spliced head and corrupts the list.  On a CONFIG_DEBUG_LIST=y
kernel this is a hard BUG(); without list debugging it silently links a
kernel-stack address into resv->region_cache.

This was observed as a real host panic on a dense KVM host where a QEMU
guest-RAM hugetlbfs file was mapped MAP_SHARED by both QEMU and a separate
SPDK/DPDK vhost-user target, generating concurrent region_* traffic on one
shared resv_map.

Patch 1 fixes it by using list_splice_init().  The bug is present in
mainline; the Fixes: commit dates back to v5.10.

Patch 2 adds a selftest that reproduces the race (opt-in --trigger mode,
since it panics a vulnerable host) and runs a safe single-threaded
functional check by default.

Xiangfeng Cai (2):
  mm/hugetlb: fix list corruption in allocate_file_region_entries()
  selftests/mm: add hugetlb_region_cache_race regression test

 mm/hugetlb.c                                  |   2 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb_region_cache_race.c  | 315 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   1 +
 5 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb_region_cache_race.c

-- 
2.55.0.122.gf85a7e6620

