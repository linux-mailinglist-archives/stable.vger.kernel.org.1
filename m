Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE13F7043C5
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 04:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjEPC7x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEPC7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 22:59:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8E40D3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 19:59:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f4e7ce15c4so28089791cf.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684205991; x=1686797991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2/CcS1dDO7WfV4NALb8qhhxWtiUQDoacwREUk6cWew=;
        b=d8uWc8JMUuTEzZ7Lqwg8dTJcrk6rQTB8pc0AYIPgRs1ORkU+CNzpyLY1A+Ksd2wLnh
         D5Z5JwSwJZYanPy83JBOahNLVGGUT5hqnQZUBlVQ4aeyfneHKOQqoHxt8ZGGybwxUN21
         zkLDLuNH6wfxibqrdCjWeCnBplhfwFL9WtH3ENoeuWsMdoX/qDCKG68CjiotFovSKp6d
         bitGN3YEYMMOEDew2RkL/XVEITFkUpgHaZgttJrFFA8HLx6WJ7cqFzN43yyiOboj77tF
         kVmVpNkdFZ1wkNYxEWwgw7qPDlGsaU8tkIj0LOCQLKuPYaGPx9i4oZ1/CYxpam1n5Bpr
         R2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205991; x=1686797991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2/CcS1dDO7WfV4NALb8qhhxWtiUQDoacwREUk6cWew=;
        b=Nw3xyboLRrW2K28bNWqQ++8dsjBxo723FMbkkjXqRMBOqEy3n8WTfAQHc43i+Ml/+u
         +ldUrOnoxmL+iSAnr+heagufLH3l8Yn92BO8aFh/ybJWbpjV3YNNG44UZDyFEtBGZn1X
         kj2bi/mF0Hc/qA0y99azMT4wQoWuYNKTp32tdbPVzBxdJA2P/nS01VFqb3PV9OsyU1Pq
         zAR5pKHNLvPCgQ9wk7x7DSLbW5SImrE55VAQfxXTlKHvCUSYrqt+FddP7nzPERchxKI+
         CQps7JE3EfUZ//zHRBYZD8i7lzvLH8YKwOYfQlc+7Jn/tROGSc+ttj3/hgpjjpRkXqVq
         XllQ==
X-Gm-Message-State: AC+VfDzfX9Mu6HSimNEQSrNrkOE8PcuiTlU3McSELfT8XNw9UHepmQih
        i92z1ntKNmlt9i4fh+zY8Is=
X-Google-Smtp-Source: ACHHUZ4KkzqGcYXEDTqp9CcGfAsnDvZdU6Lef0A8iS1eRs8Tp/0BG3OSZ4T2r/6AqxY4beYp9WmSWA==
X-Received: by 2002:a05:622a:1828:b0:3ef:4efa:7042 with SMTP id t40-20020a05622a182800b003ef4efa7042mr58421143qtc.62.1684205990710;
        Mon, 15 May 2023 19:59:50 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a5-20020a05620a124500b00755951e48desm268917qkl.135.2023.05.15.19.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 19:59:49 -0700 (PDT)
Message-ID: <7b830074-a08b-4dd8-a9b7-9fe11cbc0d79@gmail.com>
Date:   Mon, 15 May 2023 19:59:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4.19 163/191] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20230515161707.203549282@linuxfoundation.org>
 <20230515161713.356981889@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230515161713.356981889@linuxfoundation.org>
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

Please drop this patch from all the stable queue for now until this one 
gets accepted:

https://lore.kernel.org/lkml/20230515025608.2587012-1-f.fainelli@gmail.com/

thanks a lot!
-- 
Florian
