Return-Path: <stable+bounces-274132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75i2N1TRVWrLtwAAu9opvQ
	(envelope-from <stable+bounces-274132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403D7514F2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nda4NQu4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274132-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274132-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 075C83030244
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551133BD651;
	Tue, 14 Jul 2026 06:03:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242631FFC59;
	Tue, 14 Jul 2026 06:03:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009039; cv=none; b=TqnSCqJuFUrJJUL083MAn1KJWxf6wLGLnfZi3MHsl35+yZ4YCbIiwiFfDD11C4HrmyFhOfBOGmOhNTlJI186dsaQkPBnhSkMiQ8v+oQ8ag+2nIWL5a4ASpYAJ7xFMrYVTNY2hLrzRJ92JN0kfg1KmMl03AbLHGx08qAaCpoDoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009039; c=relaxed/simple;
	bh=n4V8g3/xAGJ3QXCe6t90uCoV3YhkVCIteU3JdGY18yo=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=XpyngbLXw1m9eyB3GTSgTB+5wtZjw2oqtdmBN0sG1uVyvCMc0IFrVhDNyrnQkSv3wuvMNwiud/egni4Xbm9Fx7iCZO29IHXwq9RGD70PBex8rR2+NV1RVWQIIy5aT4LYOPPQbig8ilnjKuz0mohzB3tWnbSsxclUhvUrTnrwtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nda4NQu4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B02001F000E9;
	Tue, 14 Jul 2026 06:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009037;
	bh=y6HDB+LkIWrLbng22LKCJQJGo4JTbKj4Gu2qxbwSnZ4=;
	h=Date:Subject:From:To:Cc;
	b=nda4NQu4IXR82lykvHQ2esPrUaIkJMrcP9/i3iVOqhGUsxCwbJQd496r4JA0n4asB
	 kbvrFAok8dMYCRYjFAqCRmFaxGTjjcel/J1C59bDvDUgSDKxAtmcY4dXve2LfjZI88
	 YGnHkqzk/FT5U5YLKEcJP3Zfag1Ya5/m+9j9wfSNJX9j85uy8wqjNXRfQ7cqJajYNK
	 Oqy9NZuKxW627B9/pOvvfXFQks5hdak5XA25EEwl1ERXqvQtA6EHpVFVypQY4S+UNe
	 jyr0qPk4vy9wngMl6q5Y8Bn5IlQMVxdHwaRUC75b2y0HCVsLVWKpXmru5r6ubV90c8
	 fU1SrwuVZAceg==
Date: Mon, 13 Jul 2026 23:03:57 -0700
Subject: [PATCHSET v3 1/2] xfs: LLM-inspired bug fixes, part 1
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <178400716321.267810.14342805775513660564.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-274132-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4403D7514F2

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

v3: add rvb tags
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
 fs/xfs/scrub/cow_repair.c |  179 ++++++++++++++++++++++-----------------------
 fs/xfs/scrub/dqiterate.c  |    2 -
 fs/xfs/scrub/rgsuper.c    |   14 +++-
 fs/xfs/scrub/rtrefcount.c |    2 -
 fs/xfs/scrub/rtrmap.c     |    2 -
 fs/xfs/xfs_bmap_util.c    |   89 ++++++++++++++++++++++
 9 files changed, 236 insertions(+), 132 deletions(-)


