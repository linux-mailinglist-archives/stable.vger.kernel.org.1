Return-Path: <stable+bounces-181237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A84B92FB1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7483A7298
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3689222590;
	Mon, 22 Sep 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XilH6IPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3DF2DEA79;
	Mon, 22 Sep 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570032; cv=none; b=g+SXlUec7McabMDmRpLheiQFE4LFtm/zKql8apH4PdewHy5uh9lcUfRZHdrRLzA5zo3Fmb3DkmC6zNhijrhF93InctQX/LoR0oM0VSNIMKbqTXuo9uEkHxX7Qbuh537dJrh0MCneGwSGLwhggeBZw7xDCZ7aoSv9jVVGuv0kf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570032; c=relaxed/simple;
	bh=3LyVNgj33xLG6tqMrcdwci5GO7Rd6E9EXSEavE7XAVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9U86bZndJcsdzaAVC3QpvjzHqJdU2Un0kW+5h/7ICK4/WGYz6FouZksZti3Vsy7Db07/UQaBiqv6QQHJhkA+JkxpS7iwaZPZrU7adeiGIxykEdD1GKSIBnYzSQ9a5pDNDfmgxJ68FEenryuXXvLtWZoNzgP6MyyKpg7GS7oXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XilH6IPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6BC4CEF5;
	Mon, 22 Sep 2025 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570032;
	bh=3LyVNgj33xLG6tqMrcdwci5GO7Rd6E9EXSEavE7XAVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XilH6IPN2rG3Xk4HXSaaXqG9MbRd/VtyTkQS0B+jqM2V1DPNBtx/QtsB29HGfVFYL
	 dsiPqZw04+d5ETf/vToUEeqVhRTmJQrGUGKfRUjw4zsGv0jdLfvCI6hdykjXzaHW+o
	 fuJ0DbZ/+YAOWM52XCWXlrh84Vja49xJKfcxerlc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 083/105] smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path
Date: Mon, 22 Sep 2025 21:30:06 +0200
Message-ID: <20250922192411.075611876@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
References: <20250922192408.913556629@linuxfoundation.org>
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

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit daac51c7032036a0ca5f1aa419ad1b0471d1c6e0 ]

During tests of another unrelated patch I was able to trigger this
error: Objects remaining on __kmem_cache_shutdown()

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smbdirect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 6284252aa4882..b1548269c308a 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1075,8 +1075,10 @@ static int smbd_negotiate(struct smbd_connection *info)
 	log_rdma_event(INFO, "smbd_post_recv rc=%d iov.addr=0x%llx iov.length=%u iov.lkey=0x%x\n",
 		       rc, response->sge.addr,
 		       response->sge.length, response->sge.lkey);
-	if (rc)
+	if (rc) {
+		put_receive_buffer(info, response);
 		return rc;
+	}
 
 	init_completion(&info->negotiate_completion);
 	info->negotiate_done = false;
-- 
2.51.0




