Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8770EDA5
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbjEXGKh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 02:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjEXGKg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 02:10:36 -0400
Received: from rs225.mailgun.us (rs225.mailgun.us [209.61.151.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7413E
        for <stable@vger.kernel.org>; Tue, 23 May 2023 23:10:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hexchain.org;
 q=dns/txt; s=smtp; t=1684908634; x=1684915834; h=Content-Transfer-Encoding:
 Content-Type: In-Reply-To: From: From: References: Cc: To: To: Subject:
 Subject: MIME-Version: Date: Message-ID: Sender: Sender;
 bh=GUARewsXAraIxbibc/Wy/aksR920CDjWgytLUfCB+Ys=;
 b=Gs+kK2MZnoSvnsy8Jo0PUqXpnFQly5E71tYh688T5wCo7PHO2Bwml50/xCs7eMQbrN/xtQp8W39ievJD2yWcY5hu+bqgZ28BJIUUDYUc8BOMen+Qk0ltv7YF1sG69YXB1+7ZvNKJu/n5sFU7WdVUesGKgJIbAiZkqrOrvQKORWBgMxF+6ZsjNXywUqvYqMphgyMqn8P6eZFExL51l2KO3aeE4vCiPewVyTgj6aefzsdHe53obEWVBNzXIX6qCyGsBhkYOlxCgoH1ocDgA4515nMNsLI5UqqNt8iAcsc1l9upYGlPhh9PIfX9nZU7He3HkzWEtdPRZhbv4VlpsgtDHA==
X-Mailgun-Sending-Ip: 209.61.151.225
X-Mailgun-Sid: WyI2Y2ZiNSIsInN0YWJsZUB2Z2VyLmtlcm5lbC5vcmciLCIxOTI1MTgiXQ==
Received: from [192.168.40.116] (254.248.75.138.unknown.m1.com.sg [138.75.248.254]) by
 addb09e5ecfc with SMTP id 646daa5ae97a44e9b711e2aa; Wed, 24 May 2023 06:10:34
 GMT
Sender: linux@hexchain.org
Message-ID: <ee2c30a5-3927-d892-2a66-00cd513c3899@hexchain.org>
Date:   Wed, 24 May 2023 14:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: amd_sfh driver causes kernel oops during boot
To:     Bagas Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linux-input@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>
References: <f40e3897-76f1-2cd0-2d83-e48d87130eab@hexchain.org>
 <ZG2LXN2+Sa2PWJqz@debian.me>
Content-Language: en-US
From:   Haochen Tong <linux@hexchain.org>
In-Reply-To: <ZG2LXN2+Sa2PWJqz@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 5/24/23 11:58, Bagas Sanjaya wrote:
> On Wed, May 24, 2023 at 01:27:57AM +0800, Haochen Tong wrote:
>> Hi,
>>
>> Since kernel 6.3.0 (and also 6.4rc3), on a ThinkPad Z13 system with Arch
>> Linux, I've noticed that the amd_sfh driver spews a lot of stack traces
>> during boot. Sometimes it is an oops:
> 
> What last kernel version before this regression occurs? Do you mean
> v6.2?
> 

I was using 6.2.12 (Arch Linux distro kernel) before seeing this regression.


Thanks.

