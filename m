Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB0783E7D
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjHVLAg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjHVLAg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 07:00:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0EE4C
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 04:00:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c65820134so154080f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692702008; x=1693306808;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoWFVqMsL83JIn/vxFgprKnAuUfFVup8ln942QNlmLA=;
        b=Z8UV6iW1itfzHm8+/As9TAjIYBcIWN2z0QLgAmaJ/2mblgU1+o+H6n1gqtruyT30xg
         GcPIjwJg72BACxxjpHRePL/hKl41unY26KQfzPIa6pull1358sSYvAh21o/MURQQsN6y
         DfgOWPluEM/MqPlhQuJ3T9s0c+XpT/UhO5uNnzRGuxX4uiS6AVK4O3WRtPCHgmXV+Lki
         ojWJJZftutfK9Km6HzytEuVGs8qn/cBZ+0UVxGIBXmN4gTM+DzsNMbpXC37tNWCah/Ux
         hUjnfRXs//2HmE+XKqlSzmA8h4ir9qMEUjDIvT03+l/5ZQPEWKoOpQ1kulZ84QsucFgm
         ON3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692702008; x=1693306808;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoWFVqMsL83JIn/vxFgprKnAuUfFVup8ln942QNlmLA=;
        b=NvHtr+YsLNjOI+6GL7Q1OL7hMiijgVeXkmL83nGeNDp41HW2qZyuV6uTRiuHkXZ3ht
         vLWJTBAxMovw6/qYiMiJ8nwSbGRdX+CH79Tv5dCtbsJSkuVmxml0TJFD3A9N0ge6ORjZ
         9kOSdHlk396qtF0aHSslh1ix/+VSSwd27gNN+uLAJ6KqQKHMRuk/DKP+mfV0JAzvXWri
         0VLRb/B60FNBOMHu2DP4fugE8wBGDWE/tHapn2+SX08nTLntsqEQAkIHvT3xdi/s7kEU
         LtZDm+1I1eimCWnk/QdhueIdlOXArOiaduPTu3NHWX9NwkH8sDK4rQpBA2uM4VK4SK7v
         MfLQ==
X-Gm-Message-State: AOJu0YxuUGzl7+MDw3jn7bD4LYF2ghZYm04sXrUfby02ps41fqznSUvC
        1llOy/SLqku9cyailPYYZ6KPhIy/WGQ=
X-Google-Smtp-Source: AGHT+IFKdURGW7iWzIEDzfIwQ7oabQT/1r1bpkExBM3su0btaR+BUUsSjhTaK472wB9hVlcXk7mbow==
X-Received: by 2002:a5d:6308:0:b0:313:e953:65d0 with SMTP id i8-20020a5d6308000000b00313e95365d0mr7168497wru.28.1692702008305;
        Tue, 22 Aug 2023 04:00:08 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b003188358e08esm15432136wrm.42.2023.08.22.04.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 04:00:07 -0700 (PDT)
Subject: Re: [PATCH 6.4 173/234] sfc: add fallback action-set-lists for TC
 offload
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <20230821194128.754601642@linuxfoundation.org>
 <20230821194136.483562509@linuxfoundation.org>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <18ed9173-46f3-b1c5-1a35-fe6aa1da5407@gmail.com>
Date:   Tue, 22 Aug 2023 12:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230821194136.483562509@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 21/08/2023 20:42, Greg Kroah-Hartman wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> [ Upstream commit e16ca7fb9ffb0d51ddf01e450a1043ea65b5be3f ]
> 
> When offloading a TC encap action, the action information for the
>  hardware might not be "ready": if there's currently no neighbour entry
>  available for the destination address, we can't construct the Ethernet
>  header to prepend to the packet.  In this case, we still offload the
>  flow rule, but with its action-set-list ID pointing at a "fallback"
>  action which simply delivers the packet to its default destination (as
>  though no flow rule had matched), thus allowing software TC to handle
>  it.  Later, when we receive a neighbouring update that allows us to
>  construct the encap header, the rule will become "ready" and we will
>  update its action-set-list ID in hardware to point at the actual
>  offloaded actions.
> This patch sets up these fallback ASLs, but does not yet use them.
> 
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: fa165e194997 ("sfc: don't unregister flow_indr if it was never registered")

I don't think this is actually needed by that commit; it's textually
 part of the context but not semantically important to it.
Why can't you do the same thing you did for 6.1?
-ed

> Signed-off-by: Sasha Levin <sashal@kernel.org>
