Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052070440C
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEPDmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPDmL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:42:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC37559A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:42:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so73315ad.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684208530; x=1686800530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFTJu2wWhYQ+AebqISrsV3BzsJGQ1gjBy5fDqwWThPU=;
        b=FuXYm+fiZHMEo5guN7d++FfpXJN6u5oxhpvcxFVGg6PbJ4wBSOjv66aUOwKpyA3U0V
         HOCTSZCLAkr6K37D1L4m/ckwVX+LLSS3BPmTQKz9SfTSUoM/tnY/zM32iKCr/W0o857P
         iAp7AZenciZf2rkHHjuEJYhpKblMQcs8+VYQeZsdNRw6b1CG7XsZo+e/pIa/XRY1GT55
         iB7SKD7Z8mKvc2nazIbLeFF0+Dq0VGNmdRg3o6Qs8WyfCTUwPWNnmX7N3dYNH/4MTIU7
         216o+NhZoIhQMNSxSLw3WFDr2Grcj8k4erTCunquP/XXoubPGTXNWpf7m4F4Ok0jnRpu
         T3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208530; x=1686800530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFTJu2wWhYQ+AebqISrsV3BzsJGQ1gjBy5fDqwWThPU=;
        b=PBJkgRhAICpGnQPuC9tMV1PD6/n7uyJOZAbnW5CI4SShi3i5nELPTfIAReLcpg6w0U
         mzDD9lzvW1uk4xAQ/E1AZ3heZoOdRM4kk91/8XJUQmhukNOi6Q3h4ZNRX62R89LfSONX
         jqdzVlX/aQGpApOtQW9bSbMVBNes54Ox1LJTkGEJfK2QT+gkrx41wtw6cWn4/yawXwkr
         ceKrVYiI6HfcTLb6/snPs+EomkIJYONAHyxgGKjwDdqt81IRaE77RYhAHGlqnUOQ/I8h
         w+WIphVpxxNuojJrdHzTnnVgOW2OJv6aMXrJRHqWGqODh6GG82AUoOX2ZRC1DdOJohBU
         RM1Q==
X-Gm-Message-State: AC+VfDz3XVUr0gKQSv5rkJcjsq4lkQgqd/ocbH2V2Pvk2wT2yV3woZDw
        dWU+x/ZUF2o3lNduduEYuLc=
X-Google-Smtp-Source: ACHHUZ5QHROk1+S9ZSJaGrSriCpQumHU09tIOc6zj87tmZ1bH4SeFfrxAMeNhjT+uiG/t6T/YFEtgQ==
X-Received: by 2002:a17:903:22c6:b0:1ac:3739:9969 with SMTP id y6-20020a17090322c600b001ac37399969mr47047977plg.48.1684208530023;
        Mon, 15 May 2023 20:42:10 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001ab1cdb4295sm14266252plb.130.2023.05.15.20.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:42:09 -0700 (PDT)
Message-ID: <9574bc6c-ad0d-9847-4925-4cff7e4514a1@gmail.com>
Date:   Mon, 15 May 2023 20:42:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6.1 089/239] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161721.545370111@linuxfoundation.org>
 <20230515161724.344429171@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161724.344429171@linuxfoundation.org>
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



On 5/15/2023 9:25 AM, Greg Kroah-Hartman wrote:
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
