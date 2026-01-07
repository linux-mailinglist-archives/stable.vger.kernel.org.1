Return-Path: <stable+bounces-206105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6DCFCA96
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 09:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B90C300AFC2
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA22D6E64;
	Wed,  7 Jan 2026 08:44:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE0284663
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775495; cv=none; b=XOuTFhyhIc3oYN0EeIQJVwscUE+R3gfYcQuUqMfoiY3qxefr7SMKLH363HAzidpURpaI3Fjmambs2fLUDT9FIXRotJieuueJ6cfPuPBA0Kji5yOafJW4ks5/UMGL3tgvcPrnEI0HdwZJPwYtPmgXw208sUYvumBjZ4cWUZ43HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775495; c=relaxed/simple;
	bh=Z/Cp4F0ZBq+W2m+DW/28XQxAMadBOYzvQ9QpYNbTJ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcO7uzmxJ+q7aXOWJeB4zHNEOg8HgROz14VLMkGyDcYzo88T84zUHdqEApF1vBwMT+yp5HGmylS+gcTOm6WOKYwrKOB7DpLC3N0PepahWQgdik4s8c4MIFWXrHVwDenEd/WFmdOuHQeZ0+Ofcw4tc9lNPeKf3fU9A7vGYDDH8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5634d866615so131285e0c.2
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 00:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775493; x=1768380293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1vgOPEez9FRp6KWJKirWJAqRTlbTZlVkOJqMPd6HmQ=;
        b=eTMO3z/2XhdJ7cmckUJ5yhgQc6FbJ9mQbco/LAHjAvjG1KIRwgCBdtMl4LVg9UTn5D
         iCPR3u+2pNuiXqbMXZ7UQK3nAiUe8uB+UKO+Sb6/MTcOKO1EPCaz3H7LT385Iau9hLGm
         wRjrTwds5yxmAAvxCsOg+XMAJ/+nnXRRSKyXOIxgKXkqne0FkRfNnsZxryYDSoC3E1pE
         WKqjaUXOztxOyrn1wUlykSddqcM7p5HbyyVcy6ADrE+wbkYMxGhzgK6DTAgBxG5SUx/9
         N6AJyQP9joFntaKTxXsDFQ6xSSEjPrud3wFDV5knIlFyWMEl99C/HIjCpaZ7OvDgYUKU
         jwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVOpG09nVqUPF+GEdLfzh6T7bpLb4iDIm+ljwkq+KVMOxITUthLbEpxxqM6vxgALypUG7cgbCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWl9cEpDoeVKpDcg+nvL68h8EYN44VXMjoNcmEEj+4bw520STw
	i6poB47VZPFgrNyvQCpN+4PJbXHrKAO2c5Y5veIk9jozWT5JB1YLu6cDeqYCWhQN
X-Gm-Gg: AY/fxX4ZnFcxxiazGwL6bGfCkFvo43mVXBNeyp7tLAmr534H/4rY6SiE5dAAA28XtVt
	rK446kLizPu3V9+p1oN0gakcv9QfYMZ6+N3sF2tMod8vTyDjdL6ZXdTGWWzet8SyUopzVdc07xx
	3cg84yV+nsWz2tJeTHECyHsvPcb3OTCLTJeAbSoMkqWG5g7JVioYC6gE26JMPvXs4HCUjxy1YRg
	JRp/+UzurD8irZ3qpdtgeo4UXjozK2EE0p6ItclylhPsilaPop4EApLR8AzGzMDrZyGzKvM5ZFo
	8gw3xv71L75iE55mIdd6j9VBHyLoaE/RXxX48lkelnWkJJ9fClMm9TIVA3gdilDWud1dSDlWw/I
	0pA7eiQc5me7zQBTRKD6CGOTX/ke7mxuCi/+sUApsNKPiTIsXT16JECNNKAkfDxUz0PV9+Y+6nv
	hSg8TGyoKRe2lHDaCSMee8P9t3a/HKAxc5T7vHUQ2RENyvbCc8
X-Google-Smtp-Source: AGHT+IH6qDKborJ2jJyPLQ3dclJG9o+mkr9DMaaUBq6mvU/IXa2GMgz6egdIGcUEPOsM/37DxqzVKQ==
X-Received: by 2002:a05:6122:421b:b0:55a:ba0d:d84d with SMTP id 71dfb90a1353d-56347d709d7mr593523e0c.7.1767775493101;
        Wed, 07 Jan 2026 00:44:53 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a074d30sm2366633e0c.0.2026.01.07.00.44.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 00:44:52 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso710900241.2
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 00:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl8iOgjLGTLi/Nyure9t7oUay8X1O4KxX2nPTbXxDZqWXJwwlKH5jZge2dqs0mpGfwhM7oScs=@vger.kernel.org
X-Received: by 2002:a05:6102:4b11:b0:530:f657:c40 with SMTP id
 ada2fe7eead31-5ecb6932feemr583997137.22.1767775491732; Wed, 07 Jan 2026
 00:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 09:44:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=kCg62C06jMSdse0QZacKn4R2EqmW2BZuZ+cBwr5tmQ@mail.gmail.com>
X-Gm-Features: AQt7F2qmnFtghLvjGfXih1A7aLAlQHCFX_w3g17kIVrnEuB-I-dOz0canJODDr4
Message-ID: <CAMuHMdV=kCg62C06jMSdse0QZacKn4R2EqmW2BZuZ+cBwr5tmQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Check that the DMA cookie is valid
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, wsa+renesas@sang-engineering.com, 
	namcao@linutronix.de, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 08:40, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The driver updates struct sci_port::tx_cookie to zero right before the TX
> work is scheduled, or to -EINVAL when DMA is disabled.
> dma_async_is_complete(), called through dma_cookie_status() (and possibly
> through dmaengine_tx_status()), considers cookies valid only if they have
> values greater than or equal to 1.
>
> Passing zero or -EINVAL to dmaengine_tx_status() before any TX DMA
> transfer has started leads to an incorrect TX status being reported, as the
> cookie is invalid for the DMA subsystem. This may cause long wait times
> when the serial device is opened for configuration before any TX activity
> has occurred.
>
> Check that the TX cookie is valid before passing it to
> dmaengine_tx_status().
>
> Fixes: 7cc0e0a43a91 ("serial: sh-sci: Check if TX data was written to device in .tx_empty()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

