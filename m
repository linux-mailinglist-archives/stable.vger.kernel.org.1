Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D97DFB3F
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 21:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377225AbjKBUJx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjKBUJw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 16:09:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD148137
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 13:09:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1435392b3a.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698955789; x=1699560589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frbIFMcPahMuJnundehXBvpEDhaieyav7O9JILL7nRI=;
        b=o+w8dFD+a8U1kV186JoDqputlzkTm/OvRBpP/lIZBYzRoNz9Yo1rzWbm9Tcarii0Qn
         VdS3IgcEv/qQ2EELTB68pmlZ3cbP77xmAJapEoyREioZsb3JgRuf4FB+/tGSYlzG04Gj
         TtwwSjtJ0MYEnCii0ZJT1lNrPyEXHGFEhqEeEeG3Cj5ntdEed+Ew+2OGfh64nubWPxcO
         gZ68dXMk7JQDQIBgMTrZ+RWt58I+EUuouSWhxB9sl1kNztplJwFkt3yWqL76pLxNXHj+
         Tq2y5/7WLICf/heTqwfbUoXteYxUraBku/SKjZufCOf18h/lNPj6AS39wcFGsUDpchXD
         rPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955789; x=1699560589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frbIFMcPahMuJnundehXBvpEDhaieyav7O9JILL7nRI=;
        b=LDt32GI3tAsiUL15mySAWSxPTi+hMiTAZLP+us4s+R+sOhsOvZ0MSyWoX2wOlNx/nL
         XQ9zeZ7MVPzMTSFegh3FgVyqrfOiPlVGcj4Kfze4bQTIoZ6vpthGX1+NagadIj6lcm61
         nHAx5cYI2Gs48DBVlQS+Op7y4NCeW/jyMKBqmTxrp3p/VKg3Q6Rdu3DhTiCk/wiyqChK
         AeQ9fvrONx31y1ykaxxLHkDN7XSN3EpJoWuODK69ozuyzOk29haXeieoYHFnqfoqvD0M
         OHDM42G5uhH3S/Mnijuaw3fs4y8lDVqTyzWPtTMVKLLfEDpgtPNh05aZPe2RRNgue3tF
         XnAg==
X-Gm-Message-State: AOJu0YwvB6II41fioC33jVQG8uhyzw9DANrQ1DJqrzdTZLkhqrRRygqD
        fQ9d2lm95l/G0n59w5V95xHtxQ==
X-Google-Smtp-Source: AGHT+IGKB3QRmtw+9Vg4zgB8QhI/Yswi9pUMHSf/qthfEpCA3X6S+uv0RWgRtFPw+Pg96oQkxFzp9w==
X-Received: by 2002:a05:6a00:2d09:b0:6bc:f819:fcf0 with SMTP id fa9-20020a056a002d0900b006bcf819fcf0mr22638289pfb.1.1698955789068;
        Thu, 02 Nov 2023 13:09:49 -0700 (PDT)
Received: from google.com (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with ESMTPSA id u8-20020a627908000000b006baa1cf561dsm162301pfc.0.2023.11.02.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:09:47 -0700 (PDT)
Date:   Thu, 2 Nov 2023 20:09:42 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
Message-ID: <ZUQCBnPYf_fzlWnD@google.com>
References: <20231102185934.773885-1-cmllamas@google.com>
 <20231102185934.773885-3-cmllamas@google.com>
 <20231102192051.innr2tbugspgmotw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102192051.innr2tbugspgmotw@revolver>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Nov 02, 2023 at 03:20:51PM -0400, Liam R. Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [231102 15:00]:
> > The mmap read lock is used during the shrinker's callback, which means
> > that using alloc->vma pointer isn't safe as it can race with munmap().
> 
> I think you know my feelings about the safety of that pointer from
> previous discussions.
> 

Yeah. The work here is not done. We actually already store the vm_start
address in alloc->buffer, so in theory we don't even need to swap the
alloc->vma pointer we could just drop it. So, I agree with you.

I want to include this saftey "fix" along with some other work that uses
the page fault handler and get_user_pages_remote(). I've tried a quick
prototype of this and it works fine.

> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index e3db8297095a..c4d60d81221b 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> >  		goto err_mmget;
> >  	if (!mmap_read_trylock(mm))
> >  		goto err_mmap_read_lock_failed;
> > -	vma = binder_alloc_get_vma(alloc);
> > +	vma = vma_lookup(mm, page_addr);
> > +	if (vma && vma != binder_alloc_get_vma(alloc))
> > +		goto err_invalid_vma;
> 
> Doesn't this need to be:
> if (!vma || vma != binder_alloc_get_vma(alloc))
> 
> This way, we catch a different vma and a NULL vma.
> 
> Or even, just:
> if (vma != binder_alloc_get_vma(alloc))
> 
> if the alloc vma cannot be NULL?
> 

If the vma_lookup() is NULL then we still need to isolate and free the
given binder page and we obviously skip the zap() in this case.

However, if we receive a random unexpected vma because of a corrupted
address or similar, then the whole process is skipped.

Thus, why we use the check above.

--
Carlos Llamas
