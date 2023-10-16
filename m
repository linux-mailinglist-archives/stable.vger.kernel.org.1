Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B007CA068
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjJPHTD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJPHTC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD4AD
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697440696;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
        b=Ur0DbJybhqotFRfJiDCJqswfi0TofjzHP73iZ15XkeXJh5N90h7Wi8cRYhOZH8yalY8hkz
        XVPpiRlIKgh0tgMTmq5lDQbic0reyGJc9tlG7qRyMz/2yEOjDQvD+0gbzqpGX4RvqlQbbR
        ohuJw/7wwQF6AYugTXQFE6jp55AAqSI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dgpiWRcMMoK3NWP6EGAlkQ-1; Mon, 16 Oct 2023 03:18:10 -0400
X-MC-Unique: dgpiWRcMMoK3NWP6EGAlkQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7abda79fc74so958789241.2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440689; x=1698045489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
        b=aZBeGSGVelaxdFRsHC3Wzwtt29eobc0LKkmrW0a54wfN4okEMYSJGoRnEW2tTV846u
         5MLE4x9ekZf5C6hTRAOzdtikpJJpFtZdpZzt1VEMtCS3IH32/m/o0lFhHPzrQ1H1kbxK
         2lI4AIJNmY/UCsLFYK0mHwq6m1kp2+ALjBVCuOFey+Q8Gcp3RUWZQzphRJGqlEPIYKc8
         IFQPbJlYVq+kCbQcQ9zErmES9gPGlwoARCzdj90QhS5jiXu74S+R798sTorhlmYqniXr
         molOPQwheHmXvp7kgURk187wvXRjM6FDCqVk8p1lprsPqRMPxzIihRV+LGUSxGm9lkPm
         Qymw==
X-Gm-Message-State: AOJu0Yw8OvTwGQj7dF4623g3zuHu3zSVbbOGKUJ2JDsAwcwIh5WyyA0P
        pKJZssWjs338SrURPyn/4IhKJvNstMztJrTGjG6+zDKE+XYPQy5TVgKfR1zyodV32RaDi2wiV5X
        uooPF9dJJ1+1e4uLH
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id c8-20020a056102318800b00457b01c4a8emr8522093vsh.7.1697440689469;
        Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrYKoQ8rnr5V8nFuKW8RRuaP7a7IwQbOXpJHv3bolS3RrOuy5SapWm+qgVLdmd8Y1bvVE4YA==
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id c8-20020a056102318800b00457b01c4a8emr8522084vsh.7.1697440689214;
        Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p17-20020ae9f311000000b00772662b7804sm2784186qkg.100.2023.10.16.00.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 00:18:08 -0700 (PDT)
Message-ID: <6b9b570c-8d73-eb64-40a7-fe7492e68be5@redhat.com>
Date:   Mon, 16 Oct 2023 09:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [RESEND PATCH v2] vhost: Allow null msg.size on
 VHOST_IOTLB_INVALIDATE
Content-Language: en-US
To:     eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
        jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
Cc:     stable@vger.kernel.org
References: <20230927140544.205088-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230927140544.205088-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 9/27/23 16:05, Eric Auger wrote:
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size = start = 0 and last = ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Cc: stable@vger.kernel.org # v5.17+
> Acked-by: Jason Wang <jasowang@redhat.com>
Gentle Ping.

Thanks

Eric
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
>  
> -	if ((msg.type == VHOST_IOTLB_UPDATE ||
> -	     msg.type == VHOST_IOTLB_INVALIDATE) &&
> -	     msg.size == 0) {
> +	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
>  		ret = -EINVAL;
>  		goto done;
>  	}

