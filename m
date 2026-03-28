Return-Path: <stable+bounces-230759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHyDM549x2mTUgUAu9opvQ
	(envelope-from <stable+bounces-230759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 03:31:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889E34D134
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C29E3049725
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346053590CD;
	Sat, 28 Mar 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di8marH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D333F378;
	Sat, 28 Mar 2026 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774665023; cv=none; b=Hkf/Ofl9fIvKskbEzUIKatT/IKgKwQNM4AHkJoOmHXSi8qP/94OMOspOoMRkFHgawUPr7ggRhGl7+6Or/cxBqdN3BC1Z+2zcxPa8j+uTkI9HsKwr4EDOMQFYA3i/b3+XApBVEvLwLg7q8gKvkljmOUybPBLNzo8P4V6qPkGNQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774665023; c=relaxed/simple;
	bh=LxFmMpfJcOxqkaYRp86376K9yg/HLYeOtxNghx/brdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN7982v3Kr1m/cU4iBQ2xGNNQ2vjKWJ7Cot+xN/a/GlJPQMnGnHSdWfkio1nNaYNDoNCS1Zc9CKQOt6uoLh3dY3azA03zJGL7Cl/B1VOb/2C7CgeOXnM1eNcm2Jw6DqcE/iqLEe9YZUAC0mLKFnBAbO9U+Jzacmc7knR9G15rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di8marH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D8C19423;
	Sat, 28 Mar 2026 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774665022;
	bh=LxFmMpfJcOxqkaYRp86376K9yg/HLYeOtxNghx/brdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=di8marH8r/JOmw/1cHmnyV1x1x3milaQg7+Hp73F+lCh7c24s5QgzJYd1sweKw4D7
	 IYX0eHDeVIzE4/1I9QhOsgifEzaqXeR82mWrrcoblYCOiSJ6Ycakdd3ywKWkyFVMm+
	 xb0mMZ/HcI2haDXc1ZDixf1zXjuw2IVc8FC1XfT1eg9qhtMU20OV2dvN1W8ysvZWEl
	 QBwPm6VmPbLrclwlQBzWsDxLKDCfV2qwV1ipUO7nhWHpXrVJHgIjFtux2hFc8z/oo4
	 GdmP6IYkvlm6Ihh1xyd/LQgpVaDUA7w/mdEt3tEIt18rGYuduGv8jTMi/ruajNT8I1
	 m0Kl1/vtLhWjg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Fri, 27 Mar 2026 19:30:20 -0700
Message-ID: <20260328023020.8525-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328005412.7606-3-sj@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230759-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2889E34D134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260328005412.7606-3-sj@kernel.org
# start of sashiko.dev inline review
commit d10719045bbbd92307cf40ef0886ce0e81cb9caa
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp

This commit adds validation for the damos_quota_goal->nid when calculating
node memory cgroup usage ratios. If an invalid node ID is provided, it
returns 0% for used memory and 100% for free memory to prevent out-of-bounds
memory access during NODE_DATA() lookups.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2273,6 +2273,13 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	unsigned long used_pages, numerator;
>  	struct sysinfo i;
>  
> +	if (invalid_mem_node(goal->nid)) {
> +		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +			return 0;
> +		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */

This isn't a bug, but there is a typo in the comment here. It says
DAMOS_QUOTA_NODE_MEM_FREE_BP instead of DAMOS_QUOTA_NODE_MEMCG_FREE_BP.

> +			return 10000;
> +	}
> +

[ ... ]

>  	si_meminfo_node(&i, goal->nid);
>  	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  		numerator = used_pages;
>  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
>  		numerator = i.totalram - used_pages;
>  	return mult_frac(numerator, 10000, i.totalram);
>  }

Does this code safely handle nodes with zero managed pages?

While the new invalid_mem_node() check ensures the node has N_MEMORY set, a
node could still have zero managed pages if all its memory is reserved, or
if a concurrent hot-remove event drops the pages to zero just before
si_meminfo_node() runs. If i.totalram evaluates to 0, mult_frac() will
cause a divide-by-zero kernel panic.

Can this calculation also silently overflow on 32-bit architectures?

Both used_pages and i.totalram are unsigned long. Since numerator <=
i.totalram, mult_frac() bypasses the initial integer division and computes
numerator * 10000 directly. If the memory cgroup uses more than ~1.7GB
(about 429,496 4KB pages), numerator * 10000 will exceed the maximum
32-bit unsigned long value, resulting in an incorrect ratio.


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260328005412.7606-3-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260328005412.7606-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

