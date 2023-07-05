Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1A7489F7
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGERQM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjGERQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 13:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22D198B;
        Wed,  5 Jul 2023 10:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA8161630;
        Wed,  5 Jul 2023 17:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BFC433C7;
        Wed,  5 Jul 2023 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688577364;
        bh=zFXaNvkTxbLMuq+O/dUCtxLwWjcMbfSWbfYucdGMHE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys2HSvNgJapJ12zfD9tK6RQ9QZY5Zq5scc749TtHRFSTgMt9zVkKUaIykz+NE3dMh
         gWA6E875QcCNM+CXkJkOKmqYb3bhK3NcDArfXueFwGRn7kBInvtJ1eMxwNHX+Da1J1
         MaUBRl4WVvSUkunw5c6rXkaTdhQ0SpE12TDRvXN0=
Date:   Wed, 5 Jul 2023 18:16:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc:     Ranjan Kumar <ranjan.kumar@broadcom.com>,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        sreekanth.reddy@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH] mpt3sas: Perform additional retries if Doorbell read
 returns 0
Message-ID: <2023070524-mocker-flatware-6e65@gregkh>
References: <20230615083010.45837-1-ranjan.kumar@broadcom.com>
 <2023061538-dizzy-amiable-9ec7@gregkh>
 <CAFdVvOwjQZZnViCYbJqPC81ZJPsZdqjNuQE=dH4bHWD4Pyu7Ew@mail.gmail.com>
 <2023062207-plywood-vindicate-c271@gregkh>
 <CAFdVvOyMdoE8Nwg82uj0HRw=MuAsxgKprTjb0p9bxL6efNPSOw@mail.gmail.com>
 <2023062228-circus-deed-7c9e@gregkh>
 <CAFdVvOyeYYwiVGBhqCSxxgVB9NMjGhHnrBPgdGd+H_OOHdctFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFdVvOyeYYwiVGBhqCSxxgVB9NMjGhHnrBPgdGd+H_OOHdctFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 05, 2023 at 11:09:30AM -0600, Sathya Prakash Veerichetty wrote:
> Hi Greg,
> The email footer issue is resolved and Ranjan has submitted a new
> revision of patches, we can discuss in the thread if you have further
> questions on the patch.

I have no context here at all, sorry.  What in the world is this all
about?

What would you do if you got a random email like this?

Remember, some of us get 1000+ emails a day to deal with...

greg k-h
