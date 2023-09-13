Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15F79EA4E
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIMOBC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjIMOBB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCB881BC3
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694613614;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
        b=iTjKRLz++kwQDoV6ybdz5g8N2TXWH6cpoWNPaSc4YzSvbQP4qwEs+wjNdUrwlUyAWViYdG
        PlyPoIhPn1K4OZtmiIJB7rGuiUHqt5dMfqBjRbc2/giJKpa4viun2YwJqJtAA9nDLeqKgV
        u7am5H3lp2ThwbFzAY35iF3lgTd/QNs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-14Vz67l1NXqmgigfYRWuxw-1; Wed, 13 Sep 2023 10:00:13 -0400
X-MC-Unique: 14Vz67l1NXqmgigfYRWuxw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76efd8bf515so66974485a.1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613613; x=1695218413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
        b=dCm4nVX2rBD2Ot4aTFxHh3S0awJKJsbhcnZWgZd6TvwzhIXqBkGWUeRJaBbRxuHKzx
         /QS0j+I+P+wME0BWWnKlflsxBObWH4ZF1XV1rARHsqRw+xl3KMGWltm2pGbmsnVk97Cz
         ON4W9ha4IaCY5h6VtabVLnsNRcueMvVqCMce04mKAyHJWAKxLHibyrhWylEMJefKIfUs
         7e1mA1ix6ALhcJ5aLePxsG0T9z5lYo1sKXUuAtyRD3QjS9Q7SNhF+xZkMeHEq8vpX5cm
         7dI/RPTWLkpXuzV4bEc3DLsKmcqBnduQmsHPIWwLRCf3t9j2u/z+qWwu6OYeNpFA+FVl
         8qnQ==
X-Gm-Message-State: AOJu0YxcRutTC/7YvUi568dV5WR5Qc5EdOmN53Fe/eTu0Wdd3g1uiViE
        zxSSTvL+Oktx2wdfnjzn8sAhf2eAJPjA6EphvE39frFt8wTe+oXP8Kfl6vgPHdGP+PC+hmBAxAi
        zzUrYLlLMLTR3LSWA
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id y3-20020a05620a44c300b0076ef686cad8mr7244562qkp.13.1694613613041;
        Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfk9vTwiioPzhJO0D1j6+0LQmPdk1mn8JxTGfaPUXi0LyXZ0YuCSf940L14zsRR6mW81HaUA==
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id y3-20020a05620a44c300b0076ef686cad8mr7244535qkp.13.1694613612753;
        Wed, 13 Sep 2023 07:00:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u9-20020a0cf1c9000000b00653589babcbsm4456536qvl.87.2023.09.13.07.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:00:11 -0700 (PDT)
Message-ID: <bed381a8-7d3d-d596-bc88-6ff8a7a5a33b@redhat.com>
Date:   Wed, 13 Sep 2023 16:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Content-Language: en-US
To:     eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
        jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
Cc:     stable@vger.kernel.org
References: <20230824093722.249291-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230824093722.249291-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 8/24/23 11:37, Eric Auger wrote:
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

Gentle ping for this fix? Any other comments besides Jason's A-b?

Best Regards

Eric
>
> ---
> v1 -> v2:
> - Added Cc stable and Jason's Acked-by
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

