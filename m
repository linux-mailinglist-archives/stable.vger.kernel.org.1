Return-Path: <stable+bounces-158158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93FCAE5731
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7784E30C8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8F22422F;
	Mon, 23 Jun 2025 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jh2Rwh6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1042222B2;
	Mon, 23 Jun 2025 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717626; cv=none; b=JL59hhz4UMIV8CWRWf4gdq3i7nLj+GXtBl5N4Tdr01q8TD35qDiJtX144iVny/7ZP4wr1utbhjk1HJfIQjhzrHE4SHKpi9W0IIzfxzJjVrdelYDyodEtAMBG9rrTQxoGxhhAUwENfQGcPspC98XfPj0NQ1HWP1FvFVi+cAPJNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717626; c=relaxed/simple;
	bh=A61kyApMLT3NLDDEAvljlD4CLlkwSUJtakXRvyYPjxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq+qZE5wp0v4g5KBS9kcnLDWWyLO/HEjNg6FSI70sdX6ro0iBTBmr8rm+gNW3KM6SQl5Xm7TcBx/0IEWGffh5/PWMA+b6KFemyeMQD61XMqMzyMLRCY8ejr/R8RzKOBKX+1nP5BicIVQ4EZjNXDjUu7crpozYDd1uoli9LSyH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jh2Rwh6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65482C4CEEA;
	Mon, 23 Jun 2025 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717626;
	bh=A61kyApMLT3NLDDEAvljlD4CLlkwSUJtakXRvyYPjxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jh2Rwh6P8zei/GClBM9X1am/gaZbC5bFgi+BK0NjY7e9JueNJIA+h4+PYIRSJHgPd
	 6hDfzmIeKbCEvZHdz2JB8QxY4MWyovAYXze/r6engPsHAqrph1lLO+Bv2wHcOtMREr
	 On1HtyWPE2nJDZBXsLksrbMgUd6cW1Un6AA5fKJk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	zhangjian <zhangjian496@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 400/414] smb: client: fix first command failure during re-negotiation
Date: Mon, 23 Jun 2025 15:08:57 +0200
Message-ID: <20250623130651.939293304@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangjian <zhangjian496@huawei.com>

commit 34331d7beed7576acfc98e991c39738b96162499 upstream.

after fabc4ed200f9, server_unresponsive add a condition to check whether client
need to reconnect depending on server->lstrp. When client failed to reconnect
for some time and abort connection, server->lstrp is updated for the last time.
In the following scene, server->lstrp is too old. This cause next command
failure in re-negotiation rather than waiting for re-negotiation done.

1. mount -t cifs -o username=Everyone,echo_internal=10 //$server_ip/export /mnt
2. ssh $server_ip "echo b > /proc/sysrq-trigger &"
3. ls /mnt
4. sleep 21s
5. ssh $server_ip "service firewalld stop"
6. ls # return EHOSTDOWN

If the interval between 5 and 6 is too small, 6 may trigger sending negotiation
request. Before backgrounding cifsd thread try to receive negotiation response
from server in cifs_readv_from_socket, server_unresponsive may trigger
cifs_reconnect which cause 6 to be failed:

ls thread
----------------
  smb2_negotiate
    server->tcpStatus = CifsInNegotiate
    compound_send_recv
      wait_for_compound_request

cifsd thread
----------------
  cifs_readv_from_socket
    server_unresponsive
      server->tcpStatus == CifsInNegotiate && jiffies > server->lstrp + 20s
        cifs_reconnect
          cifs_abort_connection: mid_state = MID_RETRY_NEEDED

ls thread
----------------
      cifs_sync_mid_result return EAGAIN
  smb2_negotiate return EHOSTDOWN

Though server->lstrp means last server response time, it is updated in
cifs_abort_connection and cifs_get_tcp_session. We can also update server->lstrp
before switching into CifsInNegotiate state to avoid failure in 6.

Fixes: 7ccc1465465d ("smb: client: fix hang in wait_for_response() for negproto")
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Acked-by: Meetakshi Setiya <msetiya@microsoft.com>
Signed-off-by: zhangjian <zhangjian496@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3993,6 +3993,7 @@ retry:
 		return 0;
 	}
 
+	server->lstrp = jiffies;
 	server->tcpStatus = CifsInNegotiate;
 	spin_unlock(&server->srv_lock);
 



