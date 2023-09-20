Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F07A7F1E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjITMYN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjITMYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3283
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E5C433C9;
        Wed, 20 Sep 2023 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212646;
        bh=734VCBFM4HpvIdCmZUiqDD7SFU+kyw3D9G6WkxS9he4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOOKEwVD87RM3/Nke4hK67reozx7AFHQX4JvId0WASs0MhegZW1YNuE9hMD4wPjOW
         cM3SKF2gW+0O0ARzPnCIgJ9uqU5bA4qmIXr3ZhZabkhxZyXtbVu8k/S5RX6dGeDE/A
         IPtOX3R9rPfRT+0RlBTKE6H6LOVlwH8lbNxULnrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 78/83] tracefs: Add missing lockdown check to tracefs_create_dir()
Date:   Wed, 20 Sep 2023 13:32:08 +0200
Message-ID: <20230920112829.744884898@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 51aab5ffceb43e05119eb059048fd75765d2bc21 upstream.

The function tracefs_create_dir() was missing a lockdown check and was
called by the RV code. This gave an inconsistent behavior of this function
returning success while other tracefs functions failed. This caused the
inode being freed by the wrong kmem_cache.

Link: https://lkml.kernel.org/r/20230905182711.692687042@goodmis.org
Link: https://lore.kernel.org/all/202309050916.58201dc6-oliver.sang@intel.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Ching-lin Yu <chinglinyu@google.com>
Fixes: bf8e602186ec4 ("tracing: Do not create tracefs files if tracefs lockdown is in effect")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -554,6 +554,9 @@ static struct dentry *__create_dir(const
  */
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 {
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	return __create_dir(name, parent, &simple_dir_inode_operations);
 }
 


