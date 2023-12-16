Return-Path: <stable+bounces-6867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089208157AC
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 06:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7307C1F25E6A
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107F10A3D;
	Sat, 16 Dec 2023 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1WOQpo/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA1798C;
	Sat, 16 Dec 2023 05:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995ACC433C7;
	Sat, 16 Dec 2023 05:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702703727;
	bh=071/Li+i9BFjkm30UNlSbnsfjr5iK7JNHvUhvR6YccA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1WOQpo/kmnwvcTHbuIbnjlsuquvX50qq/yd4oPloDvB5oWlRoEDBT2TJPjKnPo5U
	 WwyxzDU/IdPMyRt0bIvge0UGAeqTMui7EtBnGqJH+/2RfC7Bu3lKalWu1djc20HhS0
	 vvOr6OMe8pVnmSN+2oy40R6r7ZpFJ0+rj8CEvkecVPat32lg3Y/oVqAeyqn/iGEl+a
	 ug+kmZ5GAyqh1cT/e1vdiZiDLKeC+WBWruiwaZshf4bnrV4q31cIWf18FxIeYfw/M1
	 fEwcnotrP815Y8QUxR9ac/lKAcGqteimg5m/l8T9JmtiuPagCEITYZmDG+CO7ZQN4O
	 L1RkoLUpPmA/A==
Date: Sat, 16 Dec 2023 10:45:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: mani@kernel.org, quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com,
	Bhaumik Bhatt <bbhatt@codeaurora.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Message-ID: <20231216051512.GA3405@thinkpad>
References: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
 <1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com>

On Mon, Dec 11, 2023 at 02:42:51PM +0800, Qiang Yu wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Protect WP accesses such that multiple threads queueing buffers for
> incoming data do not race.
> 
> Meanwhile, if CONFIG_TRACE_IRQFLAGS is enabled, irq will be enabled once
> __local_bh_enable_ip is called as part of write_unlock_bh. Hence, let's
> take irqsave lock after TRE is generated to avoid running write_unlock_bh
> when irqsave lock is held.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/main.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b..32021fe 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1122,17 +1122,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
>  	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
>  		return -EIO;
>  
> -	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
> -
>  	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
> -	if (unlikely(ret)) {
> -		ret = -EAGAIN;
> -		goto exit_unlock;
> -	}
> +	if (unlikely(ret))
> +		return -EAGAIN;
>  
>  	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
>  	if (unlikely(ret))
> -		goto exit_unlock;
> +		return ret;
> +
> +	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
>  
>  	/* Packet is queued, take a usage ref to exit M3 if necessary
>  	 * for host->device buffer, balanced put is done on buffer completion
> @@ -1152,7 +1150,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
>  	if (dir == DMA_FROM_DEVICE)
>  		mhi_cntrl->runtime_put(mhi_cntrl);
>  
> -exit_unlock:
>  	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
>  
>  	return ret;
> @@ -1204,6 +1201,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	int eot, eob, chain, bei;
>  	int ret;
>  
> +	/* Protect accesses for reading and incrementing WP */
> +	write_lock_bh(&mhi_chan->lock);
> +
>  	buf_ring = &mhi_chan->buf_ring;
>  	tre_ring = &mhi_chan->tre_ring;
>  
> @@ -1221,8 +1221,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  
>  	if (!info->pre_mapped) {
>  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> -		if (ret)
> +		if (ret) {
> +			write_unlock_bh(&mhi_chan->lock);
>  			return ret;
> +		}
>  	}
>  
>  	eob = !!(flags & MHI_EOB);
> @@ -1239,6 +1241,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	mhi_add_ring_element(mhi_cntrl, tre_ring);
>  	mhi_add_ring_element(mhi_cntrl, buf_ring);
>  
> +	write_unlock_bh(&mhi_chan->lock);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

