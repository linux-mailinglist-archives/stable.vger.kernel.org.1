Return-Path: <stable+bounces-9005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C88205CC
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768D1B211FD
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0079EF;
	Sat, 30 Dec 2023 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImW6HgdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F479DD;
	Sat, 30 Dec 2023 12:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CB4C433C7;
	Sat, 30 Dec 2023 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938326;
	bh=4AsNwWV6hAZDlsW/pO2Ibsi+ZKSPCiJnBlDMbtbUUAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImW6HgdU8OLXR3Acc/c95NsjNs8ROniBzXFZ50tysXrIlvA+ztA/nVcutXm+Ew663
	 wK4bCjGeigoc/lukCCgKXw0nTrYrk85VsE/g1m+aSdUyd3sxbHSlnFfubsMEtYSPlU
	 KvqhViO6prgNdJDz7VYQNqYX1cYXcW+FMkts5YSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 6.1 103/112] lib/vsprintf: Fix %pfwf when current node refcount == 0
Date: Sat, 30 Dec 2023 12:00:16 +0000
Message-ID: <20231230115810.075013174@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 5c47251e8c4903111608ddcba2a77c0c425c247c upstream.

A refcount issue can appeared in __fwnode_link_del() due to the
pr_debug() call:
  WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
  Call Trace:
  <TASK>
  ...
  of_node_get+0x1e/0x30
  of_fwnode_get+0x28/0x40
  fwnode_full_name_string+0x34/0x90
  fwnode_string+0xdb/0x140
  ...
  vsnprintf+0x17b/0x630
  ...
  __fwnode_link_del+0x25/0xa0
  fwnode_links_purge+0x39/0xb0
  of_node_release+0xd9/0x180
  ...

Indeed, an fwnode (of_node) is being destroyed and so, of_node_release()
is called because the of_node refcount reached 0.
>From of_node_release() several function calls are done and lead to
a pr_debug() calls with %pfwf to print the fwnode full name.
The issue is not present if we change %pfwf to %pfwP.

To print the full name, %pfwf iterates over the current node and its
parents and obtain/drop a reference to all nodes involved.

In order to allow to print the full name (%pfwf) of a node while it is
being destroyed, do not obtain/drop a reference to this current node.

Fixes: a92eb7621b9f ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20231114152655.409331-1-herve.codina@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/vsprintf.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2092,15 +2092,20 @@ char *fwnode_full_name_string(struct fwn
 
 	/* Loop starting from the root node to the current node. */
 	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
-		struct fwnode_handle *__fwnode =
-			fwnode_get_nth_parent(fwnode, depth);
+		/*
+		 * Only get a reference for other nodes (i.e. parent nodes).
+		 * fwnode refcount may be 0 here.
+		 */
+		struct fwnode_handle *__fwnode = depth ?
+			fwnode_get_nth_parent(fwnode, depth) : fwnode;
 
 		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
 			     default_str_spec);
 		buf = string(buf, end, fwnode_get_name(__fwnode),
 			     default_str_spec);
 
-		fwnode_handle_put(__fwnode);
+		if (depth)
+			fwnode_handle_put(__fwnode);
 	}
 
 	return buf;



