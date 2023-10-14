Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29157C956C
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjJNQji (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjJNQji (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 12:39:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B96A2
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 09:39:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBD0C433C7;
        Sat, 14 Oct 2023 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697301576;
        bh=KMnJhorsnSWz5/7BlQOX6Zikw83Hl9vuJV1gG65YlOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUlmydetFqtHuStINlBONXkFH4arANnAtY+p118N/Zd9xNjP+0Wz3zLNIgAiZ0fcs
         sAdz3en4vqYCeH1BvFFBFs4+yQm3oVt7+JYEoOVp/+rz8eeVqFJSHm4oMP7bk0De6U
         2qrH2q4RqsEcMwL5ZTIhyNn2Cv8KefweVUNgoYWYX7jPrisM656LcuTFn1UkQD0B2C
         SvmZWcNgSx3CyVweFKzWVDL+oLOXImvXBl+6+zy7nfF+0g3V0+MSfgX+yjY4drV6PE
         OZy8Wn3J5TmPbRpn5lbJY19G6HeV3QiwAzeUp9OP383DQrkDK+lbsNdNozTC72TGA2
         Hu6GTMFVdodHA==
Date:   Sat, 14 Oct 2023 12:39:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Marek Vasut <marex@denx.de>, Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: Possibly broken Linux 5.10.198 backport spi: spi-zynqmp-gqspi:
 Fix runtime PM imbalance in zynqmp_qspi_probe
Message-ID: <ZSrERw6ucvl1wLWX@sashalap>
References: <9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de>
 <ZSjYC_ATX193mJOA@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZSjYC_ATX193mJOA@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 12:39:23PM +0700, Bagas Sanjaya wrote:
>On Thu, Oct 12, 2023 at 06:39:10PM +0200, Marek Vasut wrote:
>> Linux 5.10.198 commit
>> 2cdec9c13f81 ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
>> zynqmp_qspi_probe")
>>
>> looks very different compared to matching upstream commit:
>> a21fbc42807b ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
>> zynqmp_qspi_probe")
>>
>> The Linux 5.10.198 change breaks a platform for me and it really looks like
>> an incorrect backport.
>>
>> Dinghao, can you have a look ?
>>
>
>Thanks for the regression report. I'm adding it to regzbot (as stable-specific
>one):
>
>#regzbot ^introduced: 2cdec9c13f81

I'm going to revert it from 5.10.

-- 
Thanks,
Sasha
