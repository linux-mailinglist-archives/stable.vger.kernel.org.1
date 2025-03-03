Return-Path: <stable+bounces-120358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D7A4E991
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF77A2ABA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDF2BD5AC;
	Tue,  4 Mar 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPIduBF/"
X-Original-To: stable@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097C2C3758
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108704; cv=pass; b=CvtSiGT0M19XOW/UYEBvQ19qvsuF7uhVTdSRtwtaHa7AXER4Wajen0MSVdlMZBS9OouyeFWkjzLB8T8T7Buv2jE17ny62ouPY4/SvgDtMqiLpssCIeR4gbd1xyhDX5ITGTd8CQq49jySPbP6OM6yMU4ApMKyhLgn6u8kK5hzC1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108704; c=relaxed/simple;
	bh=B86K9mL2DWSBbOS2P/XXx6FWnpdGnhaunsmZn+LgU1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTaKftkjC8GFhqPirdzolw0/x5+yfguhzD7jHVRy/Ow8yLsBOWqysaI1m8bqk8cYJdbEhNUPaKB++DQh0v6o4xd5ErmI8n175CRliEAGsjhgAf9e0XTj+T3K07T157srfwf819We8acugsgno3TcD82wNmIt0Drwaa1JkI0PXAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIduBF/; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id B835140D1F4D
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 20:18:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fXJ5VHZzG07K
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:21:04 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5876942728; Tue,  4 Mar 2025 18:21:00 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIduBF/
X-Envelope-From: <linux-kernel+bounces-541714-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIduBF/
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 68BC341CC6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:39:24 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id F2C5D3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:39:23 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E8A3A81E4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084C2101A0;
	Mon,  3 Mar 2025 12:39:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5657FBAC;
	Mon,  3 Mar 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005544; cv=none; b=o+kvSl2RtylBRWj/z2y0eskI9If+QA73LMnfuyDNNgyi431AXiEPmUKgsiZPG920bcrMWEJouwiIhgirNO8xFRCoL62au4FjGKpVHiiwk+O1+0PyJDgkhyvytm5ml7hoL+ydcKwnGrO0trc5lNME4wvg982W+hOlpLqoQf+6eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005544; c=relaxed/simple;
	bh=B86K9mL2DWSBbOS2P/XXx6FWnpdGnhaunsmZn+LgU1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEQJXKy7WDaOUaP3EEMyR38LIWQxZsTLej2MWkSfLn+Z5vqwTYGIhV0wimM9WVqq95HuYWSqN3sDkBkVPtgOJWczo2zJHAd+gE5iOBQasOofH1nbPJtH0b18NQSt6pOu+SZee4kaBHXunoYCzxlhbLljPXK3U+yNMhu0BwDZw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIduBF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A9DC4CEE8;
	Mon,  3 Mar 2025 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741005544;
	bh=B86K9mL2DWSBbOS2P/XXx6FWnpdGnhaunsmZn+LgU1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iPIduBF/ryFdMhJVjAcCERxHSX8AW4S7CCuHeo1rsoc4ksIQmmXxMaTZsaoBaXm0t
	 p75PvLX6Rd5cikacEeqPg0KjFR4iK5qKFPqyx1WqUoboTMmU/oQBCZJ09DGA5Cz56t
	 VbdHMcL9bz3qP8u85LX783N3N7dP64HQhMAesZkZ3oCCdDZ/RYbyZlWERcDbOFN27G
	 9sxSsNIfOYeYHTTOMKqxCw3GcFiPIKk91BA6Wphfyta1GfBDu7yrjSkESZ22HF8OuK
	 YsOY/I1HhFIDFAcFjjjb2A09XobR6j1g3uVOIxnAfaqMFBQ0dCBpLd9VroGWKuCWaw
	 szEVuWhkdCVgw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72726e4f96cso2411224a34.0;
        Mon, 03 Mar 2025 04:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJL+UI8pauK0UtuVITxHGTd9uZ6ysjRlWEiiIalRvmdiGjumOJ6HWJ5tPT7zBnDE0dFw3G8VXq@vger.kernel.org, AJvYcCVIISWGXJtt8lfk5trYNxen5IKuBaZtnTSXss/FDRyODUkX132y27KIdwpVHhhXVoKMeX2hITiGiPI=@vger.kernel.org, AJvYcCWgjIW3fel4nBQE+JbF1qFDgXMv9OxTkR2sXS1UGkKrQxq9B0Tuv6WTfbQQQILPeuHNKV2jk1flVK4BUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdM+q0UMTnbPHAJxhYEOz3u5DFX+YT4FJ6JZbn8QzR4PqH6p71
	Qh/i3NdeFdDBTI4IMgmHlaIIBdUe0g9gW9WC2SEZdfjpEZQwbQhFVf1cOOm7l4fxOsFSDR4Eu+X
	kr/zz5Z0v+MYWt46a/oKJYILUhMw=
X-Google-Smtp-Source: AGHT+IHL7QcHIA/gOliSbHVKnX78oe4T2jnrZGkt3ri8BU4falSM2AKPYFtTywanWJLfm4FpFouSbDhOekSp/JpP7jc=
X-Received: by 2002:a05:6830:388b:b0:727:2a80:e3b9 with SMTP id
 46e09a7af769-728b8306967mr9059477a34.24.1741005543352; Mon, 03 Mar 2025
 04:39:03 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303034337.3868497-1-haoxiang_li2024@163.com>
In-Reply-To: <20250303034337.3868497-1-haoxiang_li2024@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 13:38:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
X-Gm-Features: AQ5f1Jpbua78r-Y1CAXxGLBF0QiCkuqUxIYIZ26St3GtTy8Yb-YsB_WumRvmuoE
Message-ID: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: fix an API misuse issue in em_create_pd()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fXJ5VHZzG07K
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706520.0774@n4yYYskflv6MRktAjiNQgw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 4:43=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.com=
> wrote:
>
> Replace kfree() with em_table_free() to free
> the memory allocated by em_table_alloc().

Ostensibly, this is fixing a problem, but there's no problem described
above.  Please describe it.

> Fixes: 24e9fb635df2 ("PM: EM: Remove old table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  kernel/power/energy_model.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3874f0e97651..71b60aa20227 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -447,7 +447,7 @@ static int em_create_pd(struct device *dev, int nr_st=
ates,
>         return 0;
>
>  free_pd_table:
> -       kfree(em_table);
> +       em_table_free(em_table);
>  free_pd:
>         kfree(pd);
>         return -EINVAL;
> --
> 2.25.1
>


