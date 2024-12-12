Return-Path: <stable+bounces-103798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CF39EF9FB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB31791B7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82F22654C;
	Thu, 12 Dec 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Laa12jke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882632253F9;
	Thu, 12 Dec 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025634; cv=none; b=IaChNhzJU9ldjsd2Y+3RQDHlYAiTnbr/4ww70rZXPsK62mGT9CFWmi6Av6b3heZL3OjEhCrGXttVOJq0Z9yyTENxbp2UVA74f0d/Xc2xZ1K3254+INCn7QccSj9lAXkYAZs/d1ScDc9JjDUpwGi4LAI2Av3FDHp78ciNIcUneUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025634; c=relaxed/simple;
	bh=7DNt2d+rKAum6PTC1fbU819oWgNWC4Cn7ZX0eScpZOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwQv1fDeLaPSlcnAqAoplLtbXXclqVKdtFSrhi1v3fAHCu7/qPcphUocjvrRwoz3iNRX7gTZMmPPikHpb8h7zq6NpMAfcvbNFS8wJxLLJbwPQhWVUs1iQEY7lRYHSGXumk/M+Hw1MWdCIRt9YHsf/Sh2rLZqPFy3M9KRNPbIBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Laa12jke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1661EC4CECE;
	Thu, 12 Dec 2024 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025634;
	bh=7DNt2d+rKAum6PTC1fbU819oWgNWC4Cn7ZX0eScpZOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Laa12jkeuTCx+buNR9no+nCHhX5+M96m4OBDTqLxiNXSWIKdj6moLjo67swDdsfH0
	 HRHJOh/4ebT99LNTlL51DqRt7mdBaUz6SnLkGiRmMcnXKG3EWraWGZMbS629trfVnC
	 cB8zbvjF74v4wR21cXQP1EqUXgm4xK9uaTyKYVsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 235/321] netfilter: ipset: Hold module reference while requesting a module
Date: Thu, 12 Dec 2024 16:02:33 +0100
Message-ID: <20241212144239.256723358@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 456f010bfaefde84d3390c755eedb1b0a5857c3c ]

User space may unload ip_set.ko while it is itself requesting a set type
backend module, leading to a kernel crash. The race condition may be
provoked by inserting an mdelay() right after the nfnl_unlock() call.

Fixes: a7b4f989a629 ("netfilter: ipset: IP set core support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 83fa95ecaad47..1ce19162ebf79 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -103,14 +103,19 @@ find_set_type(const char *name, u8 family, u8 revision)
 static bool
 load_settype(const char *name)
 {
+	if (!try_module_get(THIS_MODULE))
+		return false;
+
 	nfnl_unlock(NFNL_SUBSYS_IPSET);
 	pr_debug("try to load ip_set_%s\n", name);
 	if (request_module("ip_set_%s", name) < 0) {
 		pr_warn("Can't find ip_set type %s\n", name);
 		nfnl_lock(NFNL_SUBSYS_IPSET);
+		module_put(THIS_MODULE);
 		return false;
 	}
 	nfnl_lock(NFNL_SUBSYS_IPSET);
+	module_put(THIS_MODULE);
 	return true;
 }
 
-- 
2.43.0




