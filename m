Return-Path: <stable+bounces-192436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C2C326DF
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141E3189EE82
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBD337B8F;
	Tue,  4 Nov 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugPQCSCS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C6339B38
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278480; cv=none; b=aN2uZMJfYFyelnC2LIlZ3c5EUtNowyEjlS/xWT4rs60tIoJZYF/FniOKt76xioieBEVy6qDJ4ca74gd4NPA6EBAx+YiIzeSapZk2QTLdylkGbzzSHP5J03t0wzFWF6QkcA1pZasEIcu+qMpRcFWVNwnd5cTq34i5ifCz8gYlTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278480; c=relaxed/simple;
	bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3X/q958yy/W89DL/9Rbt1yO+JyAUHoVjaNInWoqF3m7+JPnDR91YLBtY7xSfmIkKekm5v1VLhvAdi+M4dem+3z21vevgn7J9vzhL6YdStXi8eLYWFyVWuDmuTzwbvHOqRLp5gFhGfs+4E0hWXPuDIaLuvNViWCS6LpJIBekiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugPQCSCS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so170a12.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278477; x=1762883277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=ugPQCSCSXojk6KFtAa99RlQNpQhR/iSiUJkjX+ysoYt7kmvj5TjvSYZJf7X06XbckA
         M/P7ERcol8+OFYvX+8af7Bc7UokUG9fiMbc74rThA1q6LZS6e7fRwHzNXdO3Lh8o6Qe/
         PNBbQIjYC4vMqOx9xl21aIw60Oo8KPnARIG1F6GPti9POO4CI3GjhSj65PQiqfaRtSCH
         l2ovvTL/ClDlnYQUn0Aj1Cv5t9kCb4Q9ZCnJllJNePRFgnfMCM6sVFv/ksI8IQDREV1S
         DcUhmIFr+veFz/g/Xj9LOt5aXpLIMM6DJUooeXCwrnZJP3bTjkSXgrLUZeYxi/grCIHR
         1Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278477; x=1762883277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=LgZK5Tj8WSymOqRhfVWDW8rpmZkjJVv1emow2vmVSmHVAANDGvQAP98tKybbtj9low
         FS8/T9XXnefVeJ5eIjw1LpZ640N3Tbc9LZBrLSJeZ+o18D7z0YdiSvYmldJ1oQ98e6nq
         mtHK/ewa7/Dd/ZF1oilKGY/Qpks9Rg3NG3crJhZ4wUD5fGZN1u5/cWFFfMKo2zFK5mYf
         eCss79nQoySS/h6WSht3N20nPJEUSAfk3nKcqd94TeaamLCqASapnJxLzNOMzNM+W/Io
         m3rl63R7QWVtNAwv2PnhAa/UH2eY5zCX56ulQbwynfzOD7z9gBTT3k/2/4/SM8Ec/w5p
         RXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVuc3PNX5EXNmSosVjkDrTDLymc/bRBvjG0MXBP0HtGgZXrRXDbrYw6HWrYyVD9iX8dyMjvhTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPB59w5j44QazWRHBzkWviWwuu+6mBv7uPGGN44MAhTh6Up5sl
	PGPv9WZrNkkImvFWGJ8WaieNvgbVSce5SKvhPpjE49Ot7UOusiz94T7002VYiOfMS1nToUu+YRM
	Dmq40xNb/0QRjLcpJ916cIKwY9SIbWGoVdbV7vjdG
X-Gm-Gg: ASbGnctBjAIkYjFEy1IxbCTnwsqqp5wX5Z4KcNDR4k5yZ1xtWZMsz69wCqu/bLGfywU
	885uit+40BdRchNnbPX6Gah4Xtc+NJR7gacjskRIFzmQplq8IVUUaOJRsV+4y66/0dD/Fnhe4/V
	SaNSxc2s7nIybAfgUr49L9O4/Wfcwn4Y4Yp+rq6+U4c0hNXmhP/M+0i/cUgm7gHG+GCyIvRwcZJ
	ZOOSZpflvWNOD/E2OHwCnl1uNYkOYl1X3PHx+wVwkoeOSTcksYK+czg68pZCD48qJc+jHRdTQwh
	sH8vwTzUs+hDFdXw6BTURdhDSw==
X-Google-Smtp-Source: AGHT+IFxVdvZoaaboVMnWhHpGqiOgxBaCtl8Wdw4aZprlhirqeuesq/cXrOlHupxbHqRD67wfy6/JLS2mKLwz3kVBAY=
X-Received: by 2002:a05:6402:d5c:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-640e9327aebmr121052a12.5.1762278477045; Tue, 04 Nov 2025
 09:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030180832.388729-1-thostet@google.com> <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
In-Reply-To: <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
From: Tim Hostetler <thostet@google.com>
Date: Tue, 4 Nov 2025 09:47:44 -0800
X-Gm-Features: AWmQ_bmk1rluEW2OlBfvkjh-u6qvpegsGbFrmPmMfNLljZ4WeLV2baWrh6d4TPM
Message-ID: <CAByH8UtTVvLQwOe-ieyfvdFUnLz8X11b_ipWmbNhGkAZAXWfOw@mail.gmail.com>
Subject: Re: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required
 ops are NULL
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:32=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> The patch itself LGTM, but I believe it should be targeted to net-next,
> as it doesn't actually fix any problem with GVE patches landed net tree
> already.
>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks Vadim and Jakub, I'll spin a v2 for net-next and fold all the
input validation into one WARN_ON_ONCE per Jakub's suggestion.

