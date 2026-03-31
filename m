Return-Path: <stable+bounces-231457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPseLKvvy2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:00:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431636C44C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2BC304C639
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2253FA5ED;
	Tue, 31 Mar 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smEqOJma"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C88285CBA;
	Tue, 31 Mar 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972510; cv=none; b=pvuUbzp26Mnd2sKClvPuY+T7m//Nk2a+OOWSbCoQqvEF0CdsnF3fXLTElQcc4ZSo09mwosvTdVfNNpItaODA5by4sBByBVRV2hh3BsSBH6DaEv8Fe5DCWlTWPYD9kzvw5dQdMqw0z98qMJ3IaDfBaFHDXFUth9pEcGFx8DowYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972510; c=relaxed/simple;
	bh=aDprB0j2xJvFThcBl3Af0grhX/iIzs5DFB/VWB2U/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNNGkCHbHlNG7YauSlK4LpugXAPzebPXaoWKakQHKiY8Myt8cs5qIQ7yDjKFn3EoWoQQPgXpI1XfK8WDCShzEPyXT3H3l8ODdJKFgE/2Jf1cmE2G+EzGL6ZAfLsN8cfVfDVicnFKhBdg2mNrFjRNfdlrh2DBoQYt3YHKJNkg7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smEqOJma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCB7C19423;
	Tue, 31 Mar 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774972509;
	bh=aDprB0j2xJvFThcBl3Af0grhX/iIzs5DFB/VWB2U/7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smEqOJma4I5FxSVuk1qKqNI84owp9C38/avG+tPtkBmAtprNzYCdqS/r2O8esNOXg
	 S7ZUAnTOcU9x7n3y35chh7HeEXf3o9k0YxpGYBLBNDXdm9abb5mmbMNsobZPYr62B7
	 U1e+C0O6aWIT81qlzRRrb9VewH7+5oVJ40ff4ET8NwyNt2BBSQwcDwh775CFLrA8wM
	 CmFcMeZrjj5W3rtzzaVUpGgnk1ONnohgiLnJVI6zUksTnSlXm5z4hxxvJrBrFrkLvQ
	 ZD60YjKOcD8yNOEXL/WQKcD0+CFDXy8XxPVZMnZUIoTRkDH0FS46KqS18IpBqFGi0Y
	 nRYPgg5zLzi6Q==
From: SeongJae Park <sj@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Tue, 31 Mar 2026 08:55:06 -0700
Message-ID: <20260331155507.79720-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331121943.GA74409@macsyma-wired.lan>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231457-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0431636C44C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 08:19:43 -0400 "Theodore Tso" <tytso@mit.edu> wrote:

> On Mon, Mar 30, 2026 at 02:22:05PM -0700, Andrew Morton wrote:
> > 
> > I view Sashiko as primarily an author tool.  Sometimes I call it
> > checkpatch++.  In a better world, author would be able to sort out
> > Sashiko issues before ever sending out the patchset.  But in this
> > world, a public send is needed to obtain that review.
> 
> Note that Sashiko is fully open source and the prompts are available
> in third_party/prompts in the git repo:
> 
> 	https://github.com/sashiko-dev/sashiko
> 
> So people can run it privately, although they will need to provide
> their own LLM credits.

That's unfortunately a barrier to some people.  To me, what makes sashiko
special and different from other AI review tools is the fact that it is
automatically reviewing nearly every kernel patch for free and publicly sharing
the results.


Thanks,
SJ

[...]

