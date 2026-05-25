Return-Path: <stable+bounces-254223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrAOgXEFGo2QAcAu9opvQ
	(envelope-from <stable+bounces-254223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:49:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D245CEED4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 230963004635
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676A3264E6;
	Mon, 25 May 2026 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZNqoi1or"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400F28643C;
	Mon, 25 May 2026 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779745791; cv=none; b=OAc58tfo/1mc84DG5lHpeM17O0pjGK7UnBIlx4hBTAhENNx7gXjWEX+reHlCIOPDHxfROYVWBN2CpU9+D06e6i3+CULD6d6SqPZdVHdlU4AJP20WVRH1jevgqxyVBuI3p7Zj1cJZi4GmHScv+N7buMCbP4Gnuc/Z2oW+nHgZbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779745791; c=relaxed/simple;
	bh=BQPqUbr/221QkSI0n4CAAJAOk/W26VAjGGPu4JcIddE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SoWC+BZP4/GaeQU5OkE2wR6E/C+nbBQQFp27HjBfCczZwVK7/b93ULztFuxf5LMA365rbZWjaCm6X2XKF7SP+HUY0VzzTnqJi2ewmRwEHQtifbybWkQO5F9rw+Q+fTrI1h54T7c46LQkrm19jk9vgCkjbNXDHbZAfixQOol2ZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZNqoi1or; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FFD1F000E9;
	Mon, 25 May 2026 21:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779745789;
	bh=tOA4XN1b++rVbl7WSQVELFj3i2FB21qxO/Z236duQus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZNqoi1or54qhwFMse+1X3LqVJCm8QFzpiEErxDlPFtbwhOosSzV59KgyOxtW2iICq
	 k/4lx8AM7FnMG3CYu5NU/cdR5dwgmLEb0SkHt6pRLEc4KTEFvl7UbienZLOfNhMH0n
	 DLoOLRNpwh6sbxWwVgImzQuqEwRYSWqh2g94qL6Y=
Date: Mon, 25 May 2026 14:49:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb_vmemmap: fix incorrect vmemmap restore in
 rollback
Message-Id: <20260525144948.15e51eb81151e498cc2af999@linux-foundation.org>
In-Reply-To: <20260525025213.2229628-1-songmuchun@bytedance.com>
References: <20260525025213.2229628-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254223-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:mid,linux-foundation.org:dkim,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E2D245CEED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 10:52:13 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> vmemmap_restore_pte() rebuilds restored vmemmap pages from a
> tail-page template derived from compound_head(). This is wrong when the
> current PTE already maps a page whose contents are not tail-page
> metadata.
> 
> In the rollback path of vmemmap_remap_free(), the first restored PTE is
> backed by vmemmap_head and contains head-page metadata. Reconstructing
> that page from a tail-page template overwrites the head-page state and
> corrupts the restored vmemmap page.
> 
> Fix this by copying the full page from the page currently mapped by the
> PTE. Also pass vmemmap_tail to the rollback walk so only PTEs backed by
> the shared tail page are restored, while the head PTE remains mapped to
> vmemmap_head. Add VM_WARN_ON_ONCE() checks for unexpected cases.

Queued in mm-hotfixes, thanks.

> Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")

A "refactoring" patch caused a regression?  Ouch.

This patch caused Sashiko to identify a possible pre-existing mem
hotplug race:
	https://sashiko.dev/#/patchset/20260525025213.2229628-1-songmuchun@bytedance.com

