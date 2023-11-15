Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E517EC9B7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKORdk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Wed, 15 Nov 2023 12:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORdj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 12:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F561B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 09:33:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFCFC433CB;
        Wed, 15 Nov 2023 17:33:35 +0000 (UTC)
Date:   Wed, 15 Nov 2023 12:33:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     beaub@linux.microsoft.com, mark.rutland@arm.com,
        mhiramat@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_event_file have ref
 counters" failed to apply to 5.4-stable tree
Message-ID: <20231115123334.725cb742@rorschach.local.home>
In-Reply-To: <2023111557-cape-ashy-6162@gregkh>
References: <2023110614-natural-tweak-9ee4@gregkh>
        <20231106144832.37bc9d16@gandalf.local.home>
        <2023111508-curly-postbox-26e0@gregkh>
        <2023111557-cape-ashy-6162@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 15 Nov 2023 07:04:42 -0500
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Nov 15, 2023 at 06:58:14AM -0500, Greg KH wrote:
> > On Mon, Nov 06, 2023 at 02:48:32PM -0500, Steven Rostedt wrote:  
> > > 
> > > [ This should work for v5.4 ]
> > > 
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > Subject: [PATCH] tracing: Have trace_event_file have ref counters
> > > 
> > > commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 upstream  
> > 
> > All now queued up, thanks.  
> 
> No, wait, all of these break the build with this error:
> 
> kernel/trace/trace_events.c: In function ‘remove_event_file_dir’:
> kernel/trace/trace_events.c:1015:24: error: unused variable ‘child’ [-Werror=unused-variable]
>  1015 |         struct dentry *child;
>       |                        ^~~~~
> 
> So I'm going to drop them now :(
> 

Ah, this patch I didn't run through all my tests, like I did with the
6.6 patches, so I didn't test with fail on warnings. The patch deleted
the following code:

 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	struct dentry *dir = file->dir;
 	struct dentry *child;
 
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
-
+	if (dir)
 		tracefs_remove_recursive(dir);
-	}
 
 	list_del(&file->list);

The extra check that that utilized that child variable is no longer
needed, and I forgot to delete the declaration of the child variable.

Did you just want to delete that, or do you want me to create a new
patch?

-- Steve
