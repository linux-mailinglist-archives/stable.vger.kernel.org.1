Return-Path: <stable+bounces-260283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOE6GjM0IWpJAwEAu9opvQ
	(envelope-from <stable+bounces-260283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:15:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69563DEBB
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:15:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y5SjTtlb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260283-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260283-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F562303A8ED
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CF37DAA4;
	Thu,  4 Jun 2026 08:03:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD937105A;
	Thu,  4 Jun 2026 08:03:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560193; cv=none; b=aqaGve5vFKmpHC0ox5oeS3l0ZFJUsy/V3igkXod3u7MSc+hMIZPDZyyB5O/ew8c3e0HusPamLTGVuLsZLlTdSf/yqsMo4QPNq8qrKs+D4cDv+RgO4i1ME6Ibwf8kgAdTXnVLd7XFtSOKF3al1K0gI9McGH464+8c5Nj6a1g8ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560193; c=relaxed/simple;
	bh=h3U4xbU6FRfj5LPw1dUAYyA8i4MkIwkSMyvS3JUHFDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYBiDDLlV3Jpj2Ee5KPHp2/jf9V/3ZAXX9krFwkfN8lgjIjf1ktmYUSGRa4c3XELaO2qu/gGXssUNrdAhZYHAUHz2SqzRGFjYRYSGTpGqSV+B3md/Q9JuEir863xziPKkoHh+/oyNzvK2Kgg24u1of1kTUM2zGYPMJ1dlNH5f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5SjTtlb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338791F00893;
	Thu,  4 Jun 2026 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780560191;
	bh=4+qbYva4rUQ36YFQxNrJt2qeBTPLEdc9Pe/mDaSC3ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5SjTtlbLR3Y70NqdDtHRID0OPhjd6I3u9X77ArcLpYFtaKcqUr0khmjofZ0XEMwZ
	 MfAUEjfkcxREBKCuG/jce90m2W658oWK21aOxxYGxOV+YKlQ48CATGSIEsVbuLsy8y
	 YFas8KGi2NyY43sivQ8J/ePykYQlSzos80HmiMQqlNadk8S6+orC9IgTNaKTUhH2mP
	 b4FCnn0HAl2Lb4Sz2qApyMs6qe0Pcu3V2zXuCy7+3kGrjUcd6Tx8tzBO8p5Jq+prPS
	 ogazCaIiqZ4u4eNtw4MjU9Cafa0ZUbN8lY5QHsoeBd0f0wDeKT6phNR8j9I2gERoQv
	 nnzEp0TB+a+Cg==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	samsun1006219@gmail.com,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid potential null folio->mapping deref during error reporting
Date: Thu,  4 Jun 2026 10:03:06 +0200
Message-ID: <20260604-ablagen-imitieren-tierreich-648c4c1c277b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604011858.2297561-1-joannelkoong@gmail.com>
References: <20260604011858.2297561-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=brauner@kernel.org; h=from:subject:message-id; bh=h3U4xbU6FRfj5LPw1dUAYyA8i4MkIwkSMyvS3JUHFDE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpGlp7nS9qvTTdLvR9OXNZhevaG/IcUxa8CV5RsVBs1 1/mtpdPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayPYKR4Z1DcbfO7KpFppdO nTWwVjS2MBD9Olv2zJ9TdmwN5wwOBzMybFvDaHFizWdxJoYY8dIfn3+Ff7wZuWg336Q1coet7kZ ZsQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:brauner@kernel.org,m:samsun1006219@gmail.com,m:djwong@kernel.org,m:hch@infradead.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD69563DEBB

On Wed, 03 Jun 2026 18:18:58 -0700, Joanne Koong wrote:
> When a buffered read fails, iomap_finish_folio_read() reports the error
> with fserror_report_io(folio->mapping->host, ...). This is called after
> ifs->read_bytes_pending has been decremented by the bytes attempted to
> be read.
> 
> For a folio split across multiple read completions, the folio is only
> guaranteed to stay locked while read_bytes_pending > 0. Once
> iomap_finish_folio_read() decrements read_bytes_pending, another
> in-flight read can complete and end the read on the folio, which unlocks
> it. This allows truncate logic to run and detach the folio (set
> folio->mapping to NULL). The error reporting path then can dereference a
> NULL folio->mapping. As reported by Sam Sun, this is the race that can
> occur:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] iomap: avoid potential null folio->mapping deref during error reporting
      https://git.kernel.org/vfs/vfs/c/2eea7f44b9c8

