Return-Path: <stable+bounces-269252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yVwFLPa8PmrhKwkAu9opvQ
	(envelope-from <stable+bounces-269252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD126CF7E3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NL/uvHU9";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269252-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269252-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3F530276AD
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421F23A7F4C;
	Fri, 26 Jun 2026 17:54:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7D2D0C62;
	Fri, 26 Jun 2026 17:54:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496486; cv=none; b=lV8N2BMdkaJdnronbBF0MUUPxD28Xc2TQGrGbjgVTMIA002xEVQllwwzPTaQ4bXuDtk28CVaT3H2/6z6Xessg54mvOjpHP3+x/Xtpj4lV2f3N7iul/YVcmGwmUTJE2afGjKxYycp+p1VPzzF2wYuu44//dHJ5TfxPPu2aOWTtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496486; c=relaxed/simple;
	bh=UHeMgYsEFPFa7fjEu6BlWGRq2scTdgJgwgSRkL6rGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUADuj0dJgcpzetizFn3aCpoewMHx7UFd0Pk3PeONWh/NBzOV3d2KIQho0eVhHq55l9d5Wv0bqpDv/Rak93wZgTK5aGNaMEHnXrIlfwz55Xx7+K2XsAG8Asv4hjIrcSjMopJKRIwDQO71AM0AMgIqmiIOCVJOEmsV5M+cAOtK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL/uvHU9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C91F00A3E;
	Fri, 26 Jun 2026 17:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496484;
	bh=4P0w2YkHaT7J926lwF6hEjqu7vYpYBfmrEfUE95GkIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NL/uvHU9nw9WmwCaB99aZ6QwI44OEqvTGdd9X7I3y5sh4NG5LVXjXeDjzmV5Bbsr2
	 0HZX6umbvCAq/dp6MrRPeXxKQyKMSZIk8ftkNetahX1B465OWkoy3kzddgT9jn7qD4
	 bimGNOqh7UEl6fE4GKJQgTYYICX1TJS/jP49Zc12IEFcnYvJF8C1OB88giv+SVIEdd
	 1S+5Lq8XyMJO5sV8TX+H6DPfWnuw1uwgPGLjBErmIIJUH3nB8s5eEQIt4dAaJlHkJC
	 DWCwBxIMKImaB8ILFTRGrR3BqDETBSj0R3SdKz+hkkUUEZwKBtiBA8fx61cmveFQob
	 GA/PR+PlppF2Q==
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Simon Liebold <simonlie@amazon.de>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 0/2] Backport dependency commits for 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Date: Fri, 26 Jun 2026 13:54:16 -0400
Message-ID: <stable-reply-item002-perf-ndebug-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625133222.3412820-1-simonlie@amazon.de>
References: <20260625133222.3412820-1-simonlie@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:namhyung@kernel.org,m:simonlie@amazon.de,m:irogers@google.com,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269252-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DD126CF7E3

> [PATCH 6.1.y 0/2] Backport dependency commits for 616b14b47a86
> ("perf build: Conditionally define NDEBUG")

Both patches queued for 6.1, thanks.

-- 
Thanks,
Sasha

