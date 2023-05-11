Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6F6FFBC4
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbjEKVTa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjEKVT3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 17:19:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512D2D5A
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:19:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so10942505276.3
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683839967; x=1686431967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc8hUlEPkHXHpIXaObZi2PEY2szZrP2OC/2zdz9YSM8=;
        b=GBOsY0xKh32hZmAjiI+2tIEUFpP/w98yvdkIkerE3xKnb7+LX9xcPEFSVNiSWHlUc6
         rzD2un+RgboQBATM0H/exrHiR42ToPnaprS6xWswb2JI3bwZ5m/+0pYb0WzH34hJnRyi
         SPpRJXrhk3jmV2CZbmcYhFZaLAR1PDQ+H8T/oE4Y1qS1oARGTGPUTfkm/MU08kmy5c8i
         +4YjORQ2CYwSntXH0PmZfwnu8m1Sz0YVFiL2MkOARE3T6hF2RZ4j/YUhAgeNPBMhilKy
         z/Tn7VHDkco04jkRjkQMqDwkoJxh5nCW1GQW1GO307PkmTU5GpFOYxXmL38XtisC59AO
         2Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839967; x=1686431967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc8hUlEPkHXHpIXaObZi2PEY2szZrP2OC/2zdz9YSM8=;
        b=UFavQhVRuyxITKGKQVVgPOpx+oBmoixOdArZR2hfsvtdtpyDQbhYO9pL8JPWIU6lp0
         P/7Nfwg5JSg+5qFDNqEV9TPR+TURkN4ikXWy7VNCrnCMhpeZrQahOjwAkJpnkuyY1OZG
         12qsvi8BeP3OzxvmftRupsYq8r2lL0K6sdpyzfrcRD41k+tfeotPU8tgw13q+Tyu7jGk
         HrdCMMbGsZ7PixSwQjn4ibfwwvy6nOPaejgBlHgN8Yw/AjB5wgDTi0Jan2cxF2w8JFM+
         26O0s8d5k0ZMPFwyURMTO/6OrP+Nr2hNuWq1jgDkkF4M0+5GTsO3Z6aHXMnG18oeCmVq
         ckzw==
X-Gm-Message-State: AC+VfDzbtkpPPfvIvW6nASdyPWnrUFildgGJ7weA4N+mKBV8VTo/3grq
        qhtOrz7T203mzro8GO4o3OH7rEtJZYM=
X-Google-Smtp-Source: ACHHUZ4QUgn9SvBu8/bvMAP98JMZb8LOhazbEpwjq76h22pyaexHc3eakOAHRr8Tahs/rDdfmf0AHVNqN1o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1890:b0:b96:7676:db4a with SMTP id
 cj16-20020a056902189000b00b967676db4amr14611706ybb.0.1683839967423; Thu, 11
 May 2023 14:19:27 -0700 (PDT)
Date:   Thu, 11 May 2023 14:19:25 -0700
In-Reply-To: <20230508154804.30078-1-minipli@grsecurity.net>
Mime-Version: 1.0
References: <20230508154804.30078-1-minipli@grsecurity.net>
Message-ID: <ZF1b3TVTibSbnHrH@google.com>
Subject: Re: [PATCH 5.10 00/10] KVM CR0.WP series backport
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023, Mathias Krause wrote:
> This is a backport of the CR0.WP KVM series[1] to Linux v5.10. It
> further extends the v5.15 backport by two patches, namely patch 5 (which
> is the prerequisite for Lai's patches) and patch 8 which was already
> part of the v5.15.27 stable update but didn't made it to v5.10.
> 
> I used 'ssdd 10 50000' from rt-tests[2] as a micro-benchmark, running on
> a grsecurity L1 VM. Below table shows the results (runtime in seconds,
> lower is better):
> 
>                           legacy     TDP    shadow
>     Linux v5.10.177       10.37s    88.7s    69.7s
>     + patches              4.88s     4.92s   70.1s
> 
> TDP MMU is, as for v5.15, slower than shadow paging on a vanilla kernel.
> Fortunately it's disabled by default.
> 
> The KVM unit test suite showed no regressions.
> 
> Please consider applying.

NAK, same reasoning as the 5.15 backports.

https://lore.kernel.org/all/ZF1a8xIGLwcdJDVZ@google.com
