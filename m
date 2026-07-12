Return-Path: <stable+bounces-273521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3l03Lsb4U2rugQMAu9opvQ
	(envelope-from <stable+bounces-273521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:27:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91457745D50
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Mmgvewp/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273521-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273521-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02105300B3E3
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA01367F2F;
	Sun, 12 Jul 2026 20:27:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0E3B3BFA;
	Sun, 12 Jul 2026 20:27:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888068; cv=none; b=XZ6carjDhGinn/qr6kqU/5nlGEQ3SHnsKlpZE3rIr7qM+4OAXMpp40naSDoVUbAI7n7QpK9UosE0KmxUMfR2lR7199yWoxZEP7pVqjA8GBMe7ZI1q+ggM0UAcrBNJZVDL46sK5sck0hBcNYQ+cbdSvXGZkTrk3Kbq0lFDHlGygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888068; c=relaxed/simple;
	bh=SL8SVxS0+03NRXsmLRbXbAMsBMXKfSOzsfaRx1n5SFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFH4+HIjuA7Wd4YWYiiHVYm2r5gs8J6tGPLXH4Pv10Y3kEi3G0hAKwpR7FGDsmzQ88Lchd/nK6HnkUzEf3eqEbwJjTe5dMeGTOF6oE8Tz2vSmDNXrlRihwH1y09s6G+DIOWveDaxq02d0qjTV47QKSCcYBV5zyT/Z28n156qsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmgvewp/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6654E1F00A3D;
	Sun, 12 Jul 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888067;
	bh=cd3Az1ImjXIaOh3RzJKV5RJtHyQvtsMEKHStSMNz50Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mmgvewp/PNc98bFXTeN5TNRRNkdI+H9KyTEZY1Vbgp7Es1bQXCvx6aMCKuWrXZ03J
	 TStAVroJWdZxL+8CbnCwQpjEC5u11KD2Mxyp8pnkFnaGtpupnE+3ZBP2DGe+PMsifN
	 c373oY0s4MjD7dYJFrSlA2VF6/onUfhcHmGxLuSYwPmoGrObotdK/dXkWaobib9vIj
	 yZhahNyy1PC3h4ClhFCqW659ta7crf0Ngiw2puis+HLfUOnDs0PysVbdFwDv0LhXEP
	 pb9dYRunDPSrw/3oPRZALW+z8bMP53jXkWoeKyXEAE3ZcOpH715it9pfrdkcaCumvw
	 CTKdv5Nc6UijA==
From: Sasha Levin <sashal@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: Please consider 83f99de1b7c0 ("ext2: fix race between setxattr and write back") for 5.10.y, 5.15.y, and 6.1.y
Date: Sun, 12 Jul 2026 16:27:40 -0400
Message-ID: <20260712105304.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJJ9bXzXfQuJ0+LrHbEjBvMR9X+WSYBzeZJFKBt+0HitNE6=CA@mail.gmail.com>
References: <CAJJ9bXzXfQuJ0+LrHbEjBvMR9X+WSYBzeZJFKBt+0HitNE6=CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michael.bommarito@gmail.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273521-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91457745D50

> Regression = a test that passes on stock but fails on patched.
>   5.10.y: NO NEW FAILURES
>   5.15.y: NO NEW FAILURES
>   6.1.y : NO NEW FAILURES
> OVERALL: PASS. The backport introduces no regressions in the ext2 surface.

Can you actually read the docs and follow the instructions there as to how to
submit backports?

-- 
Thanks,
Sasha

