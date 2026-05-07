Return-Path: <stable+bounces-244645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xOlWIrAM/WmMXAAAu9opvQ
	(envelope-from <stable+bounces-244645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:05:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0A4EF921
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4EA3013490
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF034E741;
	Thu,  7 May 2026 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b="aQKDjGql"
X-Original-To: stable@vger.kernel.org
Received: from mail.cipherat.com (mail.cipherat.com [91.98.42.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8133BBB1;
	Thu,  7 May 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.98.42.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191531; cv=none; b=q+v/+3UxFivVeHQIJWBfgmQ0aKgyog+EEvr0uxZx59Tm0eXTrRp0SVgKaYLDLdXcIoZq2NQ8vo+Bno+oe/5rA2IikeR9KW4rzTM+mBEucW6NVusPJ/Jf8lLl9exlBlSno+KsrUjfBwTRwX2Fph7oI7rtZTSs3djAUsFfxNd7h38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191531; c=relaxed/simple;
	bh=kaaOXyw6ksfngpOsy4YCSRVrWmenVmKOyKXzm7twyrM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=sarB3RJ5M1H5jz9p3X0d/If0OL+3zYPk6I0s8Wt/Vfqv3Awb1dgA6IraoojzeSozLO3W5SsdjXHpH5bvzHysQyisq0EdGXLg8LSJL/GjCL92V/hX3dvYTN9NtNrSPpiMxBKb5e44Pm07/2L2OuSbw23oyi/VGR0D6D/qdTOFcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com; spf=pass smtp.mailfrom=cipherat.com; dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b=aQKDjGql; arc=none smtp.client-ip=91.98.42.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipherat.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id CB76784FB1;
	Fri,  8 May 2026 00:56:09 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cipherat.com;
	s=dkim; t=1778190970;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jv2HF9/u/LmHnenfroq2x+AhhZ6LaGW50XARg6m/Dis=;
	b=aQKDjGqlOQ9GLuOx0Tk1kOFzm4C/6WV6rK9WKr0YcEgOrzSRthUJpFqiFHph69UXIt5w3A
	gfZg4ZQUJjtZ6Ukz1J/2QgLCCCoK9evPN0InM6jyyIpX5BY6t49pHxluZqiDDN1SPnOLhz
	/p7785l8oYvz6S+CGd8Lr436lkjPtoLI0p/moptMuy2ECZPULqH/OAf7i780dL23kgG2Bb
	t3qVZPM7UZ1ljZKVKSzirQai6n5EEVUXMGypWi7R8Rq10gopLBsehExmu4VFyYcAoY9Rhs
	++UhyakKbpl26NrtP8TvfknBaCuYhxaiucUVv6hjzsv1a7M2VywZZCuNivq4L6KC7UZdBr
	z2OKyIAIU1HbqXdxvq9Int3DoY8FEqG522EIA6Z6YZ9E3FINpM9vXN9WkYc/dJBpPWJWXn
	ll5tLC5sVXhyjuAlyVUzUCw0BmahZhs3c0f1vctCxevR04Ojcn5pw9PGArUU77bXbWVmQG
	/LEzmnzVuXjSX1U6PxaJwdDZlMlzhd92vsWyBLtnvQ+vPIVwTSNuq/VrWmt3l6JZ0Jzty5
	UzyRMESvAe0Dxuj300T5vrIrbxElSXpeVtz8XtVaNOs9w7nCPqzpvTxzOsu4fiCaFmAbvE
	u1v0IBcPCzkkfV7ru6jggS3uOAOX8FgkTE7B8u1z7AUSyOXqgKk2c=
From: "Salman Alghamdi" <me@cipherat.com>
In-Reply-To: <2026050434-construct-starter-5468@gregkh>
Content-Type: text/plain; charset="utf-8"
References: <20260428164513.763471-1-me@cipherat.com>
 <20260428164513.763471-2-me@cipherat.com> <2026050434-construct-starter-5468@gregkh>
Date: Fri, 08 May 2026 00:56:09 +0300
Cc: luka.gejak@linux.dev, straube.linux@gmail.com, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <eb3759ee-ecfb-f707-4105-6029d236ce3a@cipherat.com>
Subject: =?utf-8?q?Re=3A?= [PATCH v6 1/8] =?utf-8?q?staging=3A?=
 =?utf-8?q?_rtl8723bs=3A?= fix buffer over-read in 
 =?utf-8?q?rtw=5Fupdate=5Fprotection?=
User-Agent: SOGoMail 5.12.5
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: D6A0A4EF921
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[cipherat.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[cipherat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244645-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cipherat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@cipherat.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.linux.dev,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On May 04, 2026 12:35 +03, Greg KH <gregkh@linuxfoundation.org> wrote:
> >  drivers/staging/rtl8723bs/core/rtw=5Fmlme.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> You should not mix patches for the current release (i.e. this one), w=
ith
> patches for the next release (i.e. the rest of the patches in this
> series), as that means I can't take the full series for either :(
>=20
> Please break this up into two different sets of patches and resend th=
em
> that way.

Hi Greg,
Thank you for the review.

Two questions before I resend:
1. How do I tell which release a patch targets? Is it purely based on w=
hether it's a bug fix (current release) vs. a new change (next release)=
, or is there a more specific rule I should follow?
2. For versioning the split series, should the bug fix patch restart at=
 v1, and the rest of the series continue at v7? Or should I keep them s=
equential (bug fix as v7, next-release patches as v8)?

Thanks,
Salman Alghamdi


