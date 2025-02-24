Return-Path: <stable+bounces-118914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99387A41F33
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74B43A9AC8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8E221F07;
	Mon, 24 Feb 2025 12:31:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D119B5A3;
	Mon, 24 Feb 2025 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400266; cv=none; b=FvY3PtoXhOydlfqFXjM3f//Gc3M2Q+TqQNdVxn47Gmp67yDyQeS8JjYGmoP775gjAuv9UhL5Fz/TMWqJV5TmVQSTONgOE6CHsooLzBX/rXJ5X0gGKk3c09DpgJXeXj83kTzhIqHDabCBoPKuSjK/4T670XDPkPxcwNHja7ktsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400266; c=relaxed/simple;
	bh=Aj1fgSnSbsuebKXK7cL71r4KIt41HCLiUVhHUxEST2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5FZN59wwpBCb8opHiW2j56HzOFcM6M6kS2hauHI8U8bG2tdzJIHfmgw4H/60pQ23LuZCAb5Ys7aDdFAG5WvhsGP1qnaJKPMN2qnGQgMdyVHr0slQmDpqPMCxlGnIje6Y6OiYu8fonfU/d1CcEg2sh+JpL+USAY4lyH6sOAwIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-521b5bd2268so2580796e0c.0;
        Mon, 24 Feb 2025 04:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400263; x=1741005063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpwRDmNfJixHhcPNp0aPYj4prQ9N655RIM3FLbxCSF8=;
        b=TtqL1NqTe2JML8eB0+GBz9vA4j56Mq9v8zPvxeDb96yOrZmj21T9eF0KvtMBJlsBIA
         so/1OpTRvLl3pM+Cs7InoN/gUlysv7GFTs5p2SJrs4YsHphIZFJ+oFMJCzDFZ6d5f68q
         r6RGku7lKiN0b2X5O2kTNQvFF2a1SaDgi5OOkIrnLddK6Cw35v8kAAsUEd72yIusqZtc
         J+TTkUssly1hTjqAQUK0DF9tdCrC/Cj4TxoyboWFhvzOLS/L8PdLrmV7ClQ9g7DK1x2b
         yoF8TOrt36k6KDD+uTMcePSjrduwK9mFJXmVhNbcNbDilhDKzD+OQ0HggkLjPtQDlaO/
         SAQw==
X-Forwarded-Encrypted: i=1; AJvYcCUelUEntVig3bQy4IU5VlIFTUycsAWwOBT6D8yCu2Z1zjiWMX6jIYgqMRkGB+O3zGjNa4/3frUD@vger.kernel.org, AJvYcCUykS6GsMPzKLJsCiYA0hgIYN3nXo1plOygOd27rdmYwzYlRuTh8/d/EVPX2HEZHQnj8xutZk53dReIlRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3t2XmqwhKpgGsnCMD1//9QloopsRM2mrZYRDbwOb/QINhHV8+
	ysaCzdYV3hUSBvZ2IgS3bbg8Q98V3h76rkOhxiSCW3WpfDMZExi0Wb7wlTcS6X8=
X-Gm-Gg: ASbGncuRNNAwJ/1Wr5T3mKP4NPOeReEg6Aa2m9Z0w7BjDcNsxpzzoi+tKCv1T4GCZr/
	t5070lSyH2LDvgkc0pBIgfNNOqZG7o1XdKhh2RmDTmS7Wctv70d6lRgJ5HayJpNZQ9MZJJQlpnZ
	a/OaFvAmqImxqVpWWLjuubMEj1tej5VG0YJXQuq/gt99lTO5eKno6xd6m+aJOHhpkJNHrA4zoQI
	waiHd1Tp5K6kWGf1BI7p7r3fpe3qki9mtvsZRKCZORsWebiqkvE5YgJoAEUyJLGTSVDNHdRKDIn
	8s2mfzkx/az+n7Gsi9cA2MZIvTjXWPQiL/wlB5uPJX/MuzXoHdRm/hc9TdcGvB7u
X-Google-Smtp-Source: AGHT+IHFwrghthQNyNeEpKiW1uMVjyIwpWxHTWW0AvfTOyhzj7jgBdU9s0cIylU3pyPc/h1PwGJrhQ==
X-Received: by 2002:a05:6122:488f:b0:520:59ee:8197 with SMTP id 71dfb90a1353d-521ee448087mr6004985e0c.8.1740400263138;
        Mon, 24 Feb 2025 04:31:03 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e86bd45csm4609368241.24.2025.02.24.04.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 04:31:02 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-866faa61728so2585468241.2;
        Mon, 24 Feb 2025 04:31:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV67ACbxKEDleM4osQZ5uy+MUZBH22j8a7P0YI6q6rQPyUl0XEHW1LFvRz0nPbYOfkbj5DhcpBEvVj9ByI=@vger.kernel.org, AJvYcCXYMjPh+Mj68F9OhaIyxh9bmL5/A1bveupKfKcKefCdvVvVj2jKcIrpEnTYt4wjCBQlfefK04hR@vger.kernel.org
X-Received: by 2002:a05:6102:50ab:b0:4bb:d394:46d7 with SMTP id
 ada2fe7eead31-4bfc0021756mr5448326137.6.1740400260502; Mon, 24 Feb 2025
 04:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224101527.2971012-1-haoxiang_li2024@163.com>
In-Reply-To: <20250224101527.2971012-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 13:30:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM18v5zyvQ5YZWRhN5Ppn8ks5LGxrjOX1GHy=hC3SD3Q@mail.gmail.com>
X-Gm-Features: AWEUYZmM_bkwvA0z-YjpK_qsk5uZkUfOB_T5-yLlTRbGrCbVCo-fL3mmCN6Y7Dk
Message-ID: <CAMuHMdUM18v5zyvQ5YZWRhN5Ppn8ks5LGxrjOX1GHy=hC3SD3Q@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andy@kernel.org, u.kleine-koenig@pengutronix.de, erick.archer@outlook.com, 
	ojeda@kernel.org, w@1wt.eu, poeschel@lemonage.de, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 11:16, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Variable allocated by charlcd_alloc() should be released
> by charlcd_free(). The following patch changed kfree() to
> charlcd_free() to fix an API misuse.
>
> Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Merge the two patches into one.
> - Modify the patch description.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

