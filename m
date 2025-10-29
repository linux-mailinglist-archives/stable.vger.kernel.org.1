Return-Path: <stable+bounces-191682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F111DC1DB31
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 00:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DB2189B872
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F6312801;
	Wed, 29 Oct 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXpf1Mm9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF6283FEA
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781099; cv=none; b=TENp/PIG+tYicGtw0X3enZax5452C9W3RRLCK7YACJvT6FCp4Ifol6TY86yOkrH759KOWW5ymYeOSyVirxnHCgf+YdYCWQoaymBkRCPHO3kZX/ryLw3nVV91ZRSaw4n+LlArZmYQy6tkQ8a/2bfsyO4ZXd9uP0R2u+SD6d2NjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781099; c=relaxed/simple;
	bh=da5q6WrDERZ3E8/4F677YpdkqPEiT+9pgq5RK6VpI8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvoE0AclqMtHAhplLRInJkb9LtknDstvT3ZGGLPDbxydsfFMS03zKGO2/7xfB8sEc+QEpMTrCxD6ukTYE5VyGJb7yXEB3oxiq0ZT9fgbWQsZsXrVXkWLyORAjcdHx9ZKlfcJL2lGdXO9a3OIKIwJL4bQGydrhdk5IUjcrZYAqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXpf1Mm9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761781096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQVXQhmywwNDhXjEHeNci/tD1xAS4rlDBizu8EsOzts=;
	b=fXpf1Mm9OoSpk1awk3cs6VVctR69xaKS7552mY9kEHJOKAefG6gMQUdTjNTiper7Jo0hhS
	w1fUiK8J0ZV9TE3j3Cx2fB4CakudGVtq2coheHzmprKqhY0826yJmFHp6e8pBcCowTb2ju
	hVTS6pmPBrzWKIRFywxzEuST9JO1rOY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-I_T80Mo5NjOVR9ohiR-IBQ-1; Wed, 29 Oct 2025 19:38:13 -0400
X-MC-Unique: I_T80Mo5NjOVR9ohiR-IBQ-1
X-Mimecast-MFC-AGG-ID: I_T80Mo5NjOVR9ohiR-IBQ_1761781091
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429893e2905so513205f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 16:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781090; x=1762385890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQVXQhmywwNDhXjEHeNci/tD1xAS4rlDBizu8EsOzts=;
        b=jqQMm9jd3E1ppFwAs+4eGjO59el0GNX1MOLah128MFSYY699jiLByTzLkn5uup0FBy
         NFIrX2ChzFyOLMdIzVQZHAo9xNN6Nn6SukNfVlR+p5iiB7LggQIxIFsltxOWFntjOI6J
         daGtqWoxukeEMe+rJw9/X2a5hpG7DQREY1ITLPsIRGpjm7cJnMKu81P6BQcz4o1bf894
         wsoEIw5EI5BL8GeIn55PDbCFCphSBpnEa22qW9uEgNOn5SpQIugkheMv732ajhwXnia0
         /4mggogGqbMaOzrjcddjG5pqEJPh+NFuj21PnkKu5iFc0+vGCB64cer6ENKZeiEHV1ma
         TsTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWtC0arhcM8Yz0I1o9fvOJR44Q/o9OBKI6d3KlBuO8aM+M5Z78YKOXn+iI8oIj2VfLqIEAfLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB8aPcBZbPnxjTXW/CMqqIxs27RIDMotbMm8u4lMvrVlrkGdc
	sVb5/G8ebslpDWPtJnf1GAQNy3AvaPuGTkjKn+sKyEINyKkrd7EwZacML46zSf0+5Fec7oa1kRN
	XiZ/NC2sifVIX60UMsrpIl1SKlx29pw/PQWhJyoihXGw0YGixvpdZBI/0NQ5k+kdezQ==
