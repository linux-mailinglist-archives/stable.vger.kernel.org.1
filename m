Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963D73A1FF
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFVNiv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFVNiu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:38:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEA01996
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4725e9917so74835211fa.2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687441127; x=1690033127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3fAlIm2VhzCLJtFp8wdA5IrYQ1XrCTKspq5908UfLk=;
        b=vReaDcpxAvyHB+o7E3w9b9SHtpfqpQkolhhBnkBZTD0G+S0TiGdADQIBi6f/BkQPE1
         RsEr+l/hqkFNAgYV08ZuzPD/ClEl5aMCVISMZdVPhXk1vZ0A6/Z5EpErDYuyHdGC+iOw
         DGsHbhbOBjCMPbs1GcInFXZIF1IZ/S+tL5wJIcCtOTCpjug4xJZndt3r2psnjnvNNaAE
         qgd4cqz/fldj9npBKt80vwZ6LFmSv5BpVmB7M2s7BpYuy7PbBOVfwiQBsAYOB2EfanIM
         bQ+oCRpNobHCPIiu6d2TcZNZiZ9NqZWEDJyT9W7+pjRYnyy2SwPDGr5qFFnVfqRCWGZq
         0s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441127; x=1690033127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3fAlIm2VhzCLJtFp8wdA5IrYQ1XrCTKspq5908UfLk=;
        b=QsmC1pxwsLchqkbL5GxlEqTxBOxSX9wCALYSy5Gv1Vnvq4L7jt2sS6yefHamMf71D9
         Ry28/qux37JS/zvyIpOr6yxqOMdKWWSc764IbYFC+YX0dVx0UnpDiWtmQKMW6kCAkzi1
         cwAgdCbtavRO9k9ES1g3czLjFZQm2+dDMZhOQ4gF28ala80oXHi3ceJwHtVerubTyy3/
         qD6zOHtLNWAA53+5EPbhF5uKyEz3YHyIRTk3+23mZPtzo/j+tmP+ThUj2xdyGgfcyMFJ
         GwcqhR7VaJR/X5/Z8B56WPQuQMUjVFDmRF5y13yLkoGTaNBQraBS3p/8U4bymcT04gjt
         6DaA==
X-Gm-Message-State: AC+VfDwMTXfzBKxwQFCKPWVai974WT0cGxvT+B1ur/0AknAJBumsQxZu
        XIJNdntMFxBYcUBct7kMyjK8Jw==
X-Google-Smtp-Source: ACHHUZ7Bt2qtBr8gJBo73rt2dlrHsweBpWqjh8pFTmwB8sLaeF0v2btwzVScH2ytRFqvBmyMF2f8cw==
X-Received: by 2002:a2e:6818:0:b0:2b5:7b4a:cf8f with SMTP id c24-20020a2e6818000000b002b57b4acf8fmr5258300lja.10.1687441126860;
        Thu, 22 Jun 2023 06:38:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b0098d2d219649sm912866ejb.174.2023.06.22.06.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:38:46 -0700 (PDT)
Message-ID: <36b7e220-3f9f-726d-62d7-af05eededeab@tessares.net>
Date:   Thu, 22 Jun 2023 15:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: pm nl: remove hardcoded
 default limits" failed to apply to 5.4-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062218-porous-squiggle-d837@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062218-porous-squiggle-d837@gregkh>
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

On 22/06/2023 09:57, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From 2177d0b08e421971e035672b70f3228d9485c650 Mon Sep 17 00:00:00 2001
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> Date: Thu, 8 Jun 2023 18:38:49 +0200
> Subject: [PATCH] selftests: mptcp: pm nl: remove hardcoded default limits
> 
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> One of them is the checks of the default limits returned by the MPTCP
> in-kernel path-manager. The default values have been modified by commit
> 72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
> Instead of comparing with hardcoded values, we can get the default one
> and compare with them.
> 
> Note that if we expect to have the latest version, we continue to check
> the hardcoded values to avoid unexpected behaviour changes.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: eedbc685321b ("selftests: add PM netlink functional tests")

Thank you for this notification!

I'm not sure why this patch got picked up for v5.4-stable tree because
it is fixing code that is not in v5.4 but introduced in v5.7. The commit
mentioned here above has not been backported in v5.4. That seems to be
confirmed by:

  https://kernel.dance/#eedbc685321b

So no need to do anything here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
