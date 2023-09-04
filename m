Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93355791914
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjIDNrM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjIDNrL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 09:47:11 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DD9E
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 06:47:07 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3D229868D9;
        Mon,  4 Sep 2023 15:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693835225;
        bh=xkuheIt5v+T4mzT1Yh6YLaEWF08CVYbjnidpdMmiz8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v9nRFRK9AXCuO2TOnGFxA+TWYud4p4evEXEBymKcVnSfy7oUvX3tJb2aG/vhNOsXv
         0F/DEsLkwl1l9sV4XcgfBzC0c4Lj3dvTXC6IwAkNn4BFSZ5NZkmjvosCnMn/U5FVgV
         gewROkLVxH7i9ZsnuVWal8DUW0mCbJMC0EEMB1flsU0ylaVKe5iB7Z91siNhrMs8rf
         ule3u4IsCw1ue9apaHeAPOdkCQkvLVWV0soLw3EWUC4W9oyx7ihV+EtOeZvVNaEAks
         Z4va/F8CiIeh9lwGAwU/3vFgeWkE9qbJy3BjlRHR0RrnMv0BBe2j+4rLsNGwAZh6Z4
         Mbt+QBOILn7zA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Sep 2023 10:47:05 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     gregkh@linuxfoundation.org
Cc:     m.felsch@pengutronix.de, angus@akkea.ca, christian.bach@scs.ch,
        linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: typec: tcpci: clear the fault status
 bit" failed to apply to 5.15-stable tree
In-Reply-To: <2023090314-headroom-doorbell-3ac8@gregkh>
References: <2023090314-headroom-doorbell-3ac8@gregkh>
Message-ID: <cdbcbbf136a2dac254a4ad4ee6b6f5ce@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 03/09/2023 13:57, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The reason that it fails to apply against 5.15 is due to the missing 
commit:

7963d4d71011 ("usb: typec: tcpci: move tcpci.h to include/linux/usb/")

I have submitted it as part of a series that applies cleanly against 
5.15.

Thanks
