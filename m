Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1392783058
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHUShe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjHUShc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 14:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF65058
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF82B61E41
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 18:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B8C433C7;
        Mon, 21 Aug 2023 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692643047;
        bh=zTQ1+IeazDrIptXEwZ0bTowf4Ep2OUQZXD5/3+wyHXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qskHK/C+6Wjdwz/vQ1vj5zMKctaF2aY2HPiWyVhSDVJS9XmvFVPthWq3IikbwNgIj
         ssRYGOOkwFxYmafvbCNoFD5E4mkKZwM/bl1KIg1taUBMm+dqIw1pwGS6yKuUTx0uAK
         pEe0PH4nR4AoJeUsnbxwA50Vls7ade+GRDTANxG0=
Date:   Mon, 21 Aug 2023 20:37:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org, Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH stable v4.14.y - v6.4.y] af_unix: Fix null-ptr-deref in
 unix_stream_sendpage().
Message-ID: <2023082117-henchman-applicant-bbe1@gregkh>
References: <20230821175505.23107-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821175505.23107-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 10:55:05AM -0700, Kuniyuki Iwashima wrote:
> Bing-Jhong Billy Jheng reported null-ptr-deref in unix_stream_sendpage()
> with detailed analysis and a nice repro.

Thanks, now queued up.

greg k-h
