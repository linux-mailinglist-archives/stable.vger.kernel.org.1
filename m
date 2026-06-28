Return-Path: <stable+bounces-269444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o3/HMC+WQGrKgQkAu9opvQ
	(envelope-from <stable+bounces-269444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF46D3064
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Grr/001m";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269444-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269444-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78E8C3007B95
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134827816C;
	Sun, 28 Jun 2026 03:33:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58B261B8D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617628; cv=none; b=qxE/XSPzrLQCWRhcLMv7WB7OdBRISyFwoYLRwTbnnNqoeMOZ7MLn4N+JyAZFOB2vmb3U7oQPV3Wh/N4KJjXeorm0MEnKfrEpDIGxXV3KJmdFjyKHbS7hD5YRZSkcPmY3gtGNJFKw7LNyu1KVdMCikWJabZJcwp2woN/Lsz7jy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617628; c=relaxed/simple;
	bh=+7kILXoFyJu3adRKjSfxuo1ItOcMXU4rmrcR6mbom/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz+szCy/g0EIVy47nJdkGihiOhE0KBiNHtL0V3v2jO6zQsAcDBfbFbYzcphcJFYD+VHt27TqyHbo1HsL8XRT8DjpR34oai8WkOSBb689XLIRPc+lp/oBaSS7mfNRwS91zG50bEFdPPphWaY/58I4JhUDHtQ9W3LjBizIXZkxSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grr/001m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1EA1F000E9;
	Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617627;
	bh=+7kILXoFyJu3adRKjSfxuo1ItOcMXU4rmrcR6mbom/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Grr/001m9GznrYoR2qh+9pedHbKCkSd5eMtqMtInnWz5LufksfIlEGa48wUJwpH9z
	 f4mygdAFBg/e2hDly99puIiU713DjrFXU/4+T9sRs8Hh5YJuh528KACAOK4dynZn9S
	 jdAg7BZTMFpdUda3APguavSIzhrWDYclZ81lG8pmpEle33NKTLdLcButN5DyiaaBl1
	 7tReLYLQV/M9ZlXA10ZxSEPGEBUzhgfGH0iHjzzuZw3+JMgyOo/OvT2w2ae1yQJBT7
	 tPb4oTkjRqBeMkyUqil30wgSUl/8rObG+lqFf3O4UZG0igDydQ1TBZ8EVq5Z8W1ZHh
	 EK87zxZvWw0VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.1 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:36 -0400
Message-ID: <20260628032401.0006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87FF46D3064

On Fri, Jun 26, 2026 at 06:10:58PM +0200, Sven Eckelmann wrote:
> [PATCH 6.1 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 6.1, thanks.

--
Thanks,
Sasha

