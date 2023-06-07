Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2472692C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFGStZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFGStZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:49:25 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4A18F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686163762; x=1717699762;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=e3e5wQEaaJiYTRohFjkenyAV8YXpKxg+3uN8LaF64Kk=;
  b=f22ZgQz3NQ+YLS9r16aQTk7/RUaOQ+iWRhU5b02tjkzMTY86mPhA1FAI
   6da+6WQu8Vr0uCJBFej6YdF2V9z6bKUVMSS9sj+NLXEjOw7xQVJy8bh9Q
   aPCSI/zFbWxrTwj8g78OmbgQgifAH0dcPjmjNuvSB5KUckLTfc0ILcyT2
   A=;
X-IronPort-AV: E=Sophos;i="6.00,224,1681171200"; 
   d="scan'208";a="8750538"
Subject: Re: [PATCH 4.14] Fix double fget() in vhost_net_set_backend()
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:49:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 8CD2EA0A04;
        Wed,  7 Jun 2023 18:49:21 +0000 (UTC)
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 18:49:21 +0000
Received: from localhost (10.111.86.65) by EX19D001UWA002.ant.amazon.com
 (10.13.138.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 7 Jun
 2023 18:49:21 +0000
Date:   Wed, 7 Jun 2023 11:49:20 -0700
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <benh@amazon.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <stable@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Message-ID: <20230607184920.vtq3ehupgokxefxp@u46989501580c5c.ant.amazon.com>
References: <20230606182831.639358-1-samjonas@amazon.com>
 <2023060713-scoreless-gratitude-2177@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023060713-scoreless-gratitude-2177@gregkh>
X-Originating-IP: [10.111.86.65]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D001UWA002.ant.amazon.com (10.13.138.236)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 07, 2023 at 08:35:29PM +0200, Greg Kroah-Hartman wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Tue, Jun 06, 2023 at 11:28:31AM -0700, Samuel Mendoza-Jonas wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > commit fb4554c2232e44d595920f4d5c66cf8f7d13f9bc upstream.
> >
> > Descriptor table is a shared resource; two fget() on the same descriptor
> > may return different struct file references.  get_tap_ptr_ring() is
> > called after we'd found (and pinned) the socket we'll be using and it
> > tries to find the private tun/tap data structures associated with it.
> > Redoing the lookup by the same file descriptor we'd used to get the
> > socket is racy - we need to same struct file.
> >
> > Thanks to Jason for spotting a braino in the original variant of patch -
> > I'd missed the use of fd == -1 for disabling backend, and in that case
> > we can end up with sock == NULL and sock != oldsock.
> >
> > Cc: stable@kernel.org
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I did not sign off on this patch, where did that come from?
> 
> Please be more careful.
> 
> thanks,
> 
> greg k-h

Ah my apologies, that must have come from the commit to the other stable
branches.

Thanks,
Sam
