Return-Path: <stable+bounces-169702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96BB2785F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 07:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EC01CC26C5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F982472AB;
	Fri, 15 Aug 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtuuhoFu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BE2236F7
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235401; cv=none; b=p7EpAH+6GWh0uQ2Dr5nr+oxlPYmMfbPrPMBqt2ZqufRqFE0c17JkztpPNd5IzMNl2X18aQGoOhA1xfwblS35ShbA2AYBm7q5IMZ3dojVIMsF37dlCojh36MRVWx6x9G6Kc0AmkilDjbs+KltQ59BvFiUDmC2P/OGVNcY2bXEEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235401; c=relaxed/simple;
	bh=V8Ueiz1xSXHXEvy644YzyjPt8VCpS+xcVARVvP0U8mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huXILgwiuwQHqszHZNQ+5ZAAKQXv9lyDw3ZK51l+H8V6uKVVxlqDDmB38VFACwMnxa6PkuXkz6408Vuy/EqecbrhJaGAzcV/JuLSYTfiDGOJnWuxgbD+ZHNMC83wLGn0MZDTTRPOgR4L0jylZFkGroUKFfqKzrht1X3eEn2j2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtuuhoFu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so9224485e9.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755235398; x=1755840198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=xtuuhoFuSK0LVpxWBSNYcavSVu3GYNnd74SrfkD2wQjKhlAsrHl+pVUSbaCdBgtNDr
         YKfdKFrzGBw2wmODl/ibp+ilud4hPWrTdrB49mpoQVxwo8mbgyMVFzIf46PvM19KvUsk
         hhDWVFIv6HhHc+6V3F9S/XdGoz2dhOl9hzbuMLPQZhzbvUKeqRoADnAgDWzLImTGvex+
         7zkoMfeCu5gbb2XUaylN3HAHGv3dRkHEguRf3ChLw0HsHKh10eS81OSD8MyX6yjl/Qpz
         1m5OJ6Bp0idmKRfQtzV6rwlHJ+KjR3xltHghPt4Wdu1YgHAj57jkCqzoK/0YVHLl8y7n
         9Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235398; x=1755840198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=wcwKDZv89HAFvXaWfq9GdGhm6JhAC7HUQH1vx4XTYE4lkcJ/dIs3bPAoPjxkVS2isR
         mJSxwxSZsZ9xZUtgcelp953v+Jf8pGBsNyqjYOMT4rBbDaJ/sEGBL9TvdDdmU4kI+gE9
         OyyOWQI7JtJENePj7uPmsZsRYY5/n824auO4+vsJkvCpRx5t5RBO0YTb2O81HpiGfE06
         n3S9WYwwPAlRHLJfdNTn8s07AQgdshHPFxL/d0lUZnIKcZyXF3cTFpATM4O9NEfyX0MS
         C9fRpHefNwTq1UprsZdbqafAR99jGiKUhcEndBRy9BYaJWjs6PfDCI2wHKY5NKaebu/l
         ELCA==
X-Forwarded-Encrypted: i=1; AJvYcCUHbzzIQeHOIzfYsg+qIpBxlJh/7+KeF6OaUpIoMvZ4GqdftCzx/igGqSco8ZGm6636HtiLkgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxqv+DRjB83akQLTLEpJPDF+VQA3+G5uMjM18UDNmVpZEsr2AU
	kRzINLABrkASoU4Eba8laUoBwoYbr2R5SXXfSPIifrNZadX1pQiFGyUdgWbNRqQYBAo=
X-Gm-Gg: ASbGncuzYrszRtu5aNOedOGCPT1tFliwXsynRxvfQTX3pfrUqn2HFmiIiT0XlQvcILN
	uWvMk8JvH7bK5JglBrMcsfLrozHiIW75HbpJN1+tT0P/5hfIRlxLW10mVc1V/dBpktx3hnkQSjf
	N7Am8T0MiIQ0IeMGciDp3AZ2jajUM7hucc173WM1XZQB1JNKf4+G9YFh+FjZNabGV4zx1jdXHW4
	DniaZnXxPctaOiNM8sMVV/63PyjFevmx0FbJcwvD6TSNI2m0K7VicanVqSlarrTkmsyHQ6KJmrx
	/zMYmya+t+gc1tuBwF1O5xqEYTkTkHdhY5HFrsSPtKoaFTFrIArXFfqLHHYX/kxCJ800wm5i3jB
	UML/kcm4PoBzgyqZmetFJl2ZPkNFgFvmaG7vKiYcs8OarbAuDOIhK7A==
X-Google-Smtp-Source: AGHT+IGFNhJOx/G+JoNt5kMjzVx46v4txqtKecbS9qJlHx4GlX6Evp2HRHELTQibK/pD8aO0fgDabg==
X-Received: by 2002:a05:600c:6095:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45a1b66e4b5mr46968775e9.6.1755235398079;
        Thu, 14 Aug 2025 22:23:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb5d089e07sm678141f8f.0.2025.08.14.22.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:23:17 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:23:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bert Karwatzki <spasswolf@web.de>, Jeff Chen <jeff.chen_1@nxp.con>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Initialize the chan_stats array to zero
Message-ID: <aJ7EQZFT4rx2Tnj_@stanley.mountain>
References: <20250815023055.477719-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023055.477719-1-rongqianfeng@vivo.com>

On Fri, Aug 15, 2025 at 10:30:50AM +0800, Qianfeng Rong wrote:
> The adapter->chan_stats[] array is initialized in
> mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
> memory.  The array is filled in mwifiex_update_chan_statistics()
> and then the user can query the data in mwifiex_cfg80211_dump_survey().
> 
> There are two potential issues here.  What if the user calls
> mwifiex_cfg80211_dump_survey() before the data has been filled in.
> Also the mwifiex_update_chan_statistics() function doesn't necessarily
> initialize the whole array.  Since the array was not initialized at
> the start that could result in an information leak.
> 
> Also this array is pretty small.  It's a maximum of 900 bytes so it's
> more appropriate to use kcalloc() instead vmalloc().
> 
> Cc: stable@vger.kernel.org
> Fixes: bf35443314ac ("mwifiex: channel statistics support for mwifiex")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Thanks so much!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


