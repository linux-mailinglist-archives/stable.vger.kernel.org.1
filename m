Return-Path: <stable+bounces-94109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB39D38BB
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF862841E9
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6F19CC1C;
	Wed, 20 Nov 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I8IbUpIt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FE15E5BB
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099878; cv=none; b=U3G5ceQNIUPDN2Ula5iY052UMoQwN8mN0fcsaYD3nlGaV+3cFckwfXoknsa17SEfdGi6AqUyLt3GlUEwJ9JKkXRmVl4NKMAUhRvJDIN/LAB0x3TCw5rQ3xgj+/9fdoIsE+Sh6m8+hUbUotg9c6CUswwhr05OXi7RHuK+Xh/bLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099878; c=relaxed/simple;
	bh=VIF+FyOXBpj3sl2QYpLzeSBurqwwz5+qcTwPTBZyBPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO8I0dWcKGCZFZFBm2L6Rko+0mb/ft42r8HmDSvVQDU4oLgBkm1qtzoF7MmbUCxwphSA2+YSyi9FjiWTLYiWkcEesUiXbzCb8LsoUngidr+5y3vCEh0rh+0arnkqJAAd4vbTRuGF84jKVp0pJKzD0z/TZUeiagjzzErOMoLX680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I8IbUpIt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f84907caso2601087e87.3
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 02:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732099873; x=1732704673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSV7n5uieMGLxmtC3IgusnUCWfo7HJvEXUUz/yMf7DU=;
        b=I8IbUpItUZ2bk7+xYmtjZXvwPrZSAQ1NANyTGib1dESYcPxTZDuX1qlyeBkXtKyZ98
         oQYmn1mVj0nQjRWkx5kavYD6aElmbkutn2pIsvJ9W4leJclqO05smMhM6kVCg0mudI06
         rXpqsrU0To1CkzzBDwh5MuUFY7AEEa3mZUXAprlWcmnC/I3pI1ZzykeIEybI26F+Vcpi
         CszLNXvhCt55fEU/Ui1ImnlzlzltgwhJm11Y2RN2Z7o5PQ0M5erZ23PahCyawtYysgem
         wqMLqL8rqAg8+GO0Eahsy8APVxic75DdF3L+aZevS50SkYEc9faw9nRhEBLbBbLczpu+
         KS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099873; x=1732704673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSV7n5uieMGLxmtC3IgusnUCWfo7HJvEXUUz/yMf7DU=;
        b=j3FYQbEizgqSBagxAOIIdHdjxUBpV5e8605bWAp0ni3wm2HvmlOR87A3domaZ8KNcc
         QLusPlbOi6OxYNZ8b0yjoZ0jT6OUZqFDrZpOvgOMES7EMuBRAStCWwAwZzmQiJart0rt
         a1t9sjeIlLF3g5wus1vJ78W5LBVBL6k/lHpXXxaUtTcuNL0PvIh0osLZMqXFskKjmXJC
         8qz+9eyOs3IRTTa0jh8bT7FutMYtZQSfNRhbtF9c6nYzAllByoCXRmN3otRHpxBfJWKf
         XOY+biJRqvmSEVW9uU3NjTOLnex+a+dp0L0dYZ49Y1UAvxMskwn9BFHUwi/78pnpMuV2
         kBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yAt7zNF19xGbBLHTbqnV7kxoTS6PE9DzPrNU/Y4Pc8xlEzPuwKuQfrxFSQKP0tKNaW5p5oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXpEZUMnL7VaST6D8lqSnYIEmTHefqsYT3cgpiml4nxD+dacL
	H5MS1rSafwzhq/Z3ucxLP2IgN4ZDtsxJoR2ju6ikrlcy+mgpkWyY1vvYj7MBdfbi/0/ZvHv7Jda
	ttusaWZoHswdO1vRhX0hL9EQImp2MnBEQzxTNDQ==
X-Gm-Gg: ASbGnctKRn7Sh3hMsDceQIkSzVNsBWLl+ejQyTpus5wkkwCr9Blz1riMXVBpkxWdxCk
	taBLMtU0s3ChZTL/GgXxrNc6c4nVbAJW1Pp8xjhLueShPsJP4J/BInMcvzMkiFg8=
X-Google-Smtp-Source: AGHT+IG6xl5NREy8BcJqWnYoAnnJiL7QZi758v8u/j5cG6idLf7Odlp0ZZ7OhsiP6+n70jhs7IKE2YUkjsAHV4d9P0M=
X-Received: by 2002:a05:6512:2253:b0:539:e4b5:10e5 with SMTP id
 2adb3069b0e04-53dc132785cmr944137e87.9.1732099871923; Wed, 20 Nov 2024
 02:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-1-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-1-7056127007a7@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Nov 2024 11:51:01 +0100
Message-ID: <CAMRc=Mca41Ob=QzAMgz-aAhfzmBZq3=HyLr=D7_rbaZ3H5CqZw@mail.gmail.com>
Subject: Re: [PATCH 1/6] firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, Andy Gross <andy.gross@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Commit 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq
> completion variable initialization") introduced a write barrier in probe
> function to store global '__scm' variable.  It also claimed that it
> added a read barrier, because as we all known barriers are paired (see
> memory-barriers.txt: "Note that write barriers should normally be paired
> with read or address-dependency barriers"), however it did not really
> add it.
>
> The offending commit used READ_ONCE() to access '__scm' global which is
> not a barrier.
>
> The barrier is needed so the store to '__scm' will be properly visible.
> This is most likely not fatal in current driver design, because missing
> read barrier would mean qcom_scm_is_available() callers will access old
> value, NULL.  Driver does not support unbinding and does not correctly
> handle probe failures, thus there is no risk of stale or old pointer in
> '__scm' variable.
>
> However for code correctness, readability and to be sure that we did not
> mess up something in this tricky topic of SMP barriers, add a read
> barrier for accessing '__scm'.  Change also comment from useless/obvious
> what does barrier do, to what is expected: which other parts of the code
> are involved here.
>
> Fixes: 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq completion=
 variable initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 72bf87ddcd969834609cda2aa915b67505e93943..246d672e8f7f0e2a326a03a5a=
f40cd434a665e67 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1867,7 +1867,8 @@ static int qcom_scm_qseecom_init(struct qcom_scm *s=
cm)
>   */
>  bool qcom_scm_is_available(void)
>  {
> -       return !!READ_ONCE(__scm);
> +       /* Paired with smp_store_release() in qcom_scm_probe */
> +       return !!smp_load_acquire(&__scm);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>
> @@ -2024,7 +2025,7 @@ static int qcom_scm_probe(struct platform_device *p=
dev)
>         if (ret)
>                 return ret;
>
> -       /* Let all above stores be available after this */
> +       /* Paired with smp_load_acquire() in qcom_scm_is_available(). */
>         smp_store_release(&__scm, scm);
>
>         irq =3D platform_get_irq_optional(pdev, 0);
>
> --
> 2.43.0
>
>

I'm not an expert on barriers and SMP but the explanation sounds correct to=
 me.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

