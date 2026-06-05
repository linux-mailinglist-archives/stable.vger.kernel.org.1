Return-Path: <stable+bounces-260796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N/W8LIMmI2rrjQEAu9opvQ
	(envelope-from <stable+bounces-260796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C0964B035
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mXKaNKNq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260796-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260796-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C07E305A8D0
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72D404BCE;
	Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2E4071CA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688269; cv=none; b=VAGeTv3npKOE0SC7swOYoeB7zMY6VPWG2sGWv5EOUXe2Sf4kiMNCqrDBP8zNvyQh7nmiqY8YaC76O4uQsBElmV4D9D6xZdadUiMBsUGXHypDjQn7GpRQDHGgf3rzSPp2F/WGAoui7D7opq7PnCC+XsuIFaROD5in4GPRQFvY7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688269; c=relaxed/simple;
	bh=wthuElmi8FoHOoUPwl3o2fwIU2TUISWTvx6TErJjIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urm0E0ISc9tStlVl3qXp0csLoNYj/XWFLEctoHpzoHiguVeyq3ghvR/gOVymypNSLvaWz+sXy/XLcVWL22qNE9dwtC9IH4UoARfltDZjf6k7HxZT807+AqXxBzhFPvt8uEscf7TFvImyHhGIf2toVwUjJonjhDPYi4JSIt7/O60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXKaNKNq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E40A1F0089A;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688268;
	bh=YyTItRyysV5RNuVdQ6p1fHtkmU+cEkEJueNunRm45zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXKaNKNqV9x4mwV4Xtu7AbSZ2xHW7uYbUVBEawWF3/QXqCC6OfriOtdNZgqvtnHlx
	 zFVYsDQWCkzN7heYgk6Ojq05B0o55GBOu+ubp00NXyy7HnQAa/iVKfxewsMgHuv2KW
	 jgs66PJSpQWubLLfizTMqHZ9hJaOTHAppvjIHBPFMWsYEzD4LHIHgHkbsPdGpUotRG
	 bVzEq8EbFgWVrsPijZTFd7DU4gpDqyr/cmX9lf0YeXT2p5gVciY5Yu8lEYZ419QcYg
	 m2oe7EFHEc+j5kJPK/ffnUljYyJyIaY4RI9gB9M7jljRq5qNpjhQmdM7OU3IIIYAtc
	 0A1N3Cm9iji7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.1.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:22 -0400
Message-ID: <20260605-stable-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121913.150323-1-weichengc@nvidia.com>
References: <2026060434-finlike-uncombed-dc4e@gregkh> <20260604121913.150323-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260796-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:weichengc@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81C0964B035

> [PATCH 6.1.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha

