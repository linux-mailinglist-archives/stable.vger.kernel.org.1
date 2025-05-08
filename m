Return-Path: <stable+bounces-142919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31069AB0271
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37E6505A7D
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE855286D4E;
	Thu,  8 May 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1DySTF9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AC28B50C
	for <stable@vger.kernel.org>; Thu,  8 May 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728080; cv=none; b=aDcAoEMnMDQvj+NAzSlhWi5gvxX0Uwf77p5wD5mOg36k/hkrkDfNAIHmj+U5rd/sqqm8ecg08Np0U+PAAeRppx1HDtZiClHxXCaRwn4BarL5/4YRungpSTsnNnrW8cwzeRnvDX5K02Uatjh/JVcV0fHJrsNqblEnblyFMPGYfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728080; c=relaxed/simple;
	bh=NbzZ80paJlbOudZo5cy2lKwapBBe1uVv2cGRVxSGlVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5eydP2frXyBqfN92uvkK5QjVVD8cw7E0urtRjgBPEHiWaVuv/PH9JvKk4gge8bUC2LOMnnIV5ywGUO779+uUhaVjTnwnLb5+84O1oTQ/UcOAwjEPUlSwuKARQd2jY/a8YWw+sUKG9O+QTXzDbEqizB/pDJgf71XuCNmXFOcxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1DySTF9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47666573242so46351cf.0
        for <stable@vger.kernel.org>; Thu, 08 May 2025 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728077; x=1747332877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cF+7Q3DWdlrrgNAEAG7h80Z18yQnWFZWmqYzAyeels=;
        b=X1DySTF9SCmMTqEpH+BVk+FowGH8M3HK/4dn8ULXO0A1Pd1Td7dcV37eTZ3WFYWrGk
         +jRfno6bCEBABgvbBKeiio3YayW9iHNf3JfQwcMmoTeChuQ0d97Z/HryEG5XmeoSw0TL
         BXP5s2hpBlIESmg52Sf61T2dm4u73YoE1jfI8ijYKV7IsaGJNJeyCpNetZjWVBKmwY4N
         k0KdPiDVhZpxQk3k1nYSHPVrtwA3N12KJ+34/+HS7oH+OyT+/Yv6W0pneG1lQKC7sRJv
         UmA+yKzvGSqsb4LWCJmaKChuO5o9Qph5WHeTZNmXVQd3fgshy/jPXjIDvNtLZzBMPruk
         +Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728077; x=1747332877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cF+7Q3DWdlrrgNAEAG7h80Z18yQnWFZWmqYzAyeels=;
        b=JbWkzTX8NxoGR5amEToAJyItH5OOsliUVOohQ9oLrU3cA+l55Awn4+kztwedg2H23K
         aJmz5juzjy76VCRbeKUD5sEq/qCIoiZCSmHrEObcmprjbg1i29QXHJOsB6z4HmPV31fA
         H2CvMK47YRjYl55hSeuiXR8K1wR9pMjBUu2cuNpf81RZ7+m5FOs4oLpC+w79TmwwvHeh
         mw5DZoSFxIu//X61YcbCPmcsR1c40ovKdRQUAeha4HN0BAhTOCOJlA9SddqP/tSP5IeW
         YxcUD6nmU5UxsM25Xg4FN2uV/P4cf9gpKPAyoHuO4i0C+C/t3MtmYtsHpOl83k0GFCbi
         Whvw==
X-Gm-Message-State: AOJu0YyBymd0efo9vb2YA3KHVpHnbMRRU2ncZ+/AyBsrhk90nbnw7wDs
	jVN7SYwnzkzb/5/FGxXB15g3/sTgdxLjQWpVzyqgeoi69VYQ/KJ7f+MbESBsd2VXOFdWzh9zkg3
	cFsUKGaw/mt7bU42UgIO9zxCZInY1filRalmLzmWV8jYOkQ7jN70fac0=
X-Gm-Gg: ASbGnct7HcGZcaS95gNQdWqeKFv+9j3e9kfF06l/RxXR2PYZYQDC5ZUpecAjtpbSUNd
	l07PDuMhubLmQPePBUiCHssPNm0m0qqoReWHWR6g/kpkcTlDtzYGMe8TpZIF9oyo3jHFzkkL+pw
	QeaLMNUM9GohXnLwCH7QoR6PUzpODk6Gx7V9V1IRcEmmJ4nZr3p7M+r2oUFZHs
X-Google-Smtp-Source: AGHT+IHaD/8W8gkdsy60lk3JqLE4FhvbJ608a7G9PY69qWRw0dfReh1VTGOC/+58Fth4MTgSqQrEG5/OHtN2ip6tURk=
X-Received: by 2002:a05:622a:1ba6:b0:47d:cdd2:8290 with SMTP id
 d75a77b69052e-49452ee111emr43271cf.9.1746728077347; Thu, 08 May 2025 11:14:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505232601.3160940-1-surenb@google.com> <20250507082538-05e988860e87f40a@stable.kernel.org>
 <CAJuCfpEdkkZd8RSZUPsXkq3BXzDvebfSHuF4T=AoRHDv8hgJzg@mail.gmail.com> <aBzmyRU6EXuuYCJu@lappy>
In-Reply-To: <aBzmyRU6EXuuYCJu@lappy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 May 2025 18:14:26 +0000
X-Gm-Features: ATxdqUEDThUgBYUWf2yQeufjIhPZSgc9A_82tCaLVpN-ec0P-Alwb4hF8OGzGKg
Message-ID: <CAJuCfpGoto6chqWSN_FET4isyLfioKzxadEQbLyKYzXTwCo+FA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:15=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Thu, May 08, 2025 at 05:04:45PM +0000, Suren Baghdasaryan wrote:
> >On Thu, May 8, 2025 at 4:18=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >>
> >> [ Sasha's backport helper bot ]
> >>
> >> Hi,
> >>
> >> Summary of potential issues:
> >> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing=
 proper reference to it
> >
> >Not sure why "patch is missing proper reference to it". I see (cherry
> >picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef) in place.
> >Did I miss something?
>
> It tries to find one of the references described in the docs for
> submitting stuff to stable@:
>
>         https://www.kernel.org/doc/html/latest/process/stable-kernel-rule=
s.html#option-3

Ah, I see now what I missed. Thanks!
Would you be able to add the reference or should I repost the backports?

>
> --
> Thanks,
> Sasha

