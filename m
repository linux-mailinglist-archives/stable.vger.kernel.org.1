Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA257043DF
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEPDMP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPDMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:12:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E865AD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:12:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6438d95f447so9439140b3a.3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206733; x=1686798733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDxT5zCKX+OlRexh0/v7BOOIwkGWHS6pFpbkoRXsF0s=;
        b=dg5JgI4iRrgVHMoaLSH9XjLMxrJPcpicON+3WSjERjZJZ3ddRoUTh0nM3C+AgMi+Jz
         PNCsFEaH20Qsuys+Bih1MCdwku5d8daxd2Cz4McgpCKo+qCQjH2Swv3c9nZDGgAW+fqD
         o6OxePpJKuqzWTsJCuoIh/hVmAppqEj1qOLTsO7Kg6cOavCnNwwKM2uHsHZZWMvckRBR
         sfuHbKXVgESMPhbYDp4IWl5zzb7aXBBMFgO5Kw9xKjLpOqa247zlQwKhBby1zJh0d2un
         XJ5Z3dFQ74slmhhToJm1F3dipJgPFqt4mfY7Jeok8loVMPYR4jDm2QfGVuWJSvp/IJ6D
         TyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206733; x=1686798733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDxT5zCKX+OlRexh0/v7BOOIwkGWHS6pFpbkoRXsF0s=;
        b=MkJjOK/mYYIigEreO08AWRltUdgncdOzo3hucG5XorUqZy1Td6MPbqeWZUsQzzpyzU
         6hjyhck+VmhqLda9gAZZW/wdMg6h3+HPalnWRhgoHCcJ2VePNpiIuI+WJzAzgc0tvOLm
         WBm64wCyJkxpNJiY8cv+lB1nrQwRDFJkUVtWXzbS3VfCsH7c70JTXnSLEX0JBrUpwYzG
         wWTBM5iD+88RUUVsIJWXldKdTwuVZPWliuHGyxMLAtpz9E77Xm9e1xALXOl7oqaErPnq
         fLKmo6fKXV+3KxTkBHp6JOYc1oc3wxdI1f5dcuBn1YKHcAe50/jTGPeDRJ9zF6AufOvg
         QLRA==
X-Gm-Message-State: AC+VfDxyk7wi1AECvtmP4O7UtgSkrWl9TQ/9uLlvHXOvfORPFxJewuLP
        cwtETUXSbymnEbMJ1+wIr1mr+sqs6PE=
X-Google-Smtp-Source: ACHHUZ5UAzeebD2P7wGy/eAUwRF6dMlbRrD2wF97aTl0OtGsDTbUpZfSy6Sd01yVn+82y76M2/H94w==
X-Received: by 2002:a05:6a00:1a06:b0:63b:8423:9e31 with SMTP id g6-20020a056a001a0600b0063b84239e31mr43622631pfv.11.1684206732768;
        Mon, 15 May 2023 20:12:12 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b0062e12f945adsm12380777pfe.135.2023.05.15.20.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:12:12 -0700 (PDT)
Message-ID: <74ac1b5c-fbf2-873c-4ced-dc0ea5b28838@gmail.com>
Date:   Mon, 15 May 2023 20:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.4 235/282] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161722.146344674@linuxfoundation.org>
 <20230515161729.266459648@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161729.266459648@linuxfoundation.org>
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



On 5/15/2023 9:30 AM, Greg Kroah-Hartman wrote:
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

Please drop this patch from the queue until 
https://lore.kernel.org/lkml/20230515025608.2587012-1-f.fainelli@gmail.com/ 
is merged into the 'net' tree, thanks!
-- 
Florian
