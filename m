Return-Path: <stable+bounces-271901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QMgWIedqSGpWqAAAu9opvQ
	(envelope-from <stable+bounces-271901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E170706735
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jz7SoV2m;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271901-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271901-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CD77302247A
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA06433E84;
	Sat,  4 Jul 2026 02:05:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937143749F7
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130749; cv=none; b=d2/3X/Hsc7c6NwYJPBNBAVo2qaSyIoMBZWAwP1mzgzhxt6FKZzJYBrSGdJCzGCx8lF+cZ4NZoKmddEPvREYUzsrxTOZfpLy3An0R1nUPBcQaq01L1Qi0IwV6WZyU2WVfF27es0fy8i/bdAJ8b4shs1EUXHEspxfy43xbKHJmQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130749; c=relaxed/simple;
	bh=p2esmnv3C4tAtf/2wdWCj8HNGs/JBx9foPru6p5TLGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTv1BfXUe1w6tbJQ/oB8CuV7TezCuUPzZ6w6BoeJ24aTIMqq9pPagHZWd8109yotL3ah+pKvLPc8LcZ6fvQzwANI1EPUXoSDAb4nAQv3RiM2R3rcC/7yew7EZ9rzuAYoyPYbhDF6YqGT2dIL6wpDSl/4rwA2jo615iEDCb1MGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz7SoV2m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181AE1F000E9;
	Sat,  4 Jul 2026 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130748;
	bh=81PCE2mbwOgj8kX6gc2Z2Hk9aUjJ1uNYjYVBkzh6qwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jz7SoV2mbK0kkcDiWeKLz8bS1DcTwg2TeBQ4JS4OJku37uVDxMqwXX3qzFnKAgUgi
	 oTROFkTDTswR2CeoZHrBTRzEcS6oguuQGmLJpQjGML1ZXtHBY9n3Kt6g/Tioaj1OlJ
	 VD2Ff7DCImAOtWyJGCJi3MfXhL/pfaqus6dG6bCwheIVvRWnAYeJw0jDfzcdQ3y7wf
	 FS6TvA5nTF75k7VnLiMV5HUBtqtrunbSnUFkOh2Smzl9HaAcDcgCb+KtEpAjKN3Tfw
	 qeqWiY5kryThVqmCQHkHp8QdgNGdIqe7NgeZCTxrMq81SdUf+d0Q+PRSvKw850+vUa
	 y8c2bjWdXenEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 7.1.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:12 -0400
Message-ID: <2026070315-stable-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154908.975523-1-kas@kernel.org>
References: <20260702154908.975523-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sashiko-bot@kernel.org,m:ljs@kernel.org,m:david@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:peterx@redhat.com,m:surenb@google.com,m:vbabka@kernel.org,m:balbirs@nvidia.com,m:akpm@linux-foundation.org,m:kas@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271901-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E170706735

On Thu, Jul 02, 2026 at 16:49:08 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 7.1.y, thanks!

-- 
Thanks,
Sasha

