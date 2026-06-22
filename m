Return-Path: <stable+bounces-267661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EdsXFfAOOWqNmAcAu9opvQ
	(envelope-from <stable+bounces-267661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CC6AEB60
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:31:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="3iIq2/jp";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=d96NQf+w;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267661-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267661-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CC6C3061B4F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A053A59B3;
	Mon, 22 Jun 2026 10:26:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5A3A545B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124017; cv=none; b=gZNp8wEFedUHPwnZfTwJwDhKysMvhq9jq+mc1+KOlIFe4q7RnqW+5M30slRJ85fT0C4bGZOWQLikDxlz7XoSvXgFq7I4kkVCxWIABO5BfPP3ya/tn/0Oc+TZEamRIJcae9pTbmL4oOnsbQjA6EnDG8L4aHPlb/KvNw5wyeawdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124017; c=relaxed/simple;
	bh=baSwirDpA4monkJd3G396GlGsw2NX5Cc/zcZ+SCqjws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHQ5UNJIvz8rKUW8ljhzkTJbSeeHymRX473vT5fqj1Jx7EGGcPGHX6ifA54CCY2tPMtd3RPTpJuQ6vwkONc7/VvBlNiFJNxDDASRJaCBzGvdO6HGnyhup/SX1qHJnb/ogx2xcIKvY7PLzm3E9L/9o5fAjG24asJAv9THspgmg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iIq2/jp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d96NQf+w; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=3iIq2/jpfKCs6dmDVcQ8W7+XpcJ4uRTb5sT0V1S9xzQUoaxsp2a0ZLl9MGgmzretjgzjsX
	NEUp6jKFf9eKMLzNdeSQohhmQPRRyuzEDNhN+HyQkJqIXs/pamlzhFt10Ym6LNjPda6UoU
	THytOOctXIQkOF6ri5SHhXKnD7WgVRjw5zwf1I+Zo4S5bGuSbYu2r99FJQFiu3MjaqiQDJ
	mQlotuMX9jF5wPEbZLTckvDxZEpz6pzI/sID5++pOhs8vXpG7WCIwGtIkaflBLsBP+cmWr
	V9ZJqVUVjHd4d1Ue1T1o3xhmhLVntBU9FoHxo+ClpEVIpaW1hCkebWIzC146yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=d96NQf+wLuKxq6Du417kDBLSH6jws2UUp5b+5lwxQ1C1UnocSs7/dRFE1ZYIItFHp8+Cz+
	8UsPY7Q7JdedXVCA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ARM: v6.6 and v6.1 stable backports
Date: Mon, 22 Jun 2026 12:26:30 +0200
Message-ID: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267661-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:bigeasy@linutronix.de,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2CC6AEB60

This is a backport of ARM related fixes. This applies cleanly to v6.6
and v6.1. The v6.18 and v6.12 trees already contain this.

I've been looking at v5.15 and it seems there is code missing so I am
not enitrely sure if it makes sense to backport the last two patches of
the series any further than v6.1. Therefore I am stopping here ;)=20

#1 and #2 are prerequisites for #3.=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Russell King (Oracle) (4):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening

 arch/arm/mm/alignment.c |  4 ++
 arch/arm/mm/fault.c     | 94 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 22 deletions(-)

--=20
2.53.0


