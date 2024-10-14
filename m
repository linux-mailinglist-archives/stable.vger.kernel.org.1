Return-Path: <stable+bounces-83950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C599CD50
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE121F222E1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497C20322;
	Mon, 14 Oct 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjnMFuGg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116B20EB;
	Mon, 14 Oct 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916294; cv=none; b=gz2SenIpaUf54G58OBCwDuCZMVsmD9jeA1mhzVGYN8l6cvzdyd35/Z51ylt/J9IcFMHH2nx1X6bCIMKQt18NBMKE5vZ5Cvf4REQSZ/pycV8iqztsJjUgT/JT8eeBU1bXkPn83vU0gO4s5so4Jc0xyiPT4MYWvItk/EVV8WwBOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916294; c=relaxed/simple;
	bh=D9XTgISuWRPtVuqVTa4t+XzsV/m7lWmYbiz084yAubo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBzhoQzsxfih1FDdn63lbZ/B+ddlGPM6SZNVkpowF/kryFr+FLeoPiE/etc+34CtP4jN0+kmXaHgixWM7Er6WbcB5YPgFsGM6vaKTVUn4aSC0sKwWgf+luEf9zr9ZrTKewxmUq984hjTcljqBGt+nO/P/P4N7bH7o03tzMo3nyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjnMFuGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A29C4CEC3;
	Mon, 14 Oct 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916294;
	bh=D9XTgISuWRPtVuqVTa4t+XzsV/m7lWmYbiz084yAubo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjnMFuGgatqRaGw8boWrKd6oZxAy+NGdlZLIhphpqnS71TCWcWYE9TjPooDeTrKzc
	 ZGgmjvirBhVWsFA6xzRWtp/5nLbQtRcOpB8MbW7noYLUxKXKBPG5q1X6h9HH7TAZ6u
	 dOuocgkwxec/dP/dn0/IdHX4iINsxC7E1luiYGS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 141/214] rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
Date: Mon, 14 Oct 2024 16:20:04 +0200
Message-ID: <20241014141050.491335289@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 07cc7b0b942bf55ef1a471470ecda8d2a6a6541f ]

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message
handlers"), once rtnl_msg_handlers[protocol] was allocated, the following
rtnl_register_module() for the same protocol never failed.

However, after the commit, rtnl_msg_handler[protocol][msgtype] needs to
be allocated in each rtnl_register_module(), so each call could fail.

Many callers of rtnl_register_module() do not handle the returned error,
and we need to add many error handlings.

To handle that easily, let's add wrapper functions for bulk registration
of rtnetlink message handlers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 78b7b991838a ("vxlan: Handle error of rtnl_register_module().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/rtnetlink.h | 17 +++++++++++++++++
 net/core/rtnetlink.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b45d57b5968af..2d3eb7cb4dfff 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -29,6 +29,15 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
 	return msgtype & RTNL_KIND_MASK;
 }
 
+struct rtnl_msg_handler {
+	struct module *owner;
+	int protocol;
+	int msgtype;
+	rtnl_doit_func doit;
+	rtnl_dumpit_func dumpit;
+	int flags;
+};
+
 void rtnl_register(int protocol, int msgtype,
 		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
 int rtnl_register_module(struct module *owner, int protocol, int msgtype,
@@ -36,6 +45,14 @@ int rtnl_register_module(struct module *owner, int protocol, int msgtype,
 int rtnl_unregister(int protocol, int msgtype);
 void rtnl_unregister_all(int protocol);
 
+int __rtnl_register_many(const struct rtnl_msg_handler *handlers, int n);
+void __rtnl_unregister_many(const struct rtnl_msg_handler *handlers, int n);
+
+#define rtnl_register_many(handlers)				\
+	__rtnl_register_many(handlers, ARRAY_SIZE(handlers))
+#define rtnl_unregister_many(handlers)				\
+	__rtnl_unregister_many(handlers, ARRAY_SIZE(handlers))
+
 static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 {
 	if (nlmsg_len(nlh) >= sizeof(struct rtgenmsg))
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 73fd7f543fd09..97a38a7e1b2cc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -384,6 +384,35 @@ void rtnl_unregister_all(int protocol)
 }
 EXPORT_SYMBOL_GPL(rtnl_unregister_all);
 
+int __rtnl_register_many(const struct rtnl_msg_handler *handlers, int n)
+{
+	const struct rtnl_msg_handler *handler;
+	int i, err;
+
+	for (i = 0, handler = handlers; i < n; i++, handler++) {
+		err = rtnl_register_internal(handler->owner, handler->protocol,
+					     handler->msgtype, handler->doit,
+					     handler->dumpit, handler->flags);
+		if (err) {
+			__rtnl_unregister_many(handlers, i);
+			break;
+		}
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(__rtnl_register_many);
+
+void __rtnl_unregister_many(const struct rtnl_msg_handler *handlers, int n)
+{
+	const struct rtnl_msg_handler *handler;
+	int i;
+
+	for (i = n - 1, handler = handlers + n - 1; i >= 0; i--, handler--)
+		rtnl_unregister(handler->protocol, handler->msgtype);
+}
+EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
+
 static LIST_HEAD(link_ops);
 
 static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
-- 
2.43.0




