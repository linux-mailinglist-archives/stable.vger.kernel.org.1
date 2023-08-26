Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1D789909
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjHZUcK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjHZUbu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:31:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021912B
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fyTrvy/42dAnR3+3KTnYxB3Infa0qzHfrPimzJ0+J/o=; b=dLt6+GpFD0rB7+CKLCsfzxR9sE
        rX9kBz3VwD19qr2L7V8k1HET+d5qqgSdL19G+VpWzm4NWMNaa/S9XI9NniUeer9VsUuVAuYuKEcIi
        2oCUOj8sRf/p66UW+NXcTmpsY8b4Y7dVpre8Ko++q3SrBZFna1qZ9R7Bz0yNTf/2x0wZSnUDIQEZ0
        p6YB4WOsFckRjB38gVxi+KPyik7xI0zaB5c0S8eo+fMr9CRWsS33UlCa7usQ4f5W1qiG8iKO2C2s2
        sbbve1XSVE2HkZtDQqZePS/P24AtCJMujokKYxfIvxWOLF7eI2I/XG6u0ZJ2X3w4oCL46W25AHCBJ
        57wbsNEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZzw1-007aM9-O8; Sat, 26 Aug 2023 20:31:05 +0000
Date:   Sat, 26 Aug 2023 21:31:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     gregkh@linuxfoundation.org
Cc:     surenb@google.com, akpm@linux-foundation.org, dave@stgolabs.net,
        david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
        jannh@google.com, ldufour@linux.ibm.com, liam.howlett@oracle.com,
        mhocko@suse.com, michel@lespinasse.org, peterx@redhat.com,
        stable@vger.kernel.org, torvalds@linuxfoundation.org,
        vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: enable page walking API to lock vmas
 during the walk" failed to apply to 6.1-stable tree
Message-ID: <ZOphCbI4I9i4CtLS@casper.infradead.org>
References: <2023082625-monotone-traps-6498@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082625-monotone-traps-6498@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 26, 2023 at 10:11:26PM +0200, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.
> Subject: [PATCH] mm: enable page walking API to lock vmas during the walk

VMA locking was introduced for 6.4, so I don't think this patch is
needed for 6.1.
