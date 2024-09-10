Return-Path: <stable+bounces-74245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFE972E42
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05281F2278B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1E18EFC3;
	Tue, 10 Sep 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyU40kBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B9188CDC;
	Tue, 10 Sep 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961240; cv=none; b=Dy8UdLhrDQ9ZBwU8etvXtOUizJLGy2njZ8rU0g0CNk0NrbFE+1/ettbjzOed/J42Qjy1r1ZcF+dqhBRhlDPYmY7Q4qifISgfxGAY9U6UkZfjbIIyIaOneJcHsM31+eBVwFpOzSG5PCug+iuOBYEQjzfXiMZK4mm0HDe4NDRInQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961240; c=relaxed/simple;
	bh=NBITYBYN6EJ7a+m5v7eY/NCAuOpYoia1mQosT7qjCxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggOlSE7wYILstzEwUut6ICeWBs1chvYUFjb/SDAFpthY3sXzlte1lDFOiaINKSVThG2zXLtYSLGY7dqS83SVniHiBSdph9QLKMYpXZyXGgUb0jfG/6quLUoJzXV+vwqrzr5guKCKSwCg4rdkp3IhX44vh+rE6BBErDPbYPR6vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyU40kBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD85C4CEC6;
	Tue, 10 Sep 2024 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961240;
	bh=NBITYBYN6EJ7a+m5v7eY/NCAuOpYoia1mQosT7qjCxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyU40kBgq0Lw1x3pcgEyw2tlIx0zGJFFrYorC/MTRhgPmTGAIt2H4BLiKFYM9jYQw
	 gyhCYB9RJ2JWQcOOm83rpS10AGpppM0WqWeu7wJ5eiCgmz3YZSJ38LC2DXPMfGi6iS
	 ylOMwX0MSHlR1YYviF/z2Z/nw6LRqX/yK2MhWeEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lex Siegel <usiegl00@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 93/96] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Tue, 10 Sep 2024 11:32:35 +0200
Message-ID: <20240910092545.621723614@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 626dfed5fa3bfb41e0dffd796032b555b69f9cde upstream.

When using a BPF program on kernel_connect(), the call can return -EPERM. This
causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
the kernel to potentially freeze up.

Neil suggested:

  This will propagate -EPERM up into other layers which might not be ready
  to handle it. It might be safer to map EPERM to an error we would be more
  likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.

ECONNREFUSED as error seems reasonable. For programs setting a different error
can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
instead of allow boolean"), thus given that it is better to simply remap for
consistent behavior. UDP does handle EPERM in xs_udp_send_request().

Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Co-developed-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Link: https://github.com/cilium/cilium/issues/33395
Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
Link: https://patch.msgid.link/9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2466,6 +2466,13 @@ static void xs_tcp_setup_socket(struct w
 	case -EALREADY:
 		xprt_unlock_connect(xprt, transport);
 		return;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		/* fall through */
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.



