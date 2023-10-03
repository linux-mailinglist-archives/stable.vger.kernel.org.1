Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4887B72CD
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjJCUwc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbjJCUwb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 16:52:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA07B0
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 13:52:28 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C9D9A86E54;
        Tue,  3 Oct 2023 22:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1696366346;
        bh=5U9wlg6+xDMoa0uykIJIp3E7//ph3xDmdW/aRu9O04c=;
        h=Date:To:Cc:From:Subject:From;
        b=0CuoGwoDGWWW5Sm+RnHyU/wABQmb76XAs9VPCsQOrmtnKvBoPpFCTL6TJHt6tHyEf
         18zcVTtPw+HCFUHQ5xjX4FAdxOtZa17lOA9gZJMaXe24dLnpNo4/SX6Cwymm20lmkw
         ejinerPJ1b+sNfrX6anKyPNnx5w5JCdkjar1e9LpRmMS9meLuecA3uTnckkEsilRFb
         /D3z5VAORE6HvNcwwLat/gR+6p77MXRUhqycbmvJoVxNYc8iJ6WbhkFJBCIF2SHlEf
         aLZDZDFaFEla0dgvuXCfpgtmR03LFhQfK7KVtonLfbVj4sBPM2xYlsk4/G3OXyhKxb
         YWlUnja8k+xvQ==
Message-ID: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
Date:   Tue, 3 Oct 2023 22:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-stable <stable@vger.kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Subject: Drop from 5.15 and older -- clk: imx: pll14xx: dynamically configure
 PLL for 393216000/361267200Hz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please drop the following commits from stable 5.10.y and 5.15.y respectively

972acd701b19 ("clk: imx: pll14xx: dynamically configure PLL for 
393216000/361267200Hz")
a8474506c912 ("clk: imx: pll14xx: dynamically configure PLL for 
393216000/361267200Hz")

The commit message states 'Cc: stable@vger.kernel.org # v5.18+'
and the commit should only be applied to Linux 5.18.y and newer,
on anything older it breaks PLL configuration due to missing
prerequisite patches.

Thanks
