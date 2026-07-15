Return-Path: <stable+bounces-274631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U8TLC9/QVmoWBgEAu9opvQ
	(envelope-from <stable+bounces-274631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:14:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A588D759A02
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:14:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ekP8SkHJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274631-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274631-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682D53133AA1
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAD2AF1D;
	Wed, 15 Jul 2026 00:12:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73D219E8
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074378; cv=none; b=Q16EklJsRQ73Ez4LsGlbQb1mghMAbLl+Sp2OUdEh9J2JaO3S/yifpfqgmKgfI/M7Lw41qqpFJoCXoMh7dDG2ISHFw1Wnz2jFB2YRMd4qizHDRxNIbHIiQWJLtSCTy/1fXWg+5jGvghwjympy2UDQxdA9xT/G9GEJLMyCD4mqSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074378; c=relaxed/simple;
	bh=TGktpBSs8EIvZwPQ9dPiZr5yHB1FOr/kUlmDOhRJZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiq9/z/D6ldKA6ufkBaq65ZMMlAShfPFB/J8agciM2p4cM4n0LL0QpT1MVEivoa2tWRCaI0lIm66eY/ZGJERWWYLgPQGi9MsmTEnFe3ufIAroc5Z06iQOzTrNZ6LAwe58x1xXwNInwgngH8tCbaftWlbBtwGQjBUrEzOWjeJm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekP8SkHJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFA1F00A3D;
	Wed, 15 Jul 2026 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074377;
	bh=kcRiSYOEa0LcsyOkFpR1HjAqMOlMaDwPSe8RyvG7hao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekP8SkHJb/iwK6GdxvmAS1tLzFcmT3AkDcn2WB6/NzovfQqoVdSqW7UYtUBKpTnU+
	 3iENKjkTSmJ76jLT/tnfuW+iJv7rgC09CRseKUwlWIVp2LHjinXF4M99d9HZEitVYA
	 XgFShDXzEHOMOvj8tsAyRxZ1mOjdDA4JyB4jKepNDBWzmW3IuO/G/z8VnHcmo5+UkT
	 LdAK1ek3RaM8ut3WdMfB17cmzcCId6Q/eZPFzhX6XCn/d5zqGIUefDkkOFLL7C6p3Z
	 rykPmqfNi2ZtOyxk/7wC5dvqkAFpa/qqUwulgJ6B8qIiTJ3ACS6JB3DH0f7nMl7ish
	 aMvvjD8lboh2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Anisse Astier <an.astier@criteo.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
Date: Tue, 14 Jul 2026 20:12:41 -0400
Message-ID: <20260714200600.stable0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714043329.3510162-1-superm1@kernel.org>
References: <20260714043329.3510162-1-superm1@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:an.astier@criteo.com,m:ardb@kernel.org,m:mario.limonciello@amd.com,m:superm1@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274631-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A588D759A02

> Background for this backport is that fwupd needs to be able to do CA
> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
> process checks for free storage, and needs this function to do it.

Queued for 6.1. I also pulled in the follow-up fix 79b83606abc7 ("efivarfs: fix
statfs() on efivarfs") on top, so the broken statfs() error path this commit
shipped with doesn't land in 6.1.y, thanks.

-- 
Thanks,
Sasha

