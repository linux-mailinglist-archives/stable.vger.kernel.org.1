Return-Path: <stable+bounces-32235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A736388AED8
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA92C7556
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450414AEC8;
	Mon, 25 Mar 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKt979+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C4804;
	Mon, 25 Mar 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391918; cv=none; b=DH6QtHq7UYtu2yZlHMcOfdqmGHIgTx9bdbYfn0hwlZwfrdUhIgub0Gi2s6SoeijV1UI6dqm2vR/2AD2r05ab1tzmBtEqTcz1LT4qn/M3HZlSETJFKED3WMXt7XhkrA18d2ZoLwxCm5XnhyoRnabG2o1KixN6LfuM3hD5MdzKnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391918; c=relaxed/simple;
	bh=blLcvYAqaiFz1G8fZPDqiwWnJvL9Uqm3A7A++8T3s4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2dgaw+1h9tafnTpQueVIaWPL8fRwkAR7njUqQW089NBxazajSrUTqwtUCqWRYzt/gzMytMAHkCtMctH6UlTAjkYwSEQmBlJySeh4Pnfwm7LQCvqSjb2B3hvKhIQRuRKzqLQyUcfseTE8+nHegh8lfI+bKb8lJu4j5uH0Kj9d7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKt979+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F9DC433C7;
	Mon, 25 Mar 2024 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711391917;
	bh=blLcvYAqaiFz1G8fZPDqiwWnJvL9Uqm3A7A++8T3s4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKt979+ORk1GhjUQtnxxmtJbwUrwTflAts8wpAM/N32EZjdQOWQv6hEg4o1jT3KHH
	 TxDtUSOEippLs58N41KVnI1fxTM8cx5ilGEDvgaO6kKL/clCZ29Lo1eiS+BSSwqAZE
	 BEYre//S80GNmVbAidCHyDdkaWKRij86uLr2LLLA=
Date: Mon, 25 Mar 2024 19:38:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] driver core: Introduce device_link_wait_removal()
Message-ID: <2024032554-tipoff-extrude-a631@gregkh>
References: <20240325152140.198219-1-herve.codina@bootlin.com>
 <20240325152140.198219-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325152140.198219-2-herve.codina@bootlin.com>

On Mon, Mar 25, 2024 at 04:21:25PM +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
> 
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
> 
> For instance, in the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()

So this is only an issue for overlays?  Why has no one noticed this in
the years since 80dd33cf72d1 was added?  Why is this an issue now
suddenly?

thanks,

greg k-h

