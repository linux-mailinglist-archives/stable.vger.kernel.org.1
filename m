Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DA70D3E9
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjEWGXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEWGXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 02:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CFC109
        for <stable@vger.kernel.org>; Mon, 22 May 2023 23:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D914462F6F
        for <stable@vger.kernel.org>; Tue, 23 May 2023 06:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD95C433EF;
        Tue, 23 May 2023 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684823020;
        bh=qCTlyH5laWe7l417TpY5BxfzIuBln0VIZOfKx7GQa2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MLLcDuKi66wqtLJGX3o9wXQLjD+DqDD0+HTxDxpMDjx+GCXPpeWtBZDOb84izPot
         RirNy0KPp4e/KIclP+McknpESaBCR0rcKTLhYITk/YIgFGuvo5qfY8YVkQ6g/Ws5v/
         6KI2WxaPMwOH+ymAfd9kCJilzgzGfSKVs4cMaLfE=
Date:   Tue, 23 May 2023 07:23:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     stable@vger.kernel.org
Subject: Re: Was there a call for 5.10.181-rc1 review?
Message-ID: <2023052348-reformer-hatchback-7299@gregkh>
References: <20230522190354.935300867@linuxfoundation.org>
 <20230523022333.GG230989@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523022333.GG230989@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 22, 2023 at 10:23:33PM -0400, Theodore Ts'o wrote:
> I can't found a call for reviewing 5.10.181-rc1, either in my inbox or
> on lore.kernel.org.
> 
> There does to be a 5.10.181-rc1 in stable-rc/linux-5.10.y, so did it
> not get e-mailed out somehow?  Or did I somehow miss it?

I did not release it, sorry, only 5.15.y and newer for this round.
5.10.181-rc will probably happen later this week or next.

thanks,

greg k-h
