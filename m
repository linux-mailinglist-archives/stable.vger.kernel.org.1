Return-Path: <stable+bounces-166483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D207B1A26C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039161617FF
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DA2571DF;
	Mon,  4 Aug 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51Q5PqT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35910EEB2;
	Mon,  4 Aug 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312195; cv=none; b=DMwh9DMPpN4TXbFzeZ/zJiqJrL5GgSflSa3HBZw6mG1Ug0qmMxoWd1wTOwLXUVvkiJVXIgK5EPqV+qjxMR2H1S2U8OWUdyVUi2xNTnhfqfPeRqEfn693jd2JEgIKHhpfeu4saSeUh9ULlE/FXybk7Iq41vX+Cr0WtpUmPUdv90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312195; c=relaxed/simple;
	bh=HxnR/eU+/CwVZpMx9CelesyRuO4Ox0PwriQncoUtHcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0swXdLYGYccZfAFUp6jXiDuRPxl0g7WaZIPAdZyu24Rt2UUBaArG7bbLfXQf7s1icsct89k8ocz51HmzlCP03IKuUN09QePoH2Ggb4Tkn6A857V90fdH1ZGKvloJc22AG+T0qzgzblakWGOwuUkUY4ENHTPFdHXD2kcCRHkF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B51Q5PqT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9c2754a00so1068161866b.2;
        Mon, 04 Aug 2025 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754312192; x=1754916992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxnR/eU+/CwVZpMx9CelesyRuO4Ox0PwriQncoUtHcc=;
        b=B51Q5PqTRrhyFVt5O4GQlseGk+3J10ReQM3Lbs43x2zbuzpYDL2ybz1r4JsfnRo4ux
         U0R5d451+IikuHK3JbjMP+inGxZ+3f8+SeJc183qdUR41BaimoaztI6cxkwxGBkxpdC3
         n8bPQsiYD5rGby2UItebooyM0lNNl6vBbExZ7xHL/zbuekvzaOLPW13GLAqFqmNeniOZ
         gWsWlgQhOsqmA4DLKo5PRDEOmz+Z1ldAbCsQ0GCpN7pbT6i68X7i7bFr+EWt2h2kGU1i
         UqugVdHEwNu+X57oLvoCHslM1xJ7f+QMWWhOdaBiweyTcu/8eQM1Q845Sw3ViCO3oQGi
         /OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312192; x=1754916992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxnR/eU+/CwVZpMx9CelesyRuO4Ox0PwriQncoUtHcc=;
        b=g4pjCGQvy71zMOhd2T0JJqB45v+f2UI5cxZpunYWo7rjsZCCdKnX9Zl4al0Buz1awR
         +tRzFk7BzS8dCpOkkuYljcwVVN+FcqcKuwiNyKTM0WkLiIVNffkfl9S6i1TdBNU25guL
         8Zlqhx/2dI5qEV8ZhE1XHXilRXehDdX9IAp+q1E7qDH8hQYvgLVSE4GPQv81FZ7w6UzI
         +WmUmDjT2Un8OTGefplIpawq0TitQ0JQQE2rQi+KH9QEIJDDE0sqhV1dM2tP9AL/TS3C
         stJF8Odx8i/mzV7NvVTTHBwtudYRDocNrTS8kUq+O7KJAC+FOC0l0u2ojlDv+HjAxNO7
         Q99Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgnj/RPgRHKEsQXAe995cut2Ib1HXpZhU+a4U4nsc1gscgEmJ0DcByxOctRND+j7sIGoLsukIN07GucxE=@vger.kernel.org, AJvYcCX8106w3FHQBBrm+ALtqBMPHVOC7hMy12TvPp/oM84So1e4ulwSig832Tux7rT7T3Olg3pUfszt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgen1jSgBZfFgMTEN3Wva8fFH6HEkCsrs+vfFhNt0DaVUAzbGV
	sNSFE0BA4JtsacXocaxRa55gLKe5xGDyHyAIEA2z251S1fvgu/JnzL+DLsHfBIwd38StePBWEyA
	NaJ/CRGkhpHAt98+BuiGs0eBccc+68y8=
X-Gm-Gg: ASbGncturCtwFnqjf1dcCnbr3/TJiuzsq6Sgq8Lsb5t7iZcp5n0NmUmh8H8JUUDwAq4
	+cZcMWQV53pE8VfWANPUGHWFt0tcBg44gU1qhRO5Sh18AmHBCFEQDc5NiSGPCvWEo70wLG6dyqC
	3oConVCIpUCRrMK539GJx5Ln/rVrmD01Fhy+OkvBUdanXwbIMt0S9DApdA+DwUJQ6Cu7jp1Xk9P
	sXTOiQpmA==
X-Google-Smtp-Source: AGHT+IGwpRgVmNoV63r1ihkBCgiC8MD4NgdCqQrsi4fWvTlyAzZlDvYYAGvvx2yHMW3uVbf+4dp7kuYYmfEJrdd/kqg=
X-Received: by 2002:a17:907:1c0c:b0:ae3:5ff2:8ecd with SMTP id
 a640c23a62f3a-af940006e03mr1079549266b.20.1754312192274; Mon, 04 Aug 2025
 05:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804120828.309790-1-hansg@kernel.org>
In-Reply-To: <20250804120828.309790-1-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 14:55:55 +0200
X-Gm-Features: Ac12FXwMQ-NBMhqMecHM6-Yp5dsRM0BqsF-HkASebZqXZxAcQSGFRsukAdIUJic
Message-ID: <CAHp75VeKvYRGQdfvhE42hdgWJWuE+vFW4z09KUhiDQAtzGuy8A@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read
 regmap_config flag
To: Hans de Goede <hansg@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 2:08=E2=80=AFPM Hans de Goede <hansg@kernel.org> wro=
te:

Thanks for the update, but I just have noticed a few style / spelling
errors in the commit message, see below.

> Testing has shown that reading multiple registers at once (for 10 bit

10-bit

> adc values) does not work. Set the use_single_read regmap_config flag

ADC

> to make regmap split these for is.

us

> This should fix temperature opregion accesses done by
> drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
> the upcoming drivers for the ADC and battery MFD cells.

...

The updated comment LGTM.

--=20
With Best Regards,
Andy Shevchenko

