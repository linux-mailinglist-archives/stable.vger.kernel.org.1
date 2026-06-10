Return-Path: <stable+bounces-262479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mQ93GXFXKWo5VQMAu9opvQ
	(envelope-from <stable+bounces-262479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:24:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFD86693D1
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=Bg38By5N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262479-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262479-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6368C30BDA1D
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEB406826;
	Wed, 10 Jun 2026 12:22:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE00404893
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 12:22:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094172; cv=pass; b=Wn5Mf6gLYgcJgaqgJ+S6n6Pgdn7vbhc/xMqbLkft/fSLRhNDQ7vyrNU0q4f+QqTGIAznCOftETl5ryed+IF6m26CBaIEbwwf75XcVZHLdFOb09lcAbt1r+mhKIHf3sba/opfo0WmNSPnwfB/IxNtkkCN7PGvEXk68kWvIHR2es4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094172; c=relaxed/simple;
	bh=zwTvTQRiuDnTHNrVN5t6ylNbG/tB4D/O7pmKvhbpJn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INZ7tTnYOeep0pthCvskMAdw9NIR6uaEyo5Y1GlTGcI4qdYVsZnp5sA10PxvfSOh8scZGgJLlK/Xp6eJmxb698oos2PnDjEqSskynmSdb8nq6lZNKIbJcOunD5kMTQUjfsocpv9ugjxgNGguOwFtt1KtyLTQK1PKJdkwLdEYgu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bg38By5N; arc=pass smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf887de87so76599766d6.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781094170; cv=none;
        d=google.com; s=arc-20240605;
        b=KwQyR/bR0PbmFufK0LLgNdq7+RFpiOHq7zuRjejb5r7rsEtycwmYt7pRsvkPOeizpc
         ax4PhmQZEqFHKyifJLwtUgHG8YZGuIwtcOslMJLBLhqD/rDuyZrQ+vKO6My93VTO0iPv
         qJC4dICXSN6t8Qhl4ggxDIJMJvZGEhXngqoZn2wHgSJXNWYL0GGYqiLkUO3cMT+Ol7G7
         02V4rTL668p2EUHc2zarC2k0PRWBEW7eaJRSiQub+Bsgf9udHefz+yDlInW3VYA88gZ2
         Kfo6hVj2qs8sYc4wgqUZyqeQ7CXywBVV8wHoPiIxBYPDpzwb56tyVWYUuTX0KVF2Ib/3
         2kpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        fh=PAys2T66chAe6N6JXGkv1Nh2xyfTzdE7jK04J2E06sw=;
        b=M8HLbl+jnFlKI9LGLgWRhM+TQvcmO95MUvlvYdK0EOL7klj2DW4FEYqDPfPFlBOkw6
         PJGxZrOuLooPB703cep8Yyzo5GBQKftkeOb1xPCW7hnTqp/gN+D6vbmBuwilY4b6/3Vr
         2Ch/TLBhpMEHLTfMAQuk/nnLy7yIUDgD1rSO8s95IGqzUvORvNlRJfoSh2FE5Gaj7xVp
         SuyXhcAZEfjBOd781xWigKVk7y6t7XIzK6cJcMHJMQZ35i7gDIyH2mfGFdckgmvCEry7
         1dpKlvVgINy1N2frrOkVXY4ZIBG6tsRGrOL8a+arw6Rr0lBrQ+DKX5eLheJSq+sdHqV3
         1Mxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781094170; x=1781698970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        b=Bg38By5Nu9u16/+LgN8VwYilA7ylHDYtALegh391WQtY7fIIKHWSykacesRPpqkfx/
         pUZFVRK0uC7hHwssNnLZEEQ8ubJTcu82MFaQ82Nb6y/n3C3WSB1lki1DB4xELLYG2x5O
         0htblUIAoxVbp1O33r9RcWOwqYn9jb3J/AJ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094170; x=1781698970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        b=qSizpnGxBi1XN0dGLfuu3X3Ic1C7SZTp7XT8crzyT3xH1mh15VBz+Zf7yjcZ9oLihc
         ERIl1sJJYeHr0ZzCYOYULw8iNYOBUMLK+IsKIk4RJNAxufg37th+u22SOswD1Y+AP/g9
         N0eoNH5qeC8ola6FK+Bs1oO5QKYs6TOz+1rCXMl5Fjeb3Mw7xdBNoGUPRu0IKi67psxn
         4ao7740XxteTEPiAvDzyoDBGmUWnPjAsV4TcdvhF7nKUlvUg7vayvwOL3YzatIroIkXk
         KD2isHXRYvAhnbzZv3aA6e7RpzyGqsgOivcuASlQUMBQw50C1GdB7WrLaqcB/AuIaNXZ
         Gy5w==
X-Forwarded-Encrypted: i=1; AFNElJ+Xmj3KlC3geUNINMcx6mX5EcZG5FxLaCdinU+wcAb4o1nlQT1DrYHQgSwxEMHBj0GctGrse2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEI9gxJkTxKhjoUXPmEpSxX5bZEroJFNaJN3ejffpG1WQqzvW
	op3kEiAPRm1eEk7tAsY3kVY6Rjh/KvoHgomtcwHR9xA/BO3Ob+u73k2kHBL5coBG2otLBp+LSKs
	Z7IBh1KOVwj1gnXgUP1VePHyT+i8L6y37LOspx7RvOg==
X-Gm-Gg: Acq92OGl6QAu6VLpSa4pBjYkyEvWFNwHXgLmZ925duTVsS4QVJmRWSm3/Y8+2v9b6lg
	/AuAZ5R4mtuPxsqLaBivza4LWWbFcauaNDMpDtSLujwpH89LRi6crMpLrvlq6yn0HGfm5v5UarC
	pKw24wGAiu8qPl9aRxmLarW3lXAyEYQVQWeW+OUvuTasrLe8FJvWOiCBUE6iCTkJdI1fr1s0iLj
	wGBg3IlOWRNb4wJuSpcntBs4c3gr+iJnKAPlXE8VlOuwgvIjtIVs6BcPL/uZkvcfCCfIqLMWYng
	RuW+p95CpEwuH+lbVhZpcn/0A/4Nxe+VGVRNgbmAejbsV1g+Qx4=
X-Received: by 2002:a05:622a:1388:b0:516:dcbd:aab9 with SMTP id
 d75a77b69052e-517959fb37dmr332271721cf.16.1781094170420; Wed, 10 Jun 2026
 05:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com> <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
 <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com> <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
 <3447B6B6-7D86-4058-ABCF-B093BEB5D391@nvidia.com>
In-Reply-To: <3447B6B6-7D86-4058-ABCF-B093BEB5D391@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 14:22:38 +0200
X-Gm-Features: AVVi8CcVXj4gxUuROX-jbgt6uRYIDQLJQTdoVkfD0EszQov5tcLIrs147vwAkgU
Message-ID: <CAJfpegsoZ4eKo0hf_AH4MVSh0b9j0b-UD9kL3uxMLxk+PJZC5Q@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: Matt Ochs <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mochs@nvidia.com,m:bschubert@ddn.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262479-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,szeredi.hu:dkim,szeredi.hu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEFD86693D1

On Fri, 22 May 2026 at 03:32, Matt Ochs <mochs@nvidia.com> wrote:

> For the remaining virtiofsd issue, does capping the local READDIR response
> size in virtiofsd sound like the right direction? READDIR can return less
> than requested, so treating MAX_BUFFER_SIZE as the maximum chunk to produce
> seems preferable to rejecting an otherwise valid request.

Right.  The server has every right to return a short count on a
READDIR request, so capping it at MAX_BUFFER_SIZE is fine.

Thanks,
Miklos

