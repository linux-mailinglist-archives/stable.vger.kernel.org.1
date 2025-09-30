Return-Path: <stable+bounces-182711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DEBADD1B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D814A53B3
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AF2FC87A;
	Tue, 30 Sep 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04JyLmBf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B07846F;
	Tue, 30 Sep 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245839; cv=none; b=RnyfXklXk0ZjkpJKrrSchL8AeGGCdNHu9PV/dZX79HJzCLKJxasG0Q/VU+si8yhC25FSsrVcS6wIZ9hFboLK3oEZ6QFuFdALswBWNceoWU6ATTfoc/IWR4nr097wgKNmaSoXUABGuNF0oRbMoGpUJkw2fj4b8cE21pKOXwDXzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245839; c=relaxed/simple;
	bh=b4c1eoEdqpBGQe2JTubd+26/3s5PpejI8NktXPk6yDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjR9eHmTu7RBM1UsGoCIhKFxDp+con4vBCLpTr9GP9UzR7gRln8GsFFspAvVFQSXPjK4V3xHeYnhyaaSICnIW80FmFVdqQbg3if67cdZVM8qbdY1PDeZ5/TTk6UrOfw2I3hEOnKGNGms7s/qK8cSI3V3OhA5e/BuW/cqiQtrQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04JyLmBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A8DC4CEF0;
	Tue, 30 Sep 2025 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245839;
	bh=b4c1eoEdqpBGQe2JTubd+26/3s5PpejI8NktXPk6yDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=04JyLmBf98SP3mQmM0TuagCv2ljCZlgAz07Fn/LGP8l+4c/yk2NgQ2lWQRRuzQaEu
	 HHbrCmsyb+8JnbIW/4Gl/7DfrqOxN4m5zitZ66jXtylwxZPBldvfichbEmsnpfysdh
	 hpxnrPCRRqzd/ftbhqdj8cA8PBeht5K2txTHVfk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhen Ni <zhen.ni@easystack.cn>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 66/91] afs: Fix potential null pointer dereference in afs_put_server
Date: Tue, 30 Sep 2025 16:48:05 +0200
Message-ID: <20250930143823.928445923@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
References: <20250930143821.118938523@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Zhen Ni <zhen.ni@easystack.cn>

commit 9158c6bb245113d4966df9b2ba602197a379412e upstream.

afs_put_server() accessed server->debug_id before the NULL check, which
could lead to a null pointer dereference. Move the debug_id assignment,
ensuring we never dereference a NULL server pointer.

Fixes: 2757a4dc1849 ("afs: Fix access after dec in put functions")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Acked-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/server.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -401,13 +401,14 @@ struct afs_server *afs_use_server(struct
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);



