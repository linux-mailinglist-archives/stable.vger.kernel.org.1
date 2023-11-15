Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF477EC1C7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 12:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjKOL60 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 06:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbjKOL6Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 06:58:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31ACC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 03:58:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BFC433C7;
        Wed, 15 Nov 2023 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700049502;
        bh=9xvkHeCV6h+sOfsFUcpoIDZcK4gObma8I/QRHrGGHU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ohsasd+Th1xnF1JwQ9QD/IF/EppYYrjPjlIdpDJ52Z8WYL4lhdXIa0TS3ttDlYJqm
         wEKJahXFUNp4WksGJc6nTs8K4joRdL1jVhw0VP7antlnB3l3cG5U8O2p+vqxBMCsqm
         HuHb60aacZSdu9ybjbApRhTTvPxr5509B+9NeQm0=
Date:   Wed, 15 Nov 2023 06:58:14 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     beaub@linux.microsoft.com, mark.rutland@arm.com,
        mhiramat@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_event_file have ref
 counters" failed to apply to 5.4-stable tree
Message-ID: <2023111508-curly-postbox-26e0@gregkh>
References: <2023110614-natural-tweak-9ee4@gregkh>
 <20231106144832.37bc9d16@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106144832.37bc9d16@gandalf.local.home>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 06, 2023 at 02:48:32PM -0500, Steven Rostedt wrote:
> 
> [ This should work for v5.4 ]
> 
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Subject: [PATCH] tracing: Have trace_event_file have ref counters
> 
> commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 upstream

All now queued up, thanks.

greg k-h
