Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0770FB7C
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjEXQM5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEXQM4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 12:12:56 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF11A7
        for <stable@vger.kernel.org>; Wed, 24 May 2023 09:12:49 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 87BD98214D
        for <stable@vger.kernel.org>; Wed, 24 May 2023 18:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684944767;
        bh=EFHgor1e8+p17tbcVO6CEerUq8G9pb5M5p0zuYlH7tg=;
        h=Date:To:From:Subject:From;
        b=SanOrZAe8ZdhlAU05hzaOqnCD2DU4xE9jyRKBjVwsTZvuKqKOgcsY0dwlErYMOsea
         NJ3dCg87/esnB+CjCsuslGUg6asatUoUrQVV8ak5SOzq2bIW13PU+owhEsZPNAXPV4
         muAgaW0+8cxX9aJf5VYIIW0P1+E+HHp4CPmHGazaJHsR5B8YxtJ15z7bIAljdZQOiI
         COy+zk807znsVTBfbMporNFRNO8CB2qqygwiCWZ//z9l0naB7NV3kTSKUQCOR9oFZh
         QyqsT7Dq9iay2RHT735nHk6cIa+d/zst+DMYMqTuebS0Zt0I+DMlA7Iz95pqI/xxRN
         pnB5q3bKpEN9g==
Message-ID: <cfc2511b-51d1-771b-8cd0-5533d03c0367@denx.de>
Date:   Wed, 24 May 2023 18:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     linux-stable <stable@vger.kernel.org>
From:   Marek Vasut <marex@denx.de>
Subject: ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport to stable 5.10.y

ee2aacb6f3a9 ("ARM: dts: stm32: fix AV96 board SAI2 pin muxing on 
stm32mp15")

Full commit ID

ee2aacb6f3a901a95b1dd68964b69c92cdbbf213

Thank you
