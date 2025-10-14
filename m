Return-Path: <stable+bounces-185682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCFBDA01B
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037B23E5217
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DB2D6E44;
	Tue, 14 Oct 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8rUVAsv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B62BE029
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452316; cv=none; b=dArrCvk4JvsrRLolN6bWEzuT0e0lhkpu8yAmOsyL+pSaBDAbVRifZCFuD9jAvnv64V26IL21Rx1sbSIwUkqCDbUjUOaC1ly4qLm0Ya0De/cOjQVz6xz5OtFG9oTbHYKv6xpwUF4O6rVoTXB+vH87NUopQio3yFVI69PdUwMNPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452316; c=relaxed/simple;
	bh=6LNc+vdwep4BeLENBR9hSs9PbKUdEngRnpluAWS4E1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ao/YhKSak2bySi9cBTkQRzRe+dGEYTw4V5zNnmK5vsb+DqDlPZhxlzf2LNr42XlVQ5fzoF21nfsE/gYqTcW+FuI315ubvcRycVLf7mVJMgRmcqxaAl9fk4PiXkMEVUI/O+lhH6k75b9ojmG77/ZJq29nMPYvCL9bs7O0w9GqaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8rUVAsv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-80ff41475cdso111418396d6.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452314; x=1761057114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=k8rUVAsvTfBEyERHFc2Wo7Pf0nSM7acG6HfqjLNm8QoPC5/yhxR34pd/fZzoGSh6DW
         7CzUmmamkVAjRp9cB5WVaYZO56jsv/6LEzLb1fX/vtOv89KwvDs8iWQSXZrtVj8RCVvQ
         qJ5yCETx9wvGPMXMCzsGMu6bcf+YgBZDEMtfQfLu6KyrXpu2ThdCBNAE0w0YID+/1dX/
         Rwp7+U5JeIozpcs9pEK6PlB/5gR6pjQpTH5yeArA2ZaEtuCi4iJjT7UdjqZvJdC8D3hk
         rtZaByVhIBrD010vY1rTKy7e5i/60UofCGK/QJCCqVmsmvPuvTfIf8f0hXK/Tdf2HM3H
         9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452314; x=1761057114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=gWkrsHNpVQz0xMOh66dbQNa4hjt7iCHXA9hTMWMszekqghqRjcTI4Tm/LgUFkd3BR5
         An+lkHmKWRkW/6rDuHy5dF8DuQVyQkd0/9X2662qIV00qdp+OdW76+UexKn7SlRlbumb
         8iVQS+RxgoQ0XRkTMVWXrDiRpm+jgaFVzfru9c5qphh8ZcszbdVMtGazueCvvrvUfayc
         SCUdCyMSKJx9ZZ1GZoJM5TXVbfZzIlHXgc/d5llIYj7L/VoUCIa4wSrY/XyVKy9dVLNr
         Nct8bwc1P6tUYA2LeR3jyzyIfGLlefzYHTjyHzLYFMaddTmiG3ByohbHUT9v2WRB3SSy
         dAzw==
X-Forwarded-Encrypted: i=1; AJvYcCWHTbEvr7dM8J7xKptwk7fSV4ur0vug9J8QyC+Vc9nIuSKbdp9jv88B8RdU1InGg/SJoyzaZi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMCy0B28b6J+/N3pVu6AqduqxHNQ6s8rUOyzu01+KhhbuGuqO
	uOupgfGxuSSGuhwFGCB/H1u8NkucC/ho9GjZxB2zpFX+gIrRRRgIhZpV
X-Gm-Gg: ASbGncu3v9i+ZaMywsQ6JRq0AMPeeVsfJbz4gnK2t2TqDy6fsTFVeQG9WjmUqwz7aA1
	SDK3nw/8D0SgrKTUUCd6xCVFTXudiySvZSObF5Sc9vwmjjIptZ/PS6utKCpKqVGbPt9o8wseb+I
	DEHi0DYzv/K4YBNERYtupZv/4Y+8tmoxkU6J3qNCIa2GAdaiFFRNVjSlSlObra3nW33kf1Jtebm
	bMBvj0tTe4IilCuvjgox8v9zx+ikymG5qSGr4i6vuXv0KL7R0cL0+t64TPmmT64dxEIgU2cJzg9
	zdwZYppEwBOaMCUUQ1MOKDOxdmZ8fibemVUyZ1uDq1+GN5YZG/hTmOQtdcb7nYN4N7B/S6vRmRy
	bn3DmGJGYOnEWgPOMKeZ6iQv14ybYGySHvC+sh6pCKXVR2UIyr6BKDpVXMLJQJjFfh9Ayg47rJm
	FJ2lfF34toapJImLljMQWnSwI=
X-Google-Smtp-Source: AGHT+IGwNwmXjeWv8Nmp6mkj0A5dZpoUF8uBRl0oD8iLD5gvHZaccJu0fCjSAdWukmLgkyib7kmZUA==
X-Received: by 2002:a0c:d785:0:b0:87b:b675:c07e with SMTP id 6a1803df08f44-87bb675c178mr190769806d6.64.1760452313618;
        Tue, 14 Oct 2025 07:31:53 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc3570c11sm92598796d6.31.2025.10.14.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:31:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:31:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>, 
 netdev@vger.kernel.org
Cc: joshwash@google.com, 
 hramamurthy@google.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 pkaligineedi@google.com, 
 jfraker@google.com, 
 ziweixiao@google.com, 
 thostet@google.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18f9d84fb2f05@gmail.com>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
References: <20251014004740.2775957-1-hramamurthy@google.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not

nit: weird line wrap. if setting had been on the line above, no line over 70.

> hardware timestamp the SKB.
> 
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

