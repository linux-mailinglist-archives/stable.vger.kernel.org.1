Return-Path: <stable+bounces-225452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ebtbBfb3tWlj7wAAu9opvQ
	(envelope-from <stable+bounces-225452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:06:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A528F9A3
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83E75307678F
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58513DF59;
	Sun, 15 Mar 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY1AnAUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCC17D2;
	Sun, 15 Mar 2026 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533169; cv=none; b=VnOas5zoZnmXWpAfH4NrsuID9EhQTq5w4+QT93Ej3X4xavjPSLmf+Owc4JBgzAjshIawl/PtlHdf18K1jBfHn1bh+lDvXc1Yno1OTk8oVLIm0li8jgxuMxNI7kG6bqLc9aih3LpbFkQjR0cmc3yHLwehvo05x0/7Hai5vMxb+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533169; c=relaxed/simple;
	bh=GdqvUN+xl9wN0WxCFWEbxnpwXdl6FS4Z+Q/2gOKzgYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNx4EvFo5OoNs0VdR8VwUD+nebsreB7RZoFDPXxtTR4xg1OH2Gn4qYxD73u2o8OdbXaNVEqiEPa/as7A0hhuLnSZoplEqRTT39TkB24PS8ZvoF+SRiuN4e1aZtF3vK8uYYjp37ENtJdh1lWZB1szl0DJCbW3fyrOzG4Odm4lCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY1AnAUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7A9C116C6;
	Sun, 15 Mar 2026 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773533168;
	bh=GdqvUN+xl9wN0WxCFWEbxnpwXdl6FS4Z+Q/2gOKzgYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MY1AnAUxfwcQXbJahppa/QPFx5OTh/brWeAoHYP9rwTwng2qRv2gB9kMvjK74eLO1
	 ONC9/gFP/+fVkmffi70Fp6+v1duqh6n9na+awJ4WZvH0TRCtiB2Pni2/xgo4DhLKwX
	 eXz5ISXerrxMLy+fxHAl/DRSaYiocrFyqAdR9IduFyxhtNVbPUUCVRnBp6y6TmafKJ
	 S1S9pWh74towQZ9qeHlYIvVBI8EeRyJYzH694U4TPlGY1WZlLLxcP3Xc/wQxgVVNqT
	 O0P8zcrWdSggXxoYdFgVeNmPk7eD8R9CL45uFcAA+g3pofFyeLR4wSsWcOM3Mxl5q3
	 D3pgpF8xrytDQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	npache@redhat.com,
	david@kernel.org,
	ziy@nvidia.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	hannes@cmpxchg.org,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	richard.weiyang@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: migrate: requeue destination folio on deferred split queue
Date: Sat, 14 Mar 2026 17:05:54 -0700
Message-ID: <20260315000555.76876-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314154042.327ba957b1a8c10f64ae0169@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,redhat.com,nvidia.com,infradead.org,kvack.org,intel.com,gmail.com,cmpxchg.org,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-225452-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 737A528F9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 15:40:42 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 13 Mar 2026 13:40:29 +0300 Usama Arif <usama.arif@linux.dev> wrote:
> 
> > 
> > 
> > On 13/03/2026 03:52, Andrew Morton wrote:
> > > On Thu, 12 Mar 2026 17:16:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > >>> By the time migrate_folio_move() runs, partially mapped folios without a
> > >>> pin have already been split by migrate_pages_batch().  So only two cases
> > >>> remain on the deferred list at this point:
> > >>>   1. Partially mapped folios with a pin (split failed).
> > >>>   2. Fully mapped but potentially underused folios.
> > >>> The recorded partially_mapped state is forwarded to deferred_split_folio()
> > >>> so that the destination folio is correctly re-queued in both cases.
> > >>>
> > >>> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > >>> Fixes: dafff3f4c850 ("mm: split underused THPs")
> > >>
> > >> Seems the commit is merged in 6.12.  And I assume the user impact on
> > >> THP-shrinker enabled systems is visible.  If so, should we Cc stable@ ?
> > > 
> > > I think the user impact should be visible to backport, but the
> > > changelog is elusive on details?
> > > 
> > 
> > 
> > The original patches added THPs to deferred_list at fault/collapse, they
> > got removed but not added back to the list after migration.
> > This patch adds them to the deferred_list on migration. The user would
> > not expect the THPs to get removed from deferred_list on migration, so
> > this fixes user expectations.
> 
> Maybe users just won't notice?

My guess of the user-visible consequence was like following.  Because THPs are
removed from the deferred_list, THP shinker cannot split the underutilized THPs
in time.  As a result, users will show less free memory than before.  I believe
I might be wrong and Usama can correct me in the case.


Thanks,
SJ

[...]