X-Gm-Gg: ASbGncvwpw/gBgWupFrQZngqVe16893fK5flIBhmDdmOBTem16uaFkxCYtqdYBPTO0c
	BX6SL9sTymapz0/y/cN3V/N3kmq7Qu8tct6r4XTtox5PHud5ym2AACWQMfBIWHdns2tcBpuXOOp
	X9FTXIIG/Z+M1tvd8iNobN4SFXCC5HqhCXG4aA7Fa2kAMsyI7MeJKFMlH4f3stUYnFk7nUJ7Otp
	D893G/+fSsZXLbI5y4H19RLwCwJaBHeadnfuiN8i/88XSiv6h/kKDhQTJ7VuRnJsQQ2euXdj4OJ
	3RX5phN7F2AYc4OLDXmShGgD30+vBzGCO8nhoaST8wlT1RoZoRf6iZQWsXPjXZJO8o+aIa+z3aJ
	poD5TZqsnhJKbaTy3zuxnzJz8vwPO65LomzKwrXQ=
X-Received: by 2002:a5d:5c89:0:b0:407:7a7:1cb6 with SMTP id ffacd0b85a97d-429b4ca3e2emr1008015f8f.55.1761781090455;
        Wed, 29 Oct 2025 16:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1uEuB+3v8AoscTZsHMuW4VKp5DpDnedQw28SoYh2t0KnxCPl65xDRR4J3Kh76yfotw/qtRQ==
X-Received: by 2002:a5d:5c89:0:b0:407:7a7:1cb6 with SMTP id ffacd0b85a97d-429b4ca3e2emr1007999f8f.55.1761781090028;
        Wed, 29 Oct 2025 16:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d252:5640:545:41db? ([2a01:e0a:d5:a000:d252:5640:545:41db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm28696727f8f.47.2025.10.29.16.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 16:38:08 -0700 (PDT)
Message-ID: <45733336-720f-484c-b683-66dda19042f7@redhat.com>
Date: Thu, 30 Oct 2025 00:38:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Clear preserved bits from register output value
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 pschneider1968@googlemail.com, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Nick Bowler <nbowler@draconx.ca>,
 Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org
References: <20251024073626.129032-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251024073626.129032-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2025 09:35, Thomas Zimmermann wrote:
> Preserve the I/O register bits in __ast_write8_i_masked() as specified
> by preserve_mask. Accidentally OR-ing the output value into these will
> overwrite the register's previous settings.
> 
> Fixes display output on the AST2300, where the screen can go blank at
> boot. The driver's original commit 312fec1405dd ("drm: Initial KMS
> driver for AST (ASpeed Technologies) 2000 series (v2)") already added
> the broken code. Commit 6f719373b943 ("drm/ast: Blank with VGACR17 sync
> enable, always clear VGACRB6 sync off") triggered the bug.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Peter Schneider <pschneider1968@googlemail.com>
> Closes: https://lore.kernel.org/dri-devel/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
> Fixes: 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")
> Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Nick Bowler <nbowler@draconx.ca>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.5+
> ---
>   drivers/gpu/drm/ast/ast_drv.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index 7be36a358e74..787e38c6c17d 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -298,13 +298,13 @@ static inline void __ast_write8_i(void __iomem *addr, u32 reg, u8 index, u8 val)
>   	__ast_write8(addr, reg + 1, val);
>   }
>   
> -static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 read_mask,
> +static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 preserve_mask,
>   					 u8 val)
>   {
> -	u8 tmp = __ast_read8_i_masked(addr, reg, index, read_mask);
> +	u8 tmp = __ast_read8_i_masked(addr, reg, index, preserve_mask);
>   
> -	tmp |= val;
> -	__ast_write8_i(addr, reg, index, tmp);
> +	val &= ~preserve_mask;
> +	__ast_write8_i(addr, reg, index, tmp | val);
>   }
>   
>   static inline u32 ast_read32(struct ast_device *ast, u32 reg)


