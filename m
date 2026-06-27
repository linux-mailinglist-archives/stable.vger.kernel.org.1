Return-Path: <stable+bounces-269404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pp3wCef7P2ryawkAu9opvQ
	(envelope-from <stable+bounces-269404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:35:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 488956D2496
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SHh1+Rvg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269404-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269404-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06611300861B
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BF31717E;
	Sat, 27 Jun 2026 16:35:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA602701DC
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578143; cv=none; b=WIq/J7xbBYjxUDiHlVtBT79aJXXB1ln2tPP9DTJfBGiQv6KbBa8w++zo+ISnhGuK+C+2mEBQkQGVMjwIogYEdWIk3XxG2m49DWZNfcjAfTPfceCwCifLB0RPeQbXk8FfxwEdAK1tkTSVCMw2Bm3w9UUVMY+nEEQZercaY2P/C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578143; c=relaxed/simple;
	bh=bbKbto2FN5zWOqJSME3TlCQUiFdgjkZqwvhKQvsGaVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoJGr57JRaVLUEPmY+AnrFXonNHbRvtzZ6/lApJJ5EUtBtiBpXUwEdKWyfzs1vQ9drTYHBlBCytZtEAXYWY5bFCFNTAG/OsdRGQmxtqlvVOrxlKISRsJcIlHLT3UPgfZXBVzA3mW/XoRxKvx/hI/ow7oB6h/An820xQNEZTaEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHh1+Rvg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2411F00A3D;
	Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578142;
	bh=Cw6YTKayCbd64Xa7/kMVbP9gM4FadKDyRhgYQXHyLkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHh1+RvgDnFTFcHWzqoASo/2fcSubg9g3wC670BvqxcJ4IyEbFNueIOEwv1J6V5dF
	 8ujk1fvTWI0SPA+2QUmrJuFP0axERsIFmSwOo+ic07KeGPj0G4v1x8dK8HVVv4vRb2
	 KY5lgvm3cgE0Ar5yyVFrfb44wbVqw9nt5so74Ih+GJYp7ov3ttTD7yxDBIVBaaH+rC
	 TGygH/FzFXlFoEymIPXgCsAXbRZ4N9f6i57i/elavAuWM/8fPsJoUZFM81q9J9ywQL
	 8Hkk9CtFQxSTZJrY1yXXNQmPxF1k4kWvSKRJDzsphFDV1dY/NswJ/PAVtPVYRM0oAh
	 h2A9Sj+XT7AEQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [stable-6.12 v2 0/3] 3 SEV fixes backport
Date: Sat, 27 Jun 2026 12:35:30 -0400
Message-ID: <stable-reply-item015-sev-612-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626193343.256956-1-jinpu.wang@ionos.com>
References: <20260626193343.256956-1-jinpu.wang@ionos.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269404-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:jinpu.wang@ionos.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ionos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 488956D2496

On Fri, 26 Jun 2026 21:28 +0200, Jack Wang <jinpu.wang@ionos.com> wrote:
> [stable-6.12 v2 0/3] 3 SEV fixes backport

Queued the v2 series for 6.12.

-- 
Thanks,
Sasha

