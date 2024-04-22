Return-Path: <stable+bounces-40416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333028AD957
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4691F21D0C
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029C45BFD;
	Mon, 22 Apr 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYMqN4nt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEC45BE6
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829945; cv=none; b=NU4SzNLDfIt47m6U+91e65R1xcZ4/uBAWtw6CQoUuZfDxcYzTO5YoTQ5uE7IUzhxmm2VCbTacCRLcbnyqjIUcOIY1cU/yRpYBDG6w/SWNR5cw4c+Drxg1leJ3Vz0ZGq1HY2I131BFo3SzoPaoKbp11riH818bKZYcBZTkNOuozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829945; c=relaxed/simple;
	bh=EHpp7S73gOdRUjxiqhvAAq6aSAY1pPeHrx6OMKnKkiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ucbf8k0cE4p0DCO3RUX1/HARzy1LKLkX9EzFxeI0g6ghx2fpiVCX3UxBqFFXYVNt+AnZpBebF7QOeWDQOwq/0q/tX26ZDbIYheWBDqERLfkJ3eyGsfDGZ0pJ3yD7TyKLriQRfq3IwhX19RtC/C/D2jgo6NYGpOAoVlvCCkFT5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LYMqN4nt; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b5ece41dfso19051336d6.2
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829942; x=1714434742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DOqaxMdms/qXRzuhL549SToyGg4i6A1dwMfsfdbbL8=;
        b=LYMqN4nt3DdEqAJP0OrcH1KFiHaOJY8rWY2LLSd+Yd7H7KZWyJ+aY3IrVgTmoAGrV2
         3uaRFXm/b07uTINi5x1NzPDQN1swjKPL/CVCUl+AceB4x/8vKFgdLNmvQFoTUp3hE9Pt
         gndfyBftqxqUf/YvIImc5NLf9VIJGAdGleuCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829942; x=1714434742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DOqaxMdms/qXRzuhL549SToyGg4i6A1dwMfsfdbbL8=;
        b=Giqru2D0JrInXrfLuHRouwrJeSnf/6WVZP8gWpdPPYpIbk6HP/NTZ+SJD2qk1qV1nx
         NQhZFE2I1VOGIdc+Ba4iYX4Pu8JHkYdlsiYj6n3uv13A57NwRxJvk5BRL+Xd8Gki0aHJ
         ChfuMvVUL2izJgAMDO2CcN2belpqXqxnMSNpfNHWCdOk2ksB+FgwGDxobs9A8kue4l3R
         CYnwedqA2ukv4lcb8JXubD59JJykKK3yqtb7wmp6eRAQzDfRWEZ3CgjV6fBOWwOhCamj
         wkZ4zKVDGEERh5GnFnyrvabDeItrfWaAkKFqxEOhBjtfHXgnvfFWc6BNoHnZJch2bEvP
         27/w==
X-Forwarded-Encrypted: i=1; AJvYcCUw5kvZEi6dqq4hmuUKsI3iuqhzni6NCpkESxbWKa7/NZxhn3hwJreeSWFS/7a0rLuRG48GKw0mqT9LNyyrMX88u7kHIMl5
X-Gm-Message-State: AOJu0Yxs+TrHuttfCRMy6njIuKLcuM1avDxEoP7hiXUelRtYK/0sBsRd
	o1O0tzoIHq+SvtssoNc/19h4dzW0/Ip/WSY9oZaC+Om7iTlWmeVGuMd+x6xfqE8ZDVxbgfKMBtJ
	p/6DB
X-Google-Smtp-Source: AGHT+IFL6rdL5Pql8DmvUhuYryAs/+bNE+yPrdQn0HWPyqXpYbZAgqHNmcJ8NWrfxpaWNgKt/9jX3A==
X-Received: by 2002:ad4:5e86:0:b0:69b:7c6:72be with SMTP id jl6-20020ad45e86000000b0069b07c672bemr15643787qvb.43.1713829942242;
        Mon, 22 Apr 2024 16:52:22 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id z12-20020a0cf00c000000b006a0441c4d15sm4667952qvk.38.2024.04.22.16.52.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:21 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439b1c72676so101011cf.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXEv3iNMBbFA7h/9eFXIO4U/AeGKche6cuOEerSjG8XB+4n975nHafPH16Wsgw2USRAF2KbWOc/dCL5U9qHf9azy22kCxJ
X-Received: by 2002:ac8:6682:0:b0:439:891f:bbd2 with SMTP id
 d2-20020ac86682000000b00439891fbbd2mr122734qtp.28.1713829940394; Mon, 22 Apr
 2024 16:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>
Message-ID: <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kdb: Use format-strings rather than '\0' injection
 in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently when kdb_read() needs to reposition the cursor it uses copy and
> paste code that works by injecting an '\0' at the cursor position before
> delivering a carriage-return and reprinting the line (which stops at the
> '\0').
>
> Tidy up the code by hoisting the copy and paste code into an appropriatel=
y
> named function. Additionally let's replace the '\0' injection with a
> proper field width parameter so that the string will be abridged during
> formatting instead.
>
> Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug=
 fixes
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Looks like a nice fix, but I think this'll create a compile warning on
some compilers. The variable "tmp" is no longer used, I think.

Once the "tmp" variable is deleted, feel free to add my Reviewed-by.

NOTE: patch #7 in your series re-adds a user of "tmp", but since this
one is "Cc: stable" you will need to delete it here and then re-add it
in patch #7.


> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 06dfbccb10336..a42607e4d1aba 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -184,6 +184,13 @@ char kdb_getchar(void)
>         unreachable();
>  }
>
> +static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
> +{
> +       kdb_printf("\r%s", kdb_prompt_str);
> +       if (cp > buffer)
> +               kdb_printf("%.*s", (int)(cp - buffer), buffer);

nit: personally, I'd take the "if" statement out. I'm nearly certain
that kdb_printf() can handle zero-length for the width argument and
"buffer" can never be _after_ cp (so you can't get negative).


-Doug

