Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE57278EE
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjFHHg2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjFHHg1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 03:36:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B07E61BCC
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 00:36:25 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0286D20C1453;
        Thu,  8 Jun 2023 00:36:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0286D20C1453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686209785;
        bh=c8XgOxVWKkxS9e5v0Lz0f/+C7OVaCVJs/TfsKd/Vmzw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VspdTQzoB2PvDQWoH0U57Ly8DLYmC49YV9f13ZEHGlyEIBgZqkFbzeav99Y1wyHAb
         rNoTx1EYExsXyZ5K6Jx3t7JJ5XN+Z3SNno7ZOfOYboAlJW+lQi7v1v6GaBsHd3STOk
         Lsq7lCogaKX2CQiJ7Shzdx7VoTxyytuXBZ3Zdeg4=
Message-ID: <c8928af7-3e93-515e-1259-1d172cedef83@linux.microsoft.com>
Date:   Thu, 8 Jun 2023 09:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6.1] arm64: efi: Use SMBIOS processor version to key off
 Ampere quirk
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, dpark@linux.microsoft.com,
        t-lo@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <2023060606-shininess-rosy-7533@gregkh>
 <20230607122612.GA846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2023060719-uncertain-implant-dede@gregkh>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <2023060719-uncertain-implant-dede@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/7/2023 8:36 PM, Greg KH wrote:
> On Wed, Jun 07, 2023 at 05:26:12AM -0700, Ard Biesheuvel wrote:
>> [ Upstream commit eb684408f3ea4856639675d6465f0024e498e4b1 ]
>>
>> Instead of using the SMBIOS type 1 record 'family' field, which is often
>> modified by OEMs, use the type 4 'processor ID' and 'processor version'
>> fields, which are set to a small set of probe-able values on all known
>> Ampere EFI systems in the field.
>>
>> Fixes: 550b33cfd4452968 ("arm64: efi: Force the use of ...")
>> Tested-by: Andrea Righi <andrea.righi@canonical.com>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Where did Sasha sign off on this?
> 

I must have picked the commit from the 6.2 backport:

https://lore.kernel.org/stable/20230328142621.544265000@linuxfoundation.org/#t
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.2.16&id=b824efafca6739f6c80d22d88a83e6545114ed8e
