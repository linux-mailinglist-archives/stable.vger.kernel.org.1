Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD896734BB4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjFSGVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFSGVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855D115;
        Sun, 18 Jun 2023 23:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4605613B3;
        Mon, 19 Jun 2023 06:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98468C433C0;
        Mon, 19 Jun 2023 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155704;
        bh=qeWfGDLi2+BXBPDFCoC97zbTEdraZaFi4t2mcX3perc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJjoHJ3SAlfQhZZAscVXzu0AdO8izxbnDur3Sy2N/CLSlw1sEchCWhMDuGUga713Z
         9UkNakt5qVxVYFvOCPRxpnYVKymJm183yO22W3nbDZ6sU99KY3/C3GQ5LntmOB/61r
         KR6Kla3ZVgULU1gV3y8ssMFzJil23Bn212KNM/hE=
Date:   Mon, 19 Jun 2023 08:21:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com
Subject: Re: [RESEND 1/1] linux-6.1/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
Message-ID: <2023061925-overact-flakily-9830@gregkh>
References: <20230614013548.1382385-1-surenb@google.com>
 <20230614013548.1382385-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614013548.1382385-3-surenb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 13, 2023 at 06:35:47PM -0700, Suren Baghdasaryan wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

That's not the author of this commit, where did it come from?

confused,

greg k-h
