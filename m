Return-Path: <stable+bounces-267319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uj40L2nBNGopgQYAu9opvQ
	(envelope-from <stable+bounces-267319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BA6A3C30
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b1qbBNod;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267319-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267319-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1910E30F7211
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DC32B11E;
	Fri, 19 Jun 2026 04:07:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53432BF41
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842047; cv=none; b=UIb0lHKd/1/gn3sbebAcTI1y7qkGTnL0OPgBdMIpqvVMsTWl9qGD7tUUEWWmJKc1h+R0mMdRAEk6+8e9emOc0y7mpcxUAiKE2st/PLEsRn4mx6kISKcoro8orEW6HA8oXhjbgmIelXqrYIzechnMIBrqUXPxWILRulh9s27uTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842047; c=relaxed/simple;
	bh=SYrOiAi23vpHmBbCBuJchauJs0CaZacvuixu5G/T7Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGB32T0w58huWTnEsUa1mK2wnDe1IjJ/hz6XME4JqzMIruY6ekowoXpjhZDpicOBC7IUfDRUVYarN7AQ9/KOQRoSSkE0tayz84DHJOgvlEhcsSYLSJ+nS3TpuvF3IuTdypqq/pHpuxN9ocvEpTiDkJVYVZbrJ8ykB95CJBO7F5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1qbBNod; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714341F00A3A;
	Fri, 19 Jun 2026 04:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842046;
	bh=SYrOiAi23vpHmBbCBuJchauJs0CaZacvuixu5G/T7Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1qbBNodfrbaz/ODiYdMFXclJ3fc++0s1ysh9iO4T0QBKIzeEvVq7+jU3WFp1nkOK
	 D5iFJv4yhEFnFlyFRmBOqaL0KjsYh5UD/PV+6UeVBBDBY/al6DHzXAPzSpdOOplfk5
	 FJaI9NomILmmGZ1ORZVKxjhV3Dm6PKqzRn697YBZlI80yroVhkfqxA1I/E9zp8KKkz
	 /aslkvUmyPNab+6BTShxcNlOsbsKdmEpJNVfxjSeB9f5UNpImFbfqChr4Te1UyMITF
	 tj+DLRbKvLcmjLPG9NC6M2O73e3dq0E01oq9dzKzsr+0WIXa0rrA/Of6PglWy2oCBw
	 uS1lcLIwJXRqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Fri, 19 Jun 2026 00:07:08 -0400
Message-ID: <20260618-reply-item039-perflink-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618074114.16091-1-shung-hsi.yu@suse.com>
References: <20260618074114.16091-1-shung-hsi.yu@suse.com>
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
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:ihor.solodrai@pm.me,m:andrii@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267319-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 459BA6A3C30

> [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link
> test

Thanks, but will this even build on 6.1? it depends on the get_time_ns()...

--
Thanks,
Sasha

