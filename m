Return-Path: <stable+bounces-273139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mDx8ELyBUGo40QIAu9opvQ
	(envelope-from <stable+bounces-273139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D57374FC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C1+RGI5Y;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273139-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273139-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B65A301E6CC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF1332916;
	Fri, 10 Jul 2026 05:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7B1A6831;
	Fri, 10 Jul 2026 05:21:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660912; cv=none; b=R64DuzZrws+17gjV6RVuq8l4B7FPsvxDLBTbFBxmEqvDxLqJ97nUP0mOGKePBvR+zJkagmajBau5X7hR9NW253IrLX0AsezzCpMtbSdsgs43VA9MHmM3SSOm66yrXrF01ASndWU512KsV7rfbxpqnY/goDJ+/kbKBl/4CW8ooQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660912; c=relaxed/simple;
	bh=EE/cagBfeP5GNhr9Bofw1TTwWgqUbL/dYGr5WY/h1oM=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Khov2iL4bOnQb0btEJTLVX9b1JHAN6wgokdtwIDxeNHCh8yQs8CW2KJ/0vgkYBpbQaTIltKbg1r4YOWxLVEYa7JwmKKF580N39M26gthCEUgZaos+Sd7sG8VEBfd3BM4SBmh4fz/GVlFppFcJ+e1l5ab3ALo9ToUSKMqsCa4SPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1+RGI5Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 76F2B1F000E9;
	Fri, 10 Jul 2026 05:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660911;
	bh=HQM5liSesRKslGVe1tT927ecCWYuzCeCQ6cekMerbCY=;
	h=Date:Subject:From:To:Cc;
	b=C1+RGI5YdVdp+Y8sd5KIuLmI9/RAH5IfIg6KF8rUibDomtM3jht2RraBPyEvVIjCa
	 lA/9QeJVZbMZKPV5QnQpF21OE7KdlWNRhiot2CO7ntDvqW6wjzfFg1xBxB0UER5REF
	 Fqcl3VLA4xUnFDGteB9OwoAFIUVkwnfQpvq8L1JLTedK8ljNNkGDi/mn2j/aDpYait
	 c5p1FdmFEhM5YFnfXFTdD4TTfXt4kdbVmbl6oWxqXRl0pRPu3ALxD/Pq1hvymW4jiu
	 iZAwAOJ266A2D9EZiytn2MUweHHjqlmCsUlEtNdASFGncbbJyeqf9w/ZpAnZYl8X+A
	 zoTttt1fl7OHA==
Date: Thu, 09 Jul 2026 22:21:51 -0700
Subject: [PATCHSET v2] xfs: LOLLM-inspired bug fixes, part 1
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178366080946.1173468.2461850065055339934.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273139-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:hch@lst.de,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 789D57374FC

Hi all,

Someone gave me a pretty generous license for a large language model, so
I pointed it at every single file under fs/xfs and told it to find bugs.
After personally filtering out the errors and garbage, here are fixes
for the real bugs that I think it found.

Most of these fixes target the online fsck code because I'm most
familiar with it, but the LLM will read other parts of the xfs codebase
so there are miscellaneous bug fixes.

I'm sending these out as smallish bundles of bug fixes.  There's no
particular order or grouping.

v2: add debugging patch to make it easier to test new cow repair code,
    move cow fork replacement function to xfs_bmap_util.c.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=llm-fixes-1
---
Commits in this patchset:
 * xfs: don't replace the wrong part of the cow fork
 * xfs: make cow repair somewhat flaky when debugging knob enabled
 * xfs: move cow_replace_mapping to xfs_bmap_util.c
 * xfs: don't wrap around quota ids in dqiterate
 * xfs: use rtrefcount btree cursor in xchk_xref_is_rt_cow_staging
 * xfs: use the rt version of the cow staging checker
 * xfs: write the rg superblock when fixing it
 * xfs: grab rtrmap btree when checking rgsuper
---
 fs/xfs/scrub/trace.h      |   35 ---------
 fs/xfs/xfs_bmap_util.h    |    4 +
 fs/xfs/xfs_trace.h        |   41 ++++++++++
 fs/xfs/scrub/cow_repair.c |  181 ++++++++++++++++++++++-----------------------
 fs/xfs/scrub/dqiterate.c  |    2 
 fs/xfs/scrub/rgsuper.c    |   14 +++
 fs/xfs/scrub/rtrefcount.c |    2 
 fs/xfs/scrub/rtrmap.c     |    2 
 fs/xfs/xfs_bmap_util.c    |   89 ++++++++++++++++++++++
 9 files changed, 238 insertions(+), 132 deletions(-)

Unreviewed patches in this submission:

[PATCHSET v2] xfs: LLM-inspired bug fixes, part 1
  [PATCH 1/8] xfs: don't replace the wrong part of the cow fork
  [PATCH 2/8] xfs: make cow repair somewhat flaky when debugging knob
  [PATCH 3/8] xfs: move cow_replace_mapping to xfs_bmap_util.c
  [PATCH 7/8] xfs: write the rg superblock when fixing it

