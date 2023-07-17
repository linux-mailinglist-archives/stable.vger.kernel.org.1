Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C2755DAC
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGQIAt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 17 Jul 2023 04:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjGQIAs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 04:00:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90510C7
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 01:00:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-99-gw_Qv1-KMQizDysYJujtTQ-1; Mon, 17 Jul 2023 09:00:43 +0100
X-MC-Unique: gw_Qv1-KMQizDysYJujtTQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 09:00:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jul 2023 09:00:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Schmitz' <schmitzmic@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH 5.4.y] block: add overflow checks for Amiga partition
 support
Thread-Topic: [PATCH 5.4.y] block: add overflow checks for Amiga partition
 support
Thread-Index: AQHZt3Pg0NqcHeFS7kudPIS6hYGc1a+9mJiw
Date:   Mon, 17 Jul 2023 08:00:42 +0000
Message-ID: <cbdb7cde68dc4d239861a631436dc01d@AcuMS.aculab.com>
References: <2023071117-convene-mockup-27f2@gregkh>
 <20230715232656.8632-1-schmitzmic@gmail.com>
In-Reply-To: <20230715232656.8632-1-schmitzmic@gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Schmitz
> Sent: 16 July 2023 00:27
> 
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
> 
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes),

Pretty much everything (including the mass of an proton) stops
you having a disk with anywhere near 2^64 bytes in it.

	David

> so check for
> u64 overflow carefully to protect against overflowing sector_t.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

