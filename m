Return-Path: <stable+bounces-244853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wATQBnN//mmErwAAu9opvQ
	(envelope-from <stable+bounces-244853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE414FD06E
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD623043385
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C711925BC;
	Sat,  9 May 2026 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGPGT21j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF61A5B9E
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286435; cv=pass; b=RzLGF1Af1i7ZApMjfHZPmRFXlwr4BCxeQav8wewuEeiIjJbIbLquouvyJQJro2yOmVtVdbVMWqMxCcQ1JS2OIDIGHruplAODJfhBL2F7v568Nm6XWYWJQ4fhyTPN4SnEubUHdnGjF4NsFLoI/sRP+RM0Tbu+Kxcw8xVFth8b6no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286435; c=relaxed/simple;
	bh=RPWiJKvzDpX5X7EX6nYz5cHa0fgSaIs7bGIDpW8ZDKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID3usvxuc1f5JMRT6fERMlxkFbBgpx8HqRbsZ0eG6HbBO8C2phtEotDNOLpMK1WEkJBTQmjVxRt0lesYJ9D6mAw5zG6oQKbpsYYk9HlJEFrTnmXHvasfvc6FIUGuYW12khelS7AiGgCFAu0PeP+zzIIwqxSO0u3Sn6zAzb21PUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGPGT21j; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51306c9f2e1so24749341cf.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 17:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778286433; cv=none;
        d=google.com; s=arc-20240605;
        b=XkaV+hYjLH1epK9cyMbwoF0BDxDbuI3k/dSBIp47Xco2ZXLnJO3mEsbuKAbnoYfR8G
         ItqUjONQi2FF5eQfl/efrX9Fu3q22oGc+zamf6Kehce0nft2lFQqYk4ORTymjEU3HC6w
         HV9+LKFj3IkW/UjwN4dYOLqu9CYIwCqg8OItrmBJ0d0h4Eh4Suw/wQeuzxEk9eIhIztk
         UwJKbZXeDuuyp9ys1Ude/JexFlZTAwGGRZLq5XmLKunQ9dcvads4DONoQVMKjaGHv0cO
         C9xwOXQHc/frWIFteAK4hGEcZBfOLl/Vdep1a1/iMj1pKwJK7sWT1JSYh1M4baElaqdL
         Tj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8z5YVrkbdzDcx4rHFrxuCZ7Uj6q9EhG45d9PNF9flWI=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=Z99j1aRZjEDT3qqsS0zHtK5IXtmkSwjO12I5pQ+ksWIQPErj2pUmMuifEehe8duVlV
         zmhLj+8U8ADg85IJ2aXug6Mc7VaDI4jGyibzrxyOJycJRAwY9onDXLVGOHPEkKMJqT6Z
         wjbbyRWzNPSIPGzrsZ/LF+p02Zmg3vl2d57r84B7CNNj1DFiDmSfqCFCc41qg+NRPbS9
         syC0XwZ7Vk/X6p0aGBDU5iHDtBNKi1BKWotW1RAk/UxZxqfs/mQDMiMPACNgXknoTXta
         O4gqkkFO+NYj9Wn17Aa64/fTIpoBT0iK7KBiRSJbHAyEIzoiaO+O1MUd3DlmFKUJgTCx
         c8ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778286433; x=1778891233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z5YVrkbdzDcx4rHFrxuCZ7Uj6q9EhG45d9PNF9flWI=;
        b=EGPGT21jG2YX65FosAuQcKktDDwCin9CZJD5donGb1N1UVHYSUIu1mF1ctrMzmniJB
         bZjI37I1yjUoGQsmVOw5caYWybMr4MdJKm9n3K0yH9fzukOOT/LfE0SaTajzRleMNkcV
         EbNfavFFZDqeSO8Bjc4FKL504X4ULU1S8JyRWHAzVKQj6Ym/+lJYW0cWJzCKf0fkIKiZ
         337v1VuMlW+VEZUXWl+XyXHx58UxdXckQW/4PFFaEzygNvThjLbLHrItfwFwIhJxaY+t
         hclVZ+VvaFgrRcM1Pi+ODNUOC+M0sMOc05I99bL6HeQy96SZ3wsQQBbYwt4+PUS9FpQt
         fgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286433; x=1778891233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8z5YVrkbdzDcx4rHFrxuCZ7Uj6q9EhG45d9PNF9flWI=;
        b=VmJ2i5ADNwK+5AsgoT1Wvg2Ffs9MJNCmnuOaki/RrXwgxBaMaFSH6MY8rpIwPw0PDl
         aCKr+PuHuqW2zaxPUFaXt/lJ6pgpW9q+ztvwyTYARbjeUMsB5h9BbMqtC2Lk8P5TFurA
         kLOHg8zHInkDV6jgLrTYKABOMECdXJaohl0dajgYgfN3mTbolpGoNkkAVtr3K+RBRW97
         aFgJDf63ayVQlNxRTCqR13GuvJDQB+Of1jnPU+etP3aHnIFz7I8wUUq/qLqhxS8/6PYA
         EUMOUFh2ctgxUDYr5yYfbtqtqy1SBL6QDO2PjIzbxhnYlmIiEtHM11Q+ttzztQopWSc0
         ueqQ==
X-Gm-Message-State: AOJu0YzKne0+81G3L1vhO8F+LMXURYDm98ooLTgoljBMstuojMwbViUe
	bNt6b2PLUHQjRAJVay0RTOLeV6r9rVrulWlFzwguzpHngeRvSziVuU2Uv4FibqEZsFyEsUl5zol
	WEI3sdYMTlRrts6fczCQ864SCu69pzMa/u2D5
X-Gm-Gg: AeBDiev9BHehet0WJofq00CJJLrjfEQahtitvkHJKpqF+cowyBy//mOHWIN6Rwzz0mP
	oJcU3OUIQjRy7dhewcrf1zoXdINax4gdTqbco/ogj7kxoy04f1lR4sOfgrkEWKGW62O65xZBwu1
	4CUlKSaDsPfKB/3Hb3kpH5+hByZlKVREdXFWW9oFAXnak3qQobn9vM8yRi/OGXvRIX8iwL9yzAS
	hduiijnZ4H3+FHr8Gk4WokXYX11k0PbOLIgINGDAXmvGGlLPJVib7QYToV6oGo82M+V/H9dRtyv
	5NlFLNBaF3AWOCXlgJU=
X-Received: by 2002:a05:622a:5c9:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-514a0a1e0f9mr12007681cf.1.1778286433149; Fri, 08 May 2026
 17:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f0c6e3a5-2043-4611-9f6d-515aeb4922f6@gmail.com> <2026050731-copper-enactment-3ca4@gregkh>
In-Reply-To: <2026050731-copper-enactment-3ca4@gregkh>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 8 May 2026 17:26:36 -0700
X-Gm-Features: AVHnY4J3y8EeKXSh8JmhV7cy4PulLR4jjGIWWfeBQdMN6KaSCzuhZuC2mvL_mU8
Message-ID: <CAPuPA7LbrC=2gbvD6xJ14hAW5NphBePvUiUu1j2c5aM2W_Ey=w@mail.gmail.com>
Subject: Re: [STABLE] Backport requests for net/crypto fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8DE414FD06E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244853-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, May 06, 2026 at 11:07:50PM -0700, Yuan Tan wrote:
> > [STABLE] Backport requests for net/crypto fixes
> >
> > Hi Linux stable team,
> >
> > Please consider backporting the following 3 upstream bug fixing commits=
 to
> > the relevant stable trees. After my inspection, they have not been
> > backported.
> >
> > I am grouping these requests together for convenience. If you would pre=
fer
> > that I send one backport request per email, please let me know.
> >
> > MAINLINE_COMMIT                               MERGED_TO_MAINLINE_AT    =
     TITLE
> > 629ec78ef8608d955ce217880cdc3e1873af3a15    2026-04-02T09:57:06-07:00  =
  mpls: add seqcount to protect the platform_label{,s} pair
> > 426c355742f02cf743b347d9d7dbdc1bfbfa31ef    2026-04-09T08:39:25-07:00  =
  net: af_key: zero aligned sockaddr tail in PF_KEY exports
>
> These both are in stable releases, what specific tree(s) do you want it
> in?

Regarding "mpls: add seqcount to protect the platform_label{,s} pair":
Both 6.12.y and 6.18.y are affected. However, our testing shows that
backporting results in code conflicts. We can send the resolved
patches later.

Regarding "net: af_key: zero aligned sockaddr tail in PF_KEY exports":
Our testing shows that the mainline patch can be backported to 6.12.y
and 6.18.y cleanly without any conflicts.

>
> > 01d798e9feb30212952d4e992801ba6bd6a82351    2026-04-15T15:22:26-07:00  =
  crypto: jitterentropy - replace long-held spinlock with mutex
>
> What kernel tree(s) do you want this in?  Why was this not tagged for
> stable already?

We have re-evaluated this bug and concluded that it requires root
privileges to trigger and has no security impact. Therefore, it does
not need to be backported.

Apologies for the confusion; we will improve our process next time.

>
> thanks,
>
> greg k-h

