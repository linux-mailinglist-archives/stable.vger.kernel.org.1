Return-Path: <stable+bounces-256221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHFOAS6tGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 322755FA15A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3DB53083E78
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985D332909;
	Thu, 28 May 2026 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zturk04N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FA23C8C7;
	Thu, 28 May 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001096; cv=none; b=FbrS6bB1VMUA+2j27x4nV28kH47/BwVsLqkfUTJKBGCgW0QOQ5pBYEzeQKEwpt0GdS+mx5tl7eW7jTB6N5ng8xjrclTYPGdQnWiydAtKcJwgNqr280WOwyGt1kATKuYbROuFhb28xAD4M45fT9SUkfzJKMaVS5XlExoQPFczAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001096; c=relaxed/simple;
	bh=P5+7Pz2I/baz4AkBlouzuPa3TiFXnzH1+h+YaoIAvxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj544MVcPz8EQGn8ubaXoEjyZhyKC1RpBSkr2hD+Sz+rKgkLsvW2O1WckIZrgzWShEA9Jgd0KtqNaTsRW9zIy0DKwFxgActccmkRiSy3TZyxC75dqAZol+xR5fD64CBV243bg0E4y7Uw/AiLouHc0m9f3Vq5TLH7gp4KqM7o8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zturk04N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934AA1F000E9;
	Thu, 28 May 2026 20:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001095;
	bh=elRsY/T7Ew7e01JpMmkZgorIoSSwOqg8PVWGU0TR3z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zturk04N0Qdf4niv5lvFGdUwmxKwHopvmpzUi2Mk/WxYc9eBsTxIQC5LXia7AIdh5
	 6Vk0+eBGcvlErINw/YlSGVOR25zSPN3wzHc6V3oE7y6hGMwGMfP+7GD5YaNTNrwE7H
	 7dwqa3tXLr4h4SxxncDHHdbjHJaTFoKQKZufQXDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 252/272] RDMA/rtrs: Fix use-after-free in path file creation cleanup
Date: Thu, 28 May 2026 21:50:26 +0200
Message-ID: <20260528194636.173308501@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256221-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 322755FA15A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 5b74373390113fba798a76b483837029ab010fef ]

In the error path of rtrs_srv_create_path_files(), the sysfs root folders
may already have been created and srv_path->kobj may already have been
initialized. If a later step fails, the cleanup currently calls
kobject_put(&srv_path->kobj) before
rtrs_srv_destroy_once_sysfs_root_folders(srv_path).

kobject_put() may drop the last reference to srv_path->kobj and invoke the
release callback, rtrs_srv_release(), which frees srv_path. The following
call to rtrs_srv_destroy_once_sysfs_root_folders(srv_path) then
dereferences srv_path internally to access srv_path->srv, resulting in a
use-after-free.

This failure path is reached before rtrs_srv_create_path_files() returns
success, so the successful-path lifetime handling is not involved.

Fix this by destroying the sysfs root folders before calling
kobject_put(&srv_path->kobj), so srv_path is still valid while the helper
accesses it.

This issue was found by a static analysis tool I am developing.

Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260514113834.865530-1-lgs201920130244@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 3f305e694fe8c..1b1c6ea4ee5a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -295,8 +295,8 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 put_kobj:
 	kobject_del(&srv_path->kobj);
 destroy_root:
-	kobject_put(&srv_path->kobj);
 	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
+	kobject_put(&srv_path->kobj);
 
 	return err;
 }
-- 
2.53.0




