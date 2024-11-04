Return-Path: <stable+bounces-89689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE809BB363
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812DBB23726
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E251BBBDD;
	Mon,  4 Nov 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNo3qFND"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AB1B0F15
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718932; cv=none; b=uSRso4fDxWSaxjWnGePubAuOWbTWe/7IKtjqlrLbf5ECN4a+8mg20RKDEMHb5ZV4szrCs12YGUJWgGi0unVcIKllRuCpK0npEiZ3qVDQTwMQI2eVFaZPZMPYN/KODC8hX/d/Fj8Z1iToILFI+iIgWTjEHUTeIiumuO3dfWI09wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718932; c=relaxed/simple;
	bh=8Pb8sCWqVT78PKsPAopEAxFND+meVGRZNGnRJZybrj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLDP9XwnhgKqHfUQ699se9Xp2mnLjka6ujBEqP21tfrN8dXneFDs2E8D34cgAi7hu7sOZbA7ThI5/im3UlWYj+Dap6OmtIU9/AIu/mzCOXDTBCEI9nT/kNGXt1BDH9unN9tAhhzQ5TEq0M4v+N4A612z3YmxxUe4w+LiURIHJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNo3qFND; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3040920e87.1
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 03:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730718929; x=1731323729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xH9DoC23Bb2/vYAIB0rsuoA8K2PG80L2HkKuDb8tLsE=;
        b=lNo3qFND51bxdP8OWa7VkbuldLEz45VHLKotjLuYucAcGPygm9IwFIGwDw1H6IVHoQ
         gr9Fn9fvqkdpkvUV8cMeJS5Tz+3olNlf4H3wSSe16AtnEVyWkzeE1Qd5sIwG3lL9/WOH
         VzxgTwQn/wKei/C6S4jFo/fiswOVM07RJS9LBL65+ZcwnPVjYvL0WR60SE1cHH3H3vI5
         YSN4ctq9Tae9hpOCk5wQUSqBAkcCpVsEH4CSN/FCgSKSuCTrljQmRy/BeWwO2oLjAorD
         i/SEz/QpkEekimVFUdF7K1pyVmszyLojiIrwijXGUXSQP4u0Ty7aWh5Y4mmuqmlNP97k
         2Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718929; x=1731323729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH9DoC23Bb2/vYAIB0rsuoA8K2PG80L2HkKuDb8tLsE=;
        b=YtqBDQTrLP4OMJRl4k7uXl6UFPzLFu/9aKcRTop+hItLMTVWHPn+D0HCteZvUx0KLq
         n9zvnfeNQPd99k273qcmCNcQPv3ZhKFDXKOnFXPt8TlBafEPhjXzVU9QuBHoQOaLCGL+
         pR59JfE71u3DNLlyc4qSmglXyE1yzqYf8RuZh1AHv+mTgz/i4r1zLWRLq78OFJR509ar
         u+g8QeFsaT/4dyaYMO4ZyDOFJN93c+f71EtfgGA9667Z7IzKCLMd4aA2GDHS2H3WMZkc
         b4CPSTS4b5Q0aEulSKn3x56QKr8/hfqXMOGenzYEXkZ4LnAc+nyrqgzYljE5Gmj1Jn7e
         Opdw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+zj5CEfzshLvUaWUduUnTRxsulJoj3pmCjPY508C9xJ5BM07d5LXlKCB3QrRtZWJG9JLXhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNNlXeYvHrqReZ/KOC2RhlcjsNCJVmMiu2G3b9yqeLpKzLiUq
	qc3MG2Mr3n5NsXhKi4c42E8p4J9NJnqOFfajjuOtJYdWEfQedOgRZXNQO96knwI=
X-Google-Smtp-Source: AGHT+IFEO+EDtDqFJQorDAHgKOspX3rc8SvNpXsw47ifoSIAuvGSd8clbgoZacNUkzbI2eHhD845gw==
X-Received: by 2002:a05:6512:308a:b0:539:8d67:1b1b with SMTP id 2adb3069b0e04-53b7ecf1ff6mr10243566e87.26.1730718928569;
        Mon, 04 Nov 2024 03:15:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc961dbsm1650852e87.43.2024.11.04.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:15:27 -0800 (PST)
Date: Mon, 4 Nov 2024 13:15:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: Drop reference to a fwnode
Message-ID: <wygsgyxczjwr5mxrmqoqloww4dp5ac22bxkor2y2elbxi7ifvw@b2mb3woxye5y>
References: <20241104083045.2101350-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104083045.2101350-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Nov 04, 2024 at 05:30:45PM +0900, Joe Hattori wrote:
> In typec_port_register_altmodes(), the fwnode reference obtained by
> device_get_named_child_node() is not dropped. This commit adds a call to
> fwnode_handle_put() to fix the possible reference leak.

Nit: s/This commit adds/Add/g , see
Documentation/process/submitting-patches.rst


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Add the Cc: stable@vger.kernel.org line.
> ---
>  drivers/usb/typec/class.c | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
With best wishes
Dmitry

