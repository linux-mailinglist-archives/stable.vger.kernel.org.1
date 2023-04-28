Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD16F1673
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjD1LO4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbjD1LOr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:14:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B44C2D
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:14:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50674656309so14899655a12.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682680484; x=1685272484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC6Pm3ksFygA2vMrmoy279inEVU/8X8+FukvfGD5RGM=;
        b=pqXE3zYKnWm2LWJCVzJQK8v+8U6NZxhhNxcxEPr6yFbKJK/n5cfMNexl7S4dXyLurC
         pw1TG+Auuf23g1VHNCtL+qFdgb270UQJG5KgS42ERTZw58gF4zZVoyHze5pljSVfYeGt
         6aksgu+CQk2xVHRFDsOmE3LKQziivCg/k/KoVdqKwn2h0vs0mm66SbPZ9ZL0ECnEfgDD
         TN6+ZfnBCmH1bF0e7onCkisweYfj7fcIz7Lopb1PhLp838ejxRQ7dJAkvo/JMTs8PB4+
         FtrERIpiT3zF61MTodXWfFWl+h0G4RIXbujyeJ+CTtz3kVVHa/2Zc8i+PNUVhs2kLrZD
         T8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682680484; x=1685272484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC6Pm3ksFygA2vMrmoy279inEVU/8X8+FukvfGD5RGM=;
        b=fwmMQEV6S4kEXIlkgnj3DM2+OiXpECAga3uXkYvRIMK6FjueJRjrO00tdS9WOTQazt
         hW7ojKUp6+Xq9wztM/1oB8X7S9LqNMgZVYENwoBVL4ngIcJlLwfV6DNiSOKBCiu7hXR9
         inC6Xu+SDnEIoZs+WecaqPnGrB7A8deysDnB7c/MX26D35doxyTS9XiSN0NFTA1paW1Z
         SUXqD0McDrhI2xoXFzSJS/Gr2wEzKNc1O9qZz04undCMwG3nMFbWDxIxuePjCR+zPDys
         //e2NjzPZXPrvkhzNXEoaPFgnUyuUa2PBOMGtsRtA3VxGbid2kle8Jg0gae6/4GdQjyw
         PG6g==
X-Gm-Message-State: AC+VfDwmSlXqk6N8JKAcBtkmvRkLVn06bV2QZ4JHTVqCy9MQY6T48As0
        nfRFWB9fo/Bj0Sf/MQPOep02Vw==
X-Google-Smtp-Source: ACHHUZ7PG7MGg6L8agrSW7fpRDab4GLP4U5E4Wnqdc9XNFyxhJtte80nHDCHNeBbDsm+lDA6m144ZA==
X-Received: by 2002:a17:907:749:b0:94f:e98:4e94 with SMTP id xc9-20020a170907074900b0094f0e984e94mr4539063ejb.47.1682680483905;
        Fri, 28 Apr 2023 04:14:43 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id vc14-20020a170907d08e00b00959c07bdbc8sm6179695ejc.100.2023.04.28.04.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 04:14:43 -0700 (PDT)
Message-ID: <0e366eea-0590-e1da-6f30-747ac4ebb74b@tessares.net>
Date:   Fri, 28 Apr 2023 13:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15] selftests: mptcp: join: fix "invalid address,
 ADD_ADDR timeout"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <ZEuV586CQyHtECVB@afc780e125e2>
 <d43a4e40-231d-879f-905d-c258e6d688a8@tessares.net>
 <2023042842-coleslaw-baffle-a9e2@gregkh>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023042842-coleslaw-baffle-a9e2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 28/04/2023 13:12, Greg KH wrote:
> On Fri, Apr 28, 2023 at 12:30:00PM +0200, Matthieu Baerts wrote:
>> On 28/04/2023 11:46, kernel test robot wrote:
>>> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>>>
>>> Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
>>> Subject: [PATCH 5.15] selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
>>> Link: https://lore.kernel.org/stable/20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22%40tessares.net
>>>
>>> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>> Please ignore this mail if the patch is not relevant for upstream.
>>
>> @Stable team: I confirm, this is not relevant for upstream, this is a
>> specific patch for v5.15 only.
> 
> Not a problem, now queued up, thanks!
Thank you!

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
