Return-Path: <stable+bounces-208126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0571D1365C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FF1C3036812
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000F255248;
	Mon, 12 Jan 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh3+4xm9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388A259CAF
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228728; cv=none; b=EVySRXlGhwKkG3PsUv6nYGTpYMDrojsLdyLveYxFci/SPm7HNYzNqglN92UxLyQrdfFA+KNucR9YShfH2OCJUHjKAr82NUnY2+AZmOpNBgHNkHfqYwWfHDfbV1ue+iYmB7l4lADvohBvWyDQXzJ4VbjAGOBqKhh1tEs59aWBvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228728; c=relaxed/simple;
	bh=7dvIXtxi8yuXwxGZINg5dwQkKeeA+lDXIu4d/vfMpJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYCU6/S4eOwFLJoB3SOnsMb66SkuM6xp/PYCsF1wHPXu2xA+LgZlWBzYbB5s2kqnYLc+CW1akDpx12rQ/S2JE/Z8EnxaJNWqdA3H75FL4/iLEzUsxAvRrvP3CGboTA3QvpZV7sIAmviBbl5sOsZnu+qH/QkXkKmYpTJ8k7HNcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh3+4xm9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b6d9f11so698432585a.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768228726; x=1768833526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OVHLwGSVY3ROBM8cymA1lSVZ22bXnEcQvZKsbH0Omk=;
        b=nh3+4xm9ZHklUxcQcguxmpP89FQxIrXpfKtDBLhxNF+m0s/wlgJzAIFSolXGSvtCLy
         Ld3H+eHkseugeJZpCgt6Egw6NnY+duCo9cA9sy5u48ah4K31VnBS5SN2awKrV/evJkic
         cXtdQ1GnOuaNOPno0vHkL6ZxLryuAuTWy4Cjtdx3Op5PEDN6YntUIU9VaYjQuMT6roRy
         qTwf+t35YAEe50dZ3R4vNl20M46q5ZQ1Uoo25f/XhuHPAQ7mq5aaowN0vx4Pg2HYTFGI
         Mbhassa9xcQejNVlVOv5rVp6igqiov5ZV0Y1yLKnld5QP1nDYGvCva9p0tMWzigfZ6uw
         XFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228726; x=1768833526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OVHLwGSVY3ROBM8cymA1lSVZ22bXnEcQvZKsbH0Omk=;
        b=MhIYyiDFCVpU/ZCtDzF5F/EOKIgnCRdbHQCh5KREHo7hIWso/gpjywwTrcwr3++oW9
         auvZQ47AsnPCCdIHRolFE65i9rSCcCguqihKz3P66NcmzP6/D+DzO0eNGC6YKk6rGq+u
         XwIVgkrErntQjyjuDJGk8M28cuBrT09qSs3l6sghmm9tmqjWRoUs3OEawT5ZwSR4K4h5
         idsyDyPdq7C4cUQS+ZbsEtHs1uzKyeeewE1Y2iLBaTnD+haIYxM6nVj1sZ9KiDIHBcSF
         RgWEWJ26zMpy6ojmp91kWmO260urbkmVi7Qr/zcb5dL78RFtOjTGvAJXtVOXmZJ0oDRp
         2MBg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/XmEt+VZ+yhd6xTcJ8NnHp53OUfjHsGUfCXJzs0R1RoRT8Tj2mAMA7cU6gzrwYCZH9GrYYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJd7WKz8MBrl526vJwfrS0ClZ1SS+Q6qHnJFIPgBAPxfZGMV+2
	Gy3tPGPiqT7+XeZPvtIGGr+LlYFrSZAq/vRx0HCBS2d0BIBq1zIXJlPGWo93J1PLOIgQGPCYt9E
	RYKPbYOV1iVjYmBV1IK1k5RIV3zKv/gMqPhEF/v9g
X-Gm-Gg: AY/fxX5sm0jtqRYjhePl3l1S04+OQiU1QNJ+2IKIbf7mQG3kjyhvochZDfhKNDqhMRL
	gFrNJm9WR7kjBEqBT+lVdzqJvKloNuVVcBgtCJAzkoauknxIH20QVt9Mk46RruqF4fam38JyW1F
	lEr36ew8w0XArQQA/bR/Was+rg7JUVa5vC20h0QYsUZgDKtUVYGxm9uaq+TxotwCk5C9NHMD8s5
	zFIFfh2BkpdlkEiCRG639HWDJTPWFWFcMo5Jw/tPtBaESRHGrEVe1B8Uy3vFGOtZ2Rmheu06qvZ
	HOasn1nHbb2iKHw2PdjlNM5dqA==
X-Google-Smtp-Source: AGHT+IGhrNYAx5nJsuxOp5EIbKgtYvgqICeyAKUqFhsc50IvEZWhS8EmoDJnYDpLRXA0O1DJ7MEwbYmYdwbQDJwI+uc=
X-Received: by 2002:a05:620a:40d4:b0:8c0:f13e:42ee with SMTP id
 af79cd13be357-8c389420351mr2515603785a.88.1768228726114; Mon, 12 Jan 2026
 06:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104134348.3544298-1-ryan.roberts@arm.com> <20260104100230.09abd1beaca2123d174022b2@linux-foundation.org>
In-Reply-To: <20260104100230.09abd1beaca2123d174022b2@linux-foundation.org>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 12 Jan 2026 15:38:09 +0100
X-Gm-Features: AZwV_QiYkGu98o69ZXegThGdFPJzrbQ3TdfnesIl4fIhpP9VWTIXvd7AfjMrgqQ
Message-ID: <CAG_fn=XtONeeJzBFFyxqWa1=Zo8bCGcUPO11Kaa4093vJOPgrA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: kmsan: Fix poisoning of high-order non-compound pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 7:02=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sun,  4 Jan 2026 13:43:47 +0000 Ryan Roberts <ryan.roberts@arm.com> wr=
ote:
>
> > kmsan_free_page() is called by the page allocator's free_pages_prepare(=
)
> > during page freeing. It's job is to poison all the memory covered by th=
e
> > page. It can be called with an order-0 page, a compound high-order page
> > or a non-compound high-order page. But page_size() only works for
> > order-0 and compound pages. For a non-compound high-order page it will
> > incorrectly return PAGE_SIZE.
> >
> > The implication is that the tail pages of a high-order non-compound pag=
e
> > do not get poisoned at free, so any invalid access while they are free
> > could go unnoticed. It looks like the pages will be poisoned again at
> > allocaiton time, so that would bookend the window.
> >
> > Fix this by using the order parameter to calculate the size.
> >
> > Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page opera=
tions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>

Thanks!
I'll send out a follow-up patch with a test for this behavior.

