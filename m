Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5383D781469
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380039AbjHRUpf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380049AbjHRUpF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 16:45:05 -0400
X-Greylist: delayed 1035 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 13:45:02 PDT
Received: from baloo.adam-barratt.org.uk (baloo.adam-barratt.org.uk [IPv6:2a02:e00:ffe9:ca::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D31FE9
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adam-barratt.org.uk; s=ab20190809; h=Content-Transfer-Encoding:MIME-Version
        :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wWtIIwgNyBU83Jq6GJVjZAMsWUM7aJS5t0b8GPBX1uQ=; b=wwlkMpw3pdl91IMBQTEu695kc5
        tNV9jgsuveHylq8fMEvigrFjgS+UmiJ9oTTKIL1B3fJIVfM0ZrQkxo0lPcmV/0J2QImvJ9pTfZf71
        NH3QdrRJzdS0qIGht1m2Dhi7tJEhjrWx4NLcDRi5uAwIHabBDtt5tIzgaWvA62TktVti7MuOLx0+H
        h7JnlWzf0qn++f5NMvQRAS0HGL+qOzuiP4YDdmO9AjwZXxGrPoXxcn6bfBJa4xZReK/uo3rEn9pGe
        5YJb2vbTFU+yy3KbBfhH6+vZNhwxpAUuHLlWr3DkDgAS6GP1fVYDLdaoBvXA0O9zExOsStySuA60J
        I2lD58IQ==;
Received: from kotick.adam-barratt.org.uk ([2a02:8010:66ea:1:240::2]:38036 helo=kotick)
        by baloo.adam-barratt.org.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92 #3 (Debian))
        (envelope-from <adam@adam-barratt.org.uk>)
        id 1qX64L-00010i-U4; Fri, 18 Aug 2023 21:27:41 +0100
Received: from localhost ([127.0.0.1])
        by kotick with esmtp (Exim 4.92)
        (envelope-from <adam@adam-barratt.org.uk>)
        id 1qX64K-0003HZ-1I; Fri, 18 Aug 2023 21:27:40 +0100
Message-ID: <413120de0cd467cc5dfe87045d8750e3223a368b.camel@adam-barratt.org.uk>
Subject: Re: [PATCH 5.10 076/529] crypto: ccp: Use the stack for small SEV
 command buffers
From:   "Adam D. Barratt" <adam@adam-barratt.org.uk>
To:     Ben Hutchings <ben@decadent.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Julien Cristau <jcristau@debian.org>, 1036543@bugs.debian.org
Date:   Fri, 18 Aug 2023 21:26:09 +0100
In-Reply-To: <c83138f6c2b65d0b51868af537ba03533f724cf8.camel@decadent.org.uk>
References: <20230310133804.978589368@linuxfoundation.org>
         <20230310133808.495306749@linuxfoundation.org>
         <80d3ba7a1b8b7d65713f66ca3562a5ec4971c5ee.camel@decadent.org.uk>
         <2023051720-studied-plutonium-7fa8@gregkh>
         <2023051729-jumbo-uncolored-05c1@gregkh>
         <c83138f6c2b65d0b51868af537ba03533f724cf8.camel@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ADSB-Scan-Signature: d6dde418675bc1ec94e740e4db21c226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Control: close -1 5.10.191-1

On Fri, 2023-05-26 at 17:36 +0200, Ben Hutchings wrote:
> On Wed, 2023-05-17 at 16:06 +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 17, 2023 at 04:02:35PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, May 17, 2023 at 02:56:21PM +0200, Ben Hutchings wrote:
[..]
> > > Julien Cristau reported a regression in ccp - the
> > > > WARN_ON_ONCE(!virt_addr_valid(data)) is now being triggered.  I
> > > > believe
> > > > this was introduced by the above commit, which depends on:
> > > > 
> > > > commit 8347b99473a313be6549a5b940bc3c56a71be81c
> > > > Author: Sean Christopherson <seanjc@google.com>
> > > > Date:   Tue Apr 6 15:49:48 2021 -0700
> > > >  
> > > >     crypto: ccp: Play nice with vmalloc'd memory for SEV
> > > > command structs
> > > > 
> > > > Ben.
> > > > 
> > > 
> > > Thanks for letting me know, now queued up.
> > 
> > Nope, now dropped, it breaks the build :(
> 
> I've now looked further and found that we need both:
> 
> d5760dee127b crypto: ccp: Reject SEV commands with mismatching
> command buffer
> 8347b99473a3 crypto: ccp: Play nice with vmalloc'd memory for SEV
> command structs
> 
> (Not yet tested; I'll ask Julien if he can do that.)
> 

Having just upgraded several affected debian.org nodes, I'm happy to
confirm that the 5.10.191-1 kernel resolves the issue for us.

Regards,

Adam

