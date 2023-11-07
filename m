Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61C7E372A
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjKGJID (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 04:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjKGJIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 04:08:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3980125
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 01:07:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0ccfc4fc8so6536418276.2
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348079; x=1699952879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q790Yzm/LOg58iq7Db8FbD2kRXLwrY5Ed6jpsrOc3Vs=;
        b=FET8fC0gvojSXEnqbtCsH0uOPrL9C6vUQssMnS/4bsFb4U4xBERYnno4Ml2ZuNMMQH
         ffxSheCWySBRxRD40r88sFRfnk2DF2jI3knTMdm2Hpbp9qQrIn+dmg1AN4IWBhucProF
         ggV8xne0feHMglxqVLggWCXlCgXsDh6kELw8ksJE+GwtwXV1Fp/27crRjdNM2beOXhn4
         Ze4Cmnc8n+vX8q8c1fDeaFoNv4IB1Aw2E50eJUXUc1p+/eA0oNLKsUbe22QTX7lCymxY
         TeE1O2I+jTqMpMv6RwqhQb735IDXG0RwxPrJU5Rbdu66Sh7XZSTX1hTZt9Fp34k8w7tY
         9Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348079; x=1699952879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q790Yzm/LOg58iq7Db8FbD2kRXLwrY5Ed6jpsrOc3Vs=;
        b=nFaDIFLoVfjNr9s1lhHXQ0MmIm6f0fs+W6uBaDv2JyPHXzvuhaIJ9ixhacy6NlsmgF
         UZZUsgTVbWqDRlO58txKH+Q2FvWcEfVDgmZ3hwFHYQ+IBRCFxRxPMUPlBNFQ0kBQSHPL
         vouiQmq8mDVKIQ0FlVf4BFo9DqcWHiuGZ3NAdxey0upf1WqywBcjoEt0Aizm1C6qo9qy
         3YTxa1pNowQmXzS4fkJD89s51X8Ioy2cEp3SpmLEUSfweJ/7dwZB08yT+Gtva+J5WmrV
         jAlPNBebxV8U8A7ju8+Cv0SqvlPh3n+bw5HwFPfcCJzgF+9Qu2kopMIKpRlBslEFKCfp
         TLgg==
X-Gm-Message-State: AOJu0Yz+3n3tApACDLFsLV0PQccOZkKdGurBmmBMx1/b+iNfGiPIwDsz
        EVnhPMCoWpof6VUYKEdYHWKJ2aSbIegCge8=
X-Google-Smtp-Source: AGHT+IGz0mDj6T1euvZTWiXeAoqw05hiXvl8br7LMII0HAUGwC7OmXVCv6BqCbTYEijhSUeSSq2m08bV5R3WG+4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:e082:0:b0:d9a:ec95:9687 with SMTP id
 x124-20020a25e082000000b00d9aec959687mr608285ybg.11.1699348078929; Tue, 07
 Nov 2023 01:07:58 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:07:56 +0000
In-Reply-To: <20231102185934.773885-3-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-3-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090756.256039-1-aliceryhl@google.com>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "Liam R . Howlett" <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Martijn Coenen <maco@android.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> The mmap read lock is used during the shrinker's callback, which means
> that using alloc->vma pointer isn't safe as it can race with munmap().
> As of commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
> munmap") the mmap lock is downgraded after the vma has been isolated.
> 
> I was able to reproduce this issue by manually adding some delays and
> triggering page reclaiming through the shrinker's debug sysfs. The
> following KASAN report confirms the UAF:
> 
>   [...snip...]
> 
> Fix this issue by performing instead a vma_lookup() which will fail to
> find the vma that was isolated before the mmap lock downgrade. Note that
> this option has better performance than upgrading to a mmap write lock
> which would increase contention. Plus, mmap_write_trylock() has been
> recently removed anyway.
> 
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: stable@vger.kernel.org
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

This change makes sense to me, and I agree that the code still needs to
run when the vma is null.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

