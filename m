Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20697EC1D8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjKOMEs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 07:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjKOMEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 07:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319893
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 04:04:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149BDC433C7;
        Wed, 15 Nov 2023 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700049884;
        bh=cZYeznXTGphm+YU61lmXYV8+TMeQPNiBRobs0fiN52o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCE0syUmonBtPyvMgUiBf0Sn5ZXB2VuB9Vbq5rkQGHOx/YYMxcuqAeWnFt4ieX7AM
         wCkAgzq33YMDrbPIq+bO2XXAtFCfgi8lPnMhlP4YLJkI+Jf/ccLdGvvdCNWRnIXyzT
         c79MYfjT5mj6YXCof9/z8uX5jDIFLXEmCtBuYQAU=
Date:   Wed, 15 Nov 2023 07:04:42 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     beaub@linux.microsoft.com, mark.rutland@arm.com,
        mhiramat@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_event_file have ref
 counters" failed to apply to 5.4-stable tree
Message-ID: <2023111557-cape-ashy-6162@gregkh>
References: <2023110614-natural-tweak-9ee4@gregkh>
 <20231106144832.37bc9d16@gandalf.local.home>
 <2023111508-curly-postbox-26e0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023111508-curly-postbox-26e0@gregkh>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 15, 2023 at 06:58:14AM -0500, Greg KH wrote:
> On Mon, Nov 06, 2023 at 02:48:32PM -0500, Steven Rostedt wrote:
> > 
> > [ This should work for v5.4 ]
> > 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > Subject: [PATCH] tracing: Have trace_event_file have ref counters
> > 
> > commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 upstream
> 
> All now queued up, thanks.

No, wait, all of these break the build with this error:

kernel/trace/trace_events.c: In function ‘remove_event_file_dir’:
kernel/trace/trace_events.c:1015:24: error: unused variable ‘child’ [-Werror=unused-variable]
 1015 |         struct dentry *child;
      |                        ^~~~~

So I'm going to drop them now :(

greg k-h
