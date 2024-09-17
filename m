Return-Path: <stable+bounces-76590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F397B1BB
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E811C22161
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2C18859D;
	Tue, 17 Sep 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fe2xLK84"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF37187FF5;
	Tue, 17 Sep 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585143; cv=none; b=Dh6v3+GslWR3UfMSSKzyV9aaXm+ndaPOODllxtZEzywH5ezdyVF3rbLYrhO5aEDrtXCwVPFEPpsj9NW+YPWgp0EZVbRIabddMwyCIyoeknTFQB65r6iaUcEOVN+EiZj0jOqlMldinHhdvdOJ1v54IqWlI5WXmzLlHqIOH34KFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585143; c=relaxed/simple;
	bh=RzBd61ZiE5iObY/dWD1aI/PEu/Zlxazk8FvhgR8ZWf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbejj1n+FOjYtYdUmhfw3ZBwewsLyl74/8k6qdV0wRMaLCx84Nn+MbD2DaHPhE0NM4JL5iSeFOWi5eneRm/mx9MgS7MouErC5rMMF+j2dFUNFlbj251XLLPHdwFyhLSwdAeO90DSUz2FW9H+KIoyWxZUfL8XCiKLviYWhZfBXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fe2xLK84; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36AE21C0004;
	Tue, 17 Sep 2024 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726585134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNjBY/yrqiRYcCWR8FN7MlTfLsbuXBXY/h7RcE1c1zM=;
	b=Fe2xLK84IaCCn94GfdEPfB+GrUeTShJDFxjrZ5qo2CPyMZZkIRQjHnI+7OxhgvtNosNkUv
	tXQjcvWQ1zTSUWzSvfYSs/7LL9BzM0885E0okb6+8ahVdPEdtXUWDP3z6faZWzwngN1oNF
	2svjDrP4t9tWK3SG6j1EdalxOR/7WuklE8ygG+XSuJrK1CuWNP0lhcbsdUP3y6GPeH4Er5
	gACcaBCNXWXFBlFra1OO7J2LDCPNLZlQo8s4IlQwTXbskwca4qqvB5CZy6V/xHlgfvV0yY
	RqpypQM9pbI9wvTA47Pgpa9tbm8bU94k6RTxOPPMmwIbGMZDy4330BH5XhhAyw==
Date: Tue, 17 Sep 2024 16:58:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, frank.li@nxp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
Message-ID: <172658508687.68424.10453824473496378760.b4-ty@bootlin.com>
References: <20240914163932.253-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914163932.253-1-kxwang23@m.fudan.edu.cn>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Sun, 15 Sep 2024 00:39:33 +0800, Kaixin Wang wrote:
> In the svc_i3c_master_probe function, &master->hj_work is bound with
> svc_i3c_master_hj_work, &master->ibi_work is bound with
> svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work  can start the
> hj_work, svc_i3c_master_irq_handler can start the ibi_work.
> 
> If we remove the module which will call svc_i3c_master_remove to
> make cleanup, it will free master->base through i3c_master_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition
      https://git.kernel.org/abelloni/c/618507257797

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

