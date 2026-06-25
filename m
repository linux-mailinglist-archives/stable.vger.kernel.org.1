Return-Path: <stable+bounces-268333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YB2rLDYGPWrDvwgAu9opvQ
	(envelope-from <stable+bounces-268333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29F6C4BD0
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WAax/uja";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268333-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268333-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DBDA3062C38
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC374E64;
	Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B503D410A
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:42:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384130; cv=none; b=VxieFGWLkO7nMnazDEcgxBooFyZeGzSC6/O5BPW9yJXPcw1zFmtTVGK3L26rpIw8I3lfSq+rYNiR6UQFFyF9RQU04qbglcUtKkuHrHWIJnMolL4pEhG5MGO2kBRXp9sYXlGk/ePnNawLDvKnweQT/tYuDFtuRSeW0fFcbBopNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384130; c=relaxed/simple;
	bh=oEas5vwhM7nTqg62I39OYDKKPhuAYO4RRmO1pIV3ySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF3u+cWooUNbQJ5opGh+Md7Qf3XOSMbrgfcHcpxWC7sSlAa9WufjfUO2gwG1bh2Mbkwd2FsV8/0Ea5WOzwPZOy3yTGKdgFQUAT+lLhKopVUXEE6P7bxLiK646e+f24ISesHU8BZ4UbAUzrAutFsCSDiCJtNa9Gebsl0TMDcmyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAax/uja; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C621F00AC4;
	Thu, 25 Jun 2026 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384129;
	bh=oEas5vwhM7nTqg62I39OYDKKPhuAYO4RRmO1pIV3ySc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WAax/ujaoAOU8fSeoeDCGSHurVOGZVoQISk/LA5vWj5vMlG4aBfAtBVX+n3CpoKMM
	 qd4sL5J60GZRfOIFBCWe5hIiOsYd3bMsnOwEyoRoJFCMAISDjA9dGQc7gHHIwIT9Sq
	 3ZOl7equws5+GXSFjqzpxnuo71FhTF8f8nTK0nTyWco9zCgpbZLn/7pMbtkQwC0+/6
	 hcDaZ4PlHiYEZwmfBYtDoNMlO/Wd+3GKBuSKDcmxhIK4/tBKEyC/nAZYO+/Jda34kH
	 cnGYy0b9A0K4Fmi6KjaFhM+O9MbW4yMq9Jay7oX4faZIg5/N7YC3j/5eFe7pt45ZMJ
	 aoT5w030B/Aew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu, 25 Jun 2026 06:41:52 -0400
Message-ID: <20260625054005.0005.bpf-kprobe-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624072901.28197-1-shung-hsi.yu@suse.com>
References: <20260624072901.28197-1-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268333-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:varunrmallya@gmail.com,m:memxor@gmail.com,m:leon.hwang@linux.dev,m:jolsa@kernel.org,m:ast@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F29F6C4BD0

> [PATCH stable 6.6 1/2] bpf: Reject sleepable kprobe_multi programs at
> attach time
> [PATCH stable 6.6 2/2] selftests/bpf: Add test to ensure kprobe_multi
> is not sleepable

Queued the 2-patch series for 6.6, thanks! The prog->aux->sleepable
adaptation is right for 6.6 - nice catch.

--
Thanks,
Sasha

