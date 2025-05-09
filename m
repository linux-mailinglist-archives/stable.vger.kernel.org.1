Return-Path: <stable+bounces-143058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C8AB184D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9561C01A47
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E522E3FD;
	Fri,  9 May 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwI0oqjq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F722DFB5;
	Fri,  9 May 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804116; cv=none; b=PKwZi3Bd9H9kcQmdilEgpd57f5Ic2tsTLDJUtOak0JmfPuDsEAPhiCkSpaUn9VWzQJNxykfc79Zy58BK0GHBaP28DyjkUEUxOQzdVHL0gdXktXuBzGq6bHOj/nUWalg2un4O7aDN8BcCCeN5lYia0cg/i98BH5VdYw7/IKFw4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804116; c=relaxed/simple;
	bh=k5UzwdEIIrmvxUov9XkUusHPM1sboqhDLvvgIyBipt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXXJ1Ogzz9B7pb183FHeI0+Y6jSpCLW+kvy/ovNRFEDtHhBVU+ttNL/CgOLhaHTCRomW7pOkI4698Cep2Wdby2Vj/OVarm2YPCC9eJXx9amVO8Onbvdbm6FPkOKsFM1EzBtcJT0oeg8DRP1zEPehvd4sEWVTJIEfGEx5LlsauRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwI0oqjq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so22080565e9.1;
        Fri, 09 May 2025 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746804113; x=1747408913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tOsD4QdQ355aBRffeibb02UxNOWzYSRiYz7WiMU9zg=;
        b=fwI0oqjqBFefUvMbc266Ilr/N8e+VZoDsoNLSTf0R/Ukhs3mteiaLhEWkNcD0Ev5+d
         Gm4TjZn3vuP6KG4Ge3I0XFFyzCzw1wzcUmIoAXbQPQvaruKIibX1Wmjxv3CtuenXM3EN
         lpgx5/YC+K+wE0PZFxl4EXdgZF/VdgdpRYk1PQtI4iV8gPV0DsWwU2Ht8rKfNiMmZumO
         gLF5jjhbdlouCa0jF5HEF1TARbISjcWK4aUm4eX+BF19bf4uM/FhIvMOgvDkWLwmKOiK
         KXc/qv76R3fYL0yS827aqiIx7t4CgHPpOOdHpchTOCE43i9agHuzW3es1ffo4+5DNN+t
         hHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804113; x=1747408913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tOsD4QdQ355aBRffeibb02UxNOWzYSRiYz7WiMU9zg=;
        b=RYVMs7jzYMk9T22ecLa9iko2kZu9nKNbyVQUvPwE25H6+VsJjGwkmgbllDMZRgXnsL
         u8FwDjdiAVz94vDqi/tvcbJmBE3lgrwshph299G+R7ZUy6P5cRp1jqnzN6Ac4bKDidCG
         QMpx99IFa/XsPdb7B833OerBvaV8hOHrVvot4aUWlQujUiLQjGpowcwS2+lhfT0984MO
         WFQs4gvWfaPcYUSo/yYz68JaeeE0/B5CPzvkt4ctxHeF8O8E4FVVAqfha0lenG5HmxKh
         LqAul7tPn4Ev77eHzBOZaEKC9WlTQzerAMnpJgwegu/Ax2W1hHQTrbGvF+Ay3OL6gA+h
         560A==
X-Forwarded-Encrypted: i=1; AJvYcCVG1GQvD/7LldHsRvYzE1v1T+21B8QdzYqtEpFLU3wqlOuDfXodofeydsOBf8tSJ76vQBhKZ1FfxoaY@vger.kernel.org, AJvYcCVksbgk0b6JX0GzLDk1D/z7xybqeXlXoxyDxK8ojn5JgsuTvlDn/zdebmNYiyy3Am4LIETDPy0cYd3q5pw=@vger.kernel.org, AJvYcCXBpjIPCzIqxgY94DcZN9JDxfHPFP7+K0LQoDVJOeTUeas+usWkrQmkh+JWdMfZKNL7ewTxa//1@vger.kernel.org, AJvYcCXsx8LjDixWmf0iJeOOBrkkjcMY/YhUKZllDcNUqqpBanr39UkRzZLTHnnWK5dwqyY2FLDnvC9F@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfM8OYjT47zlz/IdbxNcAwD15pI/WDdX+kHH9iblQbrD7cm3R
	Of02UQ5HYeosNJu/pjdMsUHMuUB/CHRSUWfZIDpMRUy56Tcc5gb9
X-Gm-Gg: ASbGncu9ke1DaBaayposRlK4irWgu54UAu4Lzo9v3KRsd/Dc4Np3XThGniKNndJ1KDC
	vRzzFP/zXe5wye9wOxpwmODXnUFKElS0q/vjtFwaWjbzqKfIW/ZlxCMABQkevh7uFYv/Iz4R+z4
	JT5518hitkJX5mKSUDoQmko7fdBSpodEzgAKbtwJvCiq9ODSjrmtDza0ukYZ3ju+St5NAahpFDc
	dfeHs4YfibopLM7c+eD4TuI8kSavV3IcPPqwsOGK8tYRcsU7LqNzSDGtHh4kD/RvYxLWnHVr/eQ
	m21l2L9xXx6vX4DPfQ5Kk8HfUnyGCAtiGRqESew=
X-Google-Smtp-Source: AGHT+IHEOyFXn66CSKxxWnTxT9CEp/NFoLemSgUDNyPSSehwGFiFWxFpyOY88TUnCFKiOXrRJY19jA==
X-Received: by 2002:a5d:5f8f:0:b0:3a1:1c38:b588 with SMTP id ffacd0b85a97d-3a1f6487206mr3257217f8f.41.1746804113307;
        Fri, 09 May 2025 08:21:53 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:d87c:9870:5eab:3ef0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm3572062f8f.91.2025.05.09.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:21:52 -0700 (PDT)
Date: Fri, 9 May 2025 16:21:45 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, kuba@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aB4dOy6fv1G1lFaf@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
 <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
 <aAtgOLMnsmuukU42@gmail.com>
 <3a84b8a8-f295-472c-8c3f-0655ff53f5cc@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a84b8a8-f295-472c-8c3f-0655ff53f5cc@lunn.ch>

On Mon, Apr 28, 2025 at 04:22:59PM +0200, Andrew Lunn wrote:
> On Fri, Apr 25, 2025 at 11:13:12AM +0100, Qasim Ijaz wrote:
> > Hi Andrew, Jakub
> > 
> > Just pinging on my last message. Any thoughts on how to proceed with
> > this patch series, I left my thoughts in the previous message.
> 
> I would suggest you do the minimum, low risk changes. Don't be driven
> to fix all the syzbot warnings just to make syzbot quiet. What really
> matters is you don't break the driver for users. syzbot is secondary.

Hi Andrew and Jakub,

Just pinging my previous message,
would you be happy with the minimal changes approach i suggested in my
previous message?

Thanks
Qasim
> 
> 	Andrew

