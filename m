Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD270440A
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEPDld (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPDlc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:41:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF5559B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:41:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5341737d7aeso1954656a12.2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684208491; x=1686800491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8muklSSsKDOiWk41cVeLRdJ/loh4oIf+0IAwRbd4TM=;
        b=RMf5l9/CoZ4Nu29hQiIGT4ak60DASextMTgysLNalT4CyPvDKRGYed88XcoOv1IzRx
         W7RqxS3jm95tKsxp5Vb1y1zVgFv6h7sgzPZPIdqXg95nQ+HwNIztgjVnyNyZC9lehmbV
         vu7MTS9KRCQcs4Wj/SvNSGlMrruxnnWxzepqqbP0g/tJvSyGuxbGpN71Wd5IYRoCYhy5
         CVs5iwSadiCI5FajzHa2KPZBBmepDZ+NegYJUBbCxR+4TuuNIgyEdrq7Vkp/4b6664D4
         55L+MGaOg5wJxgqlDI3tqEjeOvvRhqiiMhm71ext3Qk0qsMSqYN4MhW+QyIToBqoL5M7
         Zdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208491; x=1686800491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8muklSSsKDOiWk41cVeLRdJ/loh4oIf+0IAwRbd4TM=;
        b=Jc83fWQdUXztrkotiMXO3cUTbJQYh74jcb7ucuQecwzpVj8MHdYrJzR0RwhCazTp4d
         +3Oq6l1PhzZzGco8XvPlSPp7EcQMuAS4pmxSvBgsnu3v8Z1YAzfghluwuDjEKYkYxj5f
         XmoITp6jG08nb/YlOfGwqMKuLDfqOm/PGy5dVeMjFd2Zq4ILorY0r8z1pjgj9uCQmLim
         yYyePdFODAYbVAmpBb+xRmBiXOLQAtkuQqlNYHxDDakEgbFvE0IN9BJyUdqFtaauF74a
         yYTuJOcdT5ExW98XChdV6BcFC+TQhnDiYAUvNHRE0sN5lLHLpzbtcko/ApwAq7Dsrirc
         LhuQ==
X-Gm-Message-State: AC+VfDwnM5QootzG2XqfuVzb2PcyzmmkPXvsF4SCbKFs1uXI+yNmFNgt
        2JoAYply+qS6kNXXXR3N9tg=
X-Google-Smtp-Source: ACHHUZ6+NhASnNpnanf8dAH7BChYWfuh+PBucbyu2rrW36wS7jQmJ3pRoD8KCbkSrRj6RwFbgzXzGw==
X-Received: by 2002:a05:6a20:9389:b0:106:bb67:d674 with SMTP id x9-20020a056a20938900b00106bb67d674mr2947934pzh.45.1684208490756;
        Mon, 15 May 2023 20:41:30 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n21-20020a63e055000000b00530704f3a53sm9021796pgj.30.2023.05.15.20.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:41:30 -0700 (PDT)
Message-ID: <f9044b5b-a750-6f91-aa90-4d572e8dd142@gmail.com>
Date:   Mon, 15 May 2023 20:41:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.10 328/381] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161736.775969473@linuxfoundation.org>
 <20230515161751.623223787@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161751.623223787@linuxfoundation.org>
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



On 5/15/2023 9:29 AM, Greg Kroah-Hartman wrote:
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
