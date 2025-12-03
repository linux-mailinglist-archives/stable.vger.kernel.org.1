Return-Path: <stable+bounces-199865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA92CA0DAE
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D23304E57C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835534B678;
	Wed,  3 Dec 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNfQj3Kk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F934846D;
	Wed,  3 Dec 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781191; cv=none; b=kCrThTnrXwt4YIaMjDxF4hnRWEyGImzX1nQIzyCyKNjzHD9lWd4hFUjPa6lX09WNf69URkJNdZQZbjrGYs7MVGfI7OsUBEUfzlIuWr/ruXMFcyndEaMAjXDJLURad+gYoByOWqYN/YX4IK/JNlsLQAY/atyoaZzvwTgteKF3GCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781191; c=relaxed/simple;
	bh=A2KoEidZRxPpCiUKt3CGzjB6U/gcD8/+AEMdSMbyCzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmaYYLq8R1znyvI23CgoUabFEVI/kOVJPz6iVIRTsFL9LYihyjdHQFf8IEdsSDA0RuJsSE7c0P6aAsK0UhJc5wmNmopUE96tvm9krKC2vTRjFKxwTWJL8+NNsRzPp5mFXo1ms7pEwd6YUsA33XISD06yNIwWItAYeVAvBAyxb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNfQj3Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB632C116C6;
	Wed,  3 Dec 2025 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764781191;
	bh=A2KoEidZRxPpCiUKt3CGzjB6U/gcD8/+AEMdSMbyCzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNfQj3KklF7kgpWCZQ+z2H6Fgz3FQdH51oPAqkYcTAXj+CrT/8JM06BLQfQqpxh+C
	 WjUBPTfLSDTVK+lfOeJfvGLrrGj7jDisVFMNZTCIRCMI7PfJpfKkp7SKiuEReryCtR
	 5bL4cKqnzfAbPbEx5rcgIgRvRej5i+nKyPTTl07U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: [PATCH 6.6 78/93] bonding: return detailed error when loading native XDP fails
Date: Wed,  3 Dec 2025 16:30:11 +0100
Message-ID: <20251203152339.403805431@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
References: <20251203152336.494201426@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 22ccb684c1cae37411450e6e86a379cd3c29cb8f ]

Bonding only supports native XDP for specific modes, which can lead to
confusion for users regarding why XDP loads successfully at times and
fails at others. This patch enhances error handling by returning detailed
error messages, providing users with clearer insights into the specific
reasons for the failure when loading native XDP.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241021031211.814-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5622,8 +5622,11 @@ static int bond_xdp_set(struct net_devic
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond))
+	if (!bond_xdp_check(bond)) {
+		BOND_NL_ERR(dev, extack,
+			    "No native XDP support for the current bonding mode");
 		return -EOPNOTSUPP;
+	}
 
 	old_prog = bond->xdp_prog;
 	bond->xdp_prog = prog;



