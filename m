Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C552742BAE
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjF2SAu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjF2SAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:00:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AFAE49
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:00:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso1010228a12.2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688061645; x=1690653645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xpjbvJqSJwxqXLuc+xTBRlnVHjTEeJDSlKVXCaXSlg=;
        b=IEoLj6z/shC+UvIMOYRiqceQEQivpyp5wRlMbvlvWRXIm/yuPCh8jQVO6WH4TyLVjz
         pk/4R0kZo0qRZPpT2tD04gyTx4plsfSiPkbezJmvYCFYIvpH7aM1tupp4WC3vFl9S3Ob
         s0jjDsvjkeLIFl8LVYqWgGgBCzKWPKssSsl7xg8chQe8opFyuSswhvNjoROlW2ceAoz2
         G4/EvRK+hzrIreINDhPqxSziQ2I8/DTUGhEL9ekEuqMdnv5wRrST6+nRNUmS+F+CBjo/
         cutHkFM1JWoo+3bsPfHHCTB0CcvgHfmKqjM7Ug0rK/8vpC+pLANopjGxu4y8FuEAPsyP
         R1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061645; x=1690653645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xpjbvJqSJwxqXLuc+xTBRlnVHjTEeJDSlKVXCaXSlg=;
        b=BDwQFvXQRsnTW6i6w3kvXnSbzQryfVbtLHC4NiIti0KMXjRV/QDeTnxAZq0FTOvFrQ
         se2lc1bdhvdecLY50LML5pzDZNZUGS1aAlzUR3CBVe9GI8GTnPwo30h4PGCOFK7q/QJv
         GUz/8Ffo+eUohWuBXeBuHeANmKeAVMrDmiJOPC9p8K4HBABmPrfY3edVJhmEiGBp09v7
         dYmOyWS+Se/WLCqrOHWDtN9o+Kfa+OyWXJ2baMjOQpi/uYmnlBVA1Ks5QfJND2DXuDp5
         SvNstAOV3UN/vEBaMmDLXZc0RDEabTlSHlSiCVVwfhe1C+nWekOHeHSvGrDU4uQeR/ih
         +pmQ==
X-Gm-Message-State: AC+VfDwwGjQrbzXrUGhDjbUnp2C+xrGf9TrDPDW7Ycu3bEJPP+jNzWLC
        5DZkK/8wM6L8DsF2bsdaVb0Gmw==
X-Google-Smtp-Source: ACHHUZ4bPd4nSzfKusJuqGLzv6fRN8ynOeAU1PU96oM+oSvNtLReeOrqicVBLOSLNCUfPWGRzMQUQw==
X-Received: by 2002:a50:ee96:0:b0:51a:3472:9ee0 with SMTP id f22-20020a50ee96000000b0051a34729ee0mr27872141edr.29.1688061645425;
        Thu, 29 Jun 2023 11:00:45 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c98d000000b0051dd4daf13fsm1290848edt.30.2023.06.29.11.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:00:45 -0700 (PDT)
Message-ID: <062b7104-b536-2b09-acae-3f99d57368dd@tessares.net>
Date:   Thu, 29 Jun 2023 20:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] mptcp: fix possible divide by zero in
 recvmsg()" failed to apply to 5.10-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, pabeni@redhat.com, cpaasch@apple.com,
        kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062349-nerd-rupture-49ab@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062349-nerd-rupture-49ab@gregkh>
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

On 23/06/2023 11:30, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0ad529d9fd2bfa3fc619552a8d2fb2f2ef0bce2e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062349-nerd-rupture-49ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Thank you for the notification.

I think we can drop this patch for v5.10. The infrastructure in the code
is not there (mptcp_disconnect()) and the risk is very low: we only saw
the issue recently, maybe only visible in newer versions due to other
features.

So no need to do anything here for v5.10.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
