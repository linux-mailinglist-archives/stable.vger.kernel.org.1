Return-Path: <stable+bounces-253862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGrmGT/iEGpqfAYAu9opvQ
	(envelope-from <stable+bounces-253862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:09:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13E5BB5C0
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE9593009994
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059338F926;
	Fri, 22 May 2026 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQZ8sveZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643838836C;
	Fri, 22 May 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491386; cv=none; b=JbIPAfpOGVHl41uNOoenEQxTy2niG46DVjYhi4/s4NvbytZASzjzrBuK+ZqVnoIVLyrJ4lxYOqa7BNiDe5C+xu4qm2yF+wJOnNG3feO+j+0QnDh4mIXBiMYSYBW9DK7vijSGdXp98hnCk/+kd4fz12ksmJN3R/OykBZ1N4uz408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491386; c=relaxed/simple;
	bh=uutmPtII2EQBL6vO0i0jqU5bYG0r+6vcKdT2D54nMBo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YhVDWYMg94yOMXjJiqeaq/FtwPcKSqleBRX1rWyqt7dMbtqKTtUbFkt0a6xcP2YPhQ0e9Ym6XmN/Ai9Exx+CohwREBy9qdvCTH9p/6yhWtGJ1j2h/s41UbIUbGj4AQBBFi6mvGp+3trKosXwn8mcf3VVusLAkeg25II93CxQzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQZ8sveZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A7E1F000E9;
	Fri, 22 May 2026 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491385;
	bh=SRNn+HK5PU4+WE2ZZvd2N1n519hA+9ALeyWVGg6XpfE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YQZ8sveZ9qkjOvzrCCwjNmTRffNqCV1nLGIZzxyv54dBXtlgt7rvXhODy8FN2533q
	 MiVnn1IVJEGDSSU7p/j2Pi1GyQ96ld3MVOKwlwEttGQc1E21+q0IvvFrl7Xo3XQQcS
	 dOGAXA/PgwYeW3EotaFQSw76Pf7wl0KFW4sCNYdaxZQGlqo3tRgADMs0BFV/BcpfHK
	 /0EElHRH15ECtSUPOPkOn7wVe384hNyH51ICHbG6Y8G1pQZksSjo/VZRhwEjFbRRfU
	 RHDiqavjnifHfaVdLo0CCtWLTeIJmmOsKAlRfq7V+PXP9ZFQpj6gY+KrO2poLmzqZS
	 I4YzsIhKjOfAw==
Date: Fri, 22 May 2026 17:09:40 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    tongtiangen@huawei.com, akpm@linux-foundation.org, 
    pasha.tatashin@soleen.com, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: exclude invalid THP PMDs from page table
 check
In-Reply-To: <20260515065048.94564-1-cuiyunhui@bytedance.com>
Message-ID: <252be770-4d9f-954a-9388-8f7b52a92d90@kernel.org>
References: <20260515065048.94564-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253862-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bytedance.com:email]
X-Rspamd-Queue-Id: CF13E5BB5C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026, Yunhui Cui wrote:

> RISC-V THP splitting uses a temporary invalid PMD state where
> pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
> _PAGE_LEAF set so the MM code can still recognize the PMD as a THP split
> in-progress entry.
> 
> That temporary state no longer describes a user-accessible mapping, but
> page_table_check currently treats it as one because the RISC-V PMD
> user-accessibility test only checks whether the PMD is a leaf and has
> user permissions.
> 
> As a result, when a PMD-sized anonymous THP is split during a COW fault,
> page_table_check can account the invalid intermediate PMD as a live PMD
> mapping, and then account the replacement PTE mappings again when the
> split installs the PTE table. This leaves stale PMD accounting behind and
> later triggers page_table_check failures such as a non-zero
> anon_map_count when the folio is freed.
> 
> Fix this by tightening pmd_user_accessible_page() so PMD page-table-check
> accounting only considers leaf PMDs that still carry either
> _PAGE_PRESENT or _PAGE_PROT_NONE. This preserves the THP split semantics
> required by the MM code while preventing page_table_check from treating
> invalid split PMDs as live user mappings.
> 
> With CONFIG_PAGE_TABLE_CHECK=y and CONFIG_PAGE_TABLE_CHECK_ENFORCED=y,
> tools/testing/selftests/mm/cow completes successfully on RISC-V after
> this change.
> 
> Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks for the patch, but it doesn't apply as-is.  Could you fix it and 
resend?


- Paul

