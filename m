Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A179F72B90E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjFLHtP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFLHtA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 03:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A7BB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686555994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yP4vMHkO+yCSQ+z82iPRDsudDDu4cQh6jmBlyoee49w=;
        b=LO+ICnYPbClZaCFs3nmBt/OlMMcAerbN2cHA0XdZujDydSeQlqklLkJzygVvZw7ZAKW0tW
        DxuelkytppU5S4PVnIvuM8qR8WEXaiFNXx6KFKXV6+rTLr+EdSxjJN+N9TMvx6PT3RPJ8V
        18Y5FleZUQdFsndL3KkCkQIsutSsiJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-qH9LhvS5OC-dwIekzETsvg-1; Mon, 12 Jun 2023 03:46:25 -0400
X-MC-Unique: qH9LhvS5OC-dwIekzETsvg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30fc5d6e697so130391f8f.0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 00:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555984; x=1689147984;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP4vMHkO+yCSQ+z82iPRDsudDDu4cQh6jmBlyoee49w=;
        b=ITiMD51VZ0a5/qdKXnr2BY302BE045Eeqf3hFTcXhz6UYuX/yLcWawkthdSA7nbDV2
         k7GPqNd96qop+BHlsYhpujk3u2LMZXSk5Dn7R9zk4cLQ6vv7SciTFMPAjSBsXhIekVkT
         485SxLblF2wEcUPQjHaHbJ451uJgLQLaKHPe4hNLzkvkGAO6qcbRxmSY6w2AVV5RJyWM
         7PBySzaB7xuHz88R9iibMtBhptagBsVIZdMKd1qp25/BBR3YJSrbOZ0Sn7iOy4WxAvk0
         ff/QfdTaW2O8u4r1L7F6rjH/6nIVYUO0cocpb6fp2HGzzQRtIcVjN5OfJFw7rlj0pzEA
         gvYw==
X-Gm-Message-State: AC+VfDzqBqtUAP0ON2Pk/8fRlXwfs2Kd4y7PrPEbUjzkLuBY3SrOTPuV
        mvgv/vJpdOVHLZnEXSgl/lWyXhim8QwT+RWjzDQb1aoCeai1/FUVR6QOHtbdtPSVhd/XraI9jfx
        HBR5595jhV+vOJL5J
X-Received: by 2002:a05:6000:14c:b0:30f:a895:d991 with SMTP id r12-20020a056000014c00b0030fa895d991mr3131805wrx.55.1686555984695;
        Mon, 12 Jun 2023 00:46:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73G0tqHUKMiC3veRGtl5w/v7h2Kk9F4KUkzVL4unSRQmLHkul9W56Mg29yppbvMAA2E73L5A==
X-Received: by 2002:a05:6000:14c:b0:30f:a895:d991 with SMTP id r12-20020a056000014c00b0030fa895d991mr3131789wrx.55.1686555984277;
        Mon, 12 Jun 2023 00:46:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0030aedb8156esm11491237wrr.102.2023.06.12.00.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 00:46:23 -0700 (PDT)
Message-ID: <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
Date:   Mon, 12 Jun 2023 09:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kim, Dongwon" <dongwon.kim@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmarchan@redhat.com" <jmarchan@redhat.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 12.06.23 09:10, Kasireddy, Vivek wrote:
> Hi Mike,

Hi Vivek,

> 
> Sorry for the late reply; I just got back from vacation.
> If it is unsafe to directly use the subpages of a hugetlb page, then reverting
> this patch seems like the only option for addressing this issue immediately.
> So, this patch is
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> As far as the use-case is concerned, there are two main users of the udmabuf
> driver: Qemu and CrosVM VMMs. However, it appears Qemu is the only one
> that uses hugetlb pages (when hugetlb=on is set) as the backing store for
> Guest (Linux, Android and Windows) system memory. The main goal is to
> share the pages associated with the Guest allocated framebuffer (FB) with
> the Host GPU driver and other components in a zero-copy way. To that end,
> the guest GPU driver (virtio-gpu) allocates 4k size pages (associated with
> the FB) and pins them before sharing the (guest) physical (or dma) addresses
> (and lengths) with Qemu. Qemu then translates the addresses into file
> offsets and shares these offsets with udmabuf.

Is my understanding correct, that we can effectively long-term pin 
(worse than mlock) 64 MiB per UDMABUF_CREATE, allowing eventually !root 
users

ll /dev/udmabuf
crw-rw---- 1 root kvm 10, 125 12. Jun 08:12 /dev/udmabuf

to bypass there effective MEMLOCK limit, fragmenting physical memory and 
breaking swap?


Regarding the udmabuf_vm_fault(), I assume we're mapping pages we 
obtained from the memfd ourselves into a special VMA (mmap() of the 
udmabuf). I'm not sure how well shmem pages are prepared for getting 
mapped by someone else into an arbitrary VMA (page->index?).

... also, just imagine someone doing FALLOC_FL_PUNCH_HOLE / ftruncate() 
on the memfd. What's mapped into the memfd no longer corresponds to 
what's pinned / mapped into the VMA.


Was linux-mm (and especially shmem maintainers, ccing Hugh) involved in 
the upstreaming of udmabuf?

-- 
Cheers,

David / dhildenb

