Return-Path: <stable+bounces-123094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F775A5A2C7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1492F1744B0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80A231A24;
	Mon, 10 Mar 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="aDQAMiwK"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253C2309BD;
	Mon, 10 Mar 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631025; cv=none; b=BGo19Vh0bwA76kkjIYsS23ANPec1pNhDuOLcScGZlXeYhZRAZ5zIGkanVrRw04o2LotDk8KMfBdqZAy6Ql1jZuefufnsMWfJVo6exGkh8nA0pBzNRP0GyRouIoeWrGvgIk/5t1BNJvPC4HRp53AaaeT9Mz+CDtDupTLRMC6bxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631025; c=relaxed/simple;
	bh=8h/uiU16If6NruzF8ynG/tGThQGk0I+HF/byzjcy1pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnGFd4MuGl29s76ex7t/bUfZ2fES89X/qK1M0u6wt2GaQF1AJTdFr/7IeDCNHCmQgElqlEsTFOZYSh/OwcMhPWqxqVYjq8L+6VjD5NzOx0xAqvJ9P7gSUQ2Z90EtNo6+nQFj59J1w5FohApwwoPq/tt66nfaou9GtwCoOpGeC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=aDQAMiwK; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6D5F140CE18B;
	Mon, 10 Mar 2025 18:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6D5F140CE18B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741631012;
	bh=J9WgnNk8hsJqucJXyV7OVTWvviSo1PzyLdaWKwbmS6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDQAMiwKnUsInpKrImOsgUADu1a87Mys1J5sBBz/s9yCHBo5sX+KP2t2K5NH2zzB2
	 /etkaY7/rdkKB5LfEDmDk35MoABlNOzSRqfwSokrrq7wCplaB3wMEQV7VnzlZcb2er
	 WardCxs7Xv7IvNb/G1zhCdGQwviVFEbBGtIltczo=
Date: Mon, 10 Mar 2025 21:23:32 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Frank Li <Frank.li@nxp.com>
Cc: Peter Chen <peter.chen@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Sebastian Reichel <sre@kernel.org>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: chipidea: ci_hdrc_imx: disable regulator on
 error path in probe
Message-ID: <lbsj2h2zut3eafu5vy6ysuv4y7xjuqtemovqtg3lzuyhp6fjbl@4xwikb3bxl7k>
References: <20250309175805.661684-1-pchelkin@ispras.ru>
 <20250309175805.661684-3-pchelkin@ispras.ru>
 <Z8781hzSKJ5P0gBe@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8781hzSKJ5P0gBe@lizhi-Precision-Tower-5810>

On Mon, 10. Mar 10:53, Frank Li wrote:
> On Sun, Mar 09, 2025 at 08:57:58PM +0300, Fedor Pchelkin wrote:
> > Upon encountering errors during the HSIC pinctrl handling section the
> > regulator should be disabled.
> >
> > After the above-stated changes it is possible to jump onto
> > "disable_hsic_regulator" label without having added the CPU latency QoS
> > request previously. This would result in cpu_latency_qos_remove_request()
> > yielding a WARNING.
> >
> > So rearrange the error handling path to follow the reverse order of
> > different probing phases.
> 
> Suggest use devm_add_action() to simple whole error handle code.

I'll try with that in v2 then, thanks for suggestion.

> 
> >
> > Found by Linux Verification Center (linuxtesting.org).
> 
> I think this sentense have not provide valuable informaiton for reader.

Well, that's a line which the organization rules specify to put into
every bugfix patch found on its behalf. I must follow these rules.

Btw, you can find this in the changelogs of many other commits existing
in the main kernel tree:

$ git shortlog --grep="linuxtesting.org" --group=format:""
 (859):
      kernel/range.c: fix clean_sort_range() for the case of full array
      Staging: pohmelfs/dir.c: Remove unneeded mutex_unlock() from pohmelfs_rename()
      USB: usb-gadget: unlock data->lock mutex on error path in ep_read()
      ...

> 
> Frank
> 
> >
> > Fixes: 4d6141288c33 ("usb: chipidea: imx: pinctrl for HSIC is optional")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index 619779eef333..3f11ae071c7f 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -407,13 +407,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  				"pinctrl_hsic_idle lookup failed, err=%ld\n",
> >  					PTR_ERR(pinctrl_hsic_idle));
> >  			ret = PTR_ERR(pinctrl_hsic_idle);
> > -			goto err_put;
> > +			goto disable_hsic_regulator;
> >  		}
> >
> >  		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
> >  		if (ret) {
> >  			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
> > -			goto err_put;
> > +			goto disable_hsic_regulator;
> >  		}
> >
> >  		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
> > @@ -423,7 +423,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  				"pinctrl_hsic_active lookup failed, err=%ld\n",
> >  					PTR_ERR(data->pinctrl_hsic_active));
> >  			ret = PTR_ERR(data->pinctrl_hsic_active);
> > -			goto err_put;
> > +			goto disable_hsic_regulator;
> >  		}
> >  	}
> >
> > @@ -432,11 +432,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >
> >  	ret = imx_get_clks(dev);
> >  	if (ret)
> > -		goto disable_hsic_regulator;
> > +		goto qos_remove_request;
> >
> >  	ret = imx_prepare_enable_clks(dev);
> >  	if (ret)
> > -		goto disable_hsic_regulator;
> > +		goto qos_remove_request;
> >
> >  	ret = clk_prepare_enable(data->clk_wakeup);
> >  	if (ret)
> > @@ -526,12 +526,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  	clk_disable_unprepare(data->clk_wakeup);
> >  err_wakeup_clk:
> >  	imx_disable_unprepare_clks(dev);
> > +qos_remove_request:
> > +	if (pdata.flags & CI_HDRC_PMQOS)
> > +		cpu_latency_qos_remove_request(&data->pm_qos_req);
> >  disable_hsic_regulator:
> >  	if (data->hsic_pad_regulator)
> >  		/* don't overwrite original ret (cf. EPROBE_DEFER) */
> >  		regulator_disable(data->hsic_pad_regulator);
> > -	if (pdata.flags & CI_HDRC_PMQOS)
> > -		cpu_latency_qos_remove_request(&data->pm_qos_req);
> >  	data->ci_pdev = NULL;
> >  err_put:
> >  	if (data->usbmisc_data)
> > --
> > 2.48.1
> >

