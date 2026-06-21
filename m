Return-Path: <stable+bounces-267552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SIj4KkHsN2q0VgcAu9opvQ
	(envelope-from <stable+bounces-267552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CED6AAFB1
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XXHEHJbd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267552-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267552-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629463038C43
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E557288C96;
	Sun, 21 Jun 2026 13:48:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11025284880;
	Sun, 21 Jun 2026 13:48:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049683; cv=none; b=AeuPzfZHkVDcXhxsA2ga8l7LgSMTHpagz6jb094l85tI0rLP6PpNEyWoq5EkZE+e+IH9ua+7qjKvBmBm6gIV9l1hcmXAXAH36vDipKLlcBgy8rt1Mc+n6XdIHktUqIsCUNUjZGmyskkLjXpL8Vx9pj08Wwd6yjoTlbreaPOdcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049683; c=relaxed/simple;
	bh=Pb7JYT9q17DCcNrl1y0A3QiuhVemP6/3leF5kP0qupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxefxS8jJa6JqefKJQ2brARWkTRlvGd7hXMc51hKiFPIw9XCC/pJlwPX5BWzq0ySEJhl+Wf11+ssKxtO8VezU4GWGhfrxnNEWvfpalYOLTaoyWAPpdd2m10GI9jNXg7GEGYUKejBhzM9EYlYwEbf/1/QUehzuMN+LBdgjWy0OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXHEHJbd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3A1F000E9;
	Sun, 21 Jun 2026 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049682;
	bh=Pb7JYT9q17DCcNrl1y0A3QiuhVemP6/3leF5kP0qupA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXHEHJbdfZIO+KN1DmjpS2zYjqgc3ZK9FOvCJy/aFx2kLW/6rmM0ENj7855JQPFnS
	 hhVC7xtcF1a4tRLYLigo95IxxrDRa9gemNDFk+AS/bvej6qySrDp3kF3VxumaKTaGF
	 AcKJmspFWGMSUYQgWm3gtOiC/Xb+xQtDmLqDUBQZbAugennX+fbDjwrTapLsbOPR/x
	 PMVoZjBd85X2zRlFpu7jYUszuPlQ+TEdziOihtgH/aP0U5cPPasu9aqYK5P04rWYn+
	 QuTSOnSvggr0WlYf3ZYm9avW55QIdG08HJYHOGxkb1DvMu3oqTy8z5wN4jD5zoSAM5
	 mdbLePyC5SauQ==
From: Sasha Levin <sashal@kernel.org>
To: kuba@kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Sun, 21 Jun 2026 09:47:47 -0400
Message-ID: <20260621133722.0009.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com> <2026061625-starless-mascot-691a@gregkh> <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com> <2026062048-posted-scarf-dcf2@gregkh> <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267552-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:linux-hams@vger.kernel.org,m:bernard.f6bvp@gmail.com,m:bernardf6bvp@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05CED6AAFB1

> I have prepared a first set, attached as an mbox: 15 ROSE fixes for the
> 7.0.y stable tree [...] The whole series applies cleanly with "git am"
> on top of v7.0.13 [...] The 15 fixes form one coherent set [...] this is
> why I send the full set as the first batch.

Thanks Bernard. No objection from me on the series. Since Greg has said
he'll apply the 7.0.y batch himself (and these come straight from the
mod-orphan tree rather than from a mainline SHA), I'll leave him to drive
landing 7.0.y first and then the identical 6.18.y batch, and I'll pick up
the rebased older-tree batches once you send them per-tree.

Thanks,
Sasha

