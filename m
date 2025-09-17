Return-Path: <stable+bounces-179849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2403B7DEE3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CF13AAADD
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B481EBA07;
	Wed, 17 Sep 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVBKp1SQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1A194C86;
	Wed, 17 Sep 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112596; cv=none; b=brtBRE9A+LZNVkju+buBpvWXAnmml5yKL0OfeYuielwr1eGfBJ/7TSiZ6K9yLRMSyYy0AsTxS0G7Zla4OJyGYnOqtQEA/cOLi5ARPVoS2MJ9PyMGtbsV1BdbNomMX2fwnaIPqL3slQ0kZ76k2zm4OeOnv4MUrOcVcm4ko5PuJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112596; c=relaxed/simple;
	bh=JfJQ38hQTa5DE73pWGbiuLXDiBklCB1qvUZ7mT0kBnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH2sdMS+gzLcVS3MCAicTx0YYtNKrZnRe2+ClY2BDlqwZd2iqb0O3BUlrV338VGtyiKPrKoUJtTYfzQnSn6MUQCl9QQvmdepKWMKiAa2mSHUKyIcRpc1WPYuVb33vBxAYKiL8cIqi+XQHIzJmcp+xiVOL4mFF8MgbTn4fq8rARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iVBKp1SQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE113C4CEF0;
	Wed, 17 Sep 2025 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112596;
	bh=JfJQ38hQTa5DE73pWGbiuLXDiBklCB1qvUZ7mT0kBnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVBKp1SQetPud85q+o5U/uAYhjDlB0M9SX0NZThZoXPXWx9xOv/xTM3E/nDCnryUl
	 okGUooZ5KKLrOxNYsJxFD7rK3o3WQUZ/a1k1S+uAYbC+70p8zEFTTM1RXwjWaqiUn3
	 ck5EFgAGIWw+okJbB/utH8KTw0CHg7A7M3Uqn3vk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Haiden <scott.b.haiden@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 019/189] NFSv4: Dont clear capabilities that wont be reset
Date: Wed, 17 Sep 2025 14:32:09 +0200
Message-ID: <20250917123352.322489558@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 31f1a960ad1a14def94fa0b8c25d62b4c032813f ]

Don't clear the capabilities that are not going to get reset by the call
to _nfs4_server_capabilities().

Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7e203857f4668..fc86c75372b94 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4082,7 +4082,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.51.0




