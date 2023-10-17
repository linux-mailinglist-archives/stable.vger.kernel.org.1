Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D837CC846
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344084AbjJQQDQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbjJQQDQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 12:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33395
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697558548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v32pfxRKc//f3UunzAZaeCMCVvlHLiZlto1dwpElIM8=;
        b=aoCIP00tIqwHkW4DXrtBYn0T34lbrZy/5As+vggzcqBah52H2BTi3m5CbXrQCL3YQZvxPn
        //UVnKhSd3QhaJSsdNGHVeFMp+bat4XtKC01qzhCsjoENqMU4NcEco15Txz8M63+aqO+Ts
        euaRl4uknl5iPBQtKxhTZn99lb5crvg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-5gaQzsZBPIOTY_p2p14U1Q-1; Tue, 17 Oct 2023 12:02:27 -0400
X-MC-Unique: 5gaQzsZBPIOTY_p2p14U1Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bf8678af70so218159266b.2
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 09:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558546; x=1698163346;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v32pfxRKc//f3UunzAZaeCMCVvlHLiZlto1dwpElIM8=;
        b=VfQrOpJesMHqOrfL79TveSjtPvatFtOp+TKzMWWldf5Cb1E7hdfcb0n52j/aDzB3nI
         7rJ458pteAOpDuiYzEuj+nkL1FfFUxOPoDQ3G2r3VwEDPHzXwgB6S03wr3iMyly6kr5E
         6NNnqsrymtXo1c8o+RrChHBNb3SfrrRr5XMGUoRevsa5bj3WEOPW1GRipP2qbW/kVuN1
         h3BkCn9PZjrMSM1j2nv9hAYh7ViiMZUS1x0+RNASUQsgdGnyYOHDuQDE2efKeA3xyNl8
         QyEClhjO3BriPVJ/N22EdckCXM+FW0nSo+a2yxgXku0tGZfaj+jMjYzMxQAfACfs14lI
         /2Tw==
X-Gm-Message-State: AOJu0YzucBEa2Mro42lmG9btV6FBOL3Kn44/GJHhTCd4lFVzI7c5Jre6
        VWwbazZ0LbmeJiGgvraOsMlOXQOvJqABd5N6qae/KqpgWxSCG7ciIPUQGQqWMaA3bKaVhgF1FAF
        TWVUck1gw0ZFVdQcKT6qpN06wSuCEAqOM3MxCzD+W6WBe9JZ6WZiHrLA30afck+PUVQVjPS/JKz
        g8
X-Received: by 2002:a17:907:74a:b0:9bf:3c7d:5f53 with SMTP id xc10-20020a170907074a00b009bf3c7d5f53mr2303175ejb.45.1697558546012;
        Tue, 17 Oct 2023 09:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6u+YkM3Mn4mY5m0JE4EmeTMcr1spCDJTZAgrcNpYakD0TJhi5C2Vg0AdgT26flpr51EkaMQ==
X-Received: by 2002:a17:907:74a:b0:9bf:3c7d:5f53 with SMTP id xc10-20020a170907074a00b009bf3c7d5f53mr2303143ejb.45.1697558545676;
        Tue, 17 Oct 2023 09:02:25 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ci11-20020a170906c34b00b009ae587ce135sm53162ejb.223.2023.10.17.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:02:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, graf@amazon.de, rkagan@amazon.de,
        linux-kernel@vger.kernel.org, anelkz@amazon.de,
        Nicolas Saenz Julienne <nsaenz@amazon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: hyper-v: Don't auto-enable stimer on write
 from user-space
In-Reply-To: <20231017155101.40677-1-nsaenz@amazon.com>
References: <20231017155101.40677-1-nsaenz@amazon.com>
Date:   Tue, 17 Oct 2023 18:02:24 +0200
Message-ID: <87bkcx6xv3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Don't apply the stimer's counter side effects when modifying its
> value from user-space, as this may trigger spurious interrupts.
>
> For example:
>  - The stimer is configured in auto-enable mode.
>  - The stimer's count is set and the timer enabled.
>  - The stimer expires, an interrupt is injected.
>  - The VM is live migrated.
>  - The stimer config and count are deserialized, auto-enable is ON, the
>    stimer is re-enabled.
>  - The stimer expires right away, and injects an unwarranted interrupt.
>
> Cc: stable@vger.kernel.org
> Fixes: 1f4b34f825e8 ("kvm/x86: Hyper-V SynIC timers")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>
> Changes since v2: 
> - reword commit message/subject.
>
> Changes since v1:
> - Cover all 'stimer->config.enable' updates.
>
>  arch/x86/kvm/hyperv.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 7c2dac6824e2..238afd7335e4 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -727,10 +727,12 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
>  
>  	stimer_cleanup(stimer);
>  	stimer->count = count;
> -	if (stimer->count == 0)
> -		stimer->config.enable = 0;
> -	else if (stimer->config.auto_enable)
> -		stimer->config.enable = 1;
> +	if (!host) {
> +		if (stimer->count == 0)
> +			stimer->config.enable = 0;
> +		else if (stimer->config.auto_enable)
> +			stimer->config.enable = 1;
> +	}
>  
>  	if (stimer->config.enable)
>  		stimer_mark_pending(stimer, false);

LGTM, thanks!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

