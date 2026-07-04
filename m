Return-Path: <stable+bounces-271908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxWLJR9rSGptqAAAu9opvQ
	(envelope-from <stable+bounces-271908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CA706761
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oy+qIkcc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271908-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271908-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A8F30626B2
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F61371CE3;
	Sat,  4 Jul 2026 02:06:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47862309AA
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130760; cv=none; b=jhiEDQQAGoP4QJSX8AapixpSuvV4ceuOKcMNB/nOUwk73BR6XIiBQ5T3jiTHaIWk1F3U89rJzUoWWVJg4hd9TEEDtaL7tz8T8/JOXTYRvXJP//fDtUZmSSsUfnmzzeq5/Vx1Dp8Gr98eWDlvHiH4Wejk9RdRFVPjLNhG+L8aTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130760; c=relaxed/simple;
	bh=enyRv9A7LL0PMG1Sfwa7uOR0aU+AG+Mfrp90NOrgw9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edh1vCKmXrYIWb9dXF1Aqr7mylsZj1uIuaL6Lgfg2j124B9mhATmxILygb4yniHAH3ht5Ij/NAeCediIbY/FXw8KzkbuxsutYTUFZKyYaza6xZ8B9SgOPCIfsqT0TQAS5+W/5Ftkbf813jC0qBOCbXTKROCYitpMflgGwapekw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy+qIkcc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99C41F00A3F;
	Sat,  4 Jul 2026 02:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130759;
	bh=vkHbBWy6dxnIxY6uMlmcq/AMafxCSQVmxRhFn5qQ9+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy+qIkcc7/yapVDZw3SFIY110+xc6uN57TQw4BiUOk2vAkANA0CZzIQ6Zd3qKSEYb
	 0Ja8W9QvGoRTzcNUjTOe69XBsvYqMlIpV/kQ64l6c5SWkRWLk/8VqDWGzRcal//gNq
	 zShWtbwHoh0Li59kGHzoC5TuYfyT0jXTFMVB9xjV3+G0DAwJAFBTds+J/MNKcmWK7+
	 fc4yICXYCoEhacJjitzZewc5TRs149sxxXxv0nen4xmPn02EKBybqI+hXhUZu7lbiH
	 Dwqps+kcqgnyicZAc0ksLsBl5De93v47GoJPlXh8GMuLNBFDUQ4quTaFdmjO+N5kQc
	 XsFNXnkaiHm8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 6.1 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Fri,  3 Jul 2026 22:05:19 -0400
Message-ID: <2026070315-stable-reply-0025@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703061126.125313-1-shung-hsi.yu@suse.com>
References: <20260703061126.125313-1-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:daniel@iogearbox.net,m:puranjay@kernel.org,m:ast@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271908-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 524CA706761

On Thu, Jul 03, 2026 at 02:11:25PM +0800, Shung-Hsi Yu wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.

Queued for 6.6.y and 6.1.y, thanks!

-- 
Thanks,
Sasha

