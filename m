Return-Path: <stable+bounces-255070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKo/Mbh4GGo8kQgAu9opvQ
	(envelope-from <stable+bounces-255070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:17:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3D5F5823
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AD6E3097F58
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864833FB04E;
	Thu, 28 May 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQPP3oxb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265513FADE2
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988115; cv=pass; b=RTPMC32kZPigtPleq7Ia/KeHyWdsYmdrirOK3AWRgnc/rMCqneyM74GrvDap3zr/Kx/AsVVr7u2kkf9UJtOAdGCyM3blDSYwZcKNeTD5Ozv9Ty6z54LGdlJfnMHqcv4C9+fmjlvtNbsOhNqxdMJ/bN9DMkRUaI4RtJmanhi6BbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988115; c=relaxed/simple;
	bh=9jYSkpT4vtDChH8neYQk33R6QDLXNggrYivoWfmSVeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncp8KRLTBSymsSlIrt5qoan+sUXiFpmJKN0w3oX2M3zaU1BYhlkVDMYPIaVJPmpKgmULX5fYesJT3q19TGmz1UvI/jL8tLPPmzCAHUKJrx0miufQCct88Ar5RmnzLJQ2GpDUmUWxrgZHAxo2byD5tiaLO69b+Az886QByLDPBkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQPP3oxb; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6128bd9b3so3346154a34.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 10:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779988113; cv=none;
        d=google.com; s=arc-20240605;
        b=HSE60hD94Dy77x9wsIfk/ejt/KcKqY+8tvIlXqr4xoVWtPS1r9FirGKFvrl8FvO7jw
         S7z8IYjg+6UpjNRU6gSSb1j1LZwZJpXsiIP/+YfZ4fb7n5k5tfM4fLPRKQDKOX7F8Tzs
         HLrzY7h80pvRxldisz+NrV23u5BR6uZ3hZ2atPickNXMgY+DF+6Wgsyg1b63k9JGaUsO
         p+65gt6/KvySf4Dm5Xr+xUBkUOdUOlhyAUQzOY4wjRGOe1/ZNTWNy7JA+LeytVX+0DY9
         BMUjKY/yXrVLsPZETl6O3GeaDm2ubSD3gAS7c6FEn8wixyeOlYZ9DoB7e/ouSMROucRN
         wpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jYSkpT4vtDChH8neYQk33R6QDLXNggrYivoWfmSVeo=;
        fh=f2d3C+b5EsqitTcO/B/JixfCIs7clc868ufxyy+sBuE=;
        b=JzmGjPKgCchl4oaJLnSPcGNhx+pdknP7FVPVGZngWy/6OhWl7vZfLS4uErrNwqSHEo
         4f3dZ0hhCkcMUxuzICJb59GWsyT/WIMQ5hPhUFamCwh/MGgZnWqwVsVFxA8SqsJvjseO
         aYm1Nlz9o5LuD1gnDBFf32w3XkNaZWZsmxiwBEf218/1hbBBWw/glOMuOWmHRTNTV0pc
         t53i9T05ZlO+pqS6Pj00eVFY+hQnbsB14qXfsp00hW7cR2Uy9x599WXvTHzRpHtytPQC
         h5ku800Lb4hSxDVFJcrhG8vsqBLr4GB9JnzYzps+MKhyXmga/0E1N9NxuTA6uQermUwY
         7Pwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779988113; x=1780592913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jYSkpT4vtDChH8neYQk33R6QDLXNggrYivoWfmSVeo=;
        b=eQPP3oxbTPNFx6txE9Ro9ZB6L1eGC/mMPDcg4ARFpkcnd6gKEoi5Y2ElG4LNdWNAI8
         PCcpSYwbyNQSOjucu71zK4T/vzaPKNgzUdXMSZugeytztQUBmx3rCrZsmXIOg/jDN3/p
         dDhftinF9VkSsbeN9OjgXq0t75lFPGIAedE9Vkf5HPscvtYz6MwXfOv6B5k643LZetwR
         zHQUK3zmqZdEuFcksllJJ+5dgRRs3EC1YwUxR2/oRJB+f5Jy6EFeO2u0XT10Ih2sflJ7
         4koHgu30DnkYunM1XZ+uige8yXVGxaar/WVVZQ8wbUIcQ36sRwVIUlpZ7Ktx1ZCoTPD7
         IhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988113; x=1780592913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jYSkpT4vtDChH8neYQk33R6QDLXNggrYivoWfmSVeo=;
        b=HX70VXb9mXbog0P1eaRhf+FR7HjTRUAQyoCpcZ4XBo3/eduwLbXzE6cNVu3PG9MClF
         kwrKcJqlt5yOmZXjZ8hEGnKZn6SB/uvlXu3sJdZw2yRCtXfrqRj0T+9BYpxpBpu++dvN
         baSDPPDV5VxbJoU2azWVO4fhfftMNJkn2l04dkE90dnfPrJ9gT9+BdXHom39B82GwTJv
         eQyZUtnuZO5Xrv1+z1XfndoULavvB613AH1NLzaumnN78YECa42W7c2d9nrb1JwzPV5n
         /fhbXsBd0AvJPkiubFyWwfdYjSCn8X2nGBVPehUHhN8ApytGSvYLak8r0dF+W1W7npie
         nptA==
X-Forwarded-Encrypted: i=1; AFNElJ8NdMZ/9DrVhskJ+pBrhx1T09g54S6xXGPlPoXxX8EBPdDsCSUky/jewQy5tNEs3nTfaSSL2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQI+HBeP8hdxwcBdGVNZZqEUvMd5P6k48bfJ8aRcONx1ypP+s
	aYAblC38Ttc/NL6tN+rPP6G1RWSe8hcgD7q9IM3yWNkIT995YkLwFhz27HtYqdZDSLlvNrFlOZd
	Im7wZt+gb4RlwBDDaK7EKrmDb7YTIZNI=
X-Gm-Gg: Acq92OFg8ddhI+/U6Dalv1HgUe9PP9BqMY7bOqC//112K1r2j2JZI/omCEZNRBtFjPG
	ua3sI69B4gfBojn2wpJaXpeFKg0Ewm8cB//DuWDjH6grgOX4YP7/R7bFqVcRqAf3Q+9mul+Ubof
	91/M9cK+xKzKiOkTmFWQBK+B/JDQ6OY5q4ZOsTBi9jr//1wANPtcZLq8XVlnSaf01zOwddHjccP
	4Y9YuRLM6OiWyj9OuQ/aEUL4GoULlB100jCpH6aw330jbRL9m3ZnPcYc6/U+slOoDsziSh6ZDKl
	Iv5YdP7l2b086ee8
X-Received: by 2002:a05:6830:6010:b0:7de:42d5:6243 with SMTP id
 46e09a7af769-7e5fee220c4mr18023798a34.13.1779988113110; Thu, 28 May 2026
 10:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205047.3339490-1-avagin@google.com> <20260526205047.3339490-2-avagin@google.com>
 <20260527-agent5-item004-x86fpu@kernel.org>
In-Reply-To: <20260527-agent5-item004-x86fpu@kernel.org>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 28 May 2026 10:08:20 -0700
X-Gm-Features: AVHnY4IcAr08XcPThF1N4XTDwEnIvqzu0MaBmXN3xhIDxvG2XR_d6U3LaI-_8x4
Message-ID: <CANaxB-wH7bot4GgAnCcGhVbM3xuvC6eyyQtre2hDudwOpfTH5w@mail.gmail.com>
Subject: Re: [PATCH 1/5] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, criu@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrei Vagin <avagin@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Chang S. Bae" <chang.seok.bae@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255070-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 87F3D5F5823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:49=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> > This reverts commit dc8aa31a7ac2 ("x86/fpu: Refine and simplify the
> > magic number check during signal return").
> >
> > The reverted commit broke applications that construct signal frames in
> > userspace (such as CRIU and gVisor) if the frame's xstate size is
> > smaller than the kernel's fpstate->user_size.
>
> Holding this off on the stable side until the revert (and the rest of
> the series) lands in mainline. Once it's upstream, please ping with the
> mainline SHAs and the list of trees you want it on, and I'll queue it.

Will do. Thanks.

Thomas and Ingo, this revert is critical for CRIU. We've received
reports of silent memory corruption caused by the original change. Could
we please get this merged with high priority? This patch has been
pending on the mailing list for a month now; it is identical to the one
sent here:
https://lore.kernel.org/all/20260429000623.3356606-1-avagin@google.com/

Thanks,
Andrei

