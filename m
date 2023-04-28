Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9476F157E
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjD1KaZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 06:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjD1KaQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 06:30:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801C55BB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:30:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94ef0a8546fso1579342266b.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682677801; x=1685269801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6ZT6qPfbY61GV2mUTjxHMfduki53jSqulYZ0LIEF0I=;
        b=XARgRa/NLU0s1xdmZ8jwJjgTFjcztt2wYny2R3RNgLUShEY8yIQWq4ywkU4bkI63m+
         INrK4yE46kVKqIMP8DYE0590wK0u+dsDrLkPAeS4s3P4K2VGkd/LvzkO2GO2dpc08gFU
         OjPovE3RQuVhSvf9VxUvHbh7nyCgtNSzDIYuG1R0Nhc3TokJ36Bpya2TdGrG+wqlS+YJ
         U8YC380Kt9qq5b6WJXf9BRWyLJ4uKyOY5uuUoSv3WPNyKkaBPM+8DbpckBO1vMU590JQ
         Er+hvdqsSXmWM2+Wa+StW3owKBhyOQgfPnzEj8Z8mrEV6pGXe3LiNMfp+Dfc7wJChit+
         3XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682677801; x=1685269801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6ZT6qPfbY61GV2mUTjxHMfduki53jSqulYZ0LIEF0I=;
        b=H77npiX7eorG3jztOCf/8bIBYqqna3dfdPQ5M2CdzXgX2pstkCEeaVdOlKm3FAL63l
         pILTIboLGYBZaKzDsBrFqQ5UqeYyyJCgez6sbjwJa0q2I4sKeXTdLkiYslj//r0O4pNA
         xgckMkPYWX3H1Qa0DCGH+0RQxUE1sul+BLAzEu7QN3HLRww2iD51YmHkNvLKWcUOP6Vg
         mTADjGYKrFdv68CYDufl8S3JG/ciUKbKQoAYKxAoEQlfhpRVVRxVUzSFS+gVRYeLamK8
         w3k8TPGuxZ/U/bnshhCM05pcqEuU/Y/rCp2TS0Juwtoaz+c1iL4wELWWUQsJNjC2DVbk
         dtHA==
X-Gm-Message-State: AC+VfDyZv6bXUnhuQ/qIh8QhewSwPnDpV/pJI6ZvdZ7e8bPCzTrRrO/P
        OveRWU1scoKXs/jPWoQDI9lFvA==
X-Google-Smtp-Source: ACHHUZ6GfCg6AVeyn+XTFSxdpGkoQcLBF2furjwmnaarPlLtE8uvLkoy+bf8Ndmfy719q6Dt9k5LSw==
X-Received: by 2002:a17:907:d1d:b0:94f:3b83:a4d1 with SMTP id gn29-20020a1709070d1d00b0094f3b83a4d1mr4605924ejc.50.1682677801331;
        Fri, 28 Apr 2023 03:30:01 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id l7-20020a056402124700b00504937654f8sm8942942edw.21.2023.04.28.03.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 03:30:01 -0700 (PDT)
Message-ID: <d43a4e40-231d-879f-905d-c258e6d688a8@tessares.net>
Date:   Fri, 28 Apr 2023 12:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15] selftests: mptcp: join: fix "invalid address,
 ADD_ADDR timeout"
Content-Language: en-GB
To:     kernel test robot <lkp@intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <ZEuV586CQyHtECVB@afc780e125e2>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZEuV586CQyHtECVB@afc780e125e2>
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

On 28/04/2023 11:46, kernel test robot wrote:
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
> Subject: [PATCH 5.15] selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
> Link: https://lore.kernel.org/stable/20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22%40tessares.net
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Please ignore this mail if the patch is not relevant for upstream.

@Stable team: I confirm, this is not relevant for upstream, this is a
specific patch for v5.15 only.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
