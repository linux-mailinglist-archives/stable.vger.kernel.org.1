Return-Path: <stable+bounces-235626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFhCF98B2WkWlAgAu9opvQ
	(envelope-from <stable+bounces-235626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 599523D869B
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C541B3026D09
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5502F6184;
	Fri, 10 Apr 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/vxNCfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788E3CA4A3;
	Fri, 10 Apr 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829455; cv=none; b=DM4cyIpdAUa5I/AhDP9YZ20zLZO0V/o0HHQw6OIu5L4Nl9V6wXRyRUb3+GvawyGwl+NgaRcGL5CSF/16DNcYidT5kcL3nPdIq+Q3EAuahjS1W6DUL0KplCjZG3762OsC0vF66EoOf26D66n0vNri8EPTpf1k7cObLnmlMCTYUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829455; c=relaxed/simple;
	bh=2UJna0uTGN4hf6YnN3LfOZVqmiao4JvVlXwhKEIQG+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGm5FS6KyN7eadSXZRXvCy9vqfRcsRCWQ2apokvvmgz0Lj2POh3T6tvGIh2uwluwJQVnnKJ8yBqax93Z17k9zFYcnAnatSCtPbJHz5m234O9RtOQThdnWzyR5nauYnxWNOpFFQ4rh7yMgemksmr7MqyCene722CZwHIwfT1nF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/vxNCfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A279C19421;
	Fri, 10 Apr 2026 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829455;
	bh=2UJna0uTGN4hf6YnN3LfOZVqmiao4JvVlXwhKEIQG+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/vxNCfMeD0nE0Byd8pFfHDHw0yJqz5goeEh+sT5Nbdu5AfWsljC59hFWunu/iz+N
	 GQQqPu7dWX0WXANdZDShzkB/pckMJwt3MJxemYDv8EMy/QpM1sefMjouMolamdcfGm
	 AulfFI/JIkYq8jtR6AaQc1h12Vf6sVo2Sjq9J0hxZv5JQwulTzU8giLmfiVIbPcQyx
	 D+W3N87Z+erFX93ubSBIZp3/9xzZVeIncrlxNOpChNhnI42AfUFCt8MUk3cCur2y2u
	 eULKxjnS5+xfUPhCkqOK4WbB4LuBb4BbFoQaePjXZx6q1dVqv0FiQTvxbuEGrfgCvU
	 RyHi6h+mVWYdA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 06:57:27 -0700
Message-ID: <20260410135728.82274-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410044259.95877-3-aethernet65535@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235626-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 599523D869B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 12:42:59 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via
> DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2
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
> 1. DAMON_RECLAIM is built into the kernel, so it cannot be unloaded and
>    reloaded at runtime.
> 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
>    Writing 'Y' does nothing, as 'enabled' is already Y.
> 
> Reproduction
> ============
> 1. Enable DAMON_RECLAIM
> 2. Set addr_unit=3
> 3. Commit inputs via 'commit_inputs'
> 4. Observe kdamond termination
> 
> Solution
> ========
> Add an early validation in damon_reclaim_apply_parameters() to check
> 'min_region_sz' before any state change occurs. If it is non-power-of-2,
> return -EINVAL immediately, preventing 'maybe_corrupted' from being set.
> 
> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

