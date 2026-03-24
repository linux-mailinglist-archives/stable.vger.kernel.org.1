Return-Path: <stable+bounces-230175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKtHM+Ccwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:17:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902A30A063
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50953301AA85
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1483FE67A;
	Tue, 24 Mar 2026 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQdclUNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260A3FE64A;
	Tue, 24 Mar 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361745; cv=none; b=YWZtnZE4U/Igc+xwkAGcD9BMpH9r69K+xfh0+/UHo4D9e1lXkAhaCx9r+/zi4DZiwa0pDKDKUOebJs4Lnj2J2gNEBrO51YFFwzd8S9y6ZE7Vu4fIFPWxgRrGjqbmr/AMhZO7gtQN3oE3WoK/dH2VdZFZV0E+MEh9N4xqprKKHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361745; c=relaxed/simple;
	bh=rdNwTeZrJVIPFYcjbtTuAiqhCIJwk99EdUukTgho27E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdqhsAG/Rby8eZOVuE+mxqctLcO9kIUgx+i+KCZpSajpoT5zWDP9m+p7QRpjFeZcCevrf11Wj9m7Cff3xqI++xWezbPQ+1h3WYQylcj/Um2cvo08o4scl4VjmAot0NbcevyTm3OsyC2iiSzTCLfSqBhbDNAzuXqfpc889JplOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQdclUNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874A0C19424;
	Tue, 24 Mar 2026 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774361744;
	bh=rdNwTeZrJVIPFYcjbtTuAiqhCIJwk99EdUukTgho27E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQdclUNFHffW5wwZjD+EMKJE50q8xQHVKyM1l83HbpGQq85u/WW1TmUgsAhwkLy3Y
	 wN4QvlE1cbPbpP/XdoINCviYRr/vT9utsjYQCLdnIZTL2h0TvklQtTfL9+pqNUHzD4
	 d06Jv68Ho8g7N9ujedjENGhJMPvBhtbQQZ/FyZU/3NmhG0glTnUkPaNKKdX+9N3nTp
	 xi6exbRRM+3UV3hWNNBsbk8NvGpHm1vTZMIVz7/hsdgJWSMMh9gNtmIh8ciYv8352+
	 NGEUkNodtOjhMtNAuieiovyon7/ogiNz7sXttL0NA2VjpcktfATimkMiQ1z3PzcvFn
	 Z3/p95wngBcZQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Tue, 24 Mar 2026 07:15:37 -0700
Message-ID: <20260324141537.91434-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <A0701CEF-CDF1-4B3E-B25A-C05A32AE822C@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,web.de,lists.linux.dev,kvack.org,linux-foundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230175-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.github.io:url,objecting.org:email]
X-Rspamd-Queue-Id: 5902A30A063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 07:06:25 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 24 March 2026 00:14:59 GMT, SeongJae Park <sj@kernel.org> wrote:
> >On Mon, 23 Mar 2026 16:48:19 +0000 Josh Law <objecting@objecting.org> wrote:
> >[...]
> >> Also, unconnected to our topic!
> >> 
> >> 
> >> I've tried to backport Damon to 4.19 (for a personal android thing, and failed! Of course)
> >> 
> >> Can I have a bit of help if that's fine with you? The tree is based on GitHub a bit
> >
> >Sure, I will be happy to help as much as I can without burning myself ;)
> >
> >Seems [1] Alma Linux has backported DAMON on their 4.18 kernel.  Maybe you can
> >try their port first?
> >
> >Also, what is the oldest kernel that you have to use?  As newer it is, the
> >backporting will be easier.  When I was in AWS, I backported DAMON of v6.7 on
> >the v5.10 based Amazon Linux kernel, and the source is available on GitHub.  So
> >if you can use 5.10 based kernel, using that could also be a good option.
> >
> >[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
> >
> >
> >Thanks,
> >SJ
> >
> >[...]
> 
> 
> 
> well android likes using old kernels for some reasons, especially LTS, so 4.19..

Well, but the long term support of 4.19 has dead a few years ago.  The oldest
LTS kernel of today is 5.10 [1].  I understand some vendors might still use
4.19 kernel, though.  Anyway, let me know if there is anything that I can help.
I will try to help.

[1] https://www.kernel.org/category/releases.html


Thanks,
SJ

[...]

