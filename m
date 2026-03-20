Return-Path: <stable+bounces-227565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGiFCUBtvWnL9gIAu9opvQ
	(envelope-from <stable+bounces-227565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D72DCE8E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0329B30E5371
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363A3C3BF1;
	Fri, 20 Mar 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPUHva13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE2364951;
	Fri, 20 Mar 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021882; cv=none; b=i3qM4u10wWXbvfDzj87Bt7nKW6DsOzXx2kvbHGujWFBOomG7FVxMuRYtSDpUPWHeF30LA0EnlqdAhl5lmYlrgAtPGCfX1E6hyosJ+O3lwX22or6czEQ0Qo3XB2EXcMmyPzw1w74nNGnE56W02bVNYM4Hcz7PgaZ+F5AQDs+DeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021882; c=relaxed/simple;
	bh=oLa2yNfLRCVKbcj1mqAupr8pkOcbafxnJnVVjt/KHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTvbQdeydS/oraLVGoxA53/kdsuOLKh2S/7MUTuhPgniKCF9a4AWGr1+hjkYnMMDL9bCDWPaA6RdGJAWKgwTF3Eak+CUHJZO2601YOhy2pBkJjZi1sdtk0SI/TrkAwG7cdvT7ayctgVaBHyISRuky+RK+3AMPPDGXLRpEUFWu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPUHva13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24479C4CEF7;
	Fri, 20 Mar 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774021882;
	bh=oLa2yNfLRCVKbcj1mqAupr8pkOcbafxnJnVVjt/KHDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPUHva13aLssUNKZdyL3hik6iWY1cm/v5s7YTF0Ichg3gjqm6xmraqBL73k8q3jHA
	 wjt4ztB3Czdbf78qu9WzBHKlEI/OlO7aQBjzr4qgB2Pnw5l3XbQS9jEmQcK995Gbpt
	 1SC5r0zbWpAU7o4d2P8wuEUcyju9bdu5f8aodzzuSNkCZ984iUsQeyFiLg3WRKUKoN
	 jFVMj+Io6AUEBaNwZhILTR+OSAfcg46osW+4SCJg07ye6hcPzWGFO98kBVKnJkY8kh
	 ylwveh+bG+FfZT3D4UFdMYNdYsLVuoM8EHMPnB+vJ2lt9Q1bEQV6y4qOeO3mtUJi9m
	 9e+qBdnRiyzdA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/damon/sysfs: check contexts->nr before clear_schemes_tried_regions
Date: Fri, 20 Mar 2026 08:51:14 -0700
Message-ID: <20260320155115.101025-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <C65E16CA-8D81-4B88-96EA-59DB554494A0@objecting.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227565-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: 783D72DCE8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 15:14:54 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 20 March 2026 14:47:40 GMT, SeongJae Park <sj@kernel.org> wrote:
> >On Fri, 20 Mar 2026 07:06:48 +0000 Josh Law <objecting@objecting.org> wrote:
> >
> >> 
> >> 
> >> On 20 March 2026 02:13:17 GMT, SeongJae Park <sj@kernel.org> wrote:
> >> >On Thu, 19 Mar 2026 15:57:40 +0000 Josh Law <objecting@objecting.org> wrote:
[...]
> >> >Not necessarily blocker of this patch, but seems all the issues are in a same
> >> >category.  The third patch of this series is also fixing one of the category
> >> >bugs.  How about fixing all at once by checking kdamond->contexts->nr at the
> >> >beginning of damon_sysfs_handle_cmd(), like below?
> >> >
> >> >--- a/mm/damon/sysfs.c
> >> >+++ b/mm/damon/sysfs.c
> >> >@@ -2404,6 +2404,9 @@ static int damon_sysfs_update_schemes_tried_regions(
> >> > static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
> >> >                struct damon_sysfs_kdamond *kdamond)
> >> > {
> >> >+       if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
> >> >+               return -EINVAL;
> >> >+
> >> >        switch (cmd) {
> >> >        case DAMON_SYSFS_CMD_ON:
> >> >                return damon_sysfs_turn_damon_on(kdamond);
> >> >
> >> >If we pick this, Fixes: would be deserve to the oldest buggy commit that
> >> >introduced the first bug of this category.  It is indeed quite old.
> >> >
> >> >Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
> >> >Cc: <stable@vger.kernel.org> # 5.18.x
> >> >
> >> >
> >> >Thanks,
> >> >SJ
> >> 
> >> 
> >> 
> >> Hello, did you give Reviewed by you? Or not..
> >
> >Are you meaning Reviewed-by: tag?  If so, no, not yet.  I want to get your
> >answer to above question first.  Could you please answer?
> >
> >
> >Thanks,
> >SJ
> >
> >[...]
> 
> 
> Well, two is in the same catagory. But seperate fixes may be best.  Because patch 3 dont call that function, so it may be screwy, i mean, if you want me to. Ill guard it. But its a bit on the hacky side

I agree there could be more cleaner way.  But these fixes need to go to stable,
so I'd prefer a change that also easier to backport.

So, yes, I want to.  Thank you for kindly accepting my suggestion.

Could you please re-post this series for the first and the fourth patches as
they are, after adding my Reviewed-by:, Fixes: and Cc: stable tags, and a patch
checking kdamond->contexts->nr at the beginning of damon_sysfs_handle_cmd() as
I suggested?


Thanks,
SJ

[...]

