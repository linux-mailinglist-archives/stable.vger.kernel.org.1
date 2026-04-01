Return-Path: <stable+bounces-232799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CCUHXcvzWn7aQYAu9opvQ
	(envelope-from <stable+bounces-232799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:45:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D70DD37C5D2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF71314961D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02D2BF3F3;
	Wed,  1 Apr 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBiSoCDe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6065274B43
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053962; cv=pass; b=q2TxRpX2oImaJ7pWCxsX6ZvY8U3YxJc/G7Z/Indrz6P/iqRmg2si9un4qhoRUbO7TS7vKtpr2h5zJdySchCTJo2xj5RIv9nmy1878KOqQ2kCN9ZltbeQoKyWEtDBd6dJnOs0ZqhQfbkhH7ZNz62oBTU+SfcmJGNB/2lqs90BRDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053962; c=relaxed/simple;
	bh=XaMfUH02oYMrD9jBToB3ald/aQh9AL601otOm6ZFYr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2P+RA3+qxgHHE49V3VVHx3ICle+6tR8HKLjsLKL4NnXKpkXQ52BWLowYqrakPylB4uCihFx3mauR77KwxQ80MwufTi0OCfdQh2dXpCIgEPTOHjiw9cyYpFsg03rgYQs/PaHGQzUpWS7WjkrJE72meUDt0REet2KqeBn21yWKUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBiSoCDe; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so5141478a12.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 07:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053959; cv=none;
        d=google.com; s=arc-20240605;
        b=SAYLpaHQTiUcNb8PqD+aI0E9pfzOOY/FMFCVWx/RQFYEC92ztpFSsdcvUJ/0egeizl
         nKqr2HyQOFR6jto2aoIaENQ4RFKNruXbmjKNuitloN/xeLPd6bbm4w4Fgil4x++G+xFl
         pWvhXlKgSHt9ox+DicSlED8WEO0JTrw3t7XzHVw8y8jJ4xG2BpOJNJyQWJRJjKShtHKY
         iPQTCdRtmEfj1pykpUIsidQdiDxRFiVO7oLhYHUhH6Ophi7Hdl1dJ3CV8KkYWc9EyrUe
         apCCdB3E/hy44qbLykLPRVLfP3RXYXne0MGHtAKJSfkQ2UMt0oE6S/LdzFAOJGdY5Bnw
         dB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=214ntsITO7VOPzCNbP241Ydd138fuA/mCLIQDcrarVQ=;
        fh=f9SMyc/HbfY6Zcay6x3Xd4uU2pJCLHD+zWV8I40olwM=;
        b=ZqMB1XIsl5zpZ15JA0RoUmM8MlwgNqRJ1/8lViWswfBOYFBtQan6KzeWIBcO8W+1uz
         3kiSuulpJcQFoRoC1Nc/pfVXhJd2aO6Q3DXmPlmI5RchdyZOEuwN8WyfhLN3rXcDSXrO
         zIH/oAcvV/+PMWG8d3NH+8EJQOsso0ESTxGCL0hoTmhJsTaX/S+Ks8uK+WxkndRfSQiG
         8YhEh67rZzjZZaFtyxRanFLMnKEkwR9fczqoRBwWZFrfzS+IcWLlbRMmVAVXOnKb+niV
         pnrAx1ysfcKZ2r6O3imYlR/zCGiBObJKrbcB4ECwc7yt9PwgxzywxTnMd1Rg7r0mfTRj
         Dgfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053959; x=1775658759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=214ntsITO7VOPzCNbP241Ydd138fuA/mCLIQDcrarVQ=;
        b=YBiSoCDemk9qPar+T7hZgOwr5lERcdyb6i4hyiqSjSCVF/1j61yWz9IXxZSfh1XxHS
         /i2E0iQlTNPHGPm9DAC/MySsl4Y88Y3i8e4ZPML6/nG9A43uAhVJLgYtZL8/QwU15SbQ
         3u1OYiXJlDfYZ+11OFNd4ESPWeRjqBadqg7s5YhhanJU+GA4U4LkWpU6UhA7QK3H6r8S
         0Fvqp2ocRuKDb03sLTcszNW/JLQrSxZW1v+LUw2DUJ6GmE5dKfysbM5NFfhNOjLKKtef
         KQXAhHw8rrJJkRt5783p/EuLAWXlI207qbr5FFyWvavEh+vtQ5OFRAWHxan/g9zNiH2C
         LmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053959; x=1775658759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=214ntsITO7VOPzCNbP241Ydd138fuA/mCLIQDcrarVQ=;
        b=OwxuPCWTKtvEp9KHkPfvVUPr6NDrkJZ93tuKrLHNVqTbcporu77qeFpmQ13Sk3QnbL
         7DvToaZG2ph15k6frCrOeUZU2QQZGN9cgBAVt0goyUZBMjRa3tAYGl4Gq3qeky0LIQDs
         BRm71PJ3GNlNnBTWBrl/eGZoYpxjjz+jWet6Kn1g9zIssiMKeBkBlwTbYYTAKuFy3tzY
         2MaYCVfiMOtmEKGqE9L/T8EJ5lbg2C3oQrwkrhVD7oxsC5bqkPqJviWiDp4fuVcBcfKj
         1UXTmOCCmChqCfCAngX3crPjHBcWyQFzR0RogQ2kU73oNoAlo636n0Sx1NoJR+sY6wRB
         rOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn2GsJ9lt1fuiAg+5/NDWsiQwb/cQ4/OA3pKRzuanjt5vMseDLyxpOb3hk7AD4s4SxgAqofaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6X8imOsNngdIr8v8oP39xkzwVyVTySoPAmNYcejBhnWUKRa6C
	Gz3UCRL1vD+vPj+K25eKlun5kzKametsr3DDPCXW1hOTMn8w/pb24zFZQe2YFxICpodVx9dJjSC
	hmFf/+0XJ5Oa9MPw24i3AbJ/9xaxXLO0=
X-Gm-Gg: ATEYQzzjHlLIq61MU7Lx/EcWdpdqCe7iULqgFAp2JfQd6aYIH1F22X7lLFTo0b3K/1n
	/SHtJrH33SMk7MlWXeUTHRpQ7OlxBybAXlR50PkpHqO30q8aPrDU2zkhHQHGP/nxJSPIaK6g4tb
	eTN/RMQCEABkMQ2ON/XGXvxZrWRgVWgWk2Mi4PPJjrHDOEGU4XLXlfpoTMEc1EQKdqowNFcDclY
	fAGvZtAG0QyH9xc8RXeFxC7n3kcuZ6+4Mg7tqqkNsBxac3l31qYdf0cZkr1aPfqTVCMMxRV9nBo
	4pHhfY+n8L2fmQPpJICStZv1In77k/cjFBIEN9nzhxSF7u5VQn1g2QCqL+LLum1U2kXPjpZXNba
	lsoyL3xJTKtPByDq7jI5O
X-Received: by 2002:a17:906:e0c6:b0:b98:1b18:782c with SMTP id
 a640c23a62f3a-b9c137b54f1mr196289066b.6.1775053958657; Wed, 01 Apr 2026
 07:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161741.651718120@linuxfoundation.org> <20260331161742.960922011@linuxfoundation.org>
 <i4c753x3y67ek3r7dp774pcmaaaid3gvxcsvdssosdingre4in@od45qzitwtrf> <2026040115-dose-aerobics-7c6d@gregkh>
In-Reply-To: <2026040115-dose-aerobics-7c6d@gregkh>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 07:32:26 -0700
X-Gm-Features: AQROBzCMxWD9iSptIB9IWDuC78nahPwj7Gh-nabCq0dqjkd4j_Bk7ubHWIV9Nvw
Message-ID: <CAADnVQLSfDtqeLFw=DjG-dG=xD_qS7p2LHsT9jAxO5aAK0YJig@mail.gmail.com>
Subject: Re: [PATCH 6.12 034/244] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, stable <stable@vger.kernel.org>, 
	patches@lists.linux.dev, Andrea Righi <arighi@nvidia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232799-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,lists.linux.dev,nvidia.com,etsalapatis.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D70DD37C5D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 4:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 01, 2026 at 02:22:58PM +0800, Shung-Hsi Yu wrote:
> > Cc Eduard and Paul since they know this change better.
> >
> > On Tue, Mar 31, 2026 at 06:19:44PM +0200, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [ Upstream commit fbc7aef517d8765e4c425d2792409bb9bf2e1f13 ]
> > >
> > > Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> > > in __reg32_deduce_bounds() in the following situations:
> > ...
> >
> > Hi Greg,
> >
> > This patch is causing the following BPF selftests to fail
> >
> >   #222 reg_bounds_crafted
> >   #222/27 reg_bounds_crafted/(u64)[0x7fffffffffffffff; 0xffffffff000000=
00] (s64)<op> 0
> >   #222/28 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffffffffffff; 0xff=
ffffff00000000]
> >   #222/29 reg_bounds_crafted/(u64)[0x7fffffff00000001; 0xffffffff000000=
00] (s64)<op> 0
> >   #222/30 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffff00000001; 0xff=
ffffff00000000]
> >   #222/59 reg_bounds_crafted/(s64)[0xffffffff00000001; 0] (u64)<op> 0xf=
fffffff00000000
> >   #222/60 reg_bounds_crafted/(s64)0xffffffff00000000 (u64)<op> [0xfffff=
fff00000001; 0]
> >   #222/79 reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> 0
> >   #222/80 reg_bounds_crafted/(s64)0 (u64)<op> [S64_MIN; 0]
> >   #262 reg_bounds_rand_consts_s64_u64
> >
> > The failure is caused by the selftests' expectation not aligning to the
> > stable 6.12 behavior. I believe the easier way out is to drop this, the=
n
> > wait for [1] to land and pick it up in stable (or I'll try to backport
> > and send). That should address the root cause of what this patch is
> > trying to workaround.
> >
> > 1: https://lore.kernel.org/bpf/d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020=
.1774025082.git.paul.chaignon@gmail.com/
>
> Now dropped, thanks.

I suggest ignoring the selftest failures.
The patch is necessary for stable and backports.
It's fixing a real issue.

