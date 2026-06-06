Return-Path: <stable+bounces-260896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0u1xIVAiJGoi3gEAu9opvQ
	(envelope-from <stable+bounces-260896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:36:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0406264DA83
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:36:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GEDmyuIw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260896-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260896-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D083050915
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4253B42C9;
	Sat,  6 Jun 2026 13:31:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B68346ADA
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752697; cv=none; b=i6M1xE7M7qGDUZg4gtNSCO8acejOaumchMmWgB6pUbjMwcv0pKlSQhG40nIiqloG0y4z/q9fTZemwCeo7OpoJoZ5sQqm5sYlPCzazX4yJWcy/XCa/CNnSP8XDhe5OSRJsYrnsPl4tBuyLtC9kqCtGZymKezRnILDPFuTRYJ2pTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752697; c=relaxed/simple;
	bh=r3MvCLHn22H1sDApLuEBvy/ldspKp1T/unyeNRwQefU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2r1uqGNWban0qZGAPFXUByi6/28dl1i83Z5UkkvSoOQPXDxflBOxykC8+a1aLKK0BbFfoBbZuEGqePLPJ9XjuhS6JzFpKdk2/bA28P4xPqBPG+6jwemXlZ8kEyKkpth/rGdDy54yMfPjs6hO/Fq9Z8GNGyGjBGhI6vwRqLbPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEDmyuIw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F81F00893;
	Sat,  6 Jun 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752694;
	bh=0JyHE6T5pGyjMJSzEetwvTLlPbxwA+1Urrm7MvimLa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEDmyuIwGzWbRJ39iCMo6w9rZFjl5asOyYSIhu6lBtYhZMCjYWdHtHWYKu7Pr3eM1
	 72t4Yd+/HpXD1kJJF0wrF0C+b1brnqj7Gdo5tVwC8loY80+hrhZ9OphIA1xOwfF54v
	 UtAUpEKw0V1Sc7XRH4BdW12hVxOZ9eMdNlgwSUcAj74aLl6ZXZw9jbP0paNy2AdQAd
	 0QjUKRQTPuZKsarlsstekoFXKWv9CTqQnFV3mLCYCJUvoXfIw12coyUwWH5HhrPaeN
	 P2PYPMhG8aT1X8ghThqUwc8mEokc+8MBQdUL8sj/W/uaAEJN1nL7AIjwfJq+fBNjoo
	 Q4d1xoMd28lJQ==
From: Sasha Levin <sashal@kernel.org>
To: herbert@gondor.apana.org.au,
	karin0.zst@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.6.y] hwrng: core - use RCU and work_struct to fix race condition
Date: Sat,  6 Jun 2026 09:31:20 -0400
Message-ID: <20260606-stable-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605093047.1672-1-681739313@139.com>
References: <20260605093047.1672-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,gmail.com];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:karin0.zst@gmail.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:681739313@139.com,m:karin0zst@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,139.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0406264DA83

This doesn't build on 6.6: <linux/workqueue_types.h> was only split out in v6.8, so it's absent in 6.6.y.

-- 
Thanks,
Sasha

