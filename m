Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3376734BB8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFSGXR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFSGXR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8383;
        Sun, 18 Jun 2023 23:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243D3613B3;
        Mon, 19 Jun 2023 06:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C80C433C8;
        Mon, 19 Jun 2023 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155795;
        bh=bh0fnQvFOdjgaC4KY87/gyFyxoqKFblq+XO0uVh4bLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zb5HnSQOvdiaaKQdU2w05iwAtwT2Z+phM9ilXObKBOaLgEXJrgNt2IICp2xCKL1p/
         oYK/7m3fIYvAkGsckkwgmvX0GaetduPTaQOypekDb9adYQmfIXP35DUN4EZg1c56du
         KnbTBrlBzynwMuxX9dfVQjqRNDBNBLGkon7ZBP9A=
Date:   Mon, 19 Jun 2023 08:23:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com
Subject: Re: [RESEND 1/1] linux-5.10/rcu/kvfree: Avoid freeing new
 kfree_rcu() memory after old grace period
Message-ID: <2023061904-limelight-yiddish-8a0d@gregkh>
References: <20230614013548.1382385-1-surenb@google.com>
 <CAJuCfpGcpRc5nxrgC2VmDfqE4s0Z1q75ErVjWQu=tj4y1xUFZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGcpRc5nxrgC2VmDfqE4s0Z1q75ErVjWQu=tj4y1xUFZw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 13, 2023 at 06:38:55PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 13, 2023 at 6:35 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> Sorry about repeating lines. Didn't realize one would be added automatically.

All now queued up, thanks.

greg k-h
