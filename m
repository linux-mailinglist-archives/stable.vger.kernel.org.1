Return-Path: <stable+bounces-180302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A15B7F0E0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86321C27BAB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD4330D4B;
	Wed, 17 Sep 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0fFHifn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782B333AB8;
	Wed, 17 Sep 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114027; cv=none; b=bC/KXwgjyiOK1maTiaDobP/oaLh/bqmGMKUWfu6VgZZrn3T4+mD08oBfOyaP3yCn8iysn+lVSWUB0gRNjJhYEna9R2HYEUm9JvEN1Q90kQAL6XhL2mvMEQQqEswHLrKzK/5vIlJnleDoOPNGsD3AIu/ISjVOs+93q2QdfNetXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114027; c=relaxed/simple;
	bh=ogHgRuEkL1PK6kKOcXC7THJ3ZUYQs+Yli9pF7sHrDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCEDu6kmz1oS+8msTDEEzoevoDZ+qCzZsAIxAnTI+Xt5/7ZyBucQAuZVc/GXg2oWm4GXAZjauVXCpj4DMtNP8N0RqeGDUxDHSxrBVWKyJmwkU2GClCkuxVC44exynUcHPJ+gqCNwpk/LY0wdlZUcP3UXLHOcCA4waDhR8zzA4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0fFHifn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC0C4CEF0;
	Wed, 17 Sep 2025 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758114027;
	bh=ogHgRuEkL1PK6kKOcXC7THJ3ZUYQs+Yli9pF7sHrDcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0fFHifn67ooB0z2XLk97jfcuen7L+cnaxB8ko8/HaUk0vK3hSCqoqkLStc8WY+w4
	 /wLo06p/TbHdRdKYgkn72myYCSAm8RzoQ1WvJh5dTijPjg/O3soG13H/WVTkhh3F1J
	 o6mbxM/NVWbNVhh+ftPb9LJhPwguEYjEvOnIKVNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 6.1 24/78] Revert "SUNRPC: Dont allow waiting for exiting tasks"
Date: Wed, 17 Sep 2025 14:34:45 +0200
Message-ID: <20250917123330.155736405@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 199cd9e8d14bc14bdbd1fa3031ce26dac9781507 upstream.

This reverts commit 14e41b16e8cb677bb440dca2edba8b041646c742.

This patch breaks the LTP acct02 test, so let's revert and look for a
better solution.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Link: https://lore.kernel.org/linux-nfs/7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk/
Cc: stable@vger.kernel.org # 6.15.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/sched.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,8 +276,6 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	if (unlikely(current->flags & PF_EXITING))
-		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;



