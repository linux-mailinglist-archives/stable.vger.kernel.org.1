Return-Path: <stable+bounces-235625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BH5CagB2WkWlAgAu9opvQ
	(envelope-from <stable+bounces-235625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:56:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676E3D8668
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA3F73020FF1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E63C870C;
	Fri, 10 Apr 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFHGBZgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670130F523;
	Fri, 10 Apr 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829410; cv=none; b=P1GDi+ZqZSdLccs0rleMBQiXwYpOxs8fZ+wqhQ/FWYuHcbN3925Vsy55YMvFJEI7ZW7Ly5lkMH5hPc/QDFo2eOJrt7ui0/F29zQVGGOdC0MVEzerqwFFkhWw+eCNYaRGuUW5FKUOHqFBVfG66WLX24fIXA6SaCzuWAikLuvrrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829410; c=relaxed/simple;
	bh=Cq39BuoI4ZjI5z6yFIcfBlCfSg0YD+kOMe++kCrcSJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTmxX/SgJuAkmVbI8J8vD1SjB3woiz52EUdvXNiQVE26J068RIdw6NDtt1T5rQvyLTQj0yWP79prT6ktA7y2mkRjUViQJyLqg/PW+KqNiHUHpt+4JT1PL/Ldh5OzWN0dpwchofWfFbQoKe3ItwtgKk8u/9xoPeEPA8X0DsnvjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFHGBZgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D60C19421;
	Fri, 10 Apr 2026 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829410;
	bh=Cq39BuoI4ZjI5z6yFIcfBlCfSg0YD+kOMe++kCrcSJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFHGBZgEV+Fb+XXWQrmwdpREGL7yTApc7n0vOgAJE4iBdM4cozvvJnLWpm+0/Uzax
	 ENItqcy+PHFQxNsiVjsLfR1xnd1sAjpts22lobZUiLZt26CGrMQLv92UfyvgUSQdVc
	 lqHSC1E+9WxPcYkvB6PcFfxvmLISFrknfeLHHTuViAjgeqrvf7TP7U3vEMArrcs7EY
	 uEIsfELynMCVvQBZHUc5cAn2Vj4RON0k34DXoaZVwH6g4ZpjO+pngswAsvT1PyLhSf
	 Ps4P7tZgs7YDIKYbtzi19PMjxHx5HJ175kOEKeaAfvkj/QoZAYoN9yX8ZeZbm+Jbpm
	 F9zDql8qGxxew==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 06:56:42 -0700
Message-ID: <20260410135642.82152-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410044259.95877-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8676E3D8668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 12:42:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via
> DAMON_LRU_SORT, 'min_region_sz' becomes a non-power-of-2
> value. This value eventually reaches damon_commit_ctx(), which does:
> 
>     dst->maybe_corrupted = true;
>     if (!is_power_of_2(src->min_region_sz))
>         return -EINVAL;
> 
> Although -EINVAL is returned, 'maybe_corrupted' is already set. The
> running kdamond observers this flag and terminates unexpectedly.
> 
> "Unexpected termination" here means the kdamond exits without any user
> request (e.g., not by writing 'N' to 'enabled').
> 
> User Impact
> ===========
> Once kdamond terminates this way, it cannot be restarted via sysfs
> because:
> 
> 1. DAMON_LRU_SORT is built into the kernel, so it cannot be unloaded and
>    reloaded at runtime.
> 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
>    Writing 'Y' does nothing, as 'enabled' is already Y.
> 
> Reproduction
> ============
> 1. Enable DAMON_LRU_SORT
> 2. Set addr_unit=3
> 3. Commit inputs via 'commit_inputs'
> 4. Observe kdamond termination
> 
> Solution
> ========
> Add an early validation in damon_lru_sort_apply_parameters() to check
> 'min_region_sz' before any state change occurs. If it is non-power-of-2,
> return -EINVAL immediately, preventing 'maybe_corrupted' from being set.
> 
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

