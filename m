Return-Path: <stable+bounces-260887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3CHKpUhJGr83QEAu9opvQ
	(envelope-from <stable+bounces-260887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:33:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087164DA3B
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=icSoNCH0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260887-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260887-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1B493014BC5
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18853932E4;
	Sat,  6 Jun 2026 13:31:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2450155757
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752685; cv=none; b=B1jPn+IUcw1sTnO8BhbARhwWffuaeGZ0/xy9Hurg1zno4iNbkOCcueAkVqHtYi1a5zXM5VvVynMuRF5yESSd4jyDCqOVGljYs646I5j/fMfyBky+8CEB4jSutdjnp88qwJ4Yhbl86yNpLtsGOjASVuFxK0bZw8BIIH8bTEYSTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752685; c=relaxed/simple;
	bh=wlNBa87WUqlbdM9AYsxiix44qp8Hm4lzeBz7V6jA1S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3J8d6ZMJdl1bxuEvm9XImeAcRuKnYnk2gKyl3RvSGFX9CMYBPNu8x8r7La90lOHl7fs08qGSNIvRRMCDx2a1/jLK28O9xZQb4pIngsuEGqOnak+mFQ9l26RttDcAr+04EfNXq9TuNhp7f6zdZc3UH8XB52VUFeZqg7B5MKHHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icSoNCH0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B294A1F00893;
	Sat,  6 Jun 2026 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752684;
	bh=7uLeZX5YdXwGfWR+8W8pWzdZoh4HjBa0muly6bWfHUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icSoNCH0Hw2zAHHoU5stjg2rkRAdRwEIv7LiMf6d/Q+XHdfUKMBF4tUK2Ml9u8dN4
	 DJG8mqyyS4ZM6BF1v/FcRcswNfN/bdMMMscwnvkd5crWpXZ04DbFeHuKZwGlSVpciE
	 zyepgDXHsQQoQRkT8QEXqdiAAmbK0hjxNH/hfd0TrH2jYyOgVnF+t9JuDdXleQlXPo
	 gQREUPc46Iq1T7Sgl9hL653mlX04gBo8kpOB031abij1UZTVT/KnYdNk2p6BScqno7
	 ry4/NpenW25qH6TNKYQNbTGis3a893iRkbff4xYbCxTMa9nwu1ArU45ZW3eB6dm4tn
	 011N6ITkZQjgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] serial: dz: Fix bootconsole handover lockup
Date: Sat,  6 Jun 2026 09:31:11 -0400
Message-ID: <20260606-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605030250.6181-1-macro@orcam.me.uk>
References: <20260605030250.6181-1-macro@orcam.me.uk>
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
	TAGGED_FROM(0.00)[bounces-260887-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:macro@orcam.me.uk,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3087164DA3B

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

