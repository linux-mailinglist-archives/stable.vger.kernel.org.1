Return-Path: <stable+bounces-241856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC6ZL3PZ8WmLkwEAu9opvQ
	(envelope-from <stable+bounces-241856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAA492AD8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE34030068F4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0F3A8FE8;
	Wed, 29 Apr 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xEM+oNRW"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F513B47D2;
	Wed, 29 Apr 2026 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457518; cv=none; b=pz2IqYZF28Y/ZrQHmsdL9rfuDiblz5XKeEtq9hFeDIjuwy0gpFFnleZU+w8jRDv1EH8T+ZJo66dS/2YLKtQjqXSMoojvNFHeABTeXlw8hiWY1A81nOjPCzvpx24F6bWCFywF2dc+V9lHMQDc+TO3WZeaTggoepuEjePnYY7J94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457518; c=relaxed/simple;
	bh=PIpMqLnvKeFPStlamgR5UkyiNO93rr7vphpSFu46dyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipgE02ZANkhhxPMA8GNXqk+17LaiWYTkTVtcoBjnyXeOr1NIMUlFUyiRjPO53SJJ1UDqSHp19l0E8BF/gZid7jFdR3sxoFmZfOKhBWULv2xrMYuddKRM/mP8R9D7rlaPJuNUbAeiY4XzwypsGmyGrmu2Jl9UJCw9uVrC8Q3h53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xEM+oNRW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777457504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQnZQYLrTlNYy1jc1rXnnTon8LpqLdCTjRpZns17oGo=;
	b=xEM+oNRWB3iEUl7EvR41PZcCxwM+tlM71BYBVb0m6mTHUTUlRsZy9GVgnWzfYDsO7wLdvx
	qqqBFWU0yQ8IgsOppvyiVpGtZRPXqj5d1PS22xkgYBQtdQrPjdRNGC6Ec9FZq1PHvHQCTe
	D5/aom5/W69PK8yAlF8NAp+unM5fxYc=
From: Usama Arif <usama.arif@linux.dev>
To: Muchun Song <muchun.song@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison accounting lookup
Date: Wed, 29 Apr 2026 03:11:33 -0700
Message-ID: <20260429101134.1358607-1-usama.arif@linux.dev>
In-Reply-To: <A3EF6D95-E3B9-4228-9AED-A7018ED494C5@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 06BAA492AD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,huawei.com,bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-241856-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:email,linux.dev:dkim,linux.dev:mid,suse.de:email]

On Wed, 29 Apr 2026 12:18:08 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > On Apr 29, 2026, at 11:32, Oscar Salvador <osalvador@suse.de> wrote:
> > 
> > On Wed, Apr 29, 2026 at 11:08:51AM +0800, Miaohe Lin wrote:
> >> Right, I missed that. Thanks. But I'm still worried that there might be potential issues.
> >> For example, this function could be called while lock_page is held. Acquiring lock_device_hotplug
> >> while already holding lock_page might cause problems, though I haven't seen any specific issues yet.
> >> Also there might be some other potential scenarios that haven't been considered. Hope I'm just
> >> overthinking it. :)
> > 
> > lock_device_hotplug is a mutex lock, and we already take other mutex locks while
> > holding lock_folio in other paths, so I am not sure I see what should be special
> > in this case.
> 
> Hi Oscar and Miaohe,
> 
> I saw sashiko's report [1] related to folio lock and lock_device_hotplug.
> Seems it is possible. You can correct me if I am wrong.
> 
> [1] https://sashiko.dev/#/patchset/20260428085219.1316047-1-songmuchun%40bytedance.com
> 
> We could fix this by calling action_result() without holding folio lock.
> What do you think?
> 

Hello Muchun,

You could end up in memblk_nr_poison_sub() while holding hugetlb_lock spin lock
from get_huge_page_for_hwpoison(), right?

Lockdep would flag this as sleeping while atomic when acquiring mutex I think.

