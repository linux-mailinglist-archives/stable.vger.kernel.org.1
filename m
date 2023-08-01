Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8978B76BF55
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHAVfj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHAVfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 17:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858EFF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690925691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHR+gYw7cHBLdaoz+kXX0wBV31cLT+GSZK2PmYnjFDI=;
        b=Nl0nfs5inmEznoVQcP5xv5jLIx0y9Tk3QWAfz+ksm8CFnIQo3YOeI4r9aq6jilBDmIpJUi
        kzt9Wfh9WtF0XITd99nDSrsURBlYiMO/ESr63BwTYcoi+9do2+x9kOvSoJ93x9pTObesL3
        BKHDGsd820S1zXqirAfduRk36v/mQaQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-aoaEx7NiOHWnjDJ9QpeFow-1; Tue, 01 Aug 2023 17:34:49 -0400
X-MC-Unique: aoaEx7NiOHWnjDJ9QpeFow-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4054266d0beso14107001cf.0
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 14:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690925689; x=1691530489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHR+gYw7cHBLdaoz+kXX0wBV31cLT+GSZK2PmYnjFDI=;
        b=ZpVVgcYpHD6aNYri7mTjG+wLwKCI/XmX/HAUMJqEi2p+GKAd1OWJ22Af2stLTED8Fh
         UmICXeemFRGFmGsqU8TAgvo7uaqSNXXHx5to7Ch7oH5EmkizLtz21YdJ8UqAQ5V3K7x0
         XOU0SajzmTf3toWVZ9pjd1dTSYbpzqRSGwf2R4GmAiCUXjm5sfd0AJhlw3SjXTQBhJRt
         vtfn/baONJRNgEq5O1eFJ2k9r7Hnfpl2OePbPZXcSnHrwKxjK+ikohKM76OjK4aBYiJl
         3yj+9Xa2doIsQ7fnt+VFQ/KWwlpQsBtaSSmEHHA2N+ktqiGODZfRLuKJwxxbh3JQfVht
         EZNA==
X-Gm-Message-State: ABy/qLbTojI255X73Tt0RlnHq5f4MYqz6MxnQUv9bIvenaV/9RwSk9Je
        4M5EDvappflrZAiYzUmrwEvWGQnZWDrl755tB23ntNqJII+mqfeS5VACHaPm8eddl9/oWpM4uXz
        pGe6+laqz7NprGd8c
X-Received: by 2002:a05:622a:148c:b0:403:ae76:12da with SMTP id t12-20020a05622a148c00b00403ae7612damr16141364qtx.1.1690925689348;
        Tue, 01 Aug 2023 14:34:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlERXmNdWW2CNoL1GTyXMrbw7WyphoXCE2tsi7Ar+vBKiuIbu6/USybxg48TLXkKPEj8+66m3Q==
X-Received: by 2002:a05:622a:148c:b0:403:ae76:12da with SMTP id t12-20020a05622a148c00b00403ae7612damr16141349qtx.1.1690925689073;
        Tue, 01 Aug 2023 14:34:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b0040331a24f16sm4706166qtb.3.2023.08.01.14.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 14:34:48 -0700 (PDT)
Date:   Tue, 1 Aug 2023 17:34:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, ldufour@linux.ibm.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the
 walk
Message-ID: <ZMl6c+bVxdWW0YnN@x1n>
References: <20230731171233.1098105-1-surenb@google.com>
 <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
 <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
 <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
 <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
 <CAJuCfpF6WcJBSix0PD0cOD_MaeLpfGz1ddS6Ug_M+g0QTfkdzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpF6WcJBSix0PD0cOD_MaeLpfGz1ddS6Ug_M+g0QTfkdzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 01:28:56PM -0700, Suren Baghdasaryan wrote:
> I have the new patchset ready but I see 3 places where we walk the
> pages after mmap_write_lock() while *I think* we can tolerate
> concurrent page faults (don't need to lock the vmas):
> 
> s390_enable_sie()
> break_ksm()
> clear_refs_write()

This one doesn't look right to be listed - tlb flushing is postponed after
pgtable lock released, so I assume the same issue can happen like fork():
where we can have race coditions to corrupt data if, e.g., thread A
writting with a writable (unflushed) tlb, alongside with thread B CoWing.

It'll indeed be nice to know whether break_ksm() can avoid that lock_vma
parameter across quite a few function jumps. I don't yet see an immediate
issue with this one..  No idea on s390_enable_sie(), but to make it simple
and safe I'd simply leave it with the write vma lock to match the mmap
write lock.

Thanks,

-- 
Peter Xu

