Return-Path: <stable+bounces-210070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3ED3347A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B30573000B14
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA899338916;
	Fri, 16 Jan 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDnqiNKB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pk/GJIYo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7233A005
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578219; cv=none; b=YgJeBfO5V9trauVAfclKCHodYtqt1lhIL+I+TSmVAG29EQFoxJr/yAQph2VUEKol/6CMBanl/3pqi3jqqjawjOKnbJvER8adHjeailRW7v52ylkvEIHQ6fiXzQLM6uEt7ekvcSG6yOyyP3EUGIbonvLEJLj5Qvl71rhbeDBl6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578219; c=relaxed/simple;
	bh=wP0VuBymKjnK2yDnprg9vlE/v6L4WJJ2taaTKlCsFRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLHqLEtxdl48lmXZkq3CUaHOD4iuMe9r3q13F8JVj6AheAttGsy2zha9cNE5cms0xGpXDhBhW0REBm5H5tG6CGtxhu/9qW4YmT/Z4P45Cm5bEaDW1Q2Tdf36OltryoXcI4ouPUSzeA/npI5fgX/eIUkKr7zoNB5FqZrzDNPIQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDnqiNKB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pk/GJIYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768578217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4zTrolYR6sxi5JH0WGxqRhyi0s61/Mhtp+AU+f8L/k=;
	b=UDnqiNKB5jnPK2R6RnRs2pAFfw1xX+18KaXEKZ5CeBtDvsu3jZdTQ4/ps+hVDide5qg/nO
	h6Hgj+acuMQdg9cZBsqRdeqfoXpO/c9xstP/ZlZ2J8ZH1tepjEBOUWvnEdNaOFdXBkAU3P
	UxTDbHynh1O6dt0v6UKsiVj+Q0BdZQo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-IZY1vjIFNC296Ow9wOtM0A-1; Fri, 16 Jan 2026 10:43:35 -0500
X-MC-Unique: IZY1vjIFNC296Ow9wOtM0A-1
X-Mimecast-MFC-AGG-ID: IZY1vjIFNC296Ow9wOtM0A_1768578215
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bc4493d315so605650785a.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768578215; x=1769183015; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4zTrolYR6sxi5JH0WGxqRhyi0s61/Mhtp+AU+f8L/k=;
        b=pk/GJIYoV3QDgAuqWOHnHpZiPJqT0OppjOSxMI110BRyxP2AdlUvwuSnQ8l4AK7xo5
         RmK8du79MoOAhuEZk8hksyxwSyp8QwRx+Gjbyj0ESkxKvmZJ8ajUCWYevrrqbbVHd3Uq
         14aNw3x4ShyoMUkiw8DRz1aY8XaFi0vYLFZRlmwsgvWYNwcGdRixRfEaoic8Goqt5iJr
         SJg+A4GJL5ycu1zoueFwsYWzOjoccwJ0NfUNxeHo6/8yXSVCcJwa+dxZo0sy43K1pigh
         l9VbjXq3LkQ5eJBcqsy0XO4od3pSY+J+gM6GGT0bqFBNtCmkxDP895MKFMXJ+V4gXXRC
         Js7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578215; x=1769183015;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4zTrolYR6sxi5JH0WGxqRhyi0s61/Mhtp+AU+f8L/k=;
        b=seANmoeOq4qLVvJXWBKwBpTkxtFr8MO8eFNXK7XHfEh+9imGBXQS5Jb4Zj9Otee/GL
         RDQL/edtb3gDjHFluqRnl82idfBGXPe1dIw4Stc9x7JOVjVMF2y5HqvjbVpZIUBmiTh/
         9uD/lcDvaOt3WjRYX8KjiwdmD8VxZ9xnTPT5zkan70FRx3++os9Bfrlha/xA2YFKeQjs
         4aQ1PiJdmbPrCcA0tM8bcMHeREDtBpLnsirvgxCTiqmKYWAadLTituCWPMkRGq3vDYba
         c3kSeGVZ88oA7qqnynqc6mYWG4AzDfwLhxnAGGKRrLQzfWZsFyVAfYp0bUc9vgGpNj3k
         OvEg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+45oUiXzQxd2DBz6vznPmQF6dTaGWbVD0iHf7K4qZXngXNYB9OJCTjRhpXTddXBiOpRq17c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbQ5XqwWtSBAYWdWYNWOQ2b8myE6LiV5jJIyRbzAicd2OjtTE
	0iEshcetL9PTqiwCEr1S7OXLM/VnZpxl89rnM0LuxCr8blBRyrDTmw/FFiWS5QrMuvaDlI2FZOK
	ZV8Yb8m5v/6RQSUQKKGGP3ZbA0y5XyTfLk9WioMV72SkCS/+H594kDm+jmw==
X-Gm-Gg: AY/fxX5p/wADSdYnI3xn8z9uGjHkkVwxOfTRsZhFeamulDHA7oKgiO8Jdex6mw8dHBb
	iu1aY3+50pBczkXG+cEDg9pbNz+rkNoJeCCvBhrYSUjQDfwo9MoZU42SzIJ+gfD/xJW0jvzYBTx
	U9ZxkJrtzG7qEkXIqXBXF8lQcECGLuf7I/Nvx6c1+YPQ6N0av0FTgKSV47zQrOPnfWPnfPiLmE1
	zVIRMlbLIYyZyhhbzkzOrzSE4fvQicoL+8R/LwdSHb5991FsHApgmyVR9kCG/64iZlEBmt3vyqZ
	Kild7nj04c+KJDCdLTTbewwQss0Jy7ixpYeLp36eKrETU32KMBD7xTfU8g3gQqhTtRpGmMjd+Ta
	Caqd9zOz91TLJoy5RKSrZ/qlzEU+L1BGEdj9Gld53xhUE
X-Received: by 2002:a05:620a:46a6:b0:8c6:a508:a467 with SMTP id af79cd13be357-8c6a68d95b8mr438692985a.25.1768578215402;
        Fri, 16 Jan 2026 07:43:35 -0800 (PST)
X-Received: by 2002:a05:620a:46a6:b0:8c6:a508:a467 with SMTP id af79cd13be357-8c6a68d95b8mr438679385a.25.1768578213547;
        Fri, 16 Jan 2026 07:43:33 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c0759sm243653985a.14.2026.01.16.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:43:32 -0800 (PST)
Date: Fri, 16 Jan 2026 10:43:31 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] clk: st: clkgen-pll: Add clk_unregister for pll_clk
 in clkgen_c32_pll_setup()
Message-ID: <aWpco0qchQyNPB9b@redhat.com>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
 <20260116113847.1827694-6-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113847.1827694-6-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Jan 16, 2026 at 07:38:45PM +0800, Haoxiang Li wrote:
> In clkgen_c32_pll_setup(), clkgen_pll_register() allocated a
> clkgen_pll memory and registered a clk. Add clk_unregister()
> and kfree() to release the memory if error occurs.
> 
> Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Brian Masney <bmasney@redhat.com>


