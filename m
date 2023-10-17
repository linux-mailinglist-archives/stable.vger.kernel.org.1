Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F77CBC66
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjJQHhK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjJQHgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 03:36:53 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE31109
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 00:36:51 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457c441555cso1599019137.3
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697528211; x=1698133011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxT7pzdJESncQ/+9UX6/pYk1WP7pzSl0ESvB6teChuU=;
        b=N4PouUvUPXdMGFCGy725Sjo9GsCmF1ksb61u7ioomtvpRTcsT2BEuoREoJ+kk1C6fF
         xy0+ywyvWCE+fL4AtsQ3u63cS8U0uWzBDloHPziZfPs0ZUeBxMZ8SFR7/h9+V6iV0Gah
         qMcozuXDAiRqp8BruQzlIVbtNb+A56OahvR68DjnFSMhqRyqo0usZTQ6oBFJ6Yo1af3C
         iS7wE8O09mxgCx3IRpYnYoieWTjBdpFtmzee0MXLWqz7VceP/DGiHXGYgSz+P9WHHu1c
         hIvseX0/0uU03n4zrWF9Vcg6lj0n3CcHwrvAUDQ8XH+o0Zxd8qE4WhSGWD+OGC73+bL+
         24MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697528211; x=1698133011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxT7pzdJESncQ/+9UX6/pYk1WP7pzSl0ESvB6teChuU=;
        b=mN7JWMcTDQk4GRGkTGKBdIWjQenEzUfbyq0R1a1by86wFpfhcujLZCyMt47S0dO6rb
         mij2MI55S5NHGTjSKsGcA9Lbvs+Vy6Dphne8t+A+hJ+vHM5Zm2sdvepQ5cUGRDXAV+Cj
         8C5AmPZQGtlSf0/8pg3O6uoaKi7JkPU2QN1UMWiwUft8bfymg50P4RgnN/9QxD498ois
         +RgFYeYdaKVec+7Jrmz9YR5rzVbUn4BOTiPXThnRRFGg/CoXfgbDYCHK+uwyaEogHeR0
         DHHAN5TTG+S7qYx/f+sJvv5FHI1iszfX81tyFBBhyllDykzOudcM34Q1Ntb0/8hgh3Xo
         ZazA==
X-Gm-Message-State: AOJu0YyjtBDpizsAxai/VZmCnI+dFjX5dU8gEGF7ov9KLmtJMSPHlNZw
        cF43jscbE8RkmhDx48TwllZ8
X-Google-Smtp-Source: AGHT+IGFV6Oy9oyt9cc9+QXaBhIphbHezPtFo1fpD4ru8RrTKL+MKRETflutZYL7NmHrrU3OkLGrxA==
X-Received: by 2002:a05:6102:756:b0:457:cc6c:948f with SMTP id v22-20020a056102075600b00457cc6c948fmr1247130vsg.26.1697528210667;
        Tue, 17 Oct 2023 00:36:50 -0700 (PDT)
Received: from thinkpad ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id mk2-20020a056214580200b0064c9f754794sm342250qvb.86.2023.10.17.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:36:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:06:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msarkar@quicinc.com, schintav@quicinc.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Do not allocate event ring element on stack
Message-ID: <20231017073642.GA5274@thinkpad>
References: <20230901073502.69385-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230901073502.69385-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023 at 01:05:02PM +0530, Manivannan Sadhasivam wrote:
> It is possible that the host controller driver would use DMA framework to
> write the event ring element. So avoid allocating event ring element on the
> stack as DMA cannot work on vmalloc memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 961aeb689224 ("bus: mhi: ep: Add support for sending events to the host")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/ep/main.c | 52 +++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 600881808982..66ca470bf302 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -71,45 +71,61 @@ static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
>  static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
>  					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
>  {
> -	struct mhi_ring_element event = {};
> +	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	int ret;
> +
> +	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
> +	event->dword[0] = MHI_TRE_EV_DWORD0(code, len);
> +	event->dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
>  
> -	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
> -	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
> -	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
> +	ret = mhi_ep_send_event(mhi_cntrl, ring->er_index, event, MHI_TRE_DATA_GET_BEI(tre));
> +	kfree(event);
>  
> -	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, MHI_TRE_DATA_GET_BEI(tre));
> +	return ret;
>  }
>  
>  int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
>  {
> -	struct mhi_ring_element event = {};
> +	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	int ret;
> +
> +	event->dword[0] = MHI_SC_EV_DWORD0(state);
> +	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
>  
> -	event.dword[0] = MHI_SC_EV_DWORD0(state);
> -	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
> +	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> +	kfree(event);
>  
> -	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +	return ret;
>  }
>  
>  int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
>  {
> -	struct mhi_ring_element event = {};
> +	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	int ret;
> +
> +	event->dword[0] = MHI_EE_EV_DWORD0(exec_env);
> +	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
>  
> -	event.dword[0] = MHI_EE_EV_DWORD0(exec_env);
> -	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
> +	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> +	kfree(event);
>  
> -	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +	return ret;
>  }
>  
>  static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
>  {
> +	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
>  	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
> -	struct mhi_ring_element event = {};
> +	int ret;
> +
> +	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
> +	event->dword[0] = MHI_CC_EV_DWORD0(code);
> +	event->dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
>  
> -	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
> -	event.dword[0] = MHI_CC_EV_DWORD0(code);
> -	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
> +	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> +	kfree(event);
>  
> -	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +	return ret;
>  }
>  
>  static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
