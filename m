Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD476ACCA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjHAJUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjHAJUD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807930C4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDF6614F7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A1C433C7;
        Tue,  1 Aug 2023 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881481;
        bh=aYY3RmEsINfZwTMDlD2+0YXuSqhlPQCG0jkTz8yAZpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGSTdK1kneTwgTr32Gw4ObHFzacOn0kFv9dCq0oUcBEethnng4fCaSKvLTfodJ6uk
         1RHUUixwnej1U5ubdmimmKNkh4AcHw0oA0Rrd9taxGw5bY2/2j/ynOM+HmJA8mcNwj
         IXmv2GGcewzB7sJdl63oaG+3Ui+Qbzyv/LTz+AJo=
Date:   Tue, 1 Aug 2023 11:17:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] selftests: mptcp: join: only check for ip6tables
 if needed
Message-ID: <2023080151-ranged-rival-e7b4@gregkh>
References: <2023080104-stability-porcupine-fbad@gregkh>
 <20230801090716.2234574-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801090716.2234574-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 11:07:16AM +0200, Matthieu Baerts wrote:
> commit 016e7ba47f33064fbef8c4307a2485d2669dfd03 upstream.
> 
> If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
> used instead of 'ip6tables'. So no need to look if 'ip6tables' is
> available in this case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> Link: https://lore.kernel.org/r/20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Backport Notes:
>   - It was conflicting with 87154755d90e ("selftests: mptcp: join: check
>     for tools only if needed") moving the code to modify in a dedicated
>     function + checking the output directly.
>   - I then adapted the code where it was before, taking the same style
>     as what was done in the commit mentioned just above.
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Now queued up, thanks.

greg k-h
