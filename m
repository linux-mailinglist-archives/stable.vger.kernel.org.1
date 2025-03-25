Return-Path: <stable+bounces-126641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8DA70B73
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 21:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777AA166695
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CB23A991;
	Tue, 25 Mar 2025 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnZIatZ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A21A7044
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934320; cv=none; b=Kw9TOjAQNWNueTyAMg1Elekfe6n5833sTC+4B+6PybmjwLNi0S6jcjRu4AJJF3gYAXI8s4/sj8mVaByP2ejuIAO0Y5Eah4S27eZNPaMNsDpw+Ne9Mc9MwXmmUgw3yKFANVBzZ3rD7a+1YnBisY82QaM0ayLDOqu6idedvKbuyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934320; c=relaxed/simple;
	bh=K3n6uYEP5aMssXAUsPzs++ObMser+JO2sYQISRKuyLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPdxyK7y0m6wClzgp0jLObFVCzsRP7umOeFV3MYn7CWteGR/RFS4evOGYvl1Jwgk3/SG7I/2JCmgeQbfc2F+BDHVr/ZaxIb5V6kyk9OHZk0/hi7KU0pvPSlStcm5Zgg0gDuXw+OwB+X8FjvcSgzhX07JTWq9AaTjA3ilUnc7ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnZIatZ+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3015001f862so7606638a91.3
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742934318; x=1743539118; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jHfAuJ+gsHK6UjPmXC9eET8PRX5/lcYBB/XL+ivaVw=;
        b=NnZIatZ+8mJUjG8+3Jn9FMOKsPb1/We27iMyT7PkepTDSRljI9+YjwvOTVeFJNbW3/
         CvQ7AQRUARRHrwDDaVGRfE3A/eMdaT95r+n2azK9t5smy78Raa4QJMBtguejR0SwW/gy
         AhJzDMagq4qGmzBoaXpT/0e9q21MotogGXSqFJxvOiKR2GkgfvDXgIK5tg4nYivCLSQ3
         w+UOiEE+1SwYm54+2oVmlDJr9KqPTKdD3cIyDcL7ifhLHnFp2nL/DyxJRm7pwIFt+3Wv
         l6kRom8EWPQEgGaXhbaLCAvyeW3qOAI9xHnBCZkSp7R7/MPQEclflATel8xGo9TO6VKV
         Xabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934318; x=1743539118;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jHfAuJ+gsHK6UjPmXC9eET8PRX5/lcYBB/XL+ivaVw=;
        b=Mnqjl0PFsokjXVXOShpyEbzFtErZNZR6A3aPBM+JdxD4ucNdJZPzxsxBiQ8hy0IeGI
         jFFz0AG9muaxIxlNZj5BxxT+2LblEy7pUJwJSh0xZhpp0P0HdzH4O/OGGy5VcgUerWc2
         oFkYlkOY3EFiBA6nFnXJ2DzrmNmrkzgQA4qL/oeMfplLoMrq/Ke9eBUpDHI+2fX+0Zx8
         Q2n+4S6FA/pJIFrwcTY6P8ZuLGPqbck50/R0TsW+n14wqmVgxGzVaFLdAXPWudk6R2Gg
         /wUIEzxpfiKaOxBwazzm2IFXfA/HnZzR1Co0U0wel8dC0FxNqhK5G4s0eLHeZgHg2nkT
         xiFA==
X-Forwarded-Encrypted: i=1; AJvYcCVYN2PkrDXrg4JacX74LW6SddUKV2DWfl0vxXgzbP8Wkd1e80Z9HoMgUfJO22KYuVOtoEM4arc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEaxGhgXtgD/58U4h0Kn+xWoyfHK8osyr5zFn8/cHKk7SBre8
	qgqJ4CbTcIU0nEx523FPYWvIWIpf0CNGlNXqTsibESQqTEBT3v6BWPNoc4zpvxmy4G2qvG0PyZB
	ZflvV
X-Gm-Gg: ASbGnctXoQoAAjt3kVwzRok6gOSJ87l1SXEXouOMzuN3L6p6ucwadvm49dvMs6FR9y4
	rAn9XNa5Ou2R6aGi49fU0GNLTKKU88j86393p00BYz+tdWtCkCM790IxIxDPOiZBxbIoNARhQXz
	TkXGuwhfa0fyx62EndupZ2iGFq24ja1QhxQIyeIfkeo/tdKpI+vNlBOMUyLDmx+zmi+BIJswVqs
	xok8tOh/dkqAEWIBiPfiH1zIu9+znSNj25l3hd84lpbXdyPGXRBXfzVQlNEs4OrpIfgblG0Go2R
	1Dkl9uTPBAZ68l+A66pdibuEn7RpfY7IkSyqTuAc0kHoSSwFOLDhRSUQeDsYoFwpQwwUuJHi0pj
	h7t0lT2/BW16rluKZ4tvnvWs9cJP6f7PJ
X-Google-Smtp-Source: AGHT+IEdkCdnQe5BWaB3kbs17NeCm0iUUY4vmOoipeh3wSs3QX+knAUrOwzJv9++lj8+XPonZ9DdAw==
X-Received: by 2002:a17:90b:2647:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-3030fe7223bmr26888965a91.1.1742934317334;
        Tue, 25 Mar 2025 13:25:17 -0700 (PDT)
Received: from ynaffit-start.c.googlers.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bf0sm14848747a91.7.2025.03.25.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:25:16 -0700 (PDT)
From: "Tiffany Y. Yang" <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  =?utf-8?Q?Arve_Hj?=
 =?utf-8?Q?=C3=B8nnev=C3=A5g?=
 <arve@android.com>,  Todd Kjos <tkjos@android.com>,  Martijn Coenen
 <maco@android.com>,  Joel Fernandes <joel@joelfernandes.org>,  Christian
 Brauner <brauner@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Alice Ryhl <aliceryhl@google.com>,  linux-kernel@vger.kernel.org,
  kernel-team@android.com,  stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix offset calculation in debug log
In-Reply-To: <20250325184902.587138-1-cmllamas@google.com> (Carlos Llamas's
	message of "Tue, 25 Mar 2025 18:49:00 +0000")
References: <20250325184902.587138-1-cmllamas@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Mar 2025 20:25:08 +0000
Message-ID: <dbx81pukx3h7.fsf@ynaffit-start.c.googlers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Llamas <cmllamas@google.com> writes:

> The vma start address should be substracted from the buffer's user data
> address and not the other way around.
>
> Cc: Tiffany Y. Yang <ynaffit@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Tiffany Y. Yang <ynaffit@google.com>

> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 76052006bd87..5fc2c8ee61b1 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6373,7 +6373,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>  		seq_printf(m, " node %d", buffer->target_node->debug_id);
>  	seq_printf(m, " size %zd:%zd offset %lx\n",
>  		   buffer->data_size, buffer->offsets_size,
> -		   proc->alloc.vm_start - buffer->user_data);
> +		   buffer->user_data - proc->alloc.vm_start);
>  }
>  
>  static void print_binder_work_ilocked(struct seq_file *m,

