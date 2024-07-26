Return-Path: <stable+bounces-61889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8393D6C5
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D3285C1F
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2F3FBA5;
	Fri, 26 Jul 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1HHs12N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4A23759;
	Fri, 26 Jul 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010573; cv=none; b=tNFgFUyvmkj/SNnEtAj7DKgRlCgdgAKSYDlqnfag3nm4C9pYYBxcKJ8Fwsn5kySeSWahGPYHneXxwBEcUbwIMrVwfTN7nEMw1FwaJFgvZJ+f3rtU0lkAAgYrVfnzufuX0t4+zFpBDKUchfh15dlN774g2lgJiNBZKuL42Ks2TOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010573; c=relaxed/simple;
	bh=mmDA6t4TSfv6XfSHaXGCVVdLxR4aF+if9zRvtYtDxRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbBAOk6COtP9K3WSDXBUjaPjhnljssxlT1PkUqmg4zlmSouDO1tBiAq2P0y5Prq4hp2kh8jDZ/zU69KPvvnux0govTqWyjiquzQ/f0sPx2Ok2VI0p/z2TyV8vvA3+Y41vDbO537KTPGt2oAPKTcpje26DKeBumYV62sTi5xJ6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1HHs12N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E0C32782;
	Fri, 26 Jul 2024 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722010573;
	bh=mmDA6t4TSfv6XfSHaXGCVVdLxR4aF+if9zRvtYtDxRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1HHs12NDKpbhf4p86zXpkSAO/96o5WYqB5HlLNm0Zufa8wVTM5AI/u+WLGSw2BQD
	 q0E7dcQrDpJzqN9vNkH2sheyuf24FsI+kzPgcHvUtVNHjNBgtuqMpTh0Ls2uEVUKav
	 RsZCZzS6dvVfdPDaFnAQy4SJyIG2nqc0aYRCukS70R9GosAXANpQtHIlGvY1qOpYZB
	 OAOuq9XUMyzCfseTYKcgBv6W7DMHJxjy+Lnh/imQrFJADpd7YJ0kTnc3Na/ixOocay
	 /U+QGSo5KPmx8agXha/z2552m1D6PaYMkIgA+4OJNfC5sJ/hJf7FiwdZj5ElpycKzi
	 HGxxlAiXcZeBQ==
Date: Fri, 26 Jul 2024 17:16:08 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>, stable@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH iwl-net 2/3] idpf: fix memleak in vport interrupt
 configuration
Message-ID: <20240726161608.GP97837@kernel.org>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724134024.2182959-3-aleksander.lobakin@intel.com>

On Wed, Jul 24, 2024 at 03:40:23PM +0200, Alexander Lobakin wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> The initialization of vport interrupt consists of two functions:
>  1) idpf_vport_intr_init() where a generic configuration is done
>  2) idpf_vport_intr_req_irq() where the irq for each q_vector is
>    requested.
> 
> The first function used to create a base name for each interrupt using
> "kasprintf()" call. Unfortunately, although that call allocated memory
> for a text buffer, that memory was never released.
> 
> Fix this by removing creating the interrupt base name in 1).
> Instead, always create a full interrupt name in the function 2), because
> there is no need to create a base name separately, considering that the
> function 2) is never called out of idpf_vport_intr_init() context.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


