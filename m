Return-Path: <stable+bounces-267679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/RJGVIeOWp2nAcAu9opvQ
	(envelope-from <stable+bounces-267679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:36:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7E6AF251
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:36:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CmuNVBxu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267679-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267679-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E66309DEFB
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBC2C21D9;
	Mon, 22 Jun 2026 11:31:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DA2BFC7B;
	Mon, 22 Jun 2026 11:31:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127917; cv=none; b=J1M0f1B/PHxtWc+VU9unozFTTTAAYQCgdK5xwKTLhkuYoJJ9L4dwZJWyWc39kSKNX1TcrDIDptzrgHP2drOyKqr2GYg5AxSKap+kDo6Ccv8yvGrHz/4irx23rgMH0NxaZrgBDaneX2dMx5OLkg2ejIAqYAT1TCHPTcidPWn+D24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127917; c=relaxed/simple;
	bh=oD3ux3nXHs7bcD475xb8S4K/F+nq06uYV+drw4mNhSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXFIPcLDBKsvcPHAdOL67mFzMhwGBFbl6xiPlzPWzr7M3vw1z5YDfTKkHX5P12xcE2aqRtRMAOaLJ62TNGyh8rEVhFZ+Q5hdLb2YTE0xYQ6YKatbS2TuHvyWmsZd+0XVAHK7w5qGlOawWJz6qmAYwsyI/HI6P8AHZzEsGQ4nVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmuNVBxu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3981F000E9;
	Mon, 22 Jun 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782127916;
	bh=WFITMWHSz2eYvV5r4SK7tu5mdoIuGO+WsB8vHZ8ZQnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CmuNVBxudCGKY4ayoLonnCJUHGXSeEww3VsN+ldoqalAWYEDkT/J1I0eDXp7fo1v8
	 PNTjklMpg2/9hz0cerhH9zjvHJQbbenAyyR+lScm9wTKBB8tRY/ZWSzqi0kfS66SbV
	 M+ORRpYtjbrO3w5BWCmaSd3Pf6W4YwxZllS2Hj4ROigs+x+PjSWT3vGWtUUJngkgVg
	 jyGu3ozFNNEJRqeqe3ylCEaJVkQaeeGiFTXh7wP5JRGuc6GKUF3ok9Js+U/8qCDlQ8
	 Doku8cMKnKPZ9Lrlxoqyfo/AqrS0Jd7acY2GnVrQJZeO8+jrOL5gNZDAOtkx/Z9ulH
	 qCqMDTlL24qAQ==
Message-ID: <8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
Date: Mon, 22 Jun 2026 20:31:54 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
To: Alvin Lim <alvinwylim@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260621100844.1224301-1-alvinwylim@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:alvinwylim@gmail.com,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267679-lists,stable=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12B7E6AF251

On 6/21/26 19:08, Alvin Lim wrote:
> The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> can be handed DMA addresses above 4 GB - it silently corrupts data in
> transit. Reads return different, wrong data on each access. SMART is clean,
> there are no SATA link resets and no MCE is raised, so the corruption is
> invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> or, on Ceph, mass scrub errors across multiple independent filesystems at
> once - i.e. host-level, not filesystem-level.
> 
> This is the same failure mode already quirked for other controllers that
> falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> The ASM1166 currently maps to plain board_ahci with no DMA limit.

Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
this adapter bug is the same as the 1061.

-- 
Damien Le Moal
Western Digital Research

