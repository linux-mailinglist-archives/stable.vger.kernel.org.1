Return-Path: <stable+bounces-225569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBTEA4MWuGl/YwEAu9opvQ
	(envelope-from <stable+bounces-225569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:41:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A729B8FE
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE23030055E7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12E2D7DEE;
	Mon, 16 Mar 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPtMt9SX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193F2D6E7E
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672044; cv=pass; b=EDxwl5BCUAqCgJb/PpSK/bYkmVaVvO/9fCcAwveFtui3s2C3enxQbEM9ZNkAg9saFEa7G8BZdH+8z0pb7LezAy+yPPufmy+iRJhxJ1tXtvIxQ2uwXpIBcSedsVV/Yhhd5BJEwJpTSs/Wtj854KzdR+/3TYdX7KygpmDEi9kVRr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672044; c=relaxed/simple;
	bh=rfawecs0LL7AAa4M5Bwi5+LEZ00Pew7u0qrleuZ8SC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3GST8EhetsDYQEAld/Ahy+FdfBFyCAMbaGWZxd7tbUyNzMHMSRE14NvrDNGdMwZtf4AvdM+jrVavR57XwDJ4t5lNrYGNC8/CXCrzAi9SKzuJI77qjmfqSwJEWkQ6ut2INNauFJI1nHihcvIWUkKyYBiUvYaz1I7vJncTHQWxW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPtMt9SX; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12736a0147cso195645c88.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773672042; cv=none;
        d=google.com; s=arc-20240605;
        b=e1D2t0mX1lc9nXP+H5u8+lAmbScXexXjP+N8SGng+BUzvgZX/OwrkT3GgMpDiyfFcn
         V359YUjXbOvWq2NxhNBOI899pQav8owVDqmN4864i2Ac6L5TlLGz7J7CZUeHp4If73dG
         BRd98r2qVubMZi1bwWTAB0HDlnhbvVjQ4so6SAcQMnkj3KJNsiW1eAm7+UPzt4wg2vQs
         DSa/TDI0KG8gs4/pfl7Jcx/SSCxlcNheiYR1XSGpYmGavGttLLYvqRy/IngiAVUUDTd/
         T9S62RGlbriF9tOrRnLCWFhglHJb35cLIOidFpZnIYFUtZYh6gjx/gXAp6LJBmFk8WB8
         47Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfawecs0LL7AAa4M5Bwi5+LEZ00Pew7u0qrleuZ8SC8=;
        fh=mnlxLAWGfNs5ujaGciGrjTa+zfNJPMUC0KGB5qSOOpQ=;
        b=EUGaG43qk+iEnPjRm8qChVv3Q5/3J7YIrPOS+HUlZJkd+2hn2oFe7c8wertmnPi5mU
         EOrfxIHjT3yEC+u18oHVJ+Jz2O7peE8AFmsdRbRRA86PVMDy4jQGkh7Um0Xz4Kj0GsXQ
         ZBFoeswddpwWDWU4BET4NFhXiDmaeHXVgDEV/HCf+CIHEt2d0f+o28UCEmH6sTvk47ZL
         8LDnxdx9a5lncIYobc5TBb+H4u5N10Y1rANhrAPrS10otw2/egI3d+76bgAx1schn6jN
         Dcc4/CBYPPnVM86s7bO05WpYCexAu/LsTpgjti+PMK4W+wvg44Mue3DTnDxNjCYYatuZ
         ByoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773672042; x=1774276842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfawecs0LL7AAa4M5Bwi5+LEZ00Pew7u0qrleuZ8SC8=;
        b=CPtMt9SXVzoy9DB1ZXQakReiS3SBJuHQco3Y4hRqF3yXI7fEWiawbSnDcIVgmjsyYJ
         hn3FI2ef4cc08ZnaCInFTMvjCGi+ldP6mG6FFg6pUW0knY331d5aEHvlqB65KdyLJ5nh
         G8y5zoVJCX65v55rD6RKkNXH+1BhHxD2HqAf164xMZR2uAwCxUMrFSaK02M2qd5gBIkZ
         iD9j9ki4Y2zfcYJAtzsbUn3XEd2l7jTakKhBDAQag93oSy22sPTYpVO9xwtOZUnUWxyg
         JfKYPAzgnGXehKWlk/qKxsbPsvP6eXPG4DtjYueEDxN16P++1YoGtND7j8OiYcvHQWFx
         94YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773672042; x=1774276842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfawecs0LL7AAa4M5Bwi5+LEZ00Pew7u0qrleuZ8SC8=;
        b=oqOGRxZfLvwo6TUtv1ifCxIhE9fsUuGpSEVVTlZKXlgDSckieuPXWQJ/bSmoSzFS28
         diduo1qibYzaDGySDCie00SWxJJcpa0BJx8uwqCUClLaGYem0v0KKq0MGHp0v85yXXZF
         4WIaDzBgQrIdrJFTgRMcSes3PAQhM+R+xAZq42JLWdXHCvy9L3/JDUi3RmBlGZGy81zJ
         2gSHRza8FVFqFb+90vahdZ3i2itHD5A/VHmJNZwhOszM6KlJovKr7Y7RArGq9ejc18TU
         puMuuNJb03DCVZKznhf22wSv65GRtBknIVkqGB0yeg8/LTeRobg3KjgdLdaLlb6RJHm0
         R5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLy+TfdnIrkxsoFAaPvn/6JD8UuH4ilrrr1SavBPETBG48M6ZpxznBGpnemh2PIbGUwoopsvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZZcSc8zfqXd79CNYIzOVxeUcShcFCU8Nw2IEMNQ4PnRNpL2S
	ZC7RiYgLZy+bofYEnPdSUOKGwiCu8Qiu91rV9M3sEbOWduMNOqfCUFFQmCSNIkm6Al56cKqbutt
	seeSp9B+LEvAjHhjibij+XVz8HX5NLts26JvyznM=
X-Gm-Gg: ATEYQzzYWc7LniaSKrwag7h8o+l4fISPAyf5XtJePyvMdSgkK2MQP/iJdG4r1nB48vq
	G6Tap9DYkN7++kF+WUkMV4Al+U8YZsDK4xisu/KgH/JMgfQ41sQJIBF2IP+oFDtdEJuEjSz8Qzt
	/QcGLiGTnICApFq498nNJNm37e4bT3NSdFaAmyo9oMEcFBR0wTC8tpy371D0QpIYaPwknn//aw9
	zQuvgz4HUFHCo4hBc2e9rO6jO7pY0OQDwNj1NXn0Y3oU0+kGc2lafruW9XbnWB8iUnlmWDVZaxc
	fDgl8BHtt1F1+Nn4kVfhw9DTDjyKxyIOgcSY5nqxdKAGGXyn3HHseKHWUKssqL+wkN1dF9asVgP
	TDnFuLmboMjswIAn7NUd+NiU=
X-Received: by 2002:a05:7300:e887:b0:2b9:ddef:2c13 with SMTP id
 5a478bee46e88-2bea5590bcemr2887832eec.5.1773672042214; Mon, 16 Mar 2026
 07:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026031632-headband-sprinkled-2a47@gregkh>
In-Reply-To: <2026031632-headband-sprinkled-2a47@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 15:40:29 +0100
X-Gm-Features: AaiRm512U9ccGsf1lb5iIBL-tNFN0vpFqsQLN4dypN0pjJm5SIg-zf4g2w05ZxY
Message-ID: <CANiq72=iW1z9wbpBSv2zZkLzrB7J8uMRJ-JYoUTFm0o0NRwDTQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: pin-init: internal: init: document
 load-bearing fact of" failed to apply to 6.19-stable tree
To: gregkh@linuxfoundation.org, lossin@kernel.org
Cc: gary@garyguo.net, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-225569-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 1C9A729B8FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 3:34=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 580cc37b1de4fcd9997c48d7080e744533f09f36
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031632-=
headband-sprinkled-2a47@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Ditto for these ones, i.e. expected (these ones are less important
relative to the other 4).

Cheers,
Miguel

