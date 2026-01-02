Return-Path: <stable+bounces-204435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B660BCEE04A
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29ED300760D
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87842D5A13;
	Fri,  2 Jan 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIfjUH43"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F42D2384
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767343216; cv=none; b=qgMPxtr56Jgm9bYCbpy4cIA9UfONU7Ew7p5PUI8Nc0qZZnmcUh7F2iALnqLU7LDuXr/n5uROv88mxjmcgdj8Zq4sMuyPPWt6sSLAVYpAwCWsIoS46Y1g6e2xFXHQMxXDKle5QdSbEByQdR/YkIJLRK4EqH6DliVkvBBeabTGlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767343216; c=relaxed/simple;
	bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gae6kQEV3cbMm9aGmykYambo9hSXYwz2cOfxXj8rxmeItn1YksUZrkd141H3hz/Qt0fGYnzjwl2DLUdxZkz57gM3D1MpOoAQvT2l5YshDu7a9/OrTyOpM7mVrKSB8KOia/9ygFI0xFvSVeHusb7OBqeXb8DRO9P63JuUAqedg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIfjUH43; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88888c41a13so157710196d6.3
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767343214; x=1767948014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
        b=eIfjUH43UZWmeetrzLeeDlWzwhqErq0g+HS07qrkg4Szuj5G8dZpD2Ci1nSQA5+Ozi
         jDTbcv5JkGX+wzUjsBZakJ1A9AOBWNqCCQE+9VTjXwzqb/soX1P6taU3UGgwNKXl/W5d
         yfUXtCiXXNbc6xcHnI++ZFMFQnsOrqnmF8Z20z5rraLxA43Xe2Zx5u5TY7bPNYfV7a88
         WMBwAzqh5MDMeVFPv93Wwd/CG1C3p6bd6NBUrxoLiHSaFOJDCcK6cIzIqr3sofytjZYi
         J5Dsm9+s+l74ucRiTR18Dl6W+erXLutAL2syCVn69FiyZBOqk8z12GKlmcytt8XYa4wf
         qIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767343214; x=1767948014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
        b=E2vDBfBcTPBlIzsj2q6iSgAurzqyHVOztBlYFJ6Nd38r74qn9u6qQSg1M6kSBeKY1I
         fDV+q1yWr+FdikICXV/GFVADKFiOlQotlA2u13xvHciMahKHVvKye/Lgc9/ydzmqQ+Ws
         fFN5/QuDrwFiPMRCow7wje5x2lnv1i+oqlROdiud4FqN6+Zl0zcXlImQAK2Vk40FFmF3
         9W9RnbwC+6X/QxNy8XQFoe2rlGjz5Fu8NmHwvEca0Jx3wSYuUjCx36nLnkgDF/JBps+p
         5LmkobEQzVhCDXXd2M7F3Xxv4Xkp/YF8TJkIni1bStCbiyikITL7irL39ZoWqJFsDxsZ
         IphA==
X-Forwarded-Encrypted: i=1; AJvYcCVy8qAJBL6vVI4UkQ7OnQXz6V4owzSs7UJM9krgDJ2DekgI0BsVHLSA4yFgVdtEmGsGRW81zkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSukNbTKYZ7zTC895S5qPqDXCuAMM6noyT4CGDtSFzZ3fOh1Ac
	pkvn1VRFX1kD/QgFNmiCEO90CNR9e5HhNhqs1SlLQlWMSf+FJI03Wj1cjUTwqPKazX+ojugPqBd
	3wOSJVl0dRamdZVkpJEoAL/bqJiY/LvY=
X-Gm-Gg: AY/fxX6Zac5H7H4F5pEBl1GfH5ZRZ1MUFR0hDaLbTaZKFtwWxc0FeECc2QxnGtR+268
	CMzFNdVYmhL4VRiYQp08tGWwXpQYDZMKFCb1f6xc7NHzf4zxcbxpSZpKYI9VC8GcCfu3Mn3P5CD
	JxXWBiSzHNoSN6ZrDsi4CYVCEvKaGTlg1hr85bDPX1Oni5xGlZ6gOkiqH10zlZwIGljNVPc8Loo
	9NjAtCL6g0sOwdyto2h5cyDhvbRy2veXoqRCZvbVb6D/oQEz8oql2kwmS8cbD8K6nOeJOk=
X-Google-Smtp-Source: AGHT+IGC6CuYzGpscftFjWf5+gmMzki6w7/Iy7X2Zql16cmak2tCVDp7at2bcPo1WOtb39jHX+LdpWUm1mnZBbUac4Q=
X-Received: by 2002:a05:6214:23c6:b0:88a:261f:6af4 with SMTP id
 6a1803df08f44-88d8404df6amr636211446d6.58.1767343213797; Fri, 02 Jan 2026
 00:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com> <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
In-Reply-To: <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Fri, 2 Jan 2026 17:40:02 +0900
X-Gm-Features: AQt7F2r0MrGfokVOhyqLOTiI52EVobi3HtPfSH9ESALiCshy7ly_MguWuQFVcmY
Message-ID: <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>
Subject: Re: [v2] gfs2: Fix use-after-free in gfs2_fill_super()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 4:46=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> Is there a need to indicate a role for the mentioned identifier?

Yes, "fail_threads" is a goto label. And including "label" in the message
explicitly is precise.

> Do you propose to use another label here?

Yes, I am proposing a new label "fail_threads".
I chose this name to maintain consistency with the existing error labels
in this function (e.g., fail_per_node, fail_inodes).

If a v3 is required for other reasons, I will update the commit message
to include "label".

Regards,

