Return-Path: <stable+bounces-164846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA8B12C6A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2A16DF71
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD0289370;
	Sat, 26 Jul 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjbAvRDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79F288C88;
	Sat, 26 Jul 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562994; cv=none; b=F5PO0I+YomJ0XemBtHPxns7KWL3U9Gz4TWx/1Q9j3U1koUPaqs7qfsiMmSNABoO1K2eTRq/889iViKfYJggEvTVsvH8uGuaH6W/+U34LHfA0TgatxbnLZ2d5eSk9F+AOPEgVlwQHseGhkyDmLYbjfopZKKvnl5RyFTsEFn8xb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562994; c=relaxed/simple;
	bh=7bxfoEqqMehW+lOE9Yi5wWXF0naGs2EAUJ3qo070GP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN9Hk41tpoSBeAVrCZGZY3vFXTzUqtWrzQFcuWGSIFNFGRN+pJW+T3mxQjSy1p9sWTfqAEZTzvDlMMkyN2blVDkBUFQLrvD3BTizueXZ95V1VeeJ0SWuspI99iNHgjHKRsh0hz4AjKUVDNaOqQOf0lb/xywZGIPyIfBKxMWN47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjbAvRDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D785C4CEED;
	Sat, 26 Jul 2025 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562994;
	bh=7bxfoEqqMehW+lOE9Yi5wWXF0naGs2EAUJ3qo070GP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjbAvRDX/+aM/iO7OiKO20tKqTtHLnnxAZd2FDtuVLt9Wkj4ln9nOCYXoMf8XeQDP
	 aT21XGSL8DPzO9P3GV0z8e2f2GSRIFgg8rWRt8ZsH08TSBTNF21ElU2uWrgMGNfJTv
	 OQlqWdol7XLejMAGKkvNnFbKkaFF704hgJk4CRG/ZTf7wJfcw7PPCGl7KwCP2UOGoe
	 P7YwB2halFYEXua19pw0bU28U3SecguKUCP9YTWrvQnQX2vsArJZiCDo2hW6B+mVHv
	 cctkugxODWmQjLky68z6N1cT6xh2rJXg+f3lw/0E8kKrpkZ4yuQqQcIvn0BEaJYgW/
	 YzpDnFAzt4ihA==
Date: Sat, 26 Jul 2025 21:49:47 +0100
From: Simon Horman <horms@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] net: mtk_eth_soc: fix device leak at probe
Message-ID: <20250726204947.GT1367887@horms.kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
 <20250725171213.880-5-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725171213.880-5-johan@kernel.org>

On Fri, Jul 25, 2025 at 07:12:12PM +0200, Johan Hovold wrote:
> The reference count to the WED devices has already been incremented when
> looking them up using of_find_device_by_node() so drop the bogus
> additional reference taken during probe.
> 
> Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
> Cc: stable@vger.kernel.org	# 5.19
> Cc: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


