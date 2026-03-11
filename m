Return-Path: <stable+bounces-224742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFSzGWixsWmXEgAAu9opvQ
	(envelope-from <stable+bounces-224742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:16:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B212687AE
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA5C3022987
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89E274FC2;
	Wed, 11 Mar 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YRmUOewu"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CD3E7156
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252948; cv=none; b=Jj7LE43hpwQCHnlDOlBkFMv54OTT/IKZ8igMjDXDWUTmwdPBekN07vnuSbcMOav6fx43+TtHGhg+wMQcWmtLUlYnjkTcr3HGDukVGvq4gS4Ft9FEPt7x9QqP2Ef5L4kNB1VWuAhnIypiOHhlWbjPBPPv7mzHNVWtORsZFcn9yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252948; c=relaxed/simple;
	bh=Jjq49ouwOstajWDDHsipi40+8r2DGwcxFw4hkhofWGU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YY+qOv2fvQ+DMQiIGNOdHosbo99W+AcKfW062fFZHLowDGh/WeJuRzEoLsbKCSjbHQZ0+NmlBjG6d/s6e6Moy5fcagL8GL/iZmr+g3W5LQ7r2I0a6wiH9JOaR5TKb8gFPD4fyDcLEwT3WBclNJxpIIelAyyOdj+5dyh3WvRHJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YRmUOewu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773252935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jjq49ouwOstajWDDHsipi40+8r2DGwcxFw4hkhofWGU=;
	b=YRmUOewu0aO319izp478Y0xTx7rGxwboIxXbrhev80N21WY8O3DvaGE9epGDrrLNs7li+F
	WhBuL59DlXs0ZajuRcVMtcd9oTzASTPmzKWa8Wl8/x1K+qfm/+5yPjHZzKrJ3VxI0ARc7h
	gL4aIP6QSdvrgtldxvJBfntRA77FeRo=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: nx - fix memory leaks in
 nx842_crypto_{alloc,free}_ctx
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <47dd8932-7347-4744-be8d-79106bc76f4b@app.fastmail.com>
Date: Wed, 11 Mar 2026 19:15:00 +0100
Cc: Haren Myneni <haren@us.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Dan Streetman <ddstreet@ieee.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2169F556-EB9F-449E-AD21-BAB1D34E81B7@linux.dev>
References: <20260311150922.382941-3-thorsten.blum@linux.dev>
 <47dd8932-7347-4744-be8d-79106bc76f4b@app.fastmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224742-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[us.ibm.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,ieee.org,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 87B212687AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11. Mar 2026, at 16:16, Ard Biesheuvel wrote:
> On Wed, 11 Mar 2026, at 16:09, Thorsten Blum wrote:
>> The bounce buffers are allocated with __get_free_pages() using
>> BOUNCE_BUFFER_ORDER (order 2 =3D 4 pages), but both the allocation =
error
>> path and nx842_crypto_free_ctx() release the buffers with =
free_page().
>> Use free_pages() with the matching order instead.
>>=20
>> Also, since the scomp conversion, nx842_crypto_alloc_ctx() allocates =
the
>> context separately, but nx842_crypto_free_ctx() never releases it. =
Add
>> the missing kfree(ctx) in nx842_crypto_free_ctx(), and reuse
>> nx842_crypto_free_ctx() in the allocation error path.
>>=20
>> Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
>> Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
>=20
> Thanks for the fixes.
>=20
> Given that you are fixing two separate issues that were introduced ~10 =
years apart, I think it would be better to split this up.

Yes, good idea. I submitted them separately here:

=
https://lore.kernel.org/lkml/20260311155645.397083-4-thorsten.blum@linux.d=
ev/

Thanks,
Thorsten


