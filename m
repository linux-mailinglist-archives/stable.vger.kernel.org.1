Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5847E9919
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 10:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjKMJg4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 04:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjKMJgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 04:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F610D3
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699868167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwJZ0Xbnvhf2lf2q1QxNyLQ6WK9A/m8KvfH5CYCBO3M=;
        b=XOI98GDKii1rFr1BDKwbFFMZ/1OSpnD+kpp5aKVqYrC9/cGemQvXC0Sss2VXBxSXk1JVb4
        mjuQeBH5bNe8Iwr2ZpTAKmdVQ5BuGkeugi754UhQZT171ijc8btiaT4dAk4SXPc21mExkh
        N8CjhgSzBIa1EzTDph/leHXwEBAB294=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-TIqkBS_eNSmzHhTSLjQNfw-1; Mon, 13 Nov 2023 04:36:05 -0500
X-MC-Unique: TIqkBS_eNSmzHhTSLjQNfw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3314bd215ceso329152f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 01:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868164; x=1700472964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwJZ0Xbnvhf2lf2q1QxNyLQ6WK9A/m8KvfH5CYCBO3M=;
        b=oZjZs9w0tqamTvWTiBClT3NENtzB+evqt7+9cxNcbwOHch07ckHYu0xpIWFubhgjKZ
         +fC3WiCMLdrAVHOMew8o471GV36ycdrDtn1CIJetCgbkBYtMK/JTjWUe9qyjEsFxP5S5
         BFW901+SHsNIC2jThvHaXvchQvBnAQdyy+c3k3KkSaEM1CViZEn6iktOokksRFcIAv//
         5dKTPpOxzPTMiYJV8kUo7R4WBBAMZkM2Z4dcvYJm/FWz4bZhJmB7AjgpzS6oVFJ96TYV
         yxwuEFmHDFL0SSd2Thytq+Yr7aTWhxWyLzYFw73hQuPNxyoFBvya/h6B1fk1yyIfy2/X
         dijw==
X-Gm-Message-State: AOJu0YwT5dSgtEVKgVulX7kq8pFPSanygoKqHOLHJD415PNzObOW2pPs
        mbXHI2t/XcdW784N+uE/UJvSGF9Z3H58Jh0HuCpYCO5IyppRnV4F44GeS/E7tadeDsnsWOH+OIB
        ALK3oaFL4VKbp92Xz
X-Received: by 2002:adf:d1c8:0:b0:32f:7d21:fd82 with SMTP id b8-20020adfd1c8000000b0032f7d21fd82mr3475735wrd.51.1699868164024;
        Mon, 13 Nov 2023 01:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLGAlllr6+af01I7oixb2AlnKzkAe+EmipQrO095UcddK3SovOFEQ7UX3I/6FEprbQxEmEuQ==
X-Received: by 2002:adf:d1c8:0:b0:32f:7d21:fd82 with SMTP id b8-20020adfd1c8000000b0032f7d21fd82mr3475721wrd.51.1699868163726;
        Mon, 13 Nov 2023 01:36:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id dn17-20020a0560000c1100b0032db1d741a6sm4729165wrb.99.2023.11.13.01.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:36:03 -0800 (PST)
Message-ID: <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>
Date:   Mon, 13 Nov 2023 10:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete stable drm/ast backport - screen freeze on boot
Content-Language: en-US
To:     Keno Fischer <keno@juliahub.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, sashal@kernel.org,
        tzimmermann@suse.de, airlied@redhat.com,
        dri-devel@lists.freedesktop.org
References: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 13/11/2023 09:34, Keno Fischer wrote:
> Greetings,
> 
> When connected to a remote machine via the BMC KVM functionality,
> I am experiencing screen freezes on boot when using 6.5 stable,
> but not master.
> 
> The BMC on the machine in question is an ASpeed AST2600.
> A quick bisect shows the problematic commit to be 2fb9667
> ("drm/ast: report connection status on Display Port.").
> This is commit f81bb0ac upstream.
> 
> I believe the problem is that the previous commit in the series
> e329cb5 ("drm/ast: Add BMC virtual connector")
> was not backported to the stable branch.
> As a consequence, it appears that the more accurate DP state detection
> is causing the kernel to believe that no display is connected,
> even when the BMC's virtual display is in fact in use.
> A cherry-pick of e329cb5 onto the stable branch resolves the issue.

Yes, you're right this two patches must be backported together.

I'm sorry I didn't pay enough attention, that only one of the two was 
picked up for the stable branch.

Is it possible to backport e329cb5 to the stable branch, or should I 
push it to drm-misc-fixes ?

Best regards,

-- 

Jocelyn

> 
> Cheers,
> Keno
> 

