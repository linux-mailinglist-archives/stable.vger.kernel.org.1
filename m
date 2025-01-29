Return-Path: <stable+bounces-111083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A449A2190C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C104B7A1112
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765F191F95;
	Wed, 29 Jan 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptEUo2jF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88A19C578
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139356; cv=none; b=XXrQdQDoBZqoD/GK5goCOgfNo3VF+wosnsLzNXerHnJH/SHr2c3XbepKd99dry8yNS9XRo4LCzAfdsORxIBjNLPgdVM2gbHG/ufIYB/YEkdhOip3U9/5ehdTZqCueI01QUtXFnlXlUFl0/KWN8Vw0wkDNZgz+aAN8n33Bpz7xsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139356; c=relaxed/simple;
	bh=t47Jt1mJr1ZEFW3Sbh3At1ibcmQelq74M+OiamMuqx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyvEkg8tcTOh/ztTk1Fnkl6goie4CEtT53twQri5ZvB884heNl43WCoptIOMkMcKawtA1kFVW+tI6qLkmrYmF5fwAUynHdJTry3TZyzsWDkpnkYPqnpZUixsdpTDAVAQo0seOfNjVulPFOSlsZS8I1HWV6JdAkdAqqsvE8WPsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptEUo2jF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a88ba968aso6397011f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738139352; x=1738744152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKiksHSFuAAjrakcNqTPfUehHuQhbKFuHBvvbO2o0v0=;
        b=ptEUo2jFg7bnBrlJwWiyKNa6GnR4yXrjz9PkLWn304dBegxHttXz3v1KM3Ples3Vzt
         fX20EuTjq5b9q9WhzOr3liyHuTTaY98fh69+MPqIR9EifT7phY4H31WjTGfnrPVePFua
         Iwn2bVbZDJ8KXO19naNpIe6R683DvStBwbEozvXU8m/j8W1b2czjpwSSygiWlJaEL7EU
         ZPjSp7LLOoV6z6l2WD9vaRgB+hyK1L0+c8W2pv1FmNfjZclAqixh08XvatPuq3sdQ6Td
         H5/d2ls8Y3L9vPNcxr/8OlrZYDQ2xzGvMpXIJDQN0RMBj7Shqu3oRdeJRe/f9Kve/i2f
         pdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738139352; x=1738744152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKiksHSFuAAjrakcNqTPfUehHuQhbKFuHBvvbO2o0v0=;
        b=U4lbLBaIBli9dz4lJGNWCLNsQKIsEnn41I2OyO8ATFnBAV6rd5c8zGbGUk95M25UhT
         1mOAOnM8jNVMjXjvc0zIdEHTFK5p2poPviHnQZe8DhZmcCchLnvNnU+RftiZhuuYhNPr
         Qn6WH++6se98AeYEqrlQ3jdnT6cgP9I8FxOx/5HoBXahPxnDlNxMlxNb3kBDu6FEoQTM
         uAszW/CrpeYe2Tx3OGulugDtg/eAAKUUdnW+/tx/Z8YElsdSyaR9ZgIx73fNzq8t8JC1
         0w5095tAhX+p5JTkO/nj9HRKmHdRThO41Wad4WQfh7Cq/qOfaFAVdNQcYpSMcFI6jzhM
         N3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWT300VO3m2Zx1EoSc3q8lddiVnwgpDSau0qSKv7G2Jqeyqke6RSkE+f2DVDeNf8U45+GiJp1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8NuklfUTvRextdwFgyJ3NQq3Zuw7rj/mod6ILHYoRYmRr3rB
	tAZLpzJr/1Fvqjg7CjiyMupYEbMuAtbmONt3WcVZi7ntgbE/N+K6CLPi3aDNY7o=
X-Gm-Gg: ASbGncsk5J1qmqDPQfLZlSSKrVp1Ow4bQzsNq0EWNo2d1ekjkO8ghsGM7geO8JE0vIW
	J/IiDf5NHkaYmkr9xUhB98Oh+dK6hd6uIj8Ddq22/xLWrBeNDpF3BqBqNG/KoDF76pTZXmjtAeT
	xCf6XlEV3cWjjz5+CJoTi/Oh0UfSb/2fw7seIlgzJ1P8toRcIzktJC3gFP07HHjY/4LQAro31KJ
	BwSfdL7kfx+JB1l6/kNU5V9rhZ7/o5w8ztqsK2RpQi+QDLvJRh973Pm1PUOFZHDv2OKcbs2AAGe
	ilbrpX8nS1twzNVhwN/zZxJP
X-Google-Smtp-Source: AGHT+IEXDkM8D6MT76Uvcn8vTyUyCQaCHOWf8pXTJKZqe7zTUpPIwe72VxUoj9vIWkt8vhTwJeGC8Q==
X-Received: by 2002:a5d:5f56:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38c51e957b9mr1485041f8f.36.1738139352191;
        Wed, 29 Jan 2025 00:29:12 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2c4ddsm13950595e9.17.2025.01.29.00.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:29:11 -0800 (PST)
Date: Wed, 29 Jan 2025 10:29:10 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC] soc: qcom: pmic_glink: Fix device access from worker
 during suspend
Message-ID: <Z5nm1kQk5nXwSRvt@linaro.org>
References: <20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org>
 <Z4UENSdocAo4uNjg@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UENSdocAo4uNjg@hovoldconsulting.com>

On 25-01-13 13:16:53, Johan Hovold wrote:
> On Fri, Jan 10, 2025 at 05:29:51PM +0200, Abel Vesa wrote:
> > The pmic_glink_altmode_worker() currently gets scheduled on the system_wq.
> > When the system is suspended (s2idle), the fact that the worker can be
> > scheduled to run while devices are still suspended provesto be a problem
> > when a Type-C retimer, switch or mux that is controlled over a bus like
> > I2C, because the I2C controller is suspended.
> > 
> > This has been proven to be the case on the X Elite boards where such
> > retimers (ParadeTech PS8830) are used in order to handle Type-C
> > orientation and altmode configuration. The following warning is thrown:
> > 
> > [   35.134876] i2c i2c-4: Transfer while suspended
> > [   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
> > [   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
> > [   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [   35.455242] Call trace:
> > [   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
> > [   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
> > [   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
> > [   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
> > [   35.478659]  _regmap_raw_write_impl+0x780/0x944
> > [   35.483401]  _regmap_bus_raw_write+0x60/0x7c
> > [   35.487848]  _regmap_write+0x134/0x184
> > [   35.491773]  regmap_write+0x54/0x78
> > [   35.495418]  ps883x_set+0x58/0xec [ps883x]
> > [   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
> > [   35.504223]  typec_switch_set+0x48/0x74 [typec]
> > [   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
> > [   35.515712]  process_scheduled_works+0x1a0/0x2d0
> > [   35.520525]  worker_thread+0x2a8/0x3c8
> > [   35.524449]  kthread+0xfc/0x184
> > [   35.527749]  ret_from_fork+0x10/0x20
> > 
> > The solution here is to schedule the altmode worker on the system_freezable_wq
> > instead of the system_wq. This will result in the altmode worker not being
> > scheduled to run until the devices are resumed first, which will give the
> > controllers like I2C a chance to resume before the transfer is requested.
> > 
> > Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> > Cc: stable@vger.kernel.org    # 6.3
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> You forgot to include:
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>	
> Link: https://lore.kernel.org/lkml/Z1CCVjEZMQ6hJ-wK@hovoldconsulting.com/

Oups, sorry. Will fix in the next version.

> 
> Johan

Thanks for reviewing.

Abel

