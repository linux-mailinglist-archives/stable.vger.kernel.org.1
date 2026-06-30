Return-Path: <stable+bounces-269876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2kDBDo5FQ2pWWQoAu9opvQ
	(envelope-from <stable+bounces-269876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 06:26:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD06E0433
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 06:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q1Seo8Ff;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269876-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269876-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D215302B74F
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D323DDDB8;
	Tue, 30 Jun 2026 04:26:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AA3B71D7;
	Tue, 30 Jun 2026 04:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793584; cv=none; b=HYfD3Z1TMZplSHz4qwfUQ14AEuAgKQg53Ear2KVNtQQdheqRZhymeqvWb0J/AVt4hGJlWqP6mARKWz//aVpB6E7zCnmyLSnhNQ8IeF9RM29Hbyq9+vvRUDTHYePl1yfpAXmD+xvd4J6a/VKsfWInngR4XznnXdUgqA86WQgwdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793584; c=relaxed/simple;
	bh=P6Uk7lHUNXnieCg17gonvdPUMm4uOU4L51FRPAwbrEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyeIp+QC3+gXhoFfzDyF9cczck6CZ7vYcljMGZFCs3dOt2infiVOpfv0om7CbvBamTurkUeUessZLzgTMGjNAK1XJULHGgSjlF5+zf6XziGvpm9wae/gR6wcKbPNmWrbX9LNVRX52fGTCg3CfgWm9XSeBai6sE/yht+yuq8MIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Seo8Ff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E081F000E9;
	Tue, 30 Jun 2026 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793583;
	bh=Ae8t/Ilc5afoONBuaiJzpXJpdh+evRAuQt8lBfqqfFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1Seo8Ffs3lw+ArmCzrhd6+ZuK+vKuYMzCkkcKrKjxwuJT0X3+DzQ2Awmfl08SI72
	 pIaCRoLbGkSpScHQFf3cHZXrZE7SX8T6cbsPSJsSdCA7QOZOubFE3WbK9N5Xuflktj
	 AUJUIUfPmRsOkDNkIW5rAeKIPjhWe6T3AqAhXhyUDW3MKKKBHcUL5Zn9r+nkRAKn8a
	 cz2W203yWDri1oey6bDLcrkSeF3Qd4TFZcPAaHcbpp/K617KHHh/uLB6HIqMIxCDeR
	 aePKtHaldDnUpqJJIdXc+G7FPb6/UPvk5ym6qX9YRCVuERqhXrbxn4qBoJd4AWPoOe
	 owd+xm28QDkmA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Mon, 29 Jun 2026 21:26:12 -0700
Message-ID: <20260630042612.151351-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630035221.146458-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:akpm@linux-foundation.org,m:yangyingliang@huawei.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269876-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77AD06E0433

On Mon, 29 Jun 2026 20:52:19 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON core logic assumes zero length regions don't exist.  However, a
> few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
> DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
> could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
> and divide-by-zero from damon_merge_two_regions().
> 
> For example, the WANR_ONCE() can be triggered like below.
> 
>     # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
>     # CONFIG_DAMON_DEBUG_SANITY=y
>     # damo start
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0
>     # echo 0 > contexts/0/targets/0/regions/0/start
>     # echo 0 > contexts/0/targets/0/regions/0/end
>     # echo commit > state
>     # dmesg
>     [....]
>     [   73.705780] ------------[ cut here ]------------
>     [   73.707552] start 0 >= end 0
>     [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
>     [...]
> 
> All DAMON API callers eventually use damon_set_regions() to setup the
> regions.  Add the validation logic in the function.

Sashiko found a pre-existing issue, and it is not a blocker of this patch in my
opinion.  Read my reply [1] to Sashiko review for more details.  So this patch
is good to go.

[1] https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org


Thanks,
SJ

[...]

