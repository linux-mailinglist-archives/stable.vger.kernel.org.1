Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E347276AB3D
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjHAImk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHAImj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD410E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6936614B1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 08:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE889C433C8;
        Tue,  1 Aug 2023 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690879357;
        bh=/t5qPoFSi8zCqQ6pHPxzAVF2cWIO3OtiQr9xioY/e0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pn4P9rXKu7a56Ff3BQYZq3fghEF8nE5RYmLsd3B1mFONzQISWKs6UNkI3e25v1lc
         ip3Lx3ByrNk+UwyL/PfNW3OAVZa7ixW6qNkY/6vQKknzEObAyUcTEaF96+7CB5mOvh
         44rC29F40f2GyeRK+TVKbKoDptjj9dK1qaK6Yxh4=
Date:   Tue, 1 Aug 2023 10:42:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: should stable 6.1.y include 6c21e066f925 mm/mempolicy: Take VMA
 lock before replacing policy?
Message-ID: <2023080144-coasting-decathlon-74f1@gregkh>
References: <20230801162059.899D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801162059.899D.409509F4@e16-tech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 04:21:05PM +0800, Wang Yugui wrote:
> Hi,
> 
> should stable 6.1.y include 
> 6c21e066f925 mm/mempolicy: Take VMA lock before replacing policy
> ?

Did you test it and see if it works?  Why do you think it is needed in
6.1.y when the "Fixes:" tag references a commit that is in 6.4 only?
Is the tag incorrect?

thanks,

greg k-h
