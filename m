Return-Path: <stable+bounces-43119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634138BD194
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 17:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942D21C21E86
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C24155385;
	Mon,  6 May 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBK+H4rj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9A2F2C;
	Mon,  6 May 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009739; cv=none; b=PoNYYDnPGeeenW8N1p4XVTUqr+4IXYxKXN0YbdggvDroX84xje7IU50qxYOgX4wDA+5IHE7fHvnzlDMF0H0P7MYgvlNc3xw/whpFxUOOD8fDzv9Sv1O2zKAiIj9AVYeJ882yF7l3eq1F63q5DLPNB/6/Jx0EBy1DTU5UxaXkSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009739; c=relaxed/simple;
	bh=oGVCWQDYjNsdrnj+qazvX1umQxTGlOb3a+h86Rhs1gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WSbuGe9BuPTYDa88HjBrDSirHkfSro9NLhn8vCUCBXv6r0s8fSs0KO78/SaBJS2TPiVeqOJ/Pcv9G55g045cwcsGwOVW2r4vSJd97UuStNmrt4jThOnXms4Ny4EDKTswu4csh/RCe1/XUy9MqIFAZ7vNIIDI8Zpq68hWWszEEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBK+H4rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B830C116B1;
	Mon,  6 May 2024 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715009738;
	bh=oGVCWQDYjNsdrnj+qazvX1umQxTGlOb3a+h86Rhs1gQ=;
	h=From:Date:Subject:To:Cc:From;
	b=UBK+H4rjTdYc4zvgYsp9IejhkCGq4Szntf3sTdCy0GrJJ8jEXsKN82s5Q5zzliUUw
	 xF2791yhISGMTtPJuJJZIhq3gFcig/GElOOTEwrfFU1Jli8I8eLloTM9byk37OKiLo
	 vhhz8clfYcEk9g6mTo//XJuJ1cO4U4IjI894pU3LKmRAEdjgLWKyr4FLSIhdL4lTm3
	 GKZxJfyDC++EfklCLRug0QtKTpgX2gExt5XVLNK8NMVk70/NVVaHsJjWXESUSJo2EM
	 Z+1QSpJKj2wgJTvo9ejCdc9SYBedYlupcUx5HWcwaGo3FGCvM1QkWhdN9eaYgG1L1X
	 QXqJomxAAIl3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 06 May 2024 17:35:28 +0200
Subject: [PATCH net] mptcp: only allow set existing scheduler for
 net.mptcp.scheduler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-upstream-net-20240506-mptcp-sched-exist-v1-1-2ed1529e521e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL/4OGYC/z2NywqDMBBFf0Vm3YEkbe3jV6SLNF51FqYhE0UQ/
 72hiy7PhXPPToosUHo2O2WsovKJFeypoTD5OIKlr0zOuIu5mpaXpCXDzxxR+L/OqYTEGib0jE2
 0cOvt+2HvN+fPjupbyhhk+5U6qi69juMLcDNVzH4AAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory Detal <gregory.detal@gmail.com>, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0aZdfFi8skR4B7NuJvRMz6O7iszcw6HkWeXMMdh4f+c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOPjH9GWsrQ6Maigio6WZQWiyEbCPrOs+g2gYZ
 BjZMHog7wWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjj4xwAKCRD2t4JPQmmg
 c0qyD/4k/KpuUjpD0HjQHOcfg/2jG9hTmpnqIxN4ug+hqg1rjDQNnQkf/VGV1TdXOQaiWtMn10l
 SpHnUXTHyKf50qDee1Ln6E0woxV1PtW/85n8AunmBGJ1jlaHjymv7ZznCdmL7R5PpKO3BA557Ln
 DRRpg9aB6NOMTgTNi+qq1WkvnoIPIwm/xZaY5QlyceX/K68Rmz7KQUSBWikKeH/3jD4TOZ5r3WC
 RwhrFUjKDI4+Y+sFt/aRWRlQ6KdaN5f22CZIMKcPp5am7FN1R1qLuWJvgvET4jtbz4M5GNen868
 hW5Ony8np6pE55wWex86PvWJgWgmczgq2R/cNrAicpL3yPLXo7V99efn6XWqqP5NUKLoFLBR6Cv
 EbR2BIgETHw4ofpxlKZ0cMutOxqX+SL7nUU36Cxl9q1VZCK2v2FDtWE72i0OFWaXSGXvjv2Rigc
 k0BIUDcTBdj4F8kAtaZtLPd4VKCtdHt9pyq35DOuq0AwE5ExwSIOF7I/CrgZJCWtJ7vjETyh+5B
 bNFnhBXx3kcEyfyMLWbZ9rSKA+gyWNdGWg4DRdf1nPOhOkBIAuNGW17CPos3xLmF1eR4UOnpuNT
 Atld84F0EFo6h/gqVsOSrxWTZYD1I7Ze/m3YP27gmA9qlJske8Bd/LC5sxysjWKy+s52pqyhf2J
 +dSfiB9bZbMkkHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gregory Detal <gregory.detal@gmail.com>

The current behavior is to accept any strings as inputs, this results in
an inconsistent result where an unexisting scheduler can be set:

  # sysctl -w net.mptcp.scheduler=notdefault
  net.mptcp.scheduler = notdefault

This patch changes this behavior by checking for existing scheduler
before accepting the input.

Fixes: e3b2870b6d22 ("mptcp: add a new sysctl scheduler")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 13fe0748dde8..2963ba84e2ee 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -96,6 +96,43 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
+static int mptcp_set_scheduler(const struct net *net, const char *name)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct mptcp_sched_ops *sched;
+	int ret = 0;
+
+	rcu_read_lock();
+	sched = mptcp_sched_find(name);
+	if (sched)
+		strscpy(pernet->scheduler, name, MPTCP_SCHED_NAME_MAX);
+	else
+		ret = -ENOENT;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int proc_scheduler(struct ctl_table *ctl, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	const struct net *net = current->nsproxy->net_ns;
+	char val[MPTCP_SCHED_NAME_MAX];
+	struct ctl_table tbl = {
+		.data = val,
+		.maxlen = MPTCP_SCHED_NAME_MAX,
+	};
+	int ret;
+
+	strscpy(val, mptcp_get_scheduler(net), MPTCP_SCHED_NAME_MAX);
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		ret = mptcp_set_scheduler(net, val);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -148,7 +185,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "scheduler",
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
 		.mode = 0644,
-		.proc_handler = proc_dostring,
+		.proc_handler = proc_scheduler,
 	},
 	{
 		.procname = "close_timeout",

---
base-commit: a26ff37e624d12e28077e5b24d2b264f62764ad6
change-id: 20240506-upstream-net-20240506-mptcp-sched-exist-6a1b91872a32

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


