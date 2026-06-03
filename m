Return-Path: <stable+bounces-260150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id crOaELpcIGqy1wAAu9opvQ
	(envelope-from <stable+bounces-260150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:56:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB44639F68
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xry111.site header.s=default header.b=Jz955fD8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260150-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260150-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xry111.site;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F236310FF99
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D8306757;
	Wed,  3 Jun 2026 16:22:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E43AA1BB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:22:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503736; cv=none; b=pqSQ7WbsdT+59c4insjyzbG4ed35BEn6Hbmxw+C+fAvTqPRmzi+AjGL3luLROwrx74pozR4xrwKxo4DemNt4//mWOg+ZRqDgTqke6zYsZBcxJ9gvtgto5UXCir0fPW0pVIZxpDhJTACrTnfzSXK0HeovIYPFyJzSfkwi5B5/lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503736; c=relaxed/simple;
	bh=wGxgAQwcjweBt1joUDz6N7yOUq13v1bmpae5T1zCRVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJsLe4nnR90eiEwM9pSFzDD4MunfoDF416DG/5N3Ji07KjSMK7FWS4uF0M2rzTZsT/b26uCGslHn+fgyF8ME8zWXhm9BFQD7ju1IqD1j8Fal14wSsvQeKKcGXbrlrq0hB9/pcwbKEvPRhxh/UBgUHo2/OSF0aU8WP8VCP0Xd5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Jz955fD8; arc=none smtp.client-ip=89.208.246.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780503735;
	bh=wGxgAQwcjweBt1joUDz6N7yOUq13v1bmpae5T1zCRVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jz955fD8YsMTRnyLCPRjrx2VocqPW6P2sKxDJA/F5zbGSVGa1j7c7oSe3shqwYz/G
	 KN/xwJ+z9vwwmtHIlOdtZQlvdta3GDdBx25ToSIFeeNJywqmCvoEOEosSOQFbBbQgE
	 bykQbPRO6hvMyRw/ujp/egqZ8CX6bg4Zz4IN+LHM=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8B92E65987;
	Wed,  3 Jun 2026 12:22:14 -0400 (EDT)
Message-ID: <56ddd82d81e14d5b14247e2066955bc21223951a.camel@xry111.site>
Subject: Re: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to
 DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Thu, 04 Jun 2026 00:22:12 +0800
In-Reply-To: <20260603105137.drm-amd-fpu-guard@kernel.org>
References: <20260527144428.1095001-1-xry111@xry111.site>
	 <20260603105137.drm-amd-fpu-guard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260150-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:amd-gfx@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xry111.site:mid,xry111.site:dkim,xry111.site:from_mime,xry111.site:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FB44639F68

On Wed, 2026-06-03 at 11:13 -0400, Sasha Levin wrote:
> > [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> >=20
> > As the mainline already contains the move of FPU guard which should
> > ultimately resolve the issue, it seems better to just backport the
> > final fix instead of adding the temporary ad-hoc change back.
>=20
> Thanks for the series. Unfortunately it doesn't apply cleanly to
> 7.0.y.

Rebased onto 7.0.11:
https://lore.kernel.org/stable/20260603153920.249671-1-xry111@xry111.site/

--=20
Xi Ruoyao <xry111@xry111.site>

