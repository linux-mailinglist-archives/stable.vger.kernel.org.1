Return-Path: <stable+bounces-105026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E030F9F5534
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB001881F4A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F731F9F60;
	Tue, 17 Dec 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h8D+aXGv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E271F9415
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457612; cv=none; b=hZG+5CeDAn4PhDNJVy8HQJvluY2JSU+Kg8sZ2b1MVx3iROi7hxWRktPx2w7+zVzUhezNmaLeKpRhcriM7UAsvYfPZtzgeXkES+6xuBV10SKyCL4RSUBLC1iXufik6skg0NYd7DPzc+qO4nxs7vHuxxZvNlnp+3sjbzeBDT9UBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457612; c=relaxed/simple;
	bh=0XdEASmtmfz9ugCuznpyGWkBxXlxScjrZhwK9HX/gI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmjwPnOn/XvYPOj68vUyZAZvKevcErTlx2WjLIIed06LJV2HlqDea2K/JdaYt3Egr9DHs2EoKRsaBpegdLHTlsRL6PWP5kJnATrKXh5hUDesNHyiG/XSJ5l+IFbCCrfZD6k9GOytS6SPweHY8xWzM/6mv8jEGoymtDnEeInnnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h8D+aXGv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so7968464a12.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734457608; x=1735062408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNjkq2KN6DEBaEhuyWIj4iGu8iK40oTJn7fFygqcUbo=;
        b=h8D+aXGv/l1hkacfTj1q8+LfAiUXTKcVt7GFAKNdfQ/fDNux/9jJ3xi3M5PyYBnBmM
         XtWI2A/ykiWmljz39CqCW2pc8zhn1e3DadJ4tKDowAkwI7hoaa+2cwGbHm7kbbzyhHpl
         SXtZWkHE3KXOqU2qPQ4FRi03mXWInXTmuSLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457608; x=1735062408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNjkq2KN6DEBaEhuyWIj4iGu8iK40oTJn7fFygqcUbo=;
        b=V3OLrfs+UE3cGW2mpRBwTZHOt+cQUEzDUcE7ev26d8dRy7kJLsjXpTlcGVectg1+wY
         DnfVCQg3uGALqObD0FhXQlxSo6untUojaYjV8KlYMFFalKyEcXJRVztLb8oFPTp7m7s+
         Gwm7/3nBAjCnnfMm/ZVUYaCmCBIZCubGIFmY9oM47rhcFJT+KH3FWLBSJEUzJQUjj9Xf
         eLASZkLiecgegHdYK3Kh4CzQwBgQTRddFjPwkHdfsm0YzEVp4ICtP3bOBSBJbHlSszoH
         PcL0j+/7SZuNAa2iKDfrCPcbLqBxd1g7hj5jK4OAhMBdTRDdgqvX6qKH2IH++P8lrCNC
         DOCA==
X-Forwarded-Encrypted: i=1; AJvYcCUupu3DVGqfrjGt2SJpLXzFrRHftllreRcrGyQmdCNhfGpJSrGnkZ4Jtn7ch4RUaMxcoI+X13s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZanntwSXJZ+AzsTa7q5umbUvJ3UjQr2000mM51RJS1ZSZypR
	OKmtdpdnrjULTU6qzvnNWE7s+DQDVLqfHsGoOJ3OPiD7XY8F6Q3KvoqGmzXX3rMwOJtzjWXrD0c
	n3ow=
X-Gm-Gg: ASbGnct9GTI4qd7+alDl5NosItwfguyjjeFFBrHeY81NMfOP0gDRTAOrCR0Zox/Y5TE
	aHaOEGiri7lRWM6TuKivJp9uqdFuEEcKzaUBQlKvwxMNG5Eb4I6c2/JiIXRfwPlnmtec53p88cQ
	Qnga/PeVM6P0pRDtBBJxcaOE0zpwQhHKUBqRRnBUasLZam2JdkZkkmf4hK/7Q5zy8Tu2+TEXqP7
	EOGIPhHyN9oH0htuWGPg/0hLyJyw8PIuZImYq4vlQLsPTQzYwhLguo3sNYHqqM4KG3vKzYYPuml
	OmnxZBA3lwLhoKg6XLo2zq1LbEHVOHs=
X-Google-Smtp-Source: AGHT+IGflqgjfsVVZ9owjRmguYC+/DyJwMIH5m8oFM27h3NL7ka2E2jaJHLdVcx9RY+mZGUWWVaLvA==
X-Received: by 2002:a05:6402:5405:b0:5d0:b7c5:c3fc with SMTP id 4fb4d7f45d1cf-5d63c2e818dmr17030402a12.3.1734457608111;
        Tue, 17 Dec 2024 09:46:48 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab525fsm4523986a12.14.2024.12.17.09.46.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:46:47 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6aee68a57so819550366b.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 09:46:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUblIu0nnnkJR5X6iiYqfvftsDIpnffOH2mSlZO5aCDODCLUcPk5RepxXZpOy0kJxV7kpSle00=@vger.kernel.org
X-Received: by 2002:a17:906:c102:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aab77ee6592mr1643616666b.53.1734457606608; Tue, 17 Dec 2024
 09:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
In-Reply-To: <20241217173520.314190793@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 09:46:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
Message-ID: <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 09:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Add uname into the meta data and if the uname in the meta data from the
> previous boot does not match the uname of the current boot, then clear the
> buffer and re-initialize it.

This seems broken.

The problem is not that the previous boot data is wrong.

The problem is that you printed it *out* wrong by trying to interpret
pointers in it.

Now you basically hide that, and make it harder to see any data from a
bad kernel (since you presumably need to boot into a good kernel to do
analysis).

The real fix seems to have been your 3/3, which still prints out the
data, but stops trying to interpret the pointers in it.

Except you should also remove the last_text_delta / last_data_delta
stuff. That's all about exactly that "trying to interpret bogus
pointers". Instead you seem to have actually just *added* a case of
that in your 3/3.

           Linus

