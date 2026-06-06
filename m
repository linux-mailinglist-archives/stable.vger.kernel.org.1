Return-Path: <stable+bounces-260893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7PDGD/YhJGoT3gEAu9opvQ
	(envelope-from <stable+bounces-260893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B864DA63
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W3d+JxVv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260893-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260893-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065DE3038146
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CD3B3BF2;
	Sat,  6 Jun 2026 13:31:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A923183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752691; cv=none; b=hYkouYMyE64QokBeLccZbUAUpYQMhulY1nKdSvfFcoDHTv1ggM+3y74hC9mmlZkf+g+dWRCjnGz1IsNkE88hY1fJS/EJ90Pl0nB1sojf4/sgUqb25+8LNLd+z3Uvo8mjhoBHmEKZGsjCSh2W72He089KDpwxQ6RMM7Z2LL3rLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752691; c=relaxed/simple;
	bh=WbMLx/i15JDVy8U4idwmH1xcQbbTxWYH8XevgE25VKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWFoN/siR3l1Z/FapEo+s5d5KhX/ZXvgtXQUpNp+zoEWsWFHXaYKSyKOEDDQpbkTnH4bvDaR7NPYO2vblhjAUgOAh3lVjP7xD5SCKCHzvgXDTSpKrCLvid+9lNCo8KS0ByLUAcvZIx+fHkRb4xIsVrNh7qRiYqXMNbsaFU7xBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3d+JxVv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21AB1F00893;
	Sat,  6 Jun 2026 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752690;
	bh=sBEHDmIjR3o8iCzoQnFcJLtzYg0uCLXeyRN63Ulnai8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3d+JxVvU068IYcDvl9wNtXHXMpSpWf/jhDxfbnvFrFDG4y+DepwkHIw0IZkKWLkf
	 hMycwaHJlmk6h5O1Ra9uoX9a0PGl224JCk4mtNuUsZM+iX6ZFwa1rvClmA/z3VLCIX
	 nzFxMsIN5z2fHA/oU5KJYMXkqP0c/DzR0XqwGzKrTqdfcy5cEodXs34IUBR5F0ez+D
	 AS8ZDYEHXzYqwuFi3/PsRZh6wL+QgUCtmG1FNuSROXMhihA7HxlTnCxjxV5u/ZDtWz
	 dtSvOcxJb7tx/DE299Sfi3cvcerXgoqf+d4XFgJUrdhHjd7ldz5oMvjHScgsNo74Iq
	 eXkPZjCpKgyUA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nogikh@google.com,
	bp@alien8.de,
	dvyukov@google.com,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Sat,  6 Jun 2026 09:31:17 -0400
Message-ID: <20260606-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604003031.561-1-13621186580@139.com>
References: <20260604003031.561-1-13621186580@139.com>
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,alien8.de,139.com];
	TAGGED_FROM(0.00)[bounces-260893-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:nogikh@google.com,m:bp@alien8.de,m:dvyukov@google.com,m:13621186580@139.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027B864DA63

Already queued for 6.6; now also queued for 6.12, pulling in its dependency a9a76b38aaf5 ("x86/boot: Disable stack protector for early boot code"). Thanks.

-- 
Thanks,
Sasha

