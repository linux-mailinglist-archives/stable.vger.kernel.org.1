Return-Path: <stable+bounces-163354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFBB0A090
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5EA168053
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0E221297;
	Fri, 18 Jul 2025 10:24:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3BBA27
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834270; cv=none; b=E4alThWTdw5R/1JEHhRX8ytD4KDobwFtt/87KoXUC6jtIt6EE37xzE04fUOVtjEKju3qcKwWZ344qRCONNdWFNT72ID/k1EhshduvkhBPRqYsFdaC0Hhm0GoQHbRFtb1VfLFKmVB2AKcHZbwMSBnNoKfmoz/tBYOh8TqNtPiyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834270; c=relaxed/simple;
	bh=eHyXehqtuESsNQvGqDO19VFAxnFJe9AWUc88nwzw8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5UxthllkvjzqKRe0fUShfpZZmBXwohqjTj0zooO2KJnEBWZ6Wzxj2/nO6q6jDPsRftm7MEfV50isfzDw2K7LoQHqq9fPicJwms/UjMIGZ1VuI9TdAv3Gv8hFd3WXPFKU0dBIqJ8GeZZqyGlV4F9PqI0a06fBaPyiRnIegxCGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: bacs@librecast.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	stable@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH] ipv6: make addrconf_wq single threaded
Date: Fri, 18 Jul 2025 10:22:32 +0000
Message-ID: <20250718102231.5561-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250718101603.5404-2-bacs@librecast.net>
References: <20250718101603.5404-2-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett A C Sheffield (Librecast) <bacs@librecast.net>

[ Upstream commit dfd2ee086a63c730022cb095576a8b3a5a752109 ]

Both addrconf_verify_work() and addrconf_dad_work() acquire rtnl,
there is no point trying to have one thread per cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240201173031.3654257-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 231fa4dc6cde..9fc511c0c3c4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7388,7 +7388,8 @@ int __init addrconf_init(void)
 	if (err < 0)
 		goto out_addrlabel;
 
-	addrconf_wq = create_workqueue("ipv6_addrconf");
+	/* All works using addrconf_wq need to lock rtnl. */
+	addrconf_wq = create_singlethread_workqueue("ipv6_addrconf");
 	if (!addrconf_wq) {
 		err = -ENOMEM;
 		goto out_nowq;
-- 
2.49.1


