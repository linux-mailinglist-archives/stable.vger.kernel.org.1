Return-Path: <stable+bounces-262153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gwJ1DEJkJ2pYvwIAu9opvQ
	(envelope-from <stable+bounces-262153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D660865B76C
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aTLCtw3r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262153-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262153-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B81F3057CA7
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58D3019D8;
	Tue,  9 Jun 2026 00:52:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193F2E040E;
	Tue,  9 Jun 2026 00:52:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966346; cv=none; b=FTKUVUg821svlK60wrKaAR4brB2RgotPTRho95WK88yMnfK5sFdukLsvM+wkNjENmBcceqEgt+dPNGpbP4w9UTPXmqxYOo/vDicgBj0cF29quuTKT/KTVxGpLZx71s0Lx6xIE7zPQg3ZeRHTRS3K85//fU0Uh0p/5SMUpNcIKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966346; c=relaxed/simple;
	bh=huvuw9ocJVMaJPY69c7Y/32YsqsUK8XeDkGkdakdgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbtd2kJSjQQgpGcoRkD+cyN46ianfZyJ2DV75VGulmQFffvPaNXiTfYoI3MEiAaIOfkICA90lTih4DinYvDgCywMT6liQSAxTy9I/Dw2E73TwW1xOOIloGCCPeGfVbC55gSQH8ZhF7zTr3JgzOitC1jUn4lRUlVvCX7ih6+sCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTLCtw3r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B61F0089A;
	Tue,  9 Jun 2026 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966345;
	bh=huvuw9ocJVMaJPY69c7Y/32YsqsUK8XeDkGkdakdgRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTLCtw3rpDDm7zkXqLgSU0rqtauNij+Z39bxQM16InMfMO8/XgdH+ZvQ4qtergGM3
	 lQZF5cp9zeYnHWI0y7HaSJDHon1xpD3oC1wPyCJ8XBA5+Av2Ic42XBhP29VlPPVY+l
	 JjAmDTJco/vLsm71tralhY/NdYJBhmvGtJSD1D5os8UuHUCl6Z/kl4FH/GwgoaaXHD
	 TGT6rMqX4mepsVQFEB5i/39RS4jYv0LyCf1IoA6aCiU0d5YYM8/z8oCk75x8oCC3Kk
	 vmwMrPSFSNbf5b8i6KkISi6eRTHxqr9ypkoQAcepKd8x0S1W/Y3aCH+EIxngHExHAX
	 b0HSFNm4cndbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Pankaj Raghav <kernel@pankajraghav.com>
Subject: Re: [PATCH v2 6.1] mm/memory_hotplug: fix hwpoisoned large folio handling in do_migrate_range()
Date: Mon,  8 Jun 2026 20:52:00 -0400
Message-ID: <20260608-stable-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605190756.20413-1-adiupina@astralinux.ru>
References: <20260605190756.20413-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:adiupina@astralinux.ru,m:david@redhat.com,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:n-horiguchi@ah.jp.nec.com,m:mhocko@suse.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:tujinjiang@huawei.com,m:ziy@nvidia.com,m:linmiaohe@huawei.com,m:wangkefeng.wang@huawei.com,m:mcgrof@kernel.org,m:willy@infradead.org,m:mhocko@kernel.org,m:kernel@pankajraghav.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D660865B76C

> [PATCH v2 6.1] mm/memory_hotplug: fix hwpoisoned large folio handling in
> do_migrate_range()

This inverts the folio_isolate_lru() check on 6.1. In 6.1 folio_isolate_lru()
returns an int (0 on success), not a bool, so the "!folio_isolate_lru(folio)"
condition is backwards here and takes the wrong branch on a successful
isolation.

--
Thanks,
Sasha

