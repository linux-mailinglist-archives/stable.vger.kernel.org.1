Return-Path: <stable+bounces-216741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ3fD+RUk2lD3gEAu9opvQ
	(envelope-from <stable+bounces-216741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:33:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E0146B8E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7963630156F7
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D69265CBE;
	Mon, 16 Feb 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBrM+5yN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D033993
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263199; cv=none; b=MK59VETMqs/qq/IP3fjnFhsMz892gQuaPLRufu/PWRlryEA1gDGb6ORFOrhHZWM8iwYAILspwR5FW9Xm6lvHBS/b+BbCOzyWADT0W4hwY4el2HNw7Sa0teoZieA5qtKeuID5n6dCKqgLZupoLJoddZhhbl2NiyjpsraJHZFEcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263199; c=relaxed/simple;
	bh=W2R+ulVW4Ddxn3DA4p20lOhEWkpo9PpZPDzZZi14Ebs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU2mOE+VyTYRoYsv1T/0ARCAtgF2ckAOCGtzmn9CcBpniY4HFVDWamX54LMVM0kYIMZ9reVnMutQhdFOrjq7wA8bTOgvY5syks6B7Uejjsfi7iIPt1KgpdGlBkBeaf+3SUOINXqaqLi6I4jTttWRKdx3bGCLO/eaP9AJdl/8zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBrM+5yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55928C19422;
	Mon, 16 Feb 2026 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771263199;
	bh=W2R+ulVW4Ddxn3DA4p20lOhEWkpo9PpZPDzZZi14Ebs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBrM+5yNI6tRf56gCsiOAX1WZTvAsERaa6PfxA6eztS1rdouvHlPjEqzPIzhWeYtl
	 JFttHEcSQP2Kg+eQ24D/Ptehj9RG6o2DdSJ1p/JnWPSqsdLBsPzKaTp6xXJ0mA4j2P
	 zpGycp/SHftog/ZOKE2x5Yt3OseFLfU3aH5B+jEp5tMBhO7OE5+FXLDD5XpKNLwURg
	 Oy4HUoLL203d3tj99EaANjUS40oGu2a4LxiZv+bJwm/YdyIao7S3htUY+JjtVtRUVE
	 XwMoLB6vUv+LjR8DoXx9hXToiS7+9CYi2rdpqJs4F/1zqhVgGuNy6SHkB9j2vWuYd5
	 N1YP+Rr6FOgGQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 6.6.y 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Mon, 16 Feb 2026 18:33:06 +0100
Message-ID: <20260216173310.230841-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012603-stingily-washbasin-9371@gregkh>
References: <2026012603-stingily-washbasin-9371@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-216741-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 964E0146B8E
X-Rspamd-Action: no action

Backport of [1] for 6.6.

This is effectively identical to the 6.12 [2] backport.

[1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/
[2] https://lore.kernel.org/r/20260216165213.225922-1-david@kernel.org 

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


