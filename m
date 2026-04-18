Return-Path: <stable+bounces-238539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FXqMebi4mkU/wAAu9opvQ
	(envelope-from <stable+bounces-238539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:48:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE041FA4F
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6AC03046F2C
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848F2C11CB;
	Sat, 18 Apr 2026 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBPkYmSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A329B781;
	Sat, 18 Apr 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776476898; cv=none; b=tYZETcof/rDM3pxC+KCdVKABA/E1Y6x21CAqV4At+i0ag0Y4De7dSTTSRrjM0wSrbh4uOko/FchX18TmdI7J+yHE8x38fssADSLaKq8LyC9HgkXJs9aCEJxXaUmtkM/WsbOySyTHk+IN6meyo83FgJuTASA81p/DLcYg4nyVA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776476898; c=relaxed/simple;
	bh=1Rp1KBEyLyK+Bx4RgUvTNrqEBxwP43pQchU5gS2AO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeY0jYvihYPYmWCpiUUaQiIv5OnT8LNOtY4e78tdcVnhZvz11DSBIwHj6Mpd2qQHTMb3dQPXTXQFS+n8Pt0oKmo9OoZYuBRTAYQJ9Y/7AW2YoPYRJc0AJnrFzy16lBjeMHbDZd+37ueos1nZbRldenUDnv2VYfR0zFIEJSfsWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBPkYmSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79EC19425;
	Sat, 18 Apr 2026 01:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776476897;
	bh=1Rp1KBEyLyK+Bx4RgUvTNrqEBxwP43pQchU5gS2AO9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBPkYmSASkVlJEao0vRV/xxyyMOiN7JBiSCwVegfTTNhlgubeoLPDgliDrRCTPA9F
	 qkn0OdbsEemZz/j4XVVr5k+oH3WGsQW99Xz5tJWE4SgB+np0s9PAIrZyXvjwPHkn5W
	 9NHwmuXcZB7mK/VdvEnnw9uijwBt0gPcEnw24E+yz1S43bomNLF5NpevDbVDVqDos0
	 pLwrzuDwB8WKrov+hliFpkedgvklxSU7bVKy6as0RDK8poRKSHrjdt5zWssUQwU40e
	 VIoy9zKS+hwksmgS+7Yiku6HbJQOkcMK3M4GaVPyHMQL+nufwne0a535Hf1h55vZJC
	 GxCuWECx++ygQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/stat: detect and use fresh enabled status
Date: Fri, 17 Apr 2026 18:48:09 -0700
Message-ID: <20260418014809.6428-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416143857.76146-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238539-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AEE041FA4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 07:38:55 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT assumes the kdamond will keep running once damon_stat_start()
> succeeds, until it calls damon_stop() to stop it.  If the
> regions_score_histogram allocation in kdamond_fn() is tried after
> damon_stat_start() returns, however, and if the allocation fails, the
> kdamond can stop before DAMON_STAT calls damon_stop().  In this case,
> users will show the 'enabled' parameter value as 'true', while it is not
> working.  This could make users confused.
> 
> The user impact should be mild, though.  First of all, the issue may
> happen only quite rarely.  The allocation failure is arguably too small
> to fail (100 unsigned long objects) in common setups.  The time window
> for the race is also quite small.  Even if the race and the allocation
> failure happen, users could find the fact that the kdamond is stopped
> using 'ps' like commands.  By writing 'N' and 'Y' to the 'enabled'
> parameter sequentially, the user can also easily restart DAMON_STAT.
> 
> That said, the bug is a bug that needs to be fixed.  Instead of managing
> the complicated state in the variable, detect and use the real kdamond
> running status when the user reads the parameter, via the parameter read
> callback.  This will allow users to always read the correct 'enabled'
> value.
> 
> Note that the 'enabled' variable is no longer the argument for the
> 'enabled' parameter.  But it is still used for two use case.  For
> keeping the config/boot time user-set parameter value.  And for keeping
> the user request to compare against the current state, to see if the
> damon_start() or damon_stop() call are really needed.

Posted the next version of this patch as a part of another series [1], because
the patches of the series are fixing the similar type of bugs.

[1] https://lore.kernel.org/20260418014439.6353-1-sj@kernel.org


Thanks,
SJ

[...]

