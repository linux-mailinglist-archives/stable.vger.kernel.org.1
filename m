Return-Path: <stable+bounces-241111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNxOLUyF7GneZQAAu9opvQ
	(envelope-from <stable+bounces-241111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:11:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 166064659F8
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3B43012272
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04337C107;
	Sat, 25 Apr 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjP2kZH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288837C90D
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108293; cv=none; b=FmA9smN1DznoyCt2KihRtUI0C1LxaS4FPa1ReHStYnoqB6B5yi6re2UDSKeu3Bloh1Gtf8cHxZEJkE5l5jhPQLU3GR6tMoy8xhcX342rUMAVn6kL/hkE6Pl1F0b7OyqAQyZaGehNpEnNpHPM3L6XSZ21Yhi7q4QUQ3iAPAPKQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108293; c=relaxed/simple;
	bh=dcgB8CyEZTqh8eE/be8XkJAOZ8pklO7XrjXFFhbQyVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5Y+92EhQ3jZh0KxVoZ7Epg0ieZpE3qkGK7CI0E2UYt7AmGnpTjvRla04+cXQK8dW01dIZ38Ruq9LiKxiLmn5Vrx4WgCD8iUKhSjDOnwWw//3DjApxwMbMSLIeHKZEa9ldlRnOESzil5TN+sHGz7BHE1BzqObWQi2FmyM8czyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjP2kZH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B731C2BCB0;
	Sat, 25 Apr 2026 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777108292;
	bh=dcgB8CyEZTqh8eE/be8XkJAOZ8pklO7XrjXFFhbQyVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjP2kZH3v12peUjBTOmU7mMkAeQL3bVkJT524a+vnC24sdts7rcAhhAjDgigGfBeR
	 cDg+l84hBiss3fja6MhXPS+FDRta52Pz0o6hJCEw4YdI87Hn7OZD2WRZ4uhS3XM+VB
	 IuxeYAGm9xsbvCFvKITYzXi/XvjaR8wGmy/ZJ2l2snF1vBIMI2HKt7c1SRAVowjkrJ
	 1OZiI/UIbXTV5zxreBcmIzjtzfysZmcoGub9Io5/tB1pXdvUx5JFJytUC1KFveAYhQ
	 QQpdDBY6HD7uu8IViF/6Zw5C3EcdBL5pyPurgJnuWlc1QDHhViNCJc6qC6JSKZof8i
	 AwskL1DCnWoWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] ksmbd: use msleep instaed of schedule_timeout_interruptible()
Date: Sat, 25 Apr 2026 05:11:28 -0400
Message-ID: <20260425091130.3330505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042411-family-protrude-c6d7@gregkh>
References: <2026042411-family-protrude-c6d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 166064659F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-241111-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f75f8bdd4ff4830abe31a1b94892eb12b85b9535 ]

use msleep instaed of schedule_timeout_interruptible()
to guarantee the task delays as expected.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: def036ef87f8 ("ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index f5ebc200dd738..6c3b8d2279c30 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -494,7 +494,7 @@ static void stop_sessions(void)
 	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
-		schedule_timeout_interruptible(HZ / 10); /* 100ms */
+		msleep(100);
 		goto again;
 	}
 }
-- 
2.53.0


