Return-Path: <stable+bounces-104312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1D9F29C3
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 06:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E306D1644FC
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1751C54BF;
	Mon, 16 Dec 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXRPzalh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F21C54A2
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328446; cv=none; b=VzsG2yz5yjWOoG7qSil4PR0O1WTVw4k8ZiTLFm+BeNDhtoOd/loRJgzeBpZUQGXg3nH1Kx/mq1m8ehZg3ZANJoAD/d5Vlfez8wkV19FCw72vXuNHh1SDw5SKJ/Zy9oS45qz5AwZUU+C72ijwmbxLSfhYrE86C/z2s8x9gdTO+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328446; c=relaxed/simple;
	bh=ZNP0v3/4BomZoAEvLGEv2cgm7ao+GyUKQDkAYpR1azM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O+tUJEwn/EuuzY/da4rUfucPkQdYhvSKMolcY2goKte0m0N8/+H0LlzCc6qUpEbZ3c1MqVDBRQDkotOfd01jkHeeaY1PZAB7jfRy5B9S13neVGn7YeeaL4apJevlYGbM8H907n4D9yY1N0zXkJf3UwDmcjJuVgJKpcpYhWXMUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXRPzalh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67f31a858so690872366b.2
        for <stable@vger.kernel.org>; Sun, 15 Dec 2024 21:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734328443; x=1734933243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+dFO3Ui/sEdU+d4tBQlNTeaAHc3ObDp+PAoFFR+kSQ=;
        b=cXRPzalhrzVQbg4p208Qo/iCamDAmiRORkhlNuTK2WsdFgrc3WFUxq4sVSQAWfnv12
         RD5tOMZchdnE6g+9EdRbA3dtOlWRQvtKkEPULAU0/J5uGXjLu3Zy+XBaQNPDRYo+bkMd
         PC38nJZ8wCnchHRMcg0noF/hFxpVyIJbnAAcYGYnnQA2MKdP/b1NeZVsCxlAbaoPS2jP
         nsnuC0wCOjH0cONf+HAdfUesp96AIxXrJoqCpE1e5IqAANj1ZGW582oIMqlK3/r+dgjs
         V4fbugV33XHmQJ6eBw1EP4KDuZUqAJC/RFJZxFT2ZnRDDswnCmQJehVUyWLNiKIyXvoc
         e7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734328443; x=1734933243;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+dFO3Ui/sEdU+d4tBQlNTeaAHc3ObDp+PAoFFR+kSQ=;
        b=CDSQYXYO5RMJ+ofIfuhHWKq115yuvOmylFPSjwkWLxB4Cm6/bSyE50WLDHmFSqjBQd
         63OInJYDktCJXR/HKt8JbTt6Yk6VNom7w+1Ha/h2F4sRKK6XpAOZy3OrZTMtagC+4ypL
         xwURtx+ovN1Qmb+jCsMUIwrR6WFkkkZj26peqnX3UuQ/mrMPwRgYtIb82qZfeGbmQdAY
         oIljxKmGpEu3XH/ufdvNLqKqRdTYaaXwdYsB9oZyVrF3Lqk3laS60OygooeBXqLFKXze
         NoY9CfzNBJba0gqcTdcTg6SAag56SrlLL3XI9YWX81rIt5ahhj3YavIgfztXSJjpoYuP
         gaEA==
X-Forwarded-Encrypted: i=1; AJvYcCXeOOI01rG+Xt846O51TlY3yJeu7COTvfLXHNCXO9O2PhkiyVFZrnbb9r6OO+kPh2PbrjwoWGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ugnXM+/+j5cC/C5KCMdHH1FAUVLvv/qEVmmX284zn1jClMqx
	XneZTw8ElOdBJWZ+8Mj4uTpHfE4gQES6pgTOYXeTXfy9ZTLvpGkkaIudGraEX8I=
