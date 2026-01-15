Return-Path: <stable+bounces-208442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD8DD245B1
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 848943010526
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929236D4F2;
	Thu, 15 Jan 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6xLzzyf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4c/beiL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39833B974
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478478; cv=none; b=lUor3kigqxdxsP23UTuHUZ21B2WOyqQ+xWg9cwIt1X6LZarLmBXdAXrf05RxcWYUpUVTmbQYIJFTozp03LlZeKaoQv8F/tp4y7ZXzbDaZCTura33UxmSw4kNXQYicnPWIa2iRNR6ZnnWjC31JY742KwzfWxmIGKCSorhQw+OFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478478; c=relaxed/simple;
	bh=HGrCcAWK8+bJScOVj4GyD53aQQY2PTSVg+l13f7Owwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3kEiRn7M+nwzbvuInL9OyoDtNtVbirjscI4SLlRO9ilv/a/y4ioadaoi3gzWbs5Ez8evi3Pq+JpKAShcyXW3G3+OAwBlIObSCYyOgnpS3thWIAmJmgTxCGDZ+Qj7Zue5gs4LExIlyjSSAbr8ybvdGDnOkq5FOyloxJmL9RFtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6xLzzyf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4c/beiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768478475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbFTVSTAF+qKU6LVtQSbnv/YXWJKOg3pN9JnvD/UC9k=;
	b=f6xLzzyfHTeaCeDSKniRe0FQxlPhiEPMXeNb3KEIbh1DuriYB/T/+wIjBDu+1aXX3GGc7O
	zKf5XSBpCxrT9ooHnOjtEmeBUj9seZ3qiN5ClIbObMWqGgjbsK2KeRihf794SffyoM7LEN
	ZrZtoXgueSOun/fwn8P/lH2WTsqUz8Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-mjVxSJDHMS25q2Z7amlFmQ-1; Thu, 15 Jan 2026 07:01:14 -0500
X-MC-Unique: mjVxSJDHMS25q2Z7amlFmQ-1
X-Mimecast-MFC-AGG-ID: mjVxSJDHMS25q2Z7amlFmQ_1768478474
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5014d8b3ae0so18874201cf.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 04:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768478474; x=1769083274; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbFTVSTAF+qKU6LVtQSbnv/YXWJKOg3pN9JnvD/UC9k=;
        b=A4c/beiLQhGBW6p1FeG4XY/FIGemGFzc4QTMMqgST6gw1jWGsS9Hc32yfVdEibSsFC
         1BVSX6pt9KP1gwI1MjXp2+G7fugaiwmG5gK/C9HAsFu6VGaYkiS88JswnsT9N4UkpuLN
         TGn1DNICWn/BtYy+OZp8shc2Lz4IWoHp0XBL76j2WXyxEMZufG6jlBq5W4X6//CPRRMK
         PoMxgdwoj7gsN0K3JUMSpKDAeDPpekhRw21iwkbAnc5N/ydwHzhFczZqHPY9r0Hu1MU0
         /lwQCBmdGSwDN++pIqcUD1npm+tJ6gvlEFRy7ZW06ZOwPrgt6WXnFpQnHAw/x57oq1H3
         msKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768478474; x=1769083274;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbFTVSTAF+qKU6LVtQSbnv/YXWJKOg3pN9JnvD/UC9k=;
        b=tS3ouIVjaWBhWmCIFAvHUlLVhYN2W9J/BT3MF3tN/hj2jky1bUbKtW1sf8a5XnnY5c
         WuGCnsS52UZc5gS6LqPuKIPPiLuvQeHBGNqN80b42x0L2UElpVeDEJ8Oc7GsqXyNlv0h
         YYwmwZWjrhIHcowj/P1r+zM8uFuL+pPD0/rWqf4i60xvcIiTH+QJ/zKfca3NTnweOveO
         wUr83lw3TfUn1NVealrFLjYGJMK8faIHRV0P3BD/1yIs85OkIAm+Y7+W/bxsiYTOfmgB
         cVFb/MCadG3Se2FSG8RuHwSxNfiiMCGyr6VB0fWe27onChQZgQx4053egjbLHFq8nZr/
         IwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuMNFfS7IYIifA2hLYN/jFeXHg+/lmOu28r0a6y4p3b3YDMC2eBRBGRltSvKGEJgHmcIv82VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2akXYjqvAs93qxI9dSNSe4rE6U793NHoiNgHkTskLSfzTfh54
	m87BUX/A+qp94M/zNU4kIlx9VYAdLOXz0xhVE7hHinnxlZXk3Tm/ZFqCsvuWeII98mBHxENMANu
	7bXWgtkFJ+XPCwiCWeMe7CdOw6tP3liRWsH19/PUS/JBJvCgYVz8I01fXdQ==
X-Gm-Gg: AY/fxX44fKn8jAZUmr4bWqeK+Pc8G3Lf16amJZz/wW8ngMTy53UhFgOlBO8KbkfZ/zQ
	wQBrv227+/oHbQ6DR2OgjIvZuYZ7mpezXxAcDnL4CuT5fvz9JF3SK/TvoblmhhHtoowGjqXAuNH
	1myyaxmmYqlQb88sfRC/jaj7OMTLLu/6dAPB93sxZLaedcd3PBki8ovlJFIWQt5Z+tyZ181qgn1
	/fc2U0NmfC26YqKs+L4lVnkCZhSKuTBmaVc/vXUg9LJKvxvV1i5K7ZNbv2708Hqwtk4ToLVmCLC
	uoBoNkmWMwGHtcrQEa3SZWTis6Xe7hAne0H2FSPJXZUebRTkrqKAhikcO6O+n36FrJKNFxctD1X
	VJ5s1QNDeZIyVfAJZ9hrB7v1US5gojgM5hJO3TgWx/+vJ
X-Received: by 2002:a05:622a:1f11:b0:4ed:b0f9:767f with SMTP id d75a77b69052e-5014848f4c9mr87190241cf.70.1768478474094;
        Thu, 15 Jan 2026 04:01:14 -0800 (PST)
X-Received: by 2002:a05:622a:1f11:b0:4ed:b0f9:767f with SMTP id d75a77b69052e-5014848f4c9mr87189551cf.70.1768478473665;
        Thu, 15 Jan 2026 04:01:13 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077280fd3sm196986366d6.55.2026.01.15.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:01:12 -0800 (PST)
Date: Thu, 15 Jan 2026 07:01:11 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mturquette@linaro.org,
	pankaj.dev@st.com, gabriel.fernandez@st.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: st: clkgen-pll: Fix a memory leak in
 clkgen_odf_register()
Message-ID: <aWjXB8BiPgKs6wlm@redhat.com>
References: <20260115045524.640427-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115045524.640427-1-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jan 15, 2026 at 12:55:24PM +0800, Haoxiang Li wrote:
> If clk_register_composite() fails, call kfree() to release
> div and gate.
> 
> Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Brian Masney <bmasney@redhat.com>

This patch looks good, however this patch belongs in a series with
your other work to clkgen-pll. I'm going to leave some comments on your
other patch that you posted to this driver.

Brian


