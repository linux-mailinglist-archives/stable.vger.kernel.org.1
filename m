Return-Path: <stable+bounces-184064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C097DBCF2EF
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0605B189BC49
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DA2356D9;
	Sat, 11 Oct 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCsOBX5n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36EAD24
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174716; cv=none; b=J16HQDStc8xclUk1Nz8hCgDfV22hUlCwjQMLRC5i52DPkcdY5qcpCRXgpAETVTlxqYvp9Gvvjq0om/UbB5wRDFTHYUgPBIyUFAxVntNNu12hFWnONAoTweW4nplZvvq53OmqtovoGXAQl8FPzFI7HpMMvrZeHVp6y1TlFnZfLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174716; c=relaxed/simple;
	bh=9dy0aKoKhvYgFFwabOjADieVvERVExSxvcq1TvjbQsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6ca9AKk6nOSa9u2RE6KvFN+ry+l1PGBWqLwmDYhvHpIC8p2s7/RhVutoLGFEFpxuCN/a5S1fmtdTdz+T0KmTQvnUqnXMnVRZgZxeHt1jL643GPbRDaCyaaK7RjzT/Hn9GwGU+5nzR3G7k3ePpV0tEJc7wJ28kwUHtMgrU2fA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCsOBX5n; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso6128674a12.2
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760174709; x=1760779509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXEinQfxlrEaW5mbNRPwohsHPfbi3M1Bsd5Di42aJ94=;
        b=VCsOBX5nDjHoRnTFD0WyNfaQ6iZ5ZgAjal0gdkK+t6iuqFlyA7haQBZ63lt849XcfG
         Zv9hKVeHWoi1pWBgNYC4/pmXcaPyUQQVM7otuqveymREnCv5KBNod4kjqltbIfRmew1l
         Af00Ab+4hphyu8Tf8G/hCwCZfr2EWl2zkJ8RGssp7GUf3oSiqDVAUymNRIiV/8dDTZo0
         Vi9nhcn+LOO7B9EPTQUIL3AFDbKIaco7I5d3wrztCztvdtYGYuZvZsv7iaEsVqfyPLH5
         6IJYhCY8MtDyN9IZlKFUJl4EKI/4ghqJS8mD7OQouDIbSHeQQ3aElD/W4/0gaRyq5oDS
         tulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174709; x=1760779509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXEinQfxlrEaW5mbNRPwohsHPfbi3M1Bsd5Di42aJ94=;
        b=Z4YkMhhn/vhERJop5PfpfTong7ZPYzcqhe0mQ45p2O9JOiH5TPRheS2Ng2WxYmV1SY
         q6UskGDPe6ay5qWyYGcCEy313KOn8wrKISw5//1Gvrm2VH999S/Daa19vi6zDBmyS+Wp
         iMzSbFEg1ZcegYN+arTUbH+HuexwCYKkCcuHQ5cAYTUXbf5doHhtSjcCqiIlicPlfVHW
         qgT7hQ3RT2ZQre8hdEkOJPh8EGKQOq3GO7yhXZdsG/T5vuSTajuxonP8iDX8UG1v9kqS
         IjB2Mkbc55itVFkwE4BRJsZC3rheogLEEt1sJqLaKq8Gda0s0WwVtTYjL5XDpZs729s5
         Fnig==
X-Forwarded-Encrypted: i=1; AJvYcCWMOR7TFU3myHdsEuyk0v4nIAuRWXP8KiUMaQlCnL/U0qgEzcugnExBmlyv+KMQydRRLbTJboE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMU/mwFVhvELTWd8rxYYxW3yXQGkuuE+fYVZ57CYq88xoJLQF
	G2QSeT3xT8Acn4qd/IVvjkQFBm6aPiXfs5Dtx9PiHvs1xIHkYY5IqLkB
X-Gm-Gg: ASbGncu8QQVJ7fhTxHzqj94ZNfRA/FSIYEobP1C7aU9p/j0aCMjgXrAhan8UxjWlSuw
	rE5JWv8fC+Nz/ykenz0gsVGnQWVCllMC+5wug5Kzfd1o58S/BjVIpo2Y8Ik66OasF69H/RHg7Hz
	IGix0Hcey1nO20je8/s0Jy8Gwpf+N8GqRt5t5B1WTvcP/Gfj4wPhNoF6k1lQ49xC79nizqzhixi
	gmVuDzbB8fWSw107xFEq41La9QxHqhoxc0Z43EYmBir+SFVXyTPI50GKiSFAv6T3Z2wCmlsIySe
	7QPDsOBmozQntajUYxGwIpDQmYT656UhjZfpM7hzDfqH5InxLzJQHXuZhwm6jhLMEhCjGQ+76aq
	BRWsWi3+Dty7JtTczVaCMZ1E7dGsQGq6/wFexJR4bOUml1v3qaYWDU/FfleQM9gc1C0L1iMlK/H
	OF3ej6+wMEJQaWA1ekznN1jdzX
X-Google-Smtp-Source: AGHT+IHPAZam1m8sYvQuHxTUeN/bLBz2BLvjFi8GzcdgbNZYPTup6tJOTtIwpqZFsVSwm5nBOTuk5A==
X-Received: by 2002:a17:907:3d91:b0:b3f:f43d:f81e with SMTP id a640c23a62f3a-b50ac0cc027mr1653121266b.40.1760174709221;
        Sat, 11 Oct 2025 02:25:09 -0700 (PDT)
Received: from f (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a4054fsm438937866b.89.2025.10.11.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:25:08 -0700 (PDT)
Date: Sat, 11 Oct 2025 11:24:53 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: fix ERR_PTR dereference in pidfd_info()
Message-ID: <5asnajyk3d4c66fnpmodybc7rrprhvw4jy2chrihnlcgylu5uf@hfcw24zm2w7k>
References: <20251011072927.342302-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011072927.342302-1-zhen.ni@easystack.cn>

On Sat, Oct 11, 2025 at 03:29:27PM +0800, Zhen Ni wrote:
> pidfd_pid() may return an ERR_PTR() when the file does not refer to a
> valid pidfs file. Currently pidfd_info() calls pid_in_current_pidns()
> directly on the returned value, which risks dereferencing an ERR_PTR.
> 
> Fix it by explicitly checking IS_ERR(pid) and returning PTR_ERR(pid)
> before further use.
> 
> Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  fs/pidfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0ef5b47d796a..16670648bb09 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -314,6 +314,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>  		return -EFAULT;
>  
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +

Is that something you ran into or perhaps you are going off of reading
the code?

The only way that I see to get here requires a file with
pidfs_file_operations, so AFAICS this shouuld never trigger.

In the worst case perhaps this can WARN_ON?

