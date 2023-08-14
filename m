Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A477BC87
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHNPKd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjHNPKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED019A7
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16656152D
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6805C433C7;
        Mon, 14 Aug 2023 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692025784;
        bh=Pp/UrtOeghj96K/n5Nq+myPSbvS2ydV/WIp6cZvoEQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5yl6U3Jv6VTXAgE7tC5ytOtjNJYeJ3w1VkGZapOHsE9YbrWqnxEulNjoShgkPpRz
         ASB6sCVDAuVaMNkmKBDqZhEV3WoRqKgJPe64c3gWaE4cjp4J3BDp+lNpi3X2Aqow9y
         jjCPJ/S2BByFEb8XETzRGILApJzg6lSWIwSaWzfQ=
Date:   Mon, 14 Aug 2023 17:09:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0YTQuNGG0LXRgNC+0LI=?= 
        <oficerovas@basealt.ru>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: [PATCH 1/3] i2c: i801: Add support for Intel Alder Lake PCH
Message-ID: <2023081434-halt-quiver-1448@gregkh>
References: <20230810115938.3741058-3-oficerovas@altlinux.org>
 <f7153a37-90c2-42ea-6050-fd9b37ea1133@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7153a37-90c2-42ea-6050-fd9b37ea1133@basealt.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 05:34:27PM +0300, Александр Офицеров wrote:
> I'm sorry, this is my first time I ever send patches, I messed up with git
> send-email, so you received cover letter with no patches.
> 
> Now I'm sending you patches, that i wanted to send.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
