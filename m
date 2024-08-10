Return-Path: <stable+bounces-66308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A694DBD1
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7FB1F21CC0
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229D14D28C;
	Sat, 10 Aug 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG6OR5Py"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA615155345;
	Sat, 10 Aug 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281020; cv=none; b=N9lm2tn93E4+f4kc4Vpu8R/B93t4IiguzOhjeOQF229LgjDCZyyJNpl3zw07h4jCbG8GAgS3kz5vun49qdga4cLCVdevIYvuUn6EprlCMlIu48cKmzVWrKTR+57dmOnryRrSUtCprvWIMuy7vgRCb3ws2fWLF7ZOnDSyi4kqLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281020; c=relaxed/simple;
	bh=WXVJCXwzW1I64R/W1MgTk/3ACJlurBYFgx0Z/peXnpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK9Yhern3MKAlMP0BhZKQ2jU/iA+9IMea+q2atd0oiJIBRMx5clT/cFHFe6/UArg+2pk51golAJvvHI22yJVNM/t9ba5JFMqx1K62hAcfKem+oaKGE83edDuzp1LfNRvJlepUSfO/G17/JIyacLkOeRd76OTP2/r9wlGu0kWjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG6OR5Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04231C32781;
	Sat, 10 Aug 2024 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281020;
	bh=WXVJCXwzW1I64R/W1MgTk/3ACJlurBYFgx0Z/peXnpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG6OR5PyBUb0T2jL8vh9GqW3U7h4zQlB2AlJP6piU89z4nevU4SxV+ZrzvpXJV8c7
	 0DdJYWt+8M0cEeCDsKaOrN5l5/hf9Zf8R+rmlly+rgAp7Ybvrp1zhwM81SIe7cJhTF
	 XmvIyJtSWAxHfCIOweNktdNQQKW2CI0s/D8ZZAez6IU+q7xfDjFp+LHG50EkxF0B/+
	 AiD39UOxZPHTxCXPOulIUPQatB8QE0usuAe5dZ3gx0NuCjrUASvmYj2ZtxKv/XdrHs
	 R9eFKfjGgFfW8WN1WKOTyNs0dd8Tsx51yEPvS3ovPpCDFNvnLO1kfVx06+j6dgSEpN
	 GsDyyXcTDNRog==
Date: Sat, 10 Aug 2024 10:10:15 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@outlook.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ice: Fix improper handling of refcount in
 ice_sriov_set_msix_vec_count()
Message-ID: <20240810091015.GF1951@kernel.org>
References: <SY8P300MB0460412FE86859FF97DE6342C0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY8P300MB0460412FE86859FF97DE6342C0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>

On Fri, Aug 09, 2024 at 12:59:11PM +0800, Gui-Dong Han wrote:
> This patch addresses an issue with improper reference count handling in the
> ice_sriov_set_msix_vec_count() function. Specifically, the function calls
> ice_get_vf_by_id(), which increments the reference count of the vf pointer.
> If the subsequent call to ice_get_vf_vsi() fails, the function currently
> returns an error without decrementing the reference count of the vf
> pointer, leading to a reference count leak.
> 
> The correct behavior, as implemented in this patch, is to decrement the
> reference count using ice_put_vf(vf) before returning an error when vsi
> is NULL.
>  
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and identifying potential mismanagement of reference counts. In this case,
> the tool flagged the missing decrement operation as a potential issue,
> leading to this patch.
> 
> Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>

Thanks Gui-Dong Han,

I agree with your analysis.
However, I wonder if the same resource leak can occur
in the unroll label, if the if clause results in a return.

It is around line 1444 without your patch applied.

	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
	if (vf->first_vector_idx < 0)
		return -EINVAL;

> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 55ef33208456..eb5030aba9a5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
>  		return -ENOENT;
>  
>  	vsi = ice_get_vf_vsi(vf);
> -	if (!vsi)
> +	if (!vsi) {
> +		ice_put_vf(vf);
>  		return -ENOENT;
> +	}
>  
>  	prev_msix = vf->num_msix;
>  	prev_queues = vf->num_vf_qs;
> -- 
> 2.25.1
> 
> 

