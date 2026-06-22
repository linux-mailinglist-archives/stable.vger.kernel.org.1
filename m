Return-Path: <stable+bounces-267798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0I83DwOTOWrxvAcAu9opvQ
	(envelope-from <stable+bounces-267798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 21:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED36B229F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 21:54:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MPrJA0ii;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267798-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267798-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9C3C30433D6
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017334A78E;
	Mon, 22 Jun 2026 19:54:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CF21B191
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:54:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158063; cv=none; b=Jqefmdb8LhOLyYm3QHoXfSxCr6m4ck8/zaNV4Xqe9Iu0uhU8i1+65QgFWRtidDQZ93WbgqC9aT2g2RW04EP7AatKyuH/dH2zH/vojd5KdSyNcitrE7qLZolfxmwhOD26J9XgZmRmh4DQ2cpYMlWPPq4KfbwN4OcnUA8pp/o7AaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158063; c=relaxed/simple;
	bh=/PvDjwXfL4d8ojZL5Iw6Z4Z92K6WWr3yc+hYSgYDrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REKd8Dc7yUbXo1SqTTI/dIxQtIXmy3tnMmEqWs/vHP1D75icbpRwA99Hcb+uMM9r5+iTphekPOc4icClaSwIfaDM2RRoLUbNMM/UeXmp1Jemxwm/ExC8l2eiS00oezs9S9D+aY1yqrtpHG7ziprUICWaACbjQScl5wApTLuhfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPrJA0ii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F0E1F00A3D;
	Mon, 22 Jun 2026 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158062;
	bh=fF/FGalmczLJBR54/lDenR4pHv/HDXTywKKOe4nkhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPrJA0iiR8eKim8egdVAd9BVvc4dVzoWNo61L+3jGv4B+QeCHlrTfUzEvUO29wb2V
	 rwVhBj/pIEJmqOjE93GJZoOahovl/3ksbiUtYDuSqqg4FHqeczeEnBVtmqqfwbIaux
	 tZ0eGyn564BLd9EsBtQH3Jjdzu7GZKRpoEewmgoTxlIhXHtPYcjhg48seRDesUw3Rd
	 ZESxfqqUfgbBZZv3zQoNEyI7JjJLvoWfXb23WcQMg7OLvp0PZG3k+oHO0YnGUrJ/BN
	 bkzT6FrjShQqPBAZXraO4za3PHzZJBsqvrJHmSddunZobGiTjHF6ow7HgTScsAQhpP
	 3OInVvOsrnNCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [patch v6.18.y 0/4] debugobjects: Various backports
Date: Mon, 22 Jun 2026 15:54:14 -0400
Message-ID: <20260622152404.0001.debugobjects618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622093040.582177124@kernel.org>
References: <20260622093040.582177124@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:longman@redhat.com,m:bigeasy@linutronix.de,m:tglx@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267798-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3ED36B229F

On Mon, Jun 22, 2026 at 11:54:33AM +0200, Thomas Gleixner wrote:
> [patch v6.18.y 0/4] debugobjects: Various backports

All four queued for 6.18, thanks!

-- 
Thanks,
Sasha

