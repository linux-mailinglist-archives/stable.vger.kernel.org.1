Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09557381D6
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFULC7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjFULC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 07:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CEBC
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 04:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72632614F0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BBEC433C8;
        Wed, 21 Jun 2023 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687345374;
        bh=/ZP93gyM4ekuY/OOvuft6EH5tLpk4c1Fh1xaSgC03N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdjXfEW6gkhrgmW/IQiYnl+YPab9l8ik1UoemqCFAcc6QPtyCR5w7iqbEnADESSGW
         KR5E463zeEeBepaSOjuy6VqSVuUcGAOr4qZEFAyfIaiec4h+1JV5YlNt0zBLhEtHOb
         f7QEhl9IpaDzIxiYNsJ+W7405oQyxv50lO1/uAjg=
Date:   Wed, 21 Jun 2023 13:02:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     juan.hao@nxp.com, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: keep the signaling time of merged fences
Message-ID: <2023062140-bartender-closable-9fa9@gregkh>
References: <20230621073204.28459-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621073204.28459-1-christian.koenig@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 21, 2023 at 09:32:04AM +0200, Christian König wrote:
> Some Android CTS is testing for that.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org

What commit id does this fix?

thanks,

greg k-h
