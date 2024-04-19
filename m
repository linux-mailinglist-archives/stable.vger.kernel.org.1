Return-Path: <stable+bounces-40279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55048AAD16
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40701B21B94
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B37FBDA;
	Fri, 19 Apr 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVpfeQ30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6403D62
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523891; cv=none; b=H/B6Y21Ts+ftvxE+9aTIcsCzFsXFxaiMJYFqJTo6Xbcn1smvXSQ8ht59LafgqiRdH0JUeWTnGgFmE2oYTrFEW61bxmAw2RpvXRd4rgtyjeUSMz7uLh7IF9TJrcg+vLZtX865O1M1OIth+F17CHvwWhJhWJ2Vu6wK0cjQd2fOpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523891; c=relaxed/simple;
	bh=gCphIwKl57zMUy+T85sfJjfHxyh1MydYG4nzM3whads=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkF2RiOYS+v35NWlsMmBiCeD3uAOnVVMOMLw5hWUoXBjH2x0awm16heMmxMxY0ib18/7KZxH+VjGZxW6TmQkgQMSO3p3kkiaTcgXU6CnrhCFY/TKkzHl+70nxwVuKWDZ1RzifBdp72sJn0zEZ4GlDPIvdNXAOR9FQ7bRVouSp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVpfeQ30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D24AC072AA;
	Fri, 19 Apr 2024 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523891;
	bh=gCphIwKl57zMUy+T85sfJjfHxyh1MydYG4nzM3whads=;
	h=Subject:To:Cc:From:Date:From;
	b=oVpfeQ30sCz0aThRpqA6we18Nkt5N/uSVfjXSx2TcNy281AP422fn/mdroxqtlWJJ
	 OO8iX6ZGMjUdFOhSHfbU+3Z+EXqf5KmJs8zn0N8JEYun9q1KI+yTg9XJb+bW/5e7yH
	 YUBNaHzhRt8ilnblcNv3toIyiHkWWAPckFtUL95E=
Subject: FAILED: patch "[PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Apr 2024 12:51:26 +0200
Message-ID: <2024041925-walnut-flammable-adf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a4833e3abae132d613ce7da0e0c9a9465d1681fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041925-walnut-flammable-adf1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


