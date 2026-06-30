Return-Path: <stable+bounces-270059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3aD2Je9BRGoSrgoAu9opvQ
	(envelope-from <stable+bounces-270059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:23:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B876E8614
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WHd/c+0r";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270059-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270059-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87ACA3015D7E
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460E33A70F;
	Tue, 30 Jun 2026 22:23:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2873290AD
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 22:23:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858203; cv=none; b=khGXVHVd3k0iB2jkTdlsr2Try7UYf2WAPoF/+Jb21uvnkAG8/ma6zBP2CcxN2LlhuivC8izQW6VE7iH3GkWv3Kb5cS+y0LUy0cJJH+oA1RqGReLZwfoVpvNda/TkNW2C79ngYGgznvKDmbfi147iW4CljIS+10q+wQwl5TQ3/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858203; c=relaxed/simple;
	bh=dIxuY27GH9H66IR1F710Ta6hV31rXYA6c3/+TRjGgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjvzG/IPcLeeulIjR0d0GfsMSMVzz7EyO+c90U/XYZpNhal2xSNHseLBEYrfQNrVOFsKr10/8zHYf6pwoETQbW0zDkgPz+5g6yDwniuwFiOcMeKlSszlwu6xzJY7eVPBDCr7u9YcBRcD97UgwnJbsYX8Qv0OulEwE4jIcmWPqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHd/c+0r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C261F000E9;
	Tue, 30 Jun 2026 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858201;
	bh=dIxuY27GH9H66IR1F710Ta6hV31rXYA6c3/+TRjGgBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHd/c+0rvNgkI8iGQD0ZaD8+h/Hs2F72UOlqWRAEKFfMlePPRVcvymspxTHQwsbfb
	 vp0D21QYCxp8evfrrCWYzKcM6j/PZXQycI1GM8q2wGUMapH8RyNpAb1Ds+Ft/SKXww
	 xuqfAcBgs2qYJVRQ47r7iAdbbyI71oZ+lrWQWtsJtLx8KFDB2eHr+FgReNQJo+od7u
	 G0ZV3hl4sCV08Req4XJ2vYBUHl5S875aZopt4HL30+6aykFTrInuzir/fFn/XBfxlU
	 xzBr8i98X8nTh9yYrrv+1wZ69DiNTz2pSOttY2LxPVLSQZC4r7bM/uo6FjBz1ea8mH
	 ESrshPY+dyY2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mst@redhat.com,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Annie Kim <pulpannie@gmail.com>
Subject: Re: [LTS Backport Request] Fix RSS indirection table OOB write (6.1.y, 6.6.y)
Date: Tue, 30 Jun 2026 18:23:12 -0400
Message-ID: <stable-reply-item007-virtio-rss-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270059-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pulpannie@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B876E8614

> The canonical fix is the upstream commit 86a48a00efdf, which makes the
> indirection table dynamically sized. Please apply 86a48a00efdf to
> 6.6.y and 6.1.y.

Could you send a tested backport please?

--
Thanks,
Sasha

