Return-Path: <stable+bounces-40277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7168AAD10
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDABB1F21A30
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DF7FBC2;
	Fri, 19 Apr 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gd6BOoYB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7752883D
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523798; cv=none; b=sGc2Ff0WzO4aqSEttaeiHlPU099eaw1jxRgzPJ6+ZduHoalY4Ec/rH+cD669j4UNAkNrm8I/aJ9BVGOZLQbt+teVJMfYMkLNmO6ZT2UWrR6TRAKjqgI7NQkIGss15yPSys47jt6qMwbFSZdmUOVVIOXwuXR6moXx2x+j87VGZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523798; c=relaxed/simple;
	bh=xcFg2MIaltj2mv/XdLCjKEfFm4q/LwqRkL/FQhTIhik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kx3TPHqURLEkr83wNsVJgLjRFZrLtLxzJu2jkR0FR+wEDGO6tw/x4gLydDDmXQPekcv9t55pW62csDoEoRgQxikAtR2wQOexepn/NKsWlhMRY60s1O3jwIvge8s3jZ+0v20Zv1PedLc1QuT7D0TIVneiTsjWZrpbA8OQPrJsNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gd6BOoYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59682C072AA;
	Fri, 19 Apr 2024 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523798;
	bh=xcFg2MIaltj2mv/XdLCjKEfFm4q/LwqRkL/FQhTIhik=;
	h=Subject:To:Cc:From:Date:From;
	b=gd6BOoYB8qZEWjIcKS6VJr9PO6hbLy52cCWwAmr/RNSQIeltly/Josn3crc37DVR6
	 FKLqvuvn8v4msr8IWUvMKo78YE9O+Nzu+oFM1S2t2FqXLc9PEzgDrRQ0zPsVVAF0d9
	 oh1/fjoCgcyzCRL658wu6zRKs9FzQld2OYoHZ4qE=
Subject: FAILED: patch "[PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field" failed to apply to 5.4-stable tree
To: rostedt@goodmis.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Apr 2024 12:49:53 +0200
Message-ID: <2024041953-duration-fructose-0bc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a4833e3abae132d613ce7da0e0c9a9465d1681fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041953-duration-fructose-0bc1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a4833e3abae1 ("SUNRPC: Fix rpcgss_context trace event acceptor field")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4833e3abae132d613ce7da0e0c9a9465d1681fa Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 10 Apr 2024 12:38:13 -0400
Subject: [PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field

The rpcgss_context trace event acceptor field is a dynamically sized
string that records the "data" parameter. But this parameter is also
dependent on the "len" field to determine the size of the data.

It needs to use __string_len() helper macro where the length can be passed
in. It also incorrectly uses strncpy() to save it instead of
__assign_str(). As these macros can change, it is not wise to open code
them in trace events.

As of commit c759e609030c ("tracing: Remove __assign_str_len()"),
__assign_str() can be used for both __string() and __string_len() fields.
Before that commit, __assign_str_len() is required to be used. This needs
to be noted for backporting. (In actuality, commit c1fa617caeb0 ("tracing:
Rework __assign_str() and __string() to not duplicate getting the string")
is the commit that makes __string_str_len() obsolete).

Cc: stable@vger.kernel.org
Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index ba2d96a1bc2f..f50fcafc69de 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -609,7 +609,7 @@ TRACE_EVENT(rpcgss_context,
 		__field(unsigned int, timeout)
 		__field(u32, window_size)
 		__field(int, len)
-		__string(acceptor, data)
+		__string_len(acceptor, data, len)
 	),
 
 	TP_fast_assign(
@@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout = timeout;
 		__entry->window_size = window_size;
 		__entry->len = len;
-		strncpy(__get_str(acceptor), data, len);
+		__assign_str(acceptor, data);
 	),
 
 	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",


