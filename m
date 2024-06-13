Return-Path: <stable+bounces-51026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7A906DFD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743E1C217A0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546914830E;
	Thu, 13 Jun 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rY7ADKqI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732791474BF;
	Thu, 13 Jun 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280089; cv=none; b=LuDKDfjVs0FOgSGtv+bzhnU/OpsaUr7WdQ6/3UUjZ9qevCUzova/iJEI71vKQcL9ag3eL2RuO5c6e1iyNzB44001xtO7GzJN+6L85McbrTecV0s2Lf00Fp/WDLY1bfIERDEbvWAjMMnLnpMHx2b8W3bQK7uHTvAMEs2AYiIAYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280089; c=relaxed/simple;
	bh=rhEHQGYV1JqRvTKRgRcjzCIEG4HoUxQRfzbgXL4oAGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzuGt6DdEPryVU8oFqfh/IMVjAU1aZ5fM00c9XxUdtp2SYkcuVa1heehtojKj5A9xDuuw1UydN92NmmfGIwFXcQYoacavEEb7RcSn9VpbfH9FiBencJe1gnJRE8SyFGPLBXalQrWYQo2y1KZI5PR+wihbZ/dncqMU8kAK3mZjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rY7ADKqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D816C2BBFC;
	Thu, 13 Jun 2024 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280088;
	bh=rhEHQGYV1JqRvTKRgRcjzCIEG4HoUxQRfzbgXL4oAGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rY7ADKqIuB84EeZ/p9NTsL4iUxr52BG0q37knQiZO/8ViGxx4FIPdNDOVZXgdsf9P
	 PjDHQeikkonwKdkhmLCQuyzel6lRYvUL6IF3TYfm/U7GbAk3CsOHmdvQf99TP6RgdF
	 Eu3Wl0Yn7P1NOdUz73PdcsafuIPZ4uMIDsmP/4HQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Dan Aloni <dan.aloni@vastdata.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 138/202] sunrpc: fix NFSACL RPC retry on soft mount
Date: Thu, 13 Jun 2024 13:33:56 +0200
Message-ID: <20240613113233.086842677@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

From: Dan Aloni <dan.aloni@vastdata.com>

[ Upstream commit 0dc9f430027b8bd9073fdafdfcdeb1a073ab5594 ]

It used to be quite awhile ago since 1b63a75180c6 ('SUNRPC: Refactor
rpc_clone_client()'), in 2012, that `cl_timeout` was copied in so that
all mount parameters propagate to NFSACL clients. However since that
change, if mount options as follows are given:

    soft,timeo=50,retrans=16,vers=3

The resultant NFSACL client receives:

    cl_softrtry: 1
    cl_timeout: to_initval=60000, to_maxval=60000, to_increment=0, to_retries=2, to_exponential=0

These values lead to NFSACL operations not being retried under the
condition of transient network outages with soft mount. Instead, getacl
call fails after 60 seconds with EIO.

The simple fix is to pass the existing client's `cl_timeout` as the new
client timeout.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail.com/T/
Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c6fe108845e8b..dc3226edf22fb 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -964,6 +964,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
 		.stats		= old->cl_stats,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
-- 
2.43.0




