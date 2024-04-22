Return-Path: <stable+bounces-40417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7508AD95B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09C31F21A98
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AE46435;
	Mon, 22 Apr 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aKV8dekb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A845BE6
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829958; cv=none; b=CwME4K7H3fUFVaIor++qaRByplm+43NUl1kvBoIGngYk8/wT8y3YIxQ9/HrvCH9TrCY+eiz3rx6MjV3tIACMY5Pc/1jdkU1mfE1veLn+BEKRQXJpNvjulBv6L9/vuavaRDPdVJ8t3bPnNtuNiP/kTu9BIWMisSyOkx0lRuAix9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829958; c=relaxed/simple;
	bh=7VpFWji0npb8y8WcWu7SHDIm3yHlNEnN9NqpcurZ/+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhRTyT2ZOOjD0fQ81m+ffub4q9wqIiXvg7tE4YuspIeNuVGlgje+K4dSdpwLOH4L1wmQ4JgERzjBVIr6ZKvInqTmFh1w6mowAtZwsJtgJ81AsWQ0FZ7wQ7bfCj3u6Vpbk9SkVgXpklDj6jMypVu3EjBLvnslIysJ1OmWTxdHwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aKV8dekb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78edc3ad5fdso418096785a.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829955; x=1714434755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SOhZEZT4NIqKamiAK6hc1pW5omVtcjx/7H0PT95lRc=;
        b=aKV8dekbYsNf5jZXVk4zjactEwNfciW/rHbO026ce6ZOZO6+ymVG77/gcbZ29wt7oj
         Tplaj9jgi9UvaP1eW2uceN2syPNkMM6ZK3coc9NbXLCJhiELjhaeTRZreS+x9+FOY/uY
         4hee6KCerbIVPz71nTfz3P6lc6b5UUwexpydE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829955; x=1714434755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SOhZEZT4NIqKamiAK6hc1pW5omVtcjx/7H0PT95lRc=;
        b=p+1q+g+kE6a+tQvk/iMpaIR7X20cS5pqdsOHYV2YsLCtOo94aslHbtWL6xCcd36e31
         VMWHt2uEVjA8iZenb6M/QNQBIi/NapbqGiapQpMDUIJsZdPTgv/ZXvZt6SXJblYNvpK6
         Zrg7sV3aLtFDHh07iQKesmp69vOVDjCkJ9ejpJtk88vQHUvi9oqxG327ibW0dUuRQ6a4
         UyilqN+HpQ/wcWhkp7+XyPrUEtN8BpA7tde5z2jjQGIQmXRWbDeNSgm3VeHPm/Tsvdh+
         xMrs/GfX/5RqvkB9chfKpMONMJgEaHSpZE6zk1rQLJlbQcuj2WkFnRH/b+4jiX8oq51S
         7cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7ovoFJOROWpGtDnZxfkjNR5QURi27jGsiCWcEsrTAtg+Z5rQc1S7iNQuH33AlmwWQlF/xqg28w+C6kBmLg+99g2YZfUQ
X-Gm-Message-State: AOJu0YxrNEVt5Yq96/aiCKNkcZVi0a8Ei1asFl0NdiQYuckg1t/qgnAz
	WmWB9usOYWip/quRAbxnw4le7oMX2+yLYF2VnTm0weihpCuf5TL+sJEFFgdossx5W8beGgIAZuD
	d/k7H
X-Google-Smtp-Source: AGHT+IEWVqC0HhmltH0NW0Hq2C7cW+8WF6bkQN9JGlwTseCWsuLlPJbQIOjiEdmdXEEdHsr8HY3aeA==
X-Received: by 2002:a05:620a:4002:b0:78d:42d8:7123 with SMTP id h2-20020a05620a400200b0078d42d87123mr2264199qko.21.1713829955051;
        Mon, 22 Apr 2024 16:52:35 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id v20-20020a05620a123400b00790738095b4sm1492522qkj.72.2024.04.22.16.52.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:28 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436ed871225so71661cf.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhLSqYwHauQ3szK3eE8B2rOrb4lnNUKoAQ0NKOODidPF53QNvJM1Qkk2cJ1GkCsMLQ6tAnbgNw19/0SNj04g1GzMn5sXnH
X-Received: by 2002:a05:622a:8030:b0:437:a0fc:8989 with SMTP id
 jr48-20020a05622a803000b00437a0fc8989mr125978qtb.4.1713829947957; Mon, 22 Apr
 2024 16:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-3-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-3-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7TnwD+K5UiUqVz6E06A82uimDoHfQ28557857QE6P0A@mail.gmail.com>
Message-ID: <CAD=FV=X7TnwD+K5UiUqVz6E06A82uimDoHfQ28557857QE6P0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kdb: Fix console handling when editing and
 tab-completing commands
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, if the cursor position is not at the end of the command buffer
> and the user uses the Tab-complete functions, then the console does not
> leave the cursor in the correct position.
>
> For example consider the following buffer with the cursor positioned
> at the ^:
>
> md kdb_pro 10
>           ^
>
> Pressing tab should result in:
>
> md kdb_prompt_str 10
>                  ^
>
> However this does not happen. Instead the cursor is placed at the end
> (after then 10) and further cursor movement redraws incorrectly. The
> same problem exists when we double-Tab but in a different part of the
> code.
>
> Fix this by sending a carriage return and then redisplaying the text to
> the left of the cursor.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

