Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0278EB11
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjHaKuR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjHaKuR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173910D1;
        Thu, 31 Aug 2023 03:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABFB63A77;
        Thu, 31 Aug 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFE6C433C9;
        Thu, 31 Aug 2023 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693478921;
        bh=DlaX1iBckYrRAB8B2JafRr13BPYgSbRnIGdxsx4ggIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE1eLliqF9uH9SMvOeYcQVBh3pVaULHC9O2Z4YM76m3kmDHPIvWpxpxWpMtY7giPT
         kdQSOIscDNomfLlIpnKAYap+oTRXo/CN+/xOdyrdCx9287Kt9egwAGm5ntuXrZSYZ1
         vxXcMgyQGnhyZbEr4laq0d+kbpgbX79PCZt9MdUw=
Date:   Thu, 31 Aug 2023 12:48:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-parisc@vger.kernel.org
Subject: Re: [STABLE] lockdep patch for 6.1-stable to 6.5-stable
Message-ID: <2023083132-unfailing-privacy-a90e@gregkh>
References: <ZO7Tj3Pf3P01ImCG@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO7Tj3Pf3P01ImCG@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 07:28:47AM +0200, Helge Deller wrote:
> Hi Greg,
> 
> would you please queue up this upstream patch:
> 
> 	0a6b58c5cd0d ("lockdep: fix static memory detection even more")
> 
> to stable kernels 6.1, 6.4 and 6.5 ?

Now queued up, thanks.

greg k-h
