Return-Path: <stable+bounces-230799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cATiCOEJyGnMgQUAu9opvQ
	(envelope-from <stable+bounces-230799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:03:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5D34F3F2
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD9FD3005AB0
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AA3A1CE3;
	Sat, 28 Mar 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLKbqTlU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483029BDB1;
	Sat, 28 Mar 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717403; cv=none; b=K1xnxiCDnB7FT9mG4FOepqmP1KM9RzFeAPpnxJuT5CxoRVHaI/q6c9rzPI6sAtIIq6m8DNNdYVCRryoHU6BXI6RFqFM0oQYEodvbJiqdM8Tc9EU5uSC59/Xrmnh4yRI76AM4o3kawkXAod1184SjiM4ZbgyEzwysELgzBqkkLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717403; c=relaxed/simple;
	bh=Xib3LmBk+cvkQ71h/XBToCzox4WC/I5GEE+W0GLBvag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeQJtrI27WtRwBe3eGrFcVSELo4Yjl/IyrBOipw3Ek8mvhCrtodlgMU0DmrBKD64SPLsMzK4euI1d3MZZbfqZk38dLb1agruwL7xAPMqnxrg2wZAgrpkxT/gAepWeVzwOysb6AMi06rOZQAj8G+laDvjmExWKXQe6SPgt188z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLKbqTlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BBDC4CEF7;
	Sat, 28 Mar 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774717402;
	bh=Xib3LmBk+cvkQ71h/XBToCzox4WC/I5GEE+W0GLBvag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLKbqTlUiEIfPSLrLbDmry7Ju7Qr4sAg0DG1Tvb5SxxdYt9lh3pqVwUKCaWeGvWNq
	 mS88ZoRJgGz1LICYjIJ1N2gpwU5syglw76yA+qErf8zngGv5NLKjCAxcBO3PdU0Xi1
	 l/cG+nADFoA9BNGm4ZXfSvaP8YdSAV9SIvSZ51/fJO7yyQq6ryAmqhgt6eWLrcqa2v
	 vLvci7U50uALn1JP+JwYfzv1zOzFp0JRPxgUSXuyUszPgNFn8a17g4v5YlA+ujRP9g
	 xglV3RkBI+ns5CixXMLbMbnBHm6Gn2fpi2OlSYI/+jDDtjD0E+7pRpe4nIp8lJsAtT
	 WqGF/OKsucx6w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon/core: use time_in_range() for damos quota window start
Date: Sat, 28 Mar 2026 10:03:21 -0700
Message-ID: <20260328170321.48340-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328170008.48144-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230799-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Rspamd-Queue-Id: AFF5D34F3F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 10:00:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260328163930.47096-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 2ee07f5a4fcf25b39aeac61c6b88fe3fdfd0c9b6
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: use time_in_range() for damos quota window start
> 
> This commit attempts to fix a stall in DAMOS quota charge windows when
> a scheme is deactivated for more than LONG_MAX jiffies. It replaces
> time_after_eq() with !time_in_range() to properly handle the extended
> time wrap-around.
> 
> Link: https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..8e47183473d3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2452,7 +2452,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	}
> >  
> >  	/* New charge window starts */
> > -	if (time_after_eq(jiffies, quota->charged_from +
> > +	if (!time_in_range(jiffies, quota->charged_from, quota->charged_from +
> >  				msecs_to_jiffies(quota->reset_interval))) {
> 
> Does this introduce an off-by-one regression that extends every quota charge
> window by 1 jiffy?
> 
> time_in_range(a, b, c) evaluates the inclusive interval [b, c], which means
> it returns true when jiffies exactly equals the end of the interval. The
> original code used time_after_eq(), which correctly triggered the new
> charge window exactly on that jiffy.
> 
> By replacing it with !time_in_range(), the reset evaluates to false on that
> exact jiffy and is delayed until the next jiffy. For small reset_interval
> configurations or low CONFIG_HZ values, this 1-jiffy delay might alter the
> effective quota replenishment rate.

The effect should be negligible, but good finding.

> 
> Would using !time_in_range_open() preserve the exact original timing
> semantics while still fixing the wrap-around stall issue?

Good suggestion, I will do so in the next revision.


Thanks,
SJ

[...]

