Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723C573A1F9
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjFVNh7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFVNh6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:37:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D919AD
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:37:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b47354c658so74155961fa.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687441075; x=1690033075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=473d3yfYTcDL7cbiIXGdls64wU5S7Sw7jKmOF86zWak=;
        b=CjL5wFCrBJPV2DHf/T+lGQbNlGi0uyVdyB1fCA8KA4rhVGHhuYuaAaRiJ8mPaYJMDk
         BlYKxbgHXos+erIjz7DaGFEQut1nidbv3x3PjX8nI5luavxueH0JsbF1dtKYczlHRxQL
         Ht9+mDPGFjR1kEXeEb6b6BcmutYpOcv1/TSvZ4kSY6zO9KeW/d1oZhNhUwlhBcbMHb+s
         x82XbJ8p+LpMUbzmBngM4Y3Wov15Yp+FyfSgNuQCJhxgA7J+qQsL+cVtrfV5klyCWyyl
         VbiGwpvziRyMr9lwhV3f5kLw1KdrsHcPkdA6ukj1dICGz9TWiysG49MLEIysiEL4CKiM
         nd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441075; x=1690033075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=473d3yfYTcDL7cbiIXGdls64wU5S7Sw7jKmOF86zWak=;
        b=ksqDnmnQ0uSK1vuu67aF0ydCReCZvS2RnuQFsXVdLp8PSC1U+7qJv+BPTsVvxTsKz3
         KUs8cr8e+KpyHKxX6JxLw1vStSPS0200yeAajUJdBeVW56MWu9he1jKOM9qzcul+0JKw
         /XQfBLg/dcmoxAjZayTDwifKQRDonENlv4e+EGJrFrsWnziYHEQAHQVBjRVQCNa28vEH
         SQNrfEsy5ba6RCWPGQ179/GuI2BojaADVbP5tof3BU/nAbVRtzD+7vqU7lO4FRog+J5c
         hB/LUoFmbD8o/C7ndmE+ey/Y/iYcNBaxX2kNBqen3yLPbUuJHPcbXqfYdGgKyVkBvgcB
         DSJw==
X-Gm-Message-State: AC+VfDxks2uGttNrdWgPSvfHUa10HR4rkNA3DEgeuJi8Nj4VzL5OZgE9
        OmingS61tNK6nodPqztwG2iLDg==
X-Google-Smtp-Source: ACHHUZ73uN+hOot4Dg8hCQ24YXBbW8MiJrdnx47YzxXlJecOoWpeNbGEM/s1vBHpV0NhBPf6KvoPnA==
X-Received: by 2002:a2e:9648:0:b0:2b5:7ecc:bb0d with SMTP id z8-20020a2e9648000000b002b57eccbb0dmr5763913ljh.47.1687441075047;
        Thu, 22 Jun 2023 06:37:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066ad500b009829d2e892csm4748923ejs.15.2023.06.22.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:37:54 -0700 (PDT)
Message-ID: <45f034f7-9065-0556-d5a9-379ebd7ff1af@tessares.net>
Date:   Thu, 22 Jun 2023 15:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: join: helpers to skip
 tests" failed to apply to 5.10-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062228-transport-graded-b527@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062228-transport-graded-b527@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On 22/06/2023 09:59, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From cdb50525345cf5a8359ee391032ef606a7826f08 Mon Sep 17 00:00:00 2001
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> Date: Sat, 10 Jun 2023 18:11:38 +0200
> Subject: [PATCH] selftests: mptcp: join: helpers to skip tests
> 
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> Here are some helpers that will be used to mark subtests as skipped if a
> feature is not supported. Marking as a fix for the commit introducing
> this selftest to help with the backports.
> 
> While at it, also check if kallsyms feature is available as it will also
> be used in the following commits to check if MPTCP features are
> available before starting a test.

Thank you for this notification!

With the same reasons as the ones explained in my email for the same
patch but for v5.15, here for v5.10, we also don't need to backport this
commit cdb50525345c ("selftests: mptcp: join: helpers to skip tests").

So no need to do anything here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
