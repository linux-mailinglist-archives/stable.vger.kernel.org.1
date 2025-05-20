Return-Path: <stable+bounces-145194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD52ABDA7E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC04A42D2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15F242D93;
	Tue, 20 May 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RtDHPTjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91A1922ED;
	Tue, 20 May 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749440; cv=none; b=GwzJ+Xr8B7bJzRB9bmuzJuKRFbJfPtp/tjA4cM28h1RbBQp9YoclOBRV0ijksuFO3dq8e8+6VS+5Vo2h9Qi0VH6DFyNcPgcPvCf67ZjY/r7tzWRMSNYifcGiHpaXLtpjvxeZ3ilBnokmWyx4+961E9tmk8skZsiZVl3d6BcIBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749440; c=relaxed/simple;
	bh=3RKpI/+2M2p3jyZPDecFvcRGwt8DlyBtveMU7kO4Vqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm01Xpxb2cmIToSk9uqviKITekouj5XgarVguUlrQvydZv/fvlPLTkMrC9uV+uvXBufiCdY0vXV84xyTg7++zF4oIKjPWTzM1F2RfM2Aw6zef6r6WFnxYRm/YKq+NWSdyJNYGylqczUNO4L0wA4BA9DIBjxPQ3sXeJvKADU4X0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RtDHPTjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF55C4CEE9;
	Tue, 20 May 2025 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749440;
	bh=3RKpI/+2M2p3jyZPDecFvcRGwt8DlyBtveMU7kO4Vqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtDHPTjoSlvz421xLlcfZOwpKNYfATPg3lUm6kw3djMvY7SCc40qfM8cPKr63Rxha
	 BczOJ7/T7iLHVjTmtJt0S+hAnI1KxIZ4km5N2KnFMo+B5RYo8WKeOIRvXecpQXM972
	 XhwEwiK3JJFPWgsOPQk9Pcrdr7gIt9p2gWXzYLkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 28/97] net: mctp: Ensure keys maintain only one ref to corresponding dev
Date: Tue, 20 May 2025 15:49:53 +0200
Message-ID: <20250520125801.764793409@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Andrew Jeffery <andrew@codeconstruct.com.au>

[ Upstream commit e4f349bd6e58051df698b82f94721f18a02a293d ]

mctp_flow_prepare_output() is called in mctp_route_output(), which
places outbound packets onto a given interface. The packet may represent
a message fragment, in which case we provoke an unbalanced reference
count to the underlying device. This causes trouble if we ever attempt
to remove the interface:

    [   48.702195] usb 1-1: USB disconnect, device number 2
    [   58.883056] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    [   69.022548] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    [   79.172568] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    ...

Predicate the invocation of mctp_dev_set_key() in
mctp_flow_prepare_output() on not already having associated the device
with the key. It's not yet realistic to uphold the property that the key
maintains only one device reference earlier in the transmission sequence
as the route (and therefore the device) may not be known at the time the
key is associated with the socket.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Link: https://patch.msgid.link/20250508-mctp-dev-refcount-v1-1-d4f965c67bb5@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index e72cdd4ce588f..62952ad5cb636 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -274,8 +274,10 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
-	if (WARN_ON(key->dev && key->dev != dev))
+	if (key->dev) {
+		WARN_ON(key->dev != dev);
 		return;
+	}
 
 	mctp_dev_set_key(dev, key);
 }
-- 
2.39.5




