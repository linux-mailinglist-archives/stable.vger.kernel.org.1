Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB2744D19
	for <lists+stable@lfdr.de>; Sun,  2 Jul 2023 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGBJwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Sun, 2 Jul 2023 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJwR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 05:52:17 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC4101;
        Sun,  2 Jul 2023 02:52:16 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qFtkb-003r4T-Hr; Sun, 02 Jul 2023 11:52:13 +0200
Received: from dynamic-078-055-000-149.78.55.pool.telefonica.de ([78.55.0.149] helo=smtpclient.apple)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qFtkb-003n9z-AC; Sun, 02 Jul 2023 11:52:13 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 2 Jul 2023 11:51:54 +0200
Message-Id: <06CE968E-D197-4C3B-B5ED-6F0A55723E0C@physik.fu-berlin.de>
References: <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (20F75)
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.0.149
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



> On Jul 2, 2023, at 11:38 AM, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> 
> The end users have to fix their  RDBs if they want to use the new patched kernels.
> 
> But a normal user can’t edit the RDB manually. What can we do for the end users?

I would suggest writing a small bash script to do that.

Adrian
