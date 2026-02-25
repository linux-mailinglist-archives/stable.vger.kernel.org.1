Return-Path: <stable+bounces-219568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLyAL/WonmntWgQAu9opvQ
	(envelope-from <stable+bounces-219568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB76193AED
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB48A302BDE6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBA289824;
	Wed, 25 Feb 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCEXZG6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708B1C860C;
	Wed, 25 Feb 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005594; cv=none; b=kTpESDSPzYVcb5If53dXAn+5y7FiqeecfOx73HLgaJz7sV72fJ8LITPEnJxZhNK/Hdv6nZQUSNQZe1CBuWM82u017AcUPZCZU7pz1CeV1Mood0yo8DsjvtU4ERH+C3dcYNvwTquJBqkLcZtIsmiSAKojPEeNdXwZAfytV9HjIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005594; c=relaxed/simple;
	bh=lwbCFLraA1zhPh76lnhS66+D5N/BPfd7q3O/dprA6bA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qyvIVlAYxoJghtQy9Abrrc8fG+dcFMkN3TH2vETWH3NBzivc04xEeUcn3eD68BnftQHEZLDgjqLtLID2sxODls9bCQvz283Go8qr5J627f+LEgA+oVlAlfAp+E8TM6QtjLI/9OspaCQFUrBnpfdkmrOQ8YBwrjv53EtFk6LNKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCEXZG6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C488C116D0;
	Wed, 25 Feb 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005593;
	bh=lwbCFLraA1zhPh76lnhS66+D5N/BPfd7q3O/dprA6bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCEXZG6NuZLgPX4PiDjdple5EbvJyuxL6Hd5aFTiWGeQFnZaC8ewdw8lqFWsCgzvM
	 zUQ6GINNi5Fb6IObSYFJDVI7YpL4WmDmllEIQhEuxYBTDP64+MD47X3jPedVJXDoBB
	 8c5Mr7HPd/tNigK/2aa8jky2JewdEdB0B3blFDa9ANjB5w8QMd7qdyKl8LVDa8wqh/
	 XKJlhnpjPFXg/FyZgKVrl9+MnA/68xdPxK6KeV641DE0pP2ASjZmF0B7H44jbvzUzD
	 3i32ZIXK6K4XSEvRHxFrteIoQiBZ3OsTZFEFyApcqZbBn20xs2C3/kFdcp1iD6BUQN
	 +9looZGKvr+LA==
Date: Tue, 24 Feb 2026 21:46:32 -1000
Message-ID: <1c3f0e92d2e16d31004a5489e91d63f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 void@manifault.com,
 changwoo@igalia.com,
 emil@etsalapatis.com,
 stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Disable preemption
 between scx_claim_exit() and kicking helper work
In-Reply-To: <aZ6Z-JrJM6nO_XsT@gpd4>
References: <20260225050055.1069822-1-tj@kernel.org>
 <aZ6Z-JrJM6nO_XsT@gpd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219568-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FB76193AED
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:43:04AM +0100, Andrea Righi wrote:
> I think the same race window already existed even before this commit, we
> were just doing atomic_try_cmpxchg() directly, instead of using the
> scx_claim_exit() helper.
>
> So, probably the right target should be f0e1a0643a59b ("sched_ext:
> Implement BPF extensible scheduler class").

You're right. Updated the Fixes tag and stable Cc to v6.12+.

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun

