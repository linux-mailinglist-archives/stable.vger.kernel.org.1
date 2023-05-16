Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844670440B
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEPDl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPDlz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:41:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD20559A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:41:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5307502146aso4197371a12.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684208514; x=1686800514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGleJXuJTGhHLqLpDeHS3KsfT+7mitpqtqJB51lXU1o=;
        b=B9qbdwBln8PheB+T9VzI8GA2rOX1TXPwb42YzDQnP4qhW++T7Qq6w/iXNtGf5OLOl2
         Q+AT/Vq6G5q5M12BFxpwZ7RkD3hJHIJIm3pl5KcYyVbNobdYfpbXdETD3jXfF5SkA9lL
         mNaAF7uDWl/6ygu0W9HehQX91gLNp+MynUXnHfQvD/+jmtaMFhIYAQkjNptdiioPb5Fh
         kAFbSs8JrNw7pBQ9x84YCBG3QP6MuuEgql5w6Naz8MD35Qx60jF7imufrtX9KimwKVNH
         pE3V75MYhmKh4Ylag7y+OYMOISHFbPF/6vN+aKBrTpVN4Dy2S3N+l3X7WrCW4RG9+q1w
         zfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208514; x=1686800514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGleJXuJTGhHLqLpDeHS3KsfT+7mitpqtqJB51lXU1o=;
        b=KUDScAr3JLOTX9zaKacUUCrwDl+hchz6dw3CT3T/pOmUtqwPpRNwBxOhnCOqyObMnq
         yetui5GIoV2VDojMuLO3RyfSM1bWDSNe/n9VM8AwcTV0t6/fh/vOVnb3IqTbgqNx38y/
         9FikkwxnS7KNLnqBolAoeUmAcuGnSjOn/t6ombDyRx+7/mX37PfI1znIvWkOTzEZQgrE
         XB2m9FMbfWRHjMl4i2j5G9bQl5eNLREHa9vIv+bVn72HTsHLF9wWMF1tHgnlwXXkHKh8
         wH//ursZrwiHVkb0AAdN26iWoiCoAnNavbKCm90FtVvUh4GcnRkJbtcjzPWVsmCkL7Xt
         UDIw==
X-Gm-Message-State: AC+VfDxepd0IAcMkijGYR7TEvvPx5H5YsS9MCj02x1mYU7SxhLs8PJ7N
        A1LKc7GaCkCpYemtu3lPS84=
X-Google-Smtp-Source: ACHHUZ7OzSgTDJSG55FyqVg28T/ZSUHXu7cbbC8EGzGfHRQHrvJtfq2h0PXBjdo3kz8TJmo5UKFJnA==
X-Received: by 2002:a17:90a:6e44:b0:24d:ee34:57b6 with SMTP id s4-20020a17090a6e4400b0024dee3457b6mr35225929pjm.41.1684208513857;
        Mon, 15 May 2023 20:41:53 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b001ac7794a7eesm14299952plg.288.2023.05.15.20.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:41:53 -0700 (PDT)
Message-ID: <413f8553-cb46-a073-b94e-63adc3954ee7@gmail.com>
Date:   Mon, 15 May 2023 20:41:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.15 048/134] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161702.887638251@linuxfoundation.org>
 <20230515161704.750701051@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161704.750701051@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 5/15/2023 9:28 AM, Greg Kroah-Hartman wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> [ Upstream commit 93e0401e0fc0c54b0ac05b687cd135c2ac38187c ]
> 
> The call to phy_stop() races with the later call to phy_disconnect(),
> resulting in concurrent phy_suspend() calls being run from different
> CPUs. The final call to phy_disconnect() ensures that the PHY is
> stopped and suspended, too.
> 
> Fixes: c96e731c93ff ("net: bcmgenet: connect and disconnect from the PHY state machine")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch until 
https://lore.kernel.org/lkml/20230515025608.2587012-1-f.fainelli@gmail.com/ 
is merged, thanks!
-- 
Florian
