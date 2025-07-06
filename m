Return-Path: <stable+bounces-160289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E1AFA474
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2341F3BB585
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA341201113;
	Sun,  6 Jul 2025 10:27:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA98200112;
	Sun,  6 Jul 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797668; cv=none; b=ovYMcARlrSRWErgsqz5V7FuQY2suz4/7EAq5EDs8TI+dOfW6H20qjJUXKP1ixggwuiQhI7y07acwEoqTzpRjzbO9XN4ZUH1qqRAd/NGBVGP6Q6IPNkhHQTLMVX7T5RuwKlYRLMLyaVYaNAg6Sejp9me15qOGpMg0mdVmwIgFncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797668; c=relaxed/simple;
	bh=/nxwdBn+lpkCytmZ6vCTSwJv3wDIKoB3tTZpbQXDc3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTo2nFZVbvIoVY+cRYm9gV1/9t7xun3sTl1zZhYHA9MDX658BNuMDRUOW3UsOwXfDJHaOhLMmV4osGqHZoq9eBm/4FrPKt22Jl6Yqz+pU3mQVpuKeZv02ZUdEe7hChQrXz3tss2CbnIl11WLJF+XK5sKNOItENfaoDwqqa7Yy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-531466622beso679549e0c.1;
        Sun, 06 Jul 2025 03:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751797665; x=1752402465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgMNZt3qtoPt1r5FPOIURusfth1qbATvze1MiLyoY4w=;
        b=dBihciw/viY3Gl+Xa3HQojGD3+5EkbpAzP8Lt/qEPW8tx0cGKDnxev9TVkl1G7y0Em
         akJLBpOpQ6IzMGnPIiY4byzmliMZ6UM+Aq0SYCzQSMe9AjyCs1Qiln1CThgOltGZUCQ3
         4ihxHEO0x0UXVW7N/TRQnhphClhrbncu+DFN/2iXcjWSie4FMHD/pq09rmyVi/5DQGcR
         AxHMZ8Tskc/VgI2Lp5Hoch6Nhg8iV1IZzVr0nVymhNVixsUNSA9B/tb3RlSVizzPO4cU
         hUpyeI8TIOxdZEVIe/qhJvLZFP2r8keS86CNvzTHwegtl990HRgTAH2dCS27HACouptO
         ntqw==
X-Forwarded-Encrypted: i=1; AJvYcCVdXRhzbTo8ZnADiZGp9B/cRZYU4E0Cy/BpDmW6DvLwqJi3MRhxtyat1zeT2esligfav8OuWhT25X+tqMY=@vger.kernel.org, AJvYcCVmuVeBDBIa83ZeoOYKNkeFfUbsXE10MMPr1KGyi/T+OrG0so5yH5Lu+Dyggpfm2U0hhyEueKbY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8ijgP7KdCvJSDsag/YBYaJn6rizSXp1TDKvC2ZFBJnLiar5I
	TREY81QkqK+TlDnB5Qehy4YquupxsAzpeHN/lKCvwjUMxh/caLarWSqI1PHF9T/I
X-Gm-Gg: ASbGncu8cM3dqk1hgc94adbHwbZrhiEGujI7foX1Sy4b/xZ9EXy3j6tikp7ER7bgtPQ
	9kyNFJoQNQqTqlI+VMlynND418C4eqOfIsgJ95GtX9nn2iQbh1UGOaizMCzFLytg8RWml1NhGs3
	1J3dC4N/L7lSVX3ifS3Vsor3SxJjtvkHlvKY3tvDcXtJSpDGJnySLEmHXcKc4SAIB4iUV4nST4I
	TOyfG3p7Zgs+oEjrKE0i+1aYldJMOYFub38o/4bb3nqrQoHG2m7dDlwzCXvu/yaf/wBxVf/u4UD
	rUOqLRpW6ETDimpbynCnpMdeTCs55ijwn9EOV2jc8kKyF1BoJbxrqW9haqov0Q0XNtu6ZjU1t6G
	RJKF/gcfBK11AXb+IBdmF4S2R
X-Google-Smtp-Source: AGHT+IFnEbyJepPTqfFg7VtXz/wAH/ybKcrx49WRJp4OzkHlVxrenizS2f22suK4cIc8A4CKa6jQNw==
X-Received: by 2002:a05:6122:8705:b0:535:aedb:c93e with SMTP id 71dfb90a1353d-535aedbcc7bmr71194e0c.11.1751797664698;
        Sun, 06 Jul 2025 03:27:44 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5347906cadasm889528e0c.24.2025.07.06.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 03:27:44 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87f0ac304f0so405237241.3;
        Sun, 06 Jul 2025 03:27:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTl71ff1tu/BTNklxv7ODcOzntZVOzRr2UXaC7hJeOS7cMx7gmtiVDm4D89zJoNcN9t3CJJyTk@vger.kernel.org, AJvYcCWg2SP9grUX2864elX8M5TvGQ4y4q/4Vy/6oUNmmGdqcUds4z9psU7RCzokkjHuCAodW+B8xI5sPx8EorE=@vger.kernel.org
X-Received: by 2002:a05:6102:5811:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4f305b1dcfcmr2155700137.16.1751797664311; Sun, 06 Jul 2025
 03:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743115195.git.fthain@linux-m68k.org> <9d4e8c68a456d5f2bc254ac6f87a472d066ebd5e.1743115195.git.fthain@linux-m68k.org>
In-Reply-To: <9d4e8c68a456d5f2bc254ac6f87a472d066ebd5e.1743115195.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 6 Jul 2025 12:27:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3Z-BH+c1B7wB7PBn+WEih35H77OZi=FarBiB9GkdGOQ@mail.gmail.com>
X-Gm-Features: Ac12FXxAKqZp-9JhrCCCQzH4l18NXnSOaU1JG7d5QJWuwU-BDJuAUpkO0gmTKNI
Message-ID: <CAMuHMdV3Z-BH+c1B7wB7PBn+WEih35H77OZi=FarBiB9GkdGOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: Fix lost column on framebuffer debug console
To: Finn Thain <fthain@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 23:44, Finn Thain <fthain@linux-m68k.org> wrote:
> Move the cursor position rightward after rendering the character,
> not before. This avoids complications that arise when the recursive
> console_putc call has to wrap the line and/or scroll the display.
> This also fixes the linewrap bug that crops off the rightmost column.
>
> When the cursor is at the bottom of the display, a linefeed will not
> move the cursor position further downward. Instead, the display scrolls
> upward. Avoid the repeated add/subtract sequence by way of a single
> subtraction at the initialization of console_struct_num_rows.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v2:
>  - addil and subil are now addql and subql resp.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.17.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

