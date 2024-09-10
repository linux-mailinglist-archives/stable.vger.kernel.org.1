Return-Path: <stable+bounces-75668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579E973CD1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0DBB24C1E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D8191F97;
	Tue, 10 Sep 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3x8CKq7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB619DFAC
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983916; cv=none; b=V1yUOjCJihnMbmRKVLslwoEU+sYFoOq5JsbDgNDgyY6z1DrgsB+NxMBW1OhnrCAg9so0m6yPA+l9nHZGb7U2UIbyqiqpIcYk0k/6vf6UfR4GDhY/ITlQxkxEfebUx99zM8W1GdtoVQ9GZbEcNF5rIoMzBA88Kv3+aUw5jGEyaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983916; c=relaxed/simple;
	bh=waCU2jDDEDF0qHU7SHYQUJ70NKH7/AOilDEm1t63zZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPFhAm+B0Fw5ofW2v98CEVST+k4nzHD7MxtdU77esREL7UZrUON3h/jjMQoIdLqxEUijBJtzzECVeLomV7oxuwzF4gMdDEe+K6ehb4diwJiqulehVJBb0nZ4/eHTztpNnnVA7LceOB3ldJQHkH/0/N35Yfkv/2PvVm08321AgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3x8CKq7; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6db20e22c85so49010837b3.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725983914; x=1726588714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K03CEStCS7OzeEuh2GXUxQfcpo5LpeDMqzG+Osvdl9Y=;
        b=R3x8CKq72ncTTbEDUthj/Y8JMM3ppl47a0vKnWazGMrrfe70jr+BCfXnWovIEhBpP2
         F7XPidZfKeA86J+t+9NGUyG61TuBl7bRa6gJvSQdC5WJf2tTDSKr7KeYQUf6TrAFkSOg
         wAzJCEs3hvvNjKilqLuVCMUKMQaalYURf5s7ZJ/Il8fBnCQIzWyqrzbAg9Io3WUU3cxA
         Ml1dt9hY7EYrtXeqFBRorLHQwwT/WatEGQ6+C9vym/hpea7CLwWpqBnCRRnZzhmy3gVr
         WeEMX+VOvZPfoZ6M/EnujgEzJ1SjJ/MfCpBIud0Q7EHULwozb3QMNLSPZ3FAbrbNKiiC
         nOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983914; x=1726588714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K03CEStCS7OzeEuh2GXUxQfcpo5LpeDMqzG+Osvdl9Y=;
        b=jXNqa4PykIWUGPeBhiTG3Ki0wukYOx6ggEIXs9cCyZ/IobYiNHRwuXoXx2uORoahgV
         rBL33pNlZ4mSn19t7HjOzjPWkkiU/novZBDC8gPl/96FdCsNiArJXvAMw28roRmj2k55
         eBzhCQ1VP5s2PvnUmKc0yXnQbdETxYdDg8DWk/XQFw85ZlRV4vHq3iauOhVlzTq1muzn
         IEMwu4VVFFA999WaIkP3ogCCMVkzT6sHQTel1xCs8//NeCY67CiWNUNGJSFr/W4fahIx
         hXOLb7oHqKYz9tLoBJhZd/YwRF7z29WdNz9gijAl3mBS7S6vrCJwFzp4GQDFRa7U6e/s
         k70w==
X-Forwarded-Encrypted: i=1; AJvYcCXCdbElod6b7XT68Y9QX/8cV3WNT9rfcT8fX0GBHBWRh9EEXXvMhqsx+UgLuxRPRrSc3pug8lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQO5mgjk2ehPaWziCE0dJ9GwBFfHgtD+E4WFtYE8L9PjaQeYW
	cA4RYO8po5FfKsZqhucGwmqAzyfpLUkEAuy+0n/k9AMllB1YqFg2N2kIH8GWkBXXI2URpfFkk3K
	LUcU6NY5Pf1kcLub6JPoHRhtbyvs=
X-Google-Smtp-Source: AGHT+IHYfaFhEtBDGG0Rp64d0TpdLekUefvynuGeN+/HpBuSa2LJ9+64seMuVeEJHms6eG8FddELzdUVFEcBfQS6cRM=
X-Received: by 2002:a05:6902:2b0b:b0:e1a:8026:e71b with SMTP id
 3f1490d57ef6-e1d34a2c853mr13933179276.54.1725983914269; Tue, 10 Sep 2024
 08:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910151839.169699-1-0x4rd1@gmail.com> <20240910151839.169699-2-0x4rd1@gmail.com>
 <CANQsBiffhRB7RyuMMD=eDqBZE-2TcG0X+7i4HyFs_Z3oEC39Ug@mail.gmail.com>
In-Reply-To: <CANQsBiffhRB7RyuMMD=eDqBZE-2TcG0X+7i4HyFs_Z3oEC39Ug@mail.gmail.com>
From: Ardi Nugraha <0x4rd1@gmail.com>
Date: Tue, 10 Sep 2024 22:58:23 +0700
Message-ID: <CANQsBicMqm296TGTOxZ2+Q6PhMZxvi6pHhvXb8qZx8v7CFrR_Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] clk: qcom: clk-alpha-pll: Fix the pll post div mask
To: ardi.nugraha@provenant.nl
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, stable@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, it was a mistake. You can ignore it. Thank you


On Tue, Sep 10, 2024 at 10:47=E2=80=AFPM Ardi Nugraha <0x4rd1@gmail.com> wr=
ote:
>
> Sorry, it was a mistake. You can ignore it. Thank you
>
> On Tue, 10 Sep 2024 at 22.18 Ardi Nugraha <0x4rd1@gmail.com> wrote:
>>
>> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>
>> The PLL_POST_DIV_MASK should be 0 to (width - 1) bits. Fix it.
>>
>> Fixes: 1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> Link: https://lore.kernel.org/r/20240731062916.2680823-2-quic_skakitap@q=
uicinc.com
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: ardinugrxha <0x4rd1@gmail.com>
>> ---
>>  drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alp=
ha-pll.c
>> index d87314042528..9ce45cd6e09f 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -40,7 +40,7 @@
>>
>>  #define PLL_USER_CTL(p)                ((p)->offset + (p)->regs[PLL_OFF=
_USER_CTL])
>>  # define PLL_POST_DIV_SHIFT    8
>> -# define PLL_POST_DIV_MASK(p)  GENMASK((p)->width, 0)
>> +# define PLL_POST_DIV_MASK(p)  GENMASK((p)->width - 1, 0)
>>  # define PLL_ALPHA_EN          BIT(24)
>>  # define PLL_ALPHA_MODE                BIT(25)
>>  # define PLL_VCO_SHIFT         20
>> --
>> 2.43.0
>>

