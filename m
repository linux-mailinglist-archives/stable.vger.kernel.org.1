Return-Path: <stable+bounces-259412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKaYAJTqHGpWUAkAu9opvQ
	(envelope-from <stable+bounces-259412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:12:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1E618C3D
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F953015CBC
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 02:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A521773D;
	Mon,  1 Jun 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcK3UG8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D391D5160;
	Mon,  1 Jun 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279897; cv=none; b=KNFHiT8982bIkdS+jmd9H90MWSBfVaZfc2daQhtFZyWNQXd6xxRd0AW8NulpiaE3OrZ3mS/VT7wNOhJS2OtLj+ixpYUGThPW0qK85bfmOMqG3BLnLMMocaqx61iB+ltrv+fX9O/lzbe8LYncfMc4GcgP2qpN2yw2WLyZSDJfJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279897; c=relaxed/simple;
	bh=Tkkyc1fjb55iNTWltUGRP1dxid5yPJ910ybhBga2s3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFf84td6KvTtdyhmU6PhQEJz1EhU7KnXfTuxOCLNT99mz7duiiUCPrEYe9QhNo3jahn2uBkCWvg78N5+devgQ/I1Ka8+Q3iByMSplQcmIJaB/Pf+8cIFNM5IGm4ZylLGWl7dQnJgkoFKV992RVdVdVmiZd+Sjw57Uc7orGigmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcK3UG8c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067E21F00898;
	Mon,  1 Jun 2026 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780279896;
	bh=Tkkyc1fjb55iNTWltUGRP1dxid5yPJ910ybhBga2s3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcK3UG8c5lAKsU3vtF3eZBR2UEoRU5cZ5lG9UAM1PJYle6mx3bO6uMC5A5ZnyY6cZ
	 mMoF5StPQzrO/u/LZEklFNIqzBhf7DU6eMJO1z8x7H+eDItrDI+PM0/7mZP352gzbO
	 udiaBRGfwf3nf6YVSRzy2K9il6U/NmZb3OFfJBNxMxCLr7gubmIDo+yrDiJao/cM+0
	 X5bmySdYRbYhYpjsGnYcil12bFD/CyhVjH9Zhef68L6xrcl759YaNg3GNCuRGRe+J/
	 PaixpEOwgrZCYbh63LTqlsGYLqSQ+duYs12zccgMKRuNbYSqGyn1pR3ymznv7Ssqft
	 Ci8mMtdIgoC9Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	"Geoffrey D. Bennett" <g@b4.vu>
Subject: Re: [PATCH 6.1 054/969] ALSA: usb-audio: Improve Focusrite sample rate filtering
Date: Sun, 31 May 2026 22:11:21 -0400
Message-ID: <20260601015021.rc-focusrite-filtering@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahxQECPrGoTY10B3@m.b4.vu>
References: <20260530160300.485627683@linuxfoundation.org> <20260530160301.888290661@linuxfoundation.org> <ahxQECPrGoTY10B3@m.b4.vu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259412-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76D1E618C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-06-01 at 00:43 +0930, Geoffrey D. Bennett wrote:
> Please drop these from 6.1 and 5.15. They're part of a 3-patch series
> that needs all 3 to get the benefit (plus 5 more fixes on top for the
> 1st Gen Scarletts that the series regressed).

Dropped from the 6.1 and 5.15 queues. In 5.15 I also dropped the companion
"ALSA: usb-audio: Remove VALIDATE_RATES quirk for Focusrite devices"
(a8cc55bf81a4), since it builds on this one and dropping the filtering
patch alone would leave validation removed atop the old filtering logic.

--
Thanks,
Sasha

