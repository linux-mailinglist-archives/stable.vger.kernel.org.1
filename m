Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B37B458A
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjJAGLG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 02:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJAGLG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 02:11:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28073A9
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 23:11:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0AEC433C7;
        Sun,  1 Oct 2023 06:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696140663;
        bh=Z91YhPWl7yejlVDraovzs4veHBwrJmS3Z9ci/xjJwgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjSNUC4OGwb4q5el8dabvsmTegF5K9PP30DIX8Lpki1dJqE+PUfnJXJC34t6P7eix
         KERU9kEJx5s6f/5hFZx97elcdObXfTwulGp2+2iRO7JhgPEerMDdi7ySSq5XfeYMhQ
         aVj/znNHocw7vPmOsVUBJUsMCoqZUPWMS4rsgjvY=
Date:   Sun, 1 Oct 2023 08:11:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Erik =?iso-8859-1?Q?Dob=E1k?= <erik.dobak@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
Message-ID: <2023100121-curfew-remindful-aaef@gregkh>
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 01, 2023 at 07:47:54AM +0200, Erik Dobák wrote:
> please reconsider this commit.

Please contact the linux-bluetooth developers about this if you wish to
have a patch applied, there's nothing that the stable@vger list can do
about this, sorry.

good luck!

greg k-h
