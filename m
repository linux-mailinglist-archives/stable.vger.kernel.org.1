Return-Path: <stable+bounces-198134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F61C9CB96
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4004F4E4AE6
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464672D6612;
	Tue,  2 Dec 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0dkdeG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22A2D3A6D
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702550; cv=none; b=Weg8XqG/kgGbgLV46gGP5GzFxr458Br4yIB3Y315Zzdo3hWGntgk1wUTip5s5/zBxZjTxSCJaWxOcaWCxZ4gLQLSLKmhQ3no2lB1qeGLWEC8iYhG9/7YHoi9gIrZQmDGhUY/f6Z0fdyVxN3VX1Mz81exHsumGG5r0tEQFliY6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702550; c=relaxed/simple;
	bh=wQ2Q1bYuGpPDFmUhq9r5xNJXmVin/Q0cttq22S6x+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3vh9zfJ7qLjer8Xp4TbAsfCkDPI3IZFwSdWu+yJFx4UDxWwiv3kNn+kU56+6aNOAYo6vlpL8Zu+R44W4eo0Vf0vK010XNclwo0cx4nEpxq/Hfb6MzQ4Rlmzg6J4F+4ONr/SslPYgzTe3XTqAuP0qQxAtjtPaLplIJxbu2Iszn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze0dkdeG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so61023025e9.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764702546; x=1765307346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/dj2hPQG6+B9AxmgFXbvm/Feu7VMS9EdlNKmCT8+Y4=;
        b=Ze0dkdeG1JubEnwRQaUYFp/NYZZlzazUTTotPLJvahkM87xoWpUJ3ECEekWXVT9QW9
         lsAxkAUXtFhOAputq4o7mumNpfffHeWUgIio7M21mOVuevr94O1Z+avM/qOceVqpBftN
         fpj9ChShBlRF4wsNNtk1wa4Mh5wUqC84DnSRYzGztRnLtU/HhcFZ4qRivMpKrz/BxWIe
         nB+E+v39Mj3Q764P/ZlBPz0kdr7Wx12o2CQIixpLC90cUrjd8ObVriSHii5AWVV1NRJA
         u9EY4Y4bElwmMXdVCqoHhZB7xnRV0FaSQNDA3upTscAS9YVANGZKLbaTF7mN2StmcnzX
         Sn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702546; x=1765307346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/dj2hPQG6+B9AxmgFXbvm/Feu7VMS9EdlNKmCT8+Y4=;
        b=idiuLxfV9fgkQtm6YKjze2RMJiTKDjA/u8vCKtuU4QFEJBdEprbI6feqWWErddAyws
         1+9C7lFxqs2k/80suRr7NdtMug1Q+gxs5ENLECHIaV3jtwQ0Hvu9BIKC/jEiwE9AwDVR
         QVLHbLJrkaZVaWQhlMn2z7ismQc2HTkXFxqlrbVVMlPtTE3Gpii+HNp2pP8FsglcJHoX
         uqeKvQdiNx4VzcLB9TGHNZhel9zCSFAMh1iF03BW27IRIvOUJ5/GRetbdMHn+c0nONtv
         zR3pKbhZfU5onJZ0Y3NDN4YcubaFNwMHlgj4sz0UuEDP6zGAJyGa/By0+0rrElkojhfz
         7Z7g==
X-Forwarded-Encrypted: i=1; AJvYcCUV2stWF9eGGXPi3gWHYcKYeG9lkVYGvX6pDlZ6QdUKSijHEtxMeMfimWRZeJP6FaX0q1dLCMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2DlD3newvmN41kuxlxk5AZPk5auwF/6UGKC7Y40I5EbauQ+6
	INfPsNjy6zMJNkn5sc4o3A5QHnQNuiEnUhB2Nhb4syDxyz2xRkJRamUO
X-Gm-Gg: ASbGncujUyntv4CqSrG2TfDO+guJXcsh8w4DXrXIQ0I35AI4JrjftFnr1ILX1OZIgzX
	v7rk7+jfKwJLGI4Y1vj6Yrdv88iq272p+f0edrtWxgStZqqku67LLkpH9lOyFl24nEsvpm6LeXL
	Kdm4skVXg6d/1aRGg2+PfeFSzbpE1l44NGFOeGK/yFwAOxzy5ReG5MJduyMUWkxK9FkrPCu6Can
	PEHEFX5op+a1kvwaD6F32tptdwGE1Ldw5K/55JMI6ySqtCPcX7DQNQf2iRjCF1mMt17AeCpXO6z
	bsiI/kk4cpe/DT5MvBnSY0b1314dYHZfNkH+pKcqDb3SdI127TUr4DWFAGkdaBRkcIevdLt4Jsr
	aFNKWHiAkcB+ojb7vdNKZ16ecAOm4mBRqNwphE5kzjpH/GKrSFIY8d5X9l/av0OQaAZ44jdr3Eu
	lRtDwxWBVBX4xjyUIo/f2J0yH6Z6JxepnXEO+Nljgg9E0qenaD2Av+
X-Google-Smtp-Source: AGHT+IEtzByVDUpfRwdPJhgEZAkt4IcyAqDRpceCKifmprijqsNezKq/3tRdzvxL2j+KRrl1ctujJA==
X-Received: by 2002:a05:600c:8b16:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-4792a4c0738mr6652335e9.35.1764702546145;
        Tue, 02 Dec 2025 11:09:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a4bd422sm3406265e9.2.2025.12.02.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:09:05 -0800 (PST)
Date: Tue, 2 Dec 2025 19:09:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Thomas Renninger <trenn@suse.de>, Borislav
 Petkov <bp@suse.de>, Jacob Shin <jacob.shin@amd.com>,
 stable@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd_freq_sensitivity: Fix sensitivity clamping
 in amd_powersave_bias_target
Message-ID: <20251202190904.27c9bc06@pumpkin>
In-Reply-To: <20251202124427.418165-2-thorsten.blum@linux.dev>
References: <20251202124427.418165-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 13:44:28 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> The local variable 'sensitivity' was never clamped to 0 or
> POWERSAVE_BIAS_MAX because the return value of clamp() was not used. Fix
> this by assigning the clamped value back to 'sensitivity'.

This actually makes no difference
(assuming od_tuners->powersave_bias <= POWERSAVE_BIAS_MAX).
The only use of 'sensitivity' is the test at the end of the diff.

So I think you could just delete the line.

	David
 
> 
> Cc: stable@vger.kernel.org
> Fixes: 9c5320c8ea8b ("cpufreq: AMD "frequency sensitivity feedback" powersave bias for ondemand governor")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index 13fed4b9e02b..713ccf24c97d 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -76,7 +76,7 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
>  	sensitivity = POWERSAVE_BIAS_MAX -
>  		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);
>  
> -	clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
> +	sensitivity = clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
>  
>  	/* this workload is not CPU bound, so choose a lower freq */
>  	if (sensitivity < od_tuners->powersave_bias) {


