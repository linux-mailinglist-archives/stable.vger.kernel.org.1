Return-Path: <stable+bounces-89203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A09B4B13
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D0B21F88
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9A206517;
	Tue, 29 Oct 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlQU7Zt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139A20607F;
	Tue, 29 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209183; cv=none; b=Wr69BAWG27qH7miJp6hX8pui9K1o1Hk97zJtEyF8ySI9clwALyhE2e2TbpwBpJ3s0mxc2VdIXHlST3D7TKo+lmiAii1ZAhbZcu+DPtsVykycOoCcmjjV5tgy3Mn+eH7/Wc9QFridssxdr15dBxWgpW89LWkxJVF+tk0IoxuOwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209183; c=relaxed/simple;
	bh=jj3QSdkt7HgsL+0jGXGGXLBhwpp0NyA9zHvIeDdUtTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPKFmkG/Fg81Bjido+eFahQG8gVFuxPyZRMuSHXqyL1BYwxoRaD/ZvzXS+ISG2fFnGkMUXiOLQi/MokTpPMSneF7rfaOJRxNs7lqHwz8T9uKcBL/S0bVMlp8/irzN51qv5iJWoWOgNumAKpjWVcfatXUa1fb8hwK3X9fE9AlBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlQU7Zt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB20C4CEE9;
	Tue, 29 Oct 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209182;
	bh=jj3QSdkt7HgsL+0jGXGGXLBhwpp0NyA9zHvIeDdUtTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlQU7Zt7jiwk9oGNwjU/HMTb+2ShaKBDK3O13vtfL6/WB7HRJJYLCl1rqUBzYdEUe
	 eZuHFdL6nUO1EEhjVSJ+/5NpgSk5fmXUP5+afqGLerGgrVHmq0uP6phi7bejFgu2z7
	 dAeUC1718KlSGe5fMjmI5Y7c5oupjs9Pb9mL1a36/KOxe6a2wcD5o4yGCvOEgNacJn
	 63s7piaIyFOU8crfHtuD8AIEDu1mb0R062/UQhz1aSPRUcCfRmcYb6bci46MIIPIjE
	 mWiG7FjWvnueEVZ41aJvxiVBcRsc8rPI9AnGrhvwoauqL1nGQ8ZdTzJdkwypUf+bKo
	 OD55CyBv0ZoFg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5mS1-000000002sW-3cst;
	Tue, 29 Oct 2024 14:40:01 +0100
Date: Tue, 29 Oct 2024 14:40:01 +0100
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
Subject: Re: [PATCH v2 1/6] phy: core: Fix that API devm_phy_put() fails to
 release the phy
Message-ID: <ZyDlsWaA5aiRa_ry@hovoldconsulting.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-1-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024-phy_core_fix-v2-1-fc0c63dbfcf3@quicinc.com>

On Thu, Oct 24, 2024 at 10:39:26PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For devm_phy_put(), its comment says it needs to invoke phy_put() to
> release the phy, but it does not invoke the function actually since
> devres_destroy() will not call devm_phy_release() at all which will
> call the function, and the missing phy_put() call will cause:

Please split the above up in at least two sentences to make it easier to
parse. Split it after devm_phy_release() and rephrase the latter part
(e.g. by dropping "at all which will call the function").
 
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
>   devm_phy_put();
> 
>   The file(s) affected by this issue are shown below since they have such
>   typical usage.
>   drivers/pci/controller/cadence/pcie-cadence.c
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c
> 
> Fixed by using devres_release() instead of devres_destroy() within the API
> 
> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Diff itself looks good. Nice find.

Johan

