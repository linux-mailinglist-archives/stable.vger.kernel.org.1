Return-Path: <stable+bounces-89900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765CD9BD323
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E53283C16
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141D1E0B6F;
	Tue,  5 Nov 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCC2z8FJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF261DFD94;
	Tue,  5 Nov 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826815; cv=none; b=AtwIGMoooNHqt/mHC5avoctVT/1yQRN7fAqhBVwKtain1f+3bfvuQLlLb46XhWJyWPdutVLBg+FFX9H9q/+KRDg/o7nXlae8A+0AvzbSF7wVGj4uEaNtJEd3tsMVc/x1v7py13ZGiLo8FR8RtWQ0TktzFMdFTsDIXRi+qu81v3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826815; c=relaxed/simple;
	bh=lkpmN3vsfZtO6cDirzgiuE357QAQvJ3r+L0Hlwna7Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4huY0+liK4xu3bKI39fkZjJesbQk+VuxwERdQsr/kfaWbEnQ5awk2+o1rEA59IjTRnBwon/dbRyiHerKw/3egU0NiyaozY48PEJa9sycFE7pVmFDyKj83fXDBfwapryW4nEo07Awz4h/5YSDNfdfMuAfm5go+ZTgopyEDYLtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCC2z8FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E617AC4CECF;
	Tue,  5 Nov 2024 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730826815;
	bh=lkpmN3vsfZtO6cDirzgiuE357QAQvJ3r+L0Hlwna7Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCC2z8FJt4xw1wAuL0Gjhx7kImmaJ8s5bG6bPX8rzOU5ATOzKplBa58yxMbPHEXyN
	 uUrBRl0BnwYTeCQ4E4GoKonU9AYCkBdHslwtbmOXwZjK8E7Mtwk+TFPXgaBq/yrtqV
	 giXrGM0VjpgGwfDMymM0+TBAK4d2KTAVbgKH3FxKc9V5kkGZsOuaK9hRcwgiGEpGqP
	 JWCMDzzjTLNjCsOrW2llEixCEl9ajJ3vqEemCYrqRn396wRC1HTJEsWod6/VvWAoPx
	 zZfZYzJZBLKANYJq+hF0Ma4YN0TW+uB7PRH6kgR8da8LtF/TRVwl5bdhTBFwYr5QGk
	 ps9Ha0NiEJDyA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8N7V-000000008Tc-3Nfi;
	Tue, 05 Nov 2024 18:13:34 +0100
Date: Tue, 5 Nov 2024 18:13:33 +0100
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
Subject: Re: [PATCH v4 1/6] phy: core: Fix that API devm_phy_put() fails to
 release the phy
Message-ID: <ZypSPb7qSR9zYSFv@hovoldconsulting.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
 <20241102-phy_core_fix-v4-1-4f06439f61b1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102-phy_core_fix-v4-1-4f06439f61b1@quicinc.com>

On Sat, Nov 02, 2024 at 11:53:43AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_phy_put(), its comment says it needs to invoke phy_put() to
> release the phy, but it will not actually invoke the function since
> devres_destroy() does not call devm_phy_release(), and the missing
> phy_put() call will cause:

I still think the above should have been split in two sentences, but
this also works.

> - The phy fails to be released.
> - devm_phy_put() can not fully undo what API devm_phy_get() does.
> - Leak refcount of both the module and device for below typical usage:
> 
>   devm_phy_get(); // or its variant
>   ...
>   err = do_something();
>   if (err)
>       goto err_out;
>   ...
>   err_out:
>   devm_phy_put(); // leak refcount here
> 
>   The file(s) affected by this issue are shown below since they have such
>   typical usage.
>   drivers/pci/controller/cadence/pcie-cadence.c
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c
> 
> Fixed by using devres_release() instead of devres_destroy() within the API.

Nit: in the future, try to use imperative mood in your commit messages
(e.g. "fix" instead of "fixed") as the process documentation suggests.

> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

