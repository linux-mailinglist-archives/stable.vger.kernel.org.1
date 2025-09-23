Return-Path: <stable+bounces-181552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A7B978BF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 23:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CEE4A82CF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342EB30BF70;
	Tue, 23 Sep 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zQVYAayx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45B19F464
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661333; cv=none; b=INk/BH8xY8rxNISd+m+Hvv5tjOLemb19B9JL/3SKOHOeMaRlfYs1Xz9jbr79/GtRFdbZr4uyvyr7oUrXV1TxLNbT3PN6We/xSH1ONJxDwrWfGj1xEzb449ckfIKlXCOg9JaxBvgF6+YOjOg4xjSsnwAuT6bOjbU9ww1YBvnOlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661333; c=relaxed/simple;
	bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIvG+UVO3PN0+y8H4e6R/Wit2p03nsz6gUB7+OgpYw9tgAKxNw47MX9VlyufnynZuTDWRYlwLrOBxXYRWBqEn64MioIQyY+e8A4hSy7Oyc/cVOWppOKghHmNvH1qoPytsz+Xcc7cwOJg0ss6qPKC0dY3HHXpIA78Bj01J6FBTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zQVYAayx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso3953630e87.1
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758661329; x=1759266129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
        b=zQVYAayxvTC4DM+yXS2+JOcDIGlI434OAs6S+P5OvEXBbv3S4tGP03+UHvzmjBnbve
         EkRqULfSAentPeUFxo/erybtFtFbKgmgtPM7Y2LCVXwdlUIQkU/NtkuJWKBK49jQraN9
         5/E5hKuhqEDtUrerlY2diMkYqZ3y9SeN8E7dbMAgQZyXjce9glrKhZYDEcMnneYs7E5I
         3qnINZWCO+8BZEmcpJ8iP1cVcEFVcXgKgQXVy7YlpJ+/JsEE+eUalmHTDrVQHTguDXQi
         dymYoiSIhEb3nOKJheEbGFnzsiw4p489IJpTG/VDtkTqEkEeFRTMIhAAZS/m9BNJ1sKF
         I5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661329; x=1759266129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
        b=oxeE1Ungu5JSmYJ3vlE1dMBDtH4DpoYe5jFn5+7BPLq1QapvwtpXbFC5ln87cLqBJZ
         +kOLN8OPc1g3susG9QS2pfb0jh9fG7+culTPBEkQcAes7K0dXQ1Q/n68QBju2LHTDdxb
         nKiraXxQbsPm7LNT4rHiW1FVA43R7fHJVXjJ7uJPsTCdVsv5dK6gYd/JxhBtietF1YJw
         9s+kboj6GIy7iokZrAwhyWrenc9an8LxEcUV9XwbwiY9YkKyOLFp1nS0l98zuBmX/JZ2
         Hs9SJ6gzpIZnPKonPp3SDcnYmI+zOUS+r+JdB69k6iAED40LXht4gUjPFevwAD6vS0HT
         lofQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlrT3VWyruJ5ky2GCZQnYJPMxxv0LPbjD9Z9xLPaKk2hrqwoGSgVxSCcIjVKVWEvoSMNIesNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2DXbp4wRlryozyLkwwvohzmhD1/2RAyDk8kdddnnZL9LevkG
	dedBhdu6gIZ2rnI/dHWR2oMwsyoqonNMPWMWIPh0MGRqhGqIrItH7tzJOwm9ge838gcM3HeBabB
	8l68gzevvaj8NDDEQEMduh8xLQ1skpXaOV+R2hzU=
X-Gm-Gg: ASbGnctpmO/N+BetJX6qhb21jTcnSka2tX7bXFrhvaXNQlJHdmEIvHE9QgsBWjDK1Ro
	XtaK7CCSWx8Q+VfUcCFRpR6IDJjxdsbFcy0nS0xvQxd6+CbW7pDKSdP7AHdeARj3Ak0jSii5/22
	21InxJpEOJlXfpDPQTNMs1Gsneegu/DONhv0orfeJTN0F7RqeJu4qC7vqo/XsopiHJuwKC3YQfN
	2AzCu/TLwkLoQxnUUCdgNzqin6Y+BrNWuna
X-Google-Smtp-Source: AGHT+IFwXRDGhFAvcbaLj1l9RYEViT0rYo17s7yMQyCQ9DLTB6xQtn93PW2THfEcRcLtahipl4f1CCy1ovriaxNniWE=
X-Received: by 2002:a05:6512:3b21:b0:579:fb2b:d282 with SMTP id
 2adb3069b0e04-580737fbeacmr1539793e87.57.1758661329139; Tue, 23 Sep 2025
 14:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldnavsse.ffs@tglx> <20250923131334.66580-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250923131334.66580-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 23 Sep 2025 14:01:57 -0700
X-Gm-Features: AS18NWBwhUDTbtO1jhYBKXBTPrk1XrauGwTt3ITm6Svj3UcDRtzIuMhTMW9lVGo
Message-ID: <CANDhNCq_11zO4SNWsYzxOeDuwN5Ogrq9s4B9PVJ=mkx_v8RT9Q@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: tglx@linutronix.de, boqun.feng@gmail.com, clingutla@codeaurora.org, 
	elavila@google.com, gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:13=E2=80=AFAM Sumanth Gavini <sumanth.gavini@yaho=
o.com> wrote:
>
> Hi Thomas, John,
>
> Thanks for the feedback. Just to clarify =E2=80=94 my intention here was =
only to backport the already accepted upstream changes into this branch. I =
do not plan to introduce any additional modifications or syzbot-only patche=
s.
>

Might be good to revisit:
https://docs.kernel.org/process/stable-kernel-rules.html

And, assuming you feel like it still might be needed, you might add
some annotation before your signed-off-by line to clarify your
motivation for submitting it, ie: how it "fix[es] a real bug that
bothers people".

Adding tracepoints definitely feels more like a feature, not a bug fix.

thanks
-john

