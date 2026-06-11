Return-Path: <stable+bounces-262756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gzyYFBDUKmrKxgMAu9opvQ
	(envelope-from <stable+bounces-262756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:28:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6D673109
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jwRq6ZWj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262756-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262756-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42B7930F8BDE
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1F41B360;
	Thu, 11 Jun 2026 15:26:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA940F8CC
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:26:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191596; cv=none; b=GvaS1nyLT7gb/p7fVC7hZ8BuJqjEgAIeeg3wEdMtJutTvylQWftAS3QHVHNlYy9gp6o0X+QJBmZnAnaYMrmYahW6pVuccH0ej7LUprzinlUCTQd7gc+MzW+oUL1/xeDLxlAsy55NA5t5INOv9Pgzw6jBi8wlBiCBUtRTWLjrBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191596; c=relaxed/simple;
	bh=t8o/UGgityGJMHj76HO8iaVSRXTqkeYimX5nVorT8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD2hBX9mz/h9ViG0wSA/MGkToS/GwP4w9gP136imB8L5q3eXTOkP/Rs2fi/5F2/hdnTxiXH+GuszpgKFlHqYh+7Dm/IfpJKwre6JY7tGZP0XpXiKY/NxUOwrrwnxXprFj/UCdgQskCMu5vJ9VsCOwj4lJo2oBrkQDVtlq24LlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwRq6ZWj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414821F00899;
	Thu, 11 Jun 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191595;
	bh=t8o/UGgityGJMHj76HO8iaVSRXTqkeYimX5nVorT8Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwRq6ZWj/VLEqSLG+wXtgjJbRFSZ2OqciUOqqXBljPbUx++OwxhrCwF5HBpER8mR7
	 kg7dMQaMiOrN25riM3UZ8Ky0EokXYJ9RJJKoFmLF9bHznRWiJxBpzfbuE6NxZbz5OQ
	 IlKmb4v8NKmun4Yj9tn38aRQN91WqUdU7P8i+lAanpRhItVn9XZQXrAv7wEHSVE8cg
	 KODMQEmNWQr4jdJWcMBgDvcL5T6PI+jTYG4oCbOVIA8LG3v8VK2h2nfelA1Wd42vYV
	 NPXVRA2v1KQwwO+nRXkWZgsO7Xjjj2oJJ2YgLdBtSso6K35GSc+SVefQgtbL/s1Hnf
	 NnTYOG3yNjRvQ==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in pskb_carve helpers") to 6.1.y
Date: Thu, 11 Jun 2026 11:26:23 -0400
Message-ID: <20260611-stable-reply-0105@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aioyuCnSKlch1wdv@eldamar.lan>
References: <aioyuCnSKlch1wdv@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262756-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,gmail.com,google.com,redhat.com,decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:minhnguyen.080505@gmail.com,m:willemb@google.com,m:pabeni@redhat.com,m:ben@decadent.org.uk,m:minhnguyen080505@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACD6D673109

On Thu, Jun 11, 2026 at 05:59:52AM +0200, Salvatore Bonaccorso wrote:
> I tested down to 6.1.y; the 6.6.y commit needs to be slightly
> different. I have not tested 5.15/5.10 (no net_zcopy_get() in 5.10.y,
> so more work there). Should I send an explicit 6.6.y patch, or will
> you pick the change for 6.6.y and 6.1.y yourself?

Your 6.1.y patch applies cleanly and looks correct. But I can't queue it
on its own: 98d0912e9f84 isn't in 6.6.y yet, and I don't add a fix to an
older tree while a newer one is missing it. So I'm holding the 6.1.y
change until 6.6.y is sorted.

Rather than have me hand-adapt the other trees, please send explicit
per-branch backports: your 6.1 patch doesn't apply cleanly to 6.6.y

--
Thanks,
Sasha

