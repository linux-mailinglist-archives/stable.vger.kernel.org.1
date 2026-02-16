Return-Path: <stable+bounces-216733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAiIHPxLk2mi3AEAu9opvQ
	(envelope-from <stable+bounces-216733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:55:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E447614679F
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D87FE30131C8
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410731465B4;
	Mon, 16 Feb 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/a1lnT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4621257F
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260747; cv=none; b=TsLYA0bMRVBZn6iZHwbHjdmHn0RWOZQgd8Uw7bi9u/e9hkM+LwhETm123UcwcUBL1Jdpbvk3fgaJ4UmGT6b8nB+qdCMysH94aYJdwyk/wXugEHIA8GnnGcRNHMtP7fMdE/ak4hBN2657CH0h1rzS7VAqajH/gruFGZv7N+xk8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260747; c=relaxed/simple;
	bh=wMcKFT43k/vYiLzBdyULbl1qDqzVlZlTmTcgf1CO73s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRwbkWu6yHpdQPUDCO81SvXHc9ih+pvS4p/dSOA8NYoYw5uIGj0uWtHbJFz7wIfv+QRqI+Y8d1bJK0HC+BQjYwTFxrGu9xYRKsDTq6eaomef6sZ6CIK8q9ffHhitL2LzDdHMT4gw+rvKe8EtRHEOU+PScM1I/i0unAkH5zf8znQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/a1lnT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA593C116C6;
	Mon, 16 Feb 2026 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771260746;
	bh=wMcKFT43k/vYiLzBdyULbl1qDqzVlZlTmTcgf1CO73s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/a1lnT+jbhTzempmfQ9u1WAyfOCs8kHCCxzTZbqX3D3pNVmJqUIGD9CI+zq+bVuv
	 90yhzvjJoNgfVZn5C4Hm+XYnVNEFzdCjVKZ6WPMZvU4zTtOSzEuBOppQUvAeUIm6zl
	 d3pdPQlOfFHuPTlLyc4VfWWPL6mhvdpX/muH/+/wAS3Q4NNkk3xQJUhaoxx+oCELea
	 eU8e2cFibuNnRxqnU4FPVBUSA/lopAm/t2/mrh8zuUIkMvb/rUbUgiycUE/Yw5wLyV
	 dm7VhwnBouJdGUFqMcW1K6oSdZFv8GvH5MwCsx90M9lzqiA6iL4DTtTQ08lWqE6BXG
	 M05HTbf2018aw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 6.12.y 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Mon, 16 Feb 2026 17:52:08 +0100
Message-ID: <20260216165213.225922-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012600-amusable-mutilator-97ce@gregkh>
References: <2026012600-amusable-mutilator-97ce@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-216733-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E447614679F
X-Rspamd-Action: no action

Backport of [1] for 6.12.

While
	"mm/rmap: fix two comments related to huge_pmd_unshare()"
was already backported,
	"mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count"
wasn't.

Only contextual conflicts. Backport of
	"mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
	 using mmu_gather"
is the same as for 6.10.

[1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/

David Hildenbrand (Arm) (1):
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

David Hildenbrand (Red Hat) (2):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()

Jane Chu (1):
  mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

 include/asm-generic/tlb.h |  77 +++++++++++++++++++-
 include/linux/hugetlb.h   |  17 +++--
 include/linux/mm_types.h  |   6 ++
 mm/hugetlb.c              | 146 ++++++++++++++++++++------------------
 mm/mmu_gather.c           |  33 +++++++++
 mm/rmap.c                 |  25 ++++---
 6 files changed, 219 insertions(+), 85 deletions(-)

-- 
2.43.0


