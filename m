Return-Path: <stable+bounces-24549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566BB869519
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886041C24B18
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DB13DB92;
	Tue, 27 Feb 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jeSu2ge7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB354BD4;
	Tue, 27 Feb 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042327; cv=none; b=LR4BAOWxs6c5hK54pQxDUJawwBvTO2+XxcKnMs53Q/uUNkof4gWSVFJk6vphMQ/0bYNQFC8219fLIsZ5hfYRUCIbuZmqrNBEpeEKZlXEPTJRpvXS0seQJX5VlnjDvDO2c4nB/HRSUNcjjJ3kI8NHnkkr6TBsMhJ+Vi7BPz7TIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042327; c=relaxed/simple;
	bh=VVWed+cj1A0J9+E9DR0DKcYUT5XvBZz03R9MGTL2BQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzFuXADhey5gwTCeJYjeiuQ2IFHTb/baaOgAp6gtHDui0PrtU0+feJ6CRA5OceT4TKQ6u50RTaBzmaDM9SQLTqfegEa40C6lhvUw8Lg+D5Sa8kmAmaLzRJidMMk6iJBSu930lghSzmOmF6wZHKRm45ttg1yVAr1o+M945RzIeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jeSu2ge7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC32C433F1;
	Tue, 27 Feb 2024 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042327;
	bh=VVWed+cj1A0J9+E9DR0DKcYUT5XvBZz03R9MGTL2BQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeSu2ge7LYyVHx7t4DP6zD7u6trk6hmpwKZOAyNmpfhj/g/qfyjZYH7K+bwCOXmvp
	 njDel5sLqbiJArL3k97xz3Ai147YUkV7NktPvP/CBRXcAUbCXxan2hQ9AP3WsKKgq8
	 VXZ4Twy64QR+rIlfZANgs5R7fbhYhkggO/FPX+u0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 256/299] devlink: fix possible use-after-free and memory leaks in devlink_init()
Date: Tue, 27 Feb 2024 14:26:07 +0100
Message-ID: <20240227131633.951234831@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit def689fc26b9a9622d2e2cb0c4933dd3b1c8071c ]

The pernet operations structure for the subsystem must be registered
before registering the generic netlink family.

Make an unregister in case of unsuccessful registration.

Fixes: 687125b5799c ("devlink: split out core code")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://lore.kernel.org/r/20240215203400.29976-1-kovalev@altlinux.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6cec4afb01fbd..451f2bc141a05 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -308,14 +308,20 @@ static int __init devlink_init(void)
 {
 	int err;
 
-	err = genl_register_family(&devlink_nl_family);
-	if (err)
-		goto out;
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
+	err = genl_register_family(&devlink_nl_family);
+	if (err)
+		goto out_unreg_pernet_subsys;
 	err = register_netdevice_notifier(&devlink_port_netdevice_nb);
+	if (!err)
+		return 0;
+
+	genl_unregister_family(&devlink_nl_family);
 
+out_unreg_pernet_subsys:
+	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
 	WARN_ON(err);
 	return err;
-- 
2.43.0




