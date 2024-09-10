Return-Path: <stable+bounces-74753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5ED973147
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AFFB29957
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351D18DF97;
	Tue, 10 Sep 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GcMYRi9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314D18DF69;
	Tue, 10 Sep 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962728; cv=none; b=K4Q1OHRZiW6MWzWst8RfFD9/LnZNM6M6YYaFdMDXPyD7ryn2sGvCy8LRiF1FobLyVacIen2gdkPYW5zf6o5AJD8dpgUU4KcgEkobNN2y4s5Cr27gvtW24Suq2BEq5ZOgytEUMkWDVCJWIZS8C0bdr86BlTGRERHgrxkByFvUdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962728; c=relaxed/simple;
	bh=2M8huLwA3Uv0mZUAo/NpwWEValX40ljyZorrHAR/iTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+lttRJop9S4Vz5ihTIRjIFEMMczNmLraJ7p/RwLSpUzcMBvvvO3j5ldfAE1ZNSakttlUZqHg0zkE5zKsjJzWWuhHet7lGgc72yFam/w9m4CgVEPNXzzba8b76hrFwermri1GALz5IO4/Hm6rX/hBoMQpT8wQOMjwOBtFbA/ux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GcMYRi9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA8C4CEC3;
	Tue, 10 Sep 2024 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962728;
	bh=2M8huLwA3Uv0mZUAo/NpwWEValX40ljyZorrHAR/iTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcMYRi9biZgwxjZowcmUZaH8tle/fBGWB3NtMMxYlNp14XAyWGXwoEeaXyB1etnVM
	 0YwnAb0EUyRALWe4PF5kr/2GKyUccvHmoR6pcbW8oDo+qKVEfmDtltsQrSIvPxrKpp
	 HCILX1WqNB8ZgarcBf7aAXMWd+X9BUup1kyrZFGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 010/192] ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
Date: Tue, 10 Sep 2024 11:30:34 +0200
Message-ID: <20240910092558.345562430@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 844436e045ac2ab7895d8b281cb784a24de1d14d upstream.

Unlock before returning an error code if this allocation fails.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_tcp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -622,8 +622,10 @@ int ksmbd_tcp_set_interfaces(char *ifc_l
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+				rtnl_unlock();
 				return -ENOMEM;
+			}
 		}
 		rtnl_unlock();
 		bind_additional_ifaces = 1;