X-Gm-Gg: ASbGnctWSw+1cWb0pwGitPsy4MJC3IcMOPPgQL9rd9M2M3xWINE1I26jUY4cn1LLVlD
	sup3AMNX3GciqtReTufDvKeZvD9QnsCVQ8k3Lto98QeWKwDebO32VU1trTKYpKXsVDV7JuOGd2V
	0r39zaAR+j8v+zX41R0jJZD0jU33tZRd185VedW+2vzK3yRQLZKB/bndsrS8gHbg2KFxAtXKN4S
	fUi0TSyEFutFMJrRkjSxbXKkLu4oKHibY+BF623Hbx08PRCh1s531uBzbfgTw==
X-Google-Smtp-Source: AGHT+IFoSvWSFfIldErFNpAMajYw9cB5vCOVjo6HVzQrtAlbPuyC5xoikuxSZeInpDkydeS20+n9Qg==
X-Received: by 2002:a17:907:7216:b0:aab:76bd:5f8e with SMTP id a640c23a62f3a-aab77ed35d6mr1120600366b.53.1734328443208;
        Sun, 15 Dec 2024 21:54:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006c2fsm286466466b.9.2024.12.15.21.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:54:02 -0800 (PST)
Date: Mon, 16 Dec 2024 08:53:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Vitalii Mordan <mordan@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Vitalii Mordan <mordan@ispras.ru>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: phy-tahvo: fix call balance for tu->ick handling
 routines
Message-ID: <f60184a1-fe12-4a7f-bbbb-e6191f673df4@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209152604.1918882-1-mordan@ispras.ru>

Hi Vitalii,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitalii-Mordan/usb-phy-tahvo-fix-call-balance-for-tu-ick-handling-routines/20241209-232934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20241209152604.1918882-1-mordan%40ispras.ru
patch subject: [PATCH] usb: phy-tahvo: fix call balance for tu->ick handling routines
config: alpha-randconfig-r072-20241215 (https://download.01.org/0day-ci/archive/20241215/202412150530.f03D8q1a-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412150530.f03D8q1a-lkp@intel.com/

smatch warnings:
drivers/usb/phy/phy-tahvo.c:347 tahvo_usb_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +347 drivers/usb/phy/phy-tahvo.c

9ba96ae5074c9f Aaro Koskinen   2013-12-06  341  
9ba96ae5074c9f Aaro Koskinen   2013-12-06  342  	mutex_init(&tu->serialize);
9ba96ae5074c9f Aaro Koskinen   2013-12-06  343  
125b175df62ecc Vitalii Mordan  2024-12-09  344  	tu->ick = devm_clk_get_enabled(&pdev->dev, "usb_l4_ick");
125b175df62ecc Vitalii Mordan  2024-12-09  345  	if (!IS_ERR(tu->ick)) {
                                                            ^
This typo breaks the driver.

125b175df62ecc Vitalii Mordan  2024-12-09  346  		dev_err(&pdev->dev, "failed to get and enable clock\n");
125b175df62ecc Vitalii Mordan  2024-12-09 @347  		return PTR_ERR(tu->ick);
125b175df62ecc Vitalii Mordan  2024-12-09  348  	}
9ba96ae5074c9f Aaro Koskinen   2013-12-06  349  
9ba96ae5074c9f Aaro Koskinen   2013-12-06  350  	/*
9ba96ae5074c9f Aaro Koskinen   2013-12-06  351  	 * Set initial state, so that we generate kevents only on state changes.
9ba96ae5074c9f Aaro Koskinen   2013-12-06  352  	 */
9ba96ae5074c9f Aaro Koskinen   2013-12-06  353  	tu->vbus_state = retu_read(rdev, TAHVO_REG_IDSR) & TAHVO_STAT_VBUS;
9ba96ae5074c9f Aaro Koskinen   2013-12-06  354  
860d2686fda7e4 Chanwoo Choi    2015-07-01  355  	tu->extcon = devm_extcon_dev_allocate(&pdev->dev, tahvo_cable);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


