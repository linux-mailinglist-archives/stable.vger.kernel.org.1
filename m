Return-Path: <stable+bounces-89224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B159B4F26
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3DD285D4D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80620198A34;
	Tue, 29 Oct 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lndVywaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4E194A59;
	Tue, 29 Oct 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218819; cv=none; b=e7AgxVCkNT92kAiCKZuQxtdkGBsx57I2P5QxRCK22vtQaKIgdB+O3kCG+L+5XGWfBoGqZLnfg+fb8s4Up4mbunrxvnLb8q0kH6D60ImxmyEOF8y/Vg5Nb3ngNzooBug1dV/bfFYPIR+p43GG8NRWU/ek9+0Qtn8ph3J4LWU2eTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218819; c=relaxed/simple;
	bh=YoLwtosK8vF2mSihsNmeRMh027fIMoq6AZH27ocsMG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heRjN5v3kI55WoFXcyySJkAsufIIGEF6HD8+vOxYAm3X016u+YOEqVv2RDNTbvqt4ox/3SnQasEcHIcNUX/f48FtvBur2rsXoC9yIOxT/+bs1NIliL5UTZHMg91DZhpA/Ze5KcoD0epDTQuC2akgPfefWngd4H3ilZ8wuuh4wYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lndVywaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B3AC4CECD;
	Tue, 29 Oct 2024 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218818;
	bh=YoLwtosK8vF2mSihsNmeRMh027fIMoq6AZH27ocsMG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lndVywafESfGJ2Wc/9cjNzyd0zIGDd6y6HZYl3OHSIhu+rPgVmXb/G84VhfzAP/4/
	 oFcZdVtryzEvXL74pNDD7AEeQ5NETD1hn20nv1jWS1ok/XgNmIKUCBe5APjwwFqjpX
	 dQ4f5XASkEmX4QX8eXCO5yc05JZ1Bzyn1llvSvZToEbIo/ecSzzmSfmCM8sXaS9EaU
	 avpgVOw/M9BULnCkaDV7OFbdtBhFOuT2QLYVwvEeHPh7XS7FZcnWf3s77ukB2tZDj1
	 eEDN2A2hGQhRXCTIj/IrvrvxyM97ni2xThW8SuaFisWw6udobBUrPpqWk9J4ZDv4+F
	 6sRkYgICsSNMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5oxR-000000006Xf-3ahM;
	Tue, 29 Oct 2024 17:20:38 +0100
Date: Tue, 29 Oct 2024 17:20:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	stable@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
Message-ID: <ZyELVe0EUZg9iD0q@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-2-fc0c63dbfcf3@quicinc.com>
 <ZyDmdsHtxo-gFIFH@hovoldconsulting.com>
 <a6d7efe2-ec92-4ffa-a1f1-bc73ebd49d16@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d7efe2-ec92-4ffa-a1f1-bc73ebd49d16@icloud.com>

On Tue, Oct 29, 2024 at 11:35:48PM +0800, Zijun Hu wrote:
> On 2024/10/29 21:43, Johan Hovold wrote:

> > And you could consider dropping the function altogether as well.
> 
> Remove the API devm_of_phy_provider_unregister()?
> 
> i prefer fixing it instead of removing it based on below considerations.
> 
> 1) it is simper. just about one line change.
> 2) the API may be used in future. the similar API of [PATCH 1/6] have 2
> usages.

We typically don't carry APIs that no one uses (or has ever used), but
sure, that can be done separately later if anyone cares.

Johan

