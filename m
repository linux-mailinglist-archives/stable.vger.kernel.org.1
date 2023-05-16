Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B06704410
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEPDnR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEPDnJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:43:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81C6A7B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:42:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-250252e4113so9316044a91.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684208553; x=1686800553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWEDbA0e08o53RdV5T/MGMWQcP1SW07qkBJKSLgM8nI=;
        b=h80UC7Ki97MZ46YYh1nY9kuKHzsLOFKTnlpXGemW/gRc9Gnrr4AMdiGeszYgZb1+nY
         tHxXS2G/pM1HnbAgHs3EFRFTnZpT3D89PRQnzeunJNJ3Tyj467jY7+lUQ5yjeCOk2j1f
         ngz159R+oxID5ksOq83NNowOGBJaAZVKeHeYrvG+G+I359a0S2FY5sRp/qKx+gDFiC6G
         mHvCr2Cp70B5huhQnt3Gj7vGZU9aCanbNHuKbu5b6eIs0GU8Sw32UjqBn8sGGX7AYhMx
         /W3LQS1QU/HvUZl2pAqV08WTyxE7F79tR7RFlcJVj0Kc2xu7wseXC4qEq8QX+fBlbGpI
         L0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208553; x=1686800553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWEDbA0e08o53RdV5T/MGMWQcP1SW07qkBJKSLgM8nI=;
        b=GS0J7HIvglEY09Q9esXAO74mC4Sd53vmUW5Em549O9dSm+bqMDCemVYQJntErNndae
         w5ghqd7GtSZty/OTDTMS9tJ3Zur2UJcbR5ow11uk+Gti3rrijL54h7H3k8IMMUkGJDXA
         IG24WIsZE8OsIKRgaOd8YdAtgb7kbUnfZrjwsRZhUHALIYK4LxbFdqYUXvh8ooEqDj4D
         unRMiYgfiHWH3Y6tu4FJdoW+oo7UwFbRBD29aPqfBdk73BtHfTwwIfWPZjZBtudXQHtD
         JDbDv9T67CrhZPs7IsX3kEvmAbp/pX3kl6mbsETtozwXNJ3qdEQRzTqyn/ZvrcuKRhMs
         r/0A==
X-Gm-Message-State: AC+VfDy1aXI3aAIkNivIqPi1U8kCk7F+qZntkyv1lhIr/CrdtRpsBcFK
        2obOAgXhhaQdAZIWuayI3Ew=
X-Google-Smtp-Source: ACHHUZ7UvyyRZgqWaf2Op3DDkAzg3ZLkzTaA+ZfXZMwDEnbtBULVfCxaMPEjD6V+B+gluMnzbVEsWw==
X-Received: by 2002:a17:90b:160e:b0:24e:37c6:9681 with SMTP id la14-20020a17090b160e00b0024e37c69681mr36241498pjb.38.1684208553605;
        Mon, 15 May 2023 20:42:33 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b0024e49b53c24sm402972pjb.10.2023.05.15.20.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:42:32 -0700 (PDT)
Message-ID: <a7843640-7fc9-379f-8a21-a2e599f742d8@gmail.com>
Date:   Mon, 15 May 2023 20:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6.2 092/242] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161721.802179972@linuxfoundation.org>
 <20230515161724.671015328@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161724.671015328@linuxfoundation.org>
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



On 5/15/2023 9:26 AM, Greg Kroah-Hartman wrote:
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
