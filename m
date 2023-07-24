Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A542F75FFC0
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 21:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGXTXV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 15:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXTXU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 15:23:20 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A09E73
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 12:23:19 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-565a8d9d832so3009608eaf.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690226599; x=1690831399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zm6azpD5so/aQhpF9W7ZnuZupkzF/gW9qt6fdIS+xjI=;
        b=eXqy4N8/i0/BJt5HjkkZl9ZsZqYgfS5GxP3QtHbLjwMTezXd+meQb/6xlXiViQBXnt
         Aledap/rbpydiotJQ+4HmkPv6+3JqAOPuytmpPhQYPCO2FJrKaMfMMxLB0XWlPR0T/ma
         ZqOiwG1LVogv4Vk9+Hwbxsc1LpEJM0/DAxJ3f1IQCexLv18PLwdIMmxypek9Xxoll67P
         V5IIEzflcnHKaw37WVzd1cO6qEk4VR24zGxM9nZZpFONhZvuUFMl0eAtr/jlUBvhy3Wv
         nw7hfb/U3ax2f1sKGhkbdiFnYI7eKF7ZpX5Hv5F7hmw+UVcrFhRfVMrCnDW62PCIbHFw
         SrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690226599; x=1690831399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6azpD5so/aQhpF9W7ZnuZupkzF/gW9qt6fdIS+xjI=;
        b=iStkv7w5vIF2+ZMYqQe4UoO7mNQW6H6ny2XChGSnepDHxO5NHMNzD5R/RcIwtXDqZC
         LLvagfK8xYve7grFcBGX88QXW/09pqO+1Rt6goOQNaDZWHzbP2lku1FrpSlIOo6+oLWL
         H6g9IvrjQeNdjzgO+MXjR8rfp3ENVoNL5ShPHLx3SZg+dWll+zuXNprzHBt8yinmKwx4
         wgKuY0KpooKuVFaSVLsqNZ9LMz+Tf+9gyI0Ls5TBCks8aqrOmD3f78h7Dzbx6u4APvNT
         4NmRt5EVUWRr+DjFwJ8ZA3r6XIy7jU/G7MnXwYbn55+4bytRioVMPgIlQH3H+Q2O3dOZ
         b3fw==
X-Gm-Message-State: ABy/qLYVxDKK3KN/JLYe87s9PPAVpMRzxr9Anh2G4l24DSd/2XgbXZvY
        T3ENNbBQjkQ+bf7tLCWuEKo=
X-Google-Smtp-Source: APBJJlEsdE2sFvDlv24LKkg7Bu3OcKYvo6bWMRs8PW64/CFmuFMLmOwlFJbcu1CB4mkhTP8ng+2iKw==
X-Received: by 2002:a05:6808:1a99:b0:39e:c660:a5fa with SMTP id bm25-20020a0568081a9900b0039ec660a5famr9026693oib.10.1690226598851;
        Mon, 24 Jul 2023 12:23:18 -0700 (PDT)
Received: from [192.168.7.168] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id a12-20020a056808128c00b003a44b425c18sm4398631oiw.43.2023.07.24.12.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:23:18 -0700 (PDT)
Message-ID: <18e9e042-12ec-8e09-1225-ca44810e2b82@gmail.com>
Date:   Mon, 24 Jul 2023 14:23:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6.1 146/223] drm/amd/display: edp do not add non-edid
 timings
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Roman Li <roman.li@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>, eniac-xw.zhang@hp.com
References: <20230721160520.865493356@linuxfoundation.org>
 <20230721160527.097927704@linuxfoundation.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <20230721160527.097927704@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

This patch was
     * originally added to v6.1.35
     * reverted in v6.1.39
     * added back in v6.1.40

This patch is still reverted in mainline. Was this patch re-added by 
mistake in v6.1.y stable?

Alex

On 7/21/23 11:06, Greg Kroah-Hartman wrote:
> From: Hersen Wu <hersenxs.wu@amd.com>
> 
> commit 7a0e005c7957931689a327b2a4e7333a19f13f95 upstream.
> 
> [Why] most edp support only timings from edid. applying
> non-edid timings, especially those timings out of edp
> bandwidth, may damage edp.
> 
> [How] do not add non-edid timings for edp.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Stylon Wang <stylon.wang@amd.com>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> Reviewed-by: Roman Li <roman.li@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6972,7 +6972,13 @@ static int amdgpu_dm_connector_get_modes
>   				drm_add_modes_noedid(connector, 640, 480);
>   	} else {
>   		amdgpu_dm_connector_ddc_get_modes(connector, edid);
> -		amdgpu_dm_connector_add_common_modes(encoder, connector);
> +		/* most eDP supports only timings from its edid,
> +		 * usually only detailed timings are available
> +		 * from eDP edid. timings which are not from edid
> +		 * may damage eDP
> +		 */
> +		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
> +			amdgpu_dm_connector_add_common_modes(encoder, connector);
>   		amdgpu_dm_connector_add_freesync_modes(connector, edid);
>   	}
>   	amdgpu_dm_fbc_init(connector);
> 
> 
> 
