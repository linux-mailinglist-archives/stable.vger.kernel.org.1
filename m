Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761E78A610
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjH1Gtu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjH1GtX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 02:49:23 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD910D
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 23:49:20 -0700 (PDT)
Message-ID: <1fdd05f6-34fc-4ab7-b58e-090a542317c0@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693205358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMcwySqNNa59U+C7r7HX6GTQlYaPuMoNlcszRbdn0l4=;
        b=iTH71vJnaAXkF00BZWj8IYQ469AyF33rrFPry7c7F6OEOSPYAVS+x9k9nwxvN/AglZWRSL
        t7bdYq59UK6rsW8Dp7688Ju49RVjbkJ6CqvLhdp+rh/JPKQYfqS2H84ISH8Oa3zi2SshuI
        hCABI6MYmococ5xXcxx5D8mGsQ2WSa4MKz+e649uxrd+sNUr5iI/dN+8NMUSUqbx36FnUw
        FyaVX/QfFJWF5y4cV2okuK7JOkp5eEOGQtaEY5Uv+LqzZDQBvuGax9W80maCqtsTqoGVCK
        yjCFpem9fdTLuuXRpMMAI1DlsJeDS0Ui87e2r92hYYfixFCGikzFEPWBq7i35w==
Date:   Mon, 28 Aug 2023 08:49:14 +0200
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IDUuMTAuMTkyIGZhaWxzIHRvIGJ1aWxkIChlcnJvcjog4oCYUlQ3?=
 =?UTF-8?Q?11=5FJD2=5F100K=E2=80=99_undeclared_here_=28not_in_a_function=29?=
 =?UTF-8?Q?=29?=
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Bernhard Landauer <bernhard@manjaro.org>
References: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
 <2023082729-charm-broom-6cfb@gregkh>
 <b8a8451e-675d-4766-a886-2ff01fad1493@manjaro.org>
 <d2cce7fe-7847-4689-b5bd-cceaeac0a2ab@manjaro.org>
 <2023082804-unnamable-papyrus-ab8e@gregkh>
From:   =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <2023082804-unnamable-papyrus-ab8e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 28.08.23 08:46, Greg Kroah-Hartman wrote:
> On Mon, Aug 28, 2023 at 07:17:21AM +0200, Philip Müller wrote:
>> Hi Greg,
>>
>> Seems this needs to been backported too:
>>
>> https://github.com/torvalds/linux/commit/8e6c00f1fdea9fdf727969d7485d417240d2a1f9
>>
>> At least an #include "../../codecs/rt711.h" in
>> sound/soc/intel/boards/sof_sdw.c
> 
> Now queued up, thanks.
> 
> And why are you the only one seeing this issue?  What odd config are you
> using that none of the CI systems are catching this?
> 
> thanks,
> 
> greg k-h

I don't know if it is odd, but here it is:
https://gitlab.manjaro.org/packages/core/linux510/-/raw/master/config

-- 
Best, Philip

