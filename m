Return-Path: <stable+bounces-232912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGXPE3D5zWkdkAYAu9opvQ
	(envelope-from <stable+bounces-232912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:06:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC5383D88
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA8E4305D4FF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0F361DD0;
	Thu,  2 Apr 2026 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co7KDZZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC927FB35;
	Thu,  2 Apr 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106413; cv=none; b=mnXfFkgKZ2jRq8WpbWeq+TkMbjmi/u3KO8oMvkUbSFMBRS7a/kmuRVvpu+7NpfK32VbjtUdx2B7ifn2nGxuB22U7u0w1tDbH2S/tPd2rZkx7MsETHzrCe2D8J5E8KDqRo6WUz9FoGlbYhEaho4BBq7cjiS8GFb5o0qMsgKi2kRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106413; c=relaxed/simple;
	bh=wihPoKshCRvDn2VzvCkTU4pBOlXbXSfjJCzi/3jsd+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwPmtRLrhf1fBYcz1r+9X6msirMRRK/qU8FECpOT/ubnnq+wR1sJv7Ak5y5XltDBLMFReD73ga2/w7Sr4H/0o2sdF/FFplLjQGMsMWcIzIKXFFtKdzQ/j4dHG7GkNxwQdI+zgh+VL7rmfrIAwbpgXlIOL3VINIsSlO/333XMGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co7KDZZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46573C19423;
	Thu,  2 Apr 2026 05:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775106412;
	bh=wihPoKshCRvDn2VzvCkTU4pBOlXbXSfjJCzi/3jsd+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=co7KDZZqve8xBji8Vx9xt+xu/QeOhAumYCbmZnbRfc1ZRlVL8afw3jM5MFPCMhrK6
	 Q4SLY905C2hRhXGbNil4KA9HvtW/7wMkNC09FrMd6Vm+Lz/8ayG0YGNLb3mlo5nhJJ
	 VI5kO/sTpUW74IthDq3x5UuEvctp+4DJiiIXzcd8G8Oz1foOtrgYTVDP58z0GcSCwT
	 rUlp7gMqPbO3hZQXKtPBnPDgb92f7F5e3CKzC3fbqITeaGeR7nz6o+pkwnD8ZJUL74
	 xBdHmBxI7Pe3W+iX4rCYvQIKJ7I+0tSpLEBdJeVqxtwkWc/wTNyBznMpv6Xx6dLZuQ
	 Sr4/SB/ONuvtA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Wed,  1 Apr 2026 22:06:50 -0700
Message-ID: <20260402050650.72289-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402020745.68554-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232912-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: BBEC5383D88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 19:07:44 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> > > --- a/mm/damon/stat.c
> > > +++ b/mm/damon/stat.c
> > > @@ -257,7 +257,12 @@ static int damon_stat_start(void)
> > >  
> > >  	damon_stat_last_refresh_jiffies = jiffies;
> > >  	call_control.data = damon_stat_context;
> > > -	return damon_call(damon_stat_context, &call_control);
> > > +	err = damon_call(damon_stat_context, &call_control);
> > > +	if (err) {
> > > +		damon_destroy_ctx(damon_stat_context);
> > 
> > Can this cause a use-after-free?
> > 
> > Earlier in damon_stat_start(), damon_start() is called, which creates
> > and starts the kdamond_fn kernel thread. This thread actively uses the
> > damon_stat_context.
> > 
> > If damon_call() fails, the kdamond_fn thread might still be running or
> > in its teardown phase. If we free the context directly using
> > damon_destroy_ctx() before the kthread has fully exited, the kthread
> > might access freed memory.
> 
> Nice catch.
> 
> FYI, I initially thought damon_call() of DAMON_STAT cannot fail, because it
> synchronizes its damon_start()/damon_stop() calls with module parameter
> handling function, and it doesn't update the context internal state, which
> means the damon_ctx->maybe_corrupted cannot be set.  If that's true, this patch
> itself is not needed since the memory leak cannot exist.
> 
> But, kdamond can fail for its internal memory allocation failures.
> Specifically, if ctx->region_score_histogram allocation is failed, it will be
> terminated.  So, yes, sashiko is right.  There is a chance.
> 
> > 
> > Should we call damon_stop() here to wait for the thread to safely exit
> > before destroying the context, similar to the teardown sequence in
> > damon_stat_stop()?
> 
> Seems that is a workable option.  But given the fact that kdamond is already in
> its termination step, it feels odd to me.  I'll take more time to think about.

I just posted another approach [1] that can avoid the use-after-free, with RFC
tag for getting sashiko review before being merged.

[1] https://lore.kernel.org/20260402045928.71170-1-sj@kernel.org


Thanks,
SJ

[...]

