Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B3377FB0B
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbjHQPmi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Thu, 17 Aug 2023 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351820AbjHQPmK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 11:42:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADE30F0
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 08:42:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-118-7vPTjcE2PpaDehP6xc40Zw-1; Thu, 17 Aug 2023 16:42:06 +0100
X-MC-Unique: 7vPTjcE2PpaDehP6xc40Zw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 16:42:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 16:42:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        "t.martitz@avm.de" <t.martitz@avm.de>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: proc_lseek backport request
Thread-Topic: proc_lseek backport request
Thread-Index: AQHZ0RlWjYdPpw9a80uJfu9AUXEjAK/un68Q
Date:   Thu, 17 Aug 2023 15:42:02 +0000
Message-ID: <f98cf66371de47e6a0e87c5214ba2c22@AcuMS.aculab.com>
References: <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
 <2023081752-giddily-anytime-237e@gregkh>
In-Reply-To: <2023081752-giddily-anytime-237e@gregkh>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg KH 
> Sent: Thursday, August 17, 2023 3:43 PM
> 
> On Thu, Aug 17, 2023 at 11:22:30AM +0200, t.martitz@avm.de wrote:
> > Dear stable team,
> >
> > I'm asking that
> >
> > commit 3f61631d47f1 ("take care to handle NULL ->proc_lseek()")
> >
> > gets backported to the stable and LTS kernels down to 5.10.
> >
> > Background:
> > We are in the process of upgrading our kernels. One target kernel
> > is based on 5.15 LTS.
> >
> > Here we found that, if proc file drivers do not implement proc_lseek,
> > user space crashes easily, because various library routines internally
> > perform lseek(2). The crash happens in proc_reg_llseek, where it
> > wants to jump to a NULL pointer.
> >
> > We could, arguably, fix these drivers to use ".proc_lseek = no_llseek".
> > But this doesn't seem like a worthwhile path forward, considering that
> > latest Linux kernels (including 6.1 LTS) allow proc_lseek == NULL again
> > and *remove* no_lseek. Essentially, on HEAD, it's best practice to leave
> > proc_lseek == NULL.
> > Therefore, I ask that the above procfs fix gets backported so that our
> > drivers can work across all kernel versions, including latest 6.x.

Wrong patch and wrong default behaviour.
See d4455faccd.

All the NULL got converted to default_llseek().

> Attempting to keep kernel code outside of the kernel tree is, on
> purpose, very expensive in time and resources.  The very simple way to
> solve this is to get your drivers merged properly into the mainline
> kernel tree.

I've got some of those, you really wouldn't want them.
They are audio/telephony drivers for some very specific hardware.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

