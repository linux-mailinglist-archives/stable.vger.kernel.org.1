Return-Path: <stable+bounces-272385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+yFI5u/TGqCpAEAu9opvQ
	(envelope-from <stable+bounces-272385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19882719700
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:58:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nYyAMsHd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272385-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272385-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE81305A23D
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532202FD1B5;
	Tue,  7 Jul 2026 08:50:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19158332EBC
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:50:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414208; cv=none; b=KYNBKcMpCC/BmjpVlZ8LnItKXTbRR7An3hwuhNnia2crUi5SCcOXAqfruSaM123kkyZkmQEMgsE0mQLqSONk1GPfHoZg5xz+4Hae2J4SgG2bZyXm/s5BaVpBSqp2blSQRLnU7INgi44P4PPF9v9uQO8Bfe1M1NJINwVj3TuTToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414208; c=relaxed/simple;
	bh=X4byraDO7yHmbtmSmDsc+urKVfZ/c235kuLFphUiZgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyZt2rjMmqiprn1Gh0rR89ixgDfHPvh4DXrlRsa5pPXFknlXJaEDpJCHsfutkBPSCDvXIVgIQgtC3/ea3ZwMoXUVjEnV2iZzk4Bto0MD2+c6vnn6G7SYzXpxWsiyJusfi/AXxdjXh2R5SHTZwQWfJsgI1+DPjDL2I5O53pqGu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYyAMsHd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005BA1F000E9;
	Tue,  7 Jul 2026 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414206;
	bh=oHu4L+U2DMMQuBEWzdV5HgX/q2fy+pNOqSxXuYOIULM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYyAMsHdDdg8gcTseG3oUDYb4MEZqwL+uE+I5yQiitbeQlDyiTDtga7NH6rt+9Y2i
	 lxGFw69xFAa2QzoRE8NyQNuvtfx42RkCTmq+crqHy8nR0dU1wmO2QH5NKnNqECJJwO
	 2dC3OcIbtGCYJzgamXWQ2I4f97QCMmj2Wl6aQsq2hcKsR7AHwjQNUlr6bSdGBuwczA
	 J5vx55T2OUyLA91LA3WJCfml6vFxtB2H2ag2O7eMOknGz3Jad00j0663i3q4fkrS+T
	 XgZm9DDhYlh8ntdsoNmu2xordWH1fM+00GQWEIlCCiEXt1uchqUzhicp1r0jS5QpVZ
	 UmV3i+uPXUlPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y 0/3] Rockchip GPIO driver resource leaks
Date: Tue,  7 Jul 2026 04:50:01 -0400
Message-ID: <20260707044731.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706161713.2676365-1-heiko@sntech.de>
References: <20260706161713.2676365-1-heiko@sntech.de>
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
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:heiko@sntech.de,m:quentin.schulz@cherry.de,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272385-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19882719700

> Patches 2+3 resolve resource leaks, while patch 1 is structural
> change without functionality change, that is needed for 2+3 to
> apply cleanly.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

