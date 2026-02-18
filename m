Return-Path: <stable+bounces-217257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHfSDSCclWnxSgIAu9opvQ
	(envelope-from <stable+bounces-217257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:01:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BD155C19
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC497302F430
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF203090C6;
	Wed, 18 Feb 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvKF2VaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C53081CA
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412497; cv=none; b=uYxn1XxGJHKXXKSiKPn5ZO+KJ2qWrPFvR0Z+4Gk3f8zhtXpg9xs7KAbYpMRMFyD0NGSG1D60xSAzIm7+edTl9VCItzGzr8qDJdh6qV6b2ic4xjKEsr0cpJP/XXnG26oAYD3/bsUshyi0wG5kTLmnrlXmW2RFVTciXFjA7widZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412497; c=relaxed/simple;
	bh=BGuuST+/Iv1ZSFBKnarbpFXQl7OBzI0rO9uKaH1X0i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBmp/qt0YjxfQtBRm3Xlki0CjFyRzlx0yIKA9joXmlaiu6WDCppZIg4pd2hr9gHrZYyskPvv6CYNu65NP/noEyFgHqq22XSTM16z6rIvUGQ35fK/m0o8ZNSirExj9ibGMfb9bIEUnXGBcE60c5OngyTDny+BpYri5zZF9v9wFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvKF2VaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA50AC19421;
	Wed, 18 Feb 2026 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771412497;
	bh=BGuuST+/Iv1ZSFBKnarbpFXQl7OBzI0rO9uKaH1X0i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvKF2VaKO2Dz6w3eX8jyUU1+okXBCC6EXvOSh0IgzZfIwS4ZUBC9lBQhKdlFnmACH
	 vK2XShx0XzVjD7yxKoVkqcZ2NTIwHR/kWoV6LOyBIXSPe8smKmCKB0DER6+j2QqGp2
	 P8QQ3l31Kb3n/f/tXlVms/6eZjdkg7ImJaclnETudLInb2ulgW7i7xUhsmFtciax/H
	 t9OHvMLLA3+NQhLJo3aYTaph2GrWcTQizaUk8QFE8VXSL1qaBVBC49So0+/sUQe9FZ
	 9D8GFqFQIIbo7SSjFSIw1X19E85CE9KcVVBl5r59aY/CfpbkO9ySiQah0Md1ebVS79
	 N9f6z95oCpZkQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 5.15.y 0/6] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Wed, 18 Feb 2026 12:01:23 +0100
Message-ID: <20260218110129.41578-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012608-tulip-moisten-c6f6@gregkh>
References: <2026012608-tulip-moisten-c6f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217257-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,suse.de:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: B44BD155C19
X-Rspamd-Action: no action

Backport of [1] for 5.15. Backport notes are in the individual patches.

I'm also including a cleanup/fix from Miaohe that makes backporting at
least a bit easier, followed by the fix from Jane.

Tested on x86-64 with the original reproducer.

[1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/

Cc: Jane Chu <jane.chu@oracle.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>

David Hildenbrand (Red Hat) (4):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/rmap: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

Jane Chu (1):
  mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Miaohe Lin (1):
  mm/hugetlb: make detecting shared pte more reliable

 include/asm-generic/tlb.h |  77 ++++++++++++++++++++-
 include/linux/hugetlb.h   |  17 +++--
 include/linux/mm_types.h  |   1 +
 mm/hugetlb.c              | 141 +++++++++++++++++++-------------------
 mm/mmu_gather.c           |  33 +++++++++
 mm/rmap.c                 |  38 +++++-----
 6 files changed, 210 insertions(+), 97 deletions(-)

-- 
2.43.0


