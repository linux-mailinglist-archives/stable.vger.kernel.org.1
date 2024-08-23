Return-Path: <stable+bounces-69959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0795CC31
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44C81F25C0F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF3185951;
	Fri, 23 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFPdNDAj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6D185956;
	Fri, 23 Aug 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415307; cv=none; b=HbisZs3SWuUcBz6nR50nb2rFD/IApIAh4e9pGz+VmblBCQNSkWAK+56l92sLUZCcTqgNzEFW/3E0IRoUut0GPJa5k5KcSkoBVOqQkhONFUgDSNvDG3/vEpjTh6GjtM7ldZCZqrnBPH26SRbqAG9hGLnYOCqfyyQXx93ToalLp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415307; c=relaxed/simple;
	bh=g/1Oq/yHT4tjam+4FYlzrz2icgTGmfy0guEfrhFFlNs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aYrFvEaipHAwdFijNorVTVKaRc0vVuhFZJ7SrCrj60qtI6SxVZ3LhGpupm1iS75DubtD73/fF/oSfItA5OvOIsLahHyx2YkKDQYYS7J2NVhQAJqpGT8ZRk8GsaF4lhPRWZ82BKZlWHP7ldUFswEK+b8zgrGarjimEAkUJm8L/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFPdNDAj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86933829dcso220811866b.3;
        Fri, 23 Aug 2024 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724415304; x=1725020104; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwsCcLX0nWUuLEDkenDmm++3B8eZkIMKdByDwW9AmVU=;
        b=VFPdNDAjfxjIKksZxQkDN/wfbYW8G2AhxJfp4AgtW9PVVGwupDvNGHH6nHkf7Z1DYV
         b/oZCXianBY9c5kX4Z7i8CLiwUJgPLy52fbmeFNGaGXjpHBjPRHCP/+PmMVKmUyIE5ld
         jy6FhNdE2VtHATWMVVVR0KPjsxV5tCV5Nk7JSYUgj5fmhGFc6PO5tnvk0VsnPza/iYgj
         4BZzyuwtJu13pDgORYEvOplu6rYhX/kO+Jwb0EfBwg4powsc+D9UHCu+/USO1I4Tnm3s
         /szs6SZtN2ZGMDLRcpuup/fZyj43W0UULCepIksCKivqhiBwheY1+20L9qUOtRX6Y/n4
         XmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724415304; x=1725020104;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwsCcLX0nWUuLEDkenDmm++3B8eZkIMKdByDwW9AmVU=;
        b=nmkFjB8f8jE+swf4AGeIDTvsN79AY9X8b4iDAH2pZR6k2eUlKapHsuvqBFNvB6hht8
         +M7voiDGBKfcQ5GyBUVmzIfcoGWMWBSdSZyuy7p2ve+gpmFfBkzw+uRhgTLoPCx4VBSa
         whX9o39DqcUjDwWH5rCBr45MZoSizR626ip8LkTsB/orhY9p+ZfPDYqlf+NuQb7rKyZE
         2E2WspY7fmxJWGCG/iJ06XAugOjSJ8Fx1JAqRcKOngOVu465cRrs11sQd2GZY35NUNMZ
         SjS/ql1MIo4uE5SYCcTDPR1jlmBOyk2oEeb0iZpIdM6DOEuqVFhPoFZirUSQJj6qhpr3
         3vJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqDHgvbSFcuwB+meMqdK27OAi9V5IYEbKjm+ueHq7wLR4HongLZdM3rWBL0SAz1Ttw/50ZLxoUuelH/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxue26HWd7zb6TxCQOoywUtk92RMSvoieSpgc51yRLgIAIvAgaD
	oTLcKf+d/DkaGSjgfHB8n1/NH3cofw1GUP9cQtMk5hEjtKUTsDym
X-Google-Smtp-Source: AGHT+IGPKc9wvhxY8vdbiv2GzHUYcza+qlwoZLh4gEg11mnxyQwmBlXoDWFoeNz4r/sjl7l/H8IJoA==
X-Received: by 2002:a17:907:3d92:b0:a86:812a:d2b6 with SMTP id a640c23a62f3a-a86a52b917emr151810866b.23.1724415303701;
        Fri, 23 Aug 2024 05:15:03 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f487800sm253720366b.178.2024.08.23.05.15.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 05:15:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
Date: Fri, 23 Aug 2024 14:14:52 +0200
Cc: stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21AB948C-2A05-4AE1-9E8F-8441C89D36AD@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
To: Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> w dniu 23.08.2024, o godz. 13:51:
>=20
>  If that is the case nobody might
> look into this unless you are able to provide more details, like the
> result of a bisction
> =
(https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.ht=
ml
> ) -- that's just how it is=E2=80=A6
>=20

oh well - bisecting might be painful as to provoke oops - usually i need =
 - literally  - multiple days of constant 12c/24t compilation=E2=80=A6



