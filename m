Return-Path: <stable+bounces-145288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0EABDB24
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257374C59D7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CA246768;
	Tue, 20 May 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZHq1Q39"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DACF1F4622;
	Tue, 20 May 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749730; cv=none; b=qZIsL0VWzJgSJ6RopnQKYg5yMJ2g+vKt12jIpunPCS3JKpPStwQCAQAvcATVjr21dlXRKTVlYZfkY4wcciKch/+Ih9cPxeTk9k5pa4UgbL5YgkBJpXIXzfOcbuDM1ljt9V+utH3KmgD5YYWFBFdM1JwWmpV7SFD4wJ0wg4TsQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749730; c=relaxed/simple;
	bh=/ErcEAep7eeZBWlJ+uQUQc3Wxk9ZsXLE9I5b9rV6xIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnJlyRjce5BG5RgeR4k5eOWybvPDYi4NK1xTpjxCirWraVOz/NtxK9EDM1QR8q/pTO9iyUS3n1kKWF8Qtk2IIP4/q8psAro3g1RG22EoUV6s2EO6ffZftc2X022v7/mp2L5BhDaSrJm6AUro8U1L9+wtPjC0jmr/BMhvL2dEw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZHq1Q39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770D7C4CEE9;
	Tue, 20 May 2025 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749730;
	bh=/ErcEAep7eeZBWlJ+uQUQc3Wxk9ZsXLE9I5b9rV6xIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZHq1Q39nOeFhEF8R1hEh0IeFVcYmJC7ZQGA08Nck8/gajnnOI5y+y+8Tg21oLtnR
	 epWoojmnC25JmvT444H9JxZla1WPvGFDnn2jOKF8btzRDAIAkCIZQtwFr2ZETf/61C
	 EJaP7/R0nQjqShnLk+mgexmRhGQDY/q+PH0t3VY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 041/117] net: mctp: Ensure keys maintain only one ref to corresponding dev
Date: Tue, 20 May 2025 15:50:06 +0200
Message-ID: <20250520125805.620247185@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index d3c1f54386efc..009ba5edbd525 100644
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




