Return-Path: <stable+bounces-242225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE45GZr582lo9QEAu9opvQ
	(envelope-from <stable+bounces-242225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC364A9646
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B22E13034CAC
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5C23EA8B;
	Fri,  1 May 2026 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKJV6/QH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F490273D8D;
	Fri,  1 May 2026 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596794; cv=none; b=vGfvZ9H0BVDYJ58UJsib8cRWqJusZsTFzjylzXED1cewLthfTszITVIL/5ZJZZVEXpz7pUeA7s9sxJL12XWa0ZE/bq8VhrBzAGQzt10o1pS1DD3Izz7zOpdCvQUeoRZXk3J4eL41R0q0DszccL9PcYK+WyZXLRvO0RMRbaMDzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596794; c=relaxed/simple;
	bh=J009uALaMNGkc1EoBMX1tkYlbX2OyU5ubo2x3SyVJy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVOn9qmvcoFJ9Q6qcylO81tDeRnuAU321BTuTUhr2P3z2eyGbTttyZs9dGH5CYsY8jKMDYOL/xb+1W4BwF5lJwiys6uYnKSzRkwCrw1QXu26QaVxOjDqvex/v8ZqNMDjkk+S2MudTBEdnJCDk1MoeCNwbcu0/M/7ONcqZYokyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKJV6/QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87313C2BCB3;
	Fri,  1 May 2026 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596794;
	bh=J009uALaMNGkc1EoBMX1tkYlbX2OyU5ubo2x3SyVJy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKJV6/QHp5wIkyq9r2SYDCUkNMNoQdp0lsKcg+1qtaa4iTq1f9hcPO3KLv1tGhPkV
	 7J2B3CoRFsTQw1WlGQZs57me7tCzlJT+BTWtOsXmYU6jisFE3n6RZKmxP57jHwVQFi
	 hYC9Raa89LvSa+vnYQCJkclbYhe1YTSM3YM6bmUNEymeHtcub52lW9zMVAsC4I1uFZ
	 HP1j8IUuBJAT7bv4wTdI9pXeK4B4fNWbSA90N6z9p49uLgt/rsoDue4rWbf3lNc9wI
	 RSFpaKpdW9MYYL0ruOhmp+Y8vdN+EzsQYj+F9ymdpSYjmOiFNZKA0MKHH5ss3XP9bw
	 q/aChTDWdaHfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
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
Subject: Re: [PATCH 6.12] mm/memory_hotplug: fix hwpoisoned large folio handling in do_migrate_range()
Date: Thu, 30 Apr 2026 20:53:11 -0400
Message-ID: <20260430160000.item005-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430113731.1227-1-adiupina@astralinux.ru>
References: <20260430113731.1227-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBC364A9646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-242225-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[astralinux.ru,redhat.com,suse.de,linux-foundation.org,suse.com,gmail.com,kvack.org,vger.kernel.org,linuxtesting.org,huawei.com,nvidia.com,kernel.org,infradead.org,pankajraghav.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]

On Thu, Apr 30, 2026 at 02:37:31PM +0300, Alexandra Diupina wrote:
> From: Jinjiang Tu <tujinjiang@huawei.com>
>
> commit 397f6d14f9c370e4910e6885294c340f39dedbf5 upstream.
>
> In do_migrate_range(), the hwpoisoned folio may be large folio, which
> can't be handled by unmap_poisoned_folio().

Thanks, queued for 6.12.y.

--
Thanks,
Sasha

