Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A239D77F899
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351784AbjHQOSn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351819AbjHQOS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 10:18:27 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39BB30D1;
        Thu, 17 Aug 2023 07:18:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 660AD835BD;
        Thu, 17 Aug 2023 10:18:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1692281904; bh=odByIvjRi92I6foojdwddE69jn8cbNIsBbc/Ta7FEDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WtyepLvm4L4V/LRIR2m6x1MkMRKW/q8myjxkbfV5i7cjymEWv2Q+R1qyr/Bu8D3yD
         z9Vweq8AZcTsXv9tj2dAP4XimsPkVcAUAFJMABKsfHemL90gWLrjj+hAWSLzJHDlNs
         c1LI6J1T8e5hXsEwpQPrr2tspU5lX/lTu6wrynqjRYT9gIIvvKT0o0FfIsv8QjMPPo
         CBXys5a83aRMTnC9RPdIhtoHQl8iyF7nKrvRz84q/Scw6zFTg3q28Ezepqw6xvhEpw
         ZARnjOxRCTtubJSUR4Rt/9Z0VtMnVGuTM9Jh+FcpRC29tZa5zjERrVRs9IAQb3R51Z
         qm41vHJox/9Hg==
Message-ID: <3de0063c-4683-715e-1ba0-f20a82d3bf59@dorminy.me>
Date:   Thu, 17 Aug 2023 10:18:18 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v4] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        stable@vger.kernel.org
References: <20230810142346.96772-1-sweettea-kernel@dorminy.me>
 <20230810172457.GC701926@google.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20230810172457.GC701926@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 8/10/23 13:24, Eric Biggers wrote:
> On Thu, Aug 10, 2023 at 10:21:16AM -0400, Sweet Tea Dorminy wrote:
>> +	/* Dynamic allocation is needed because of lockdep_register_key(). */
>> +	blk_crypto_fallback_profile =
>> +		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
>> +	if (!blk_crypto_fallback_profile)
>>   		goto fail_free_bioset;
> 
> err needs to be set to -ENOMEM on failure here.  See the suggestion I gave in v1
> 
> - Eric

Apologies; that's what I get for trying to rush out one more patch 
before going on a trip. Hopefully v5 is correct. Apologies again.
