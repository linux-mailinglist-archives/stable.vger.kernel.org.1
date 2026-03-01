Return-Path: <stable+bounces-222397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGCNFj6wo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:19:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF11CE639
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99CF73053B07
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2426ED59;
	Sun,  1 Mar 2026 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk+/fKfa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0572FFFA5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333002; cv=none; b=prC8EbMkmz7e7+hGxlZbf2yWaIi0TrwNygLm8FO14ZSZffYxk+y1RkZKXQI6Rg7YSOI5xgiHiDqSbwskqsY3Ic9r//LXI7Cfn/28A4c4khXBWk5uUbcKc4wbz7adp8M7IHFufqWq5dqSBmSGvRTtxXdJ2cWHAyaoIOyM6BQNJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333002; c=relaxed/simple;
	bh=StiYaJg5TnIgR97jqI7sw8c91dqPU9OEJIf6O1a7rcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBGbNTktSq6UynuFedzImtt07I+265JtkFC5zrqleZGXJlqMMx7sUM+e6jzyGywpQgQFsaOrZGBUeGIXx+VS4qOedDLpRwSWK2Pc2bwvaXHFE/sESp/utoqBBEL979EHMAl5OZRZ1TQsPRzsDIyAUB0+xYDRWog3JxWvd0wq6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk+/fKfa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1092444a12.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772333000; x=1772937800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/4+K7t1AmwyZhD8tmPo2E9QsgNK7fdWts0ll2jiHOI=;
        b=fk+/fKfadFRQ7MYgVDN1VuVfl4regnAJCFFnKsnVI6r492dj1JHXFRU4eg4nF1DnfX
         Yejzn8vJxjB9ZRgtAQM6GbRb0H5XgmWZk7XhDfs2CEUFjNExW2nQeOnOdG95VvIA92UL
         mbfZDSpSfP+g/sXHSgCK6xRxdgYXcUmT9fc6kJv9vwn/IsqP2GNTyIhsBw0/fSXiF4fz
         P17VaME0dRXVtQeQIRiama8JI8O+jWqqxq8GGRFKr/81fgM7D+mS/TCjXyDPJDTUNVdN
         vAEwp+EeCbW1EGte+BnFhO6V09fE+E9mOqsN4noP8ILIRhWi4zBKgsb1EwThyvmWjzMS
         MMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772333000; x=1772937800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/4+K7t1AmwyZhD8tmPo2E9QsgNK7fdWts0ll2jiHOI=;
        b=wx7L+lq7SDxMUcoGYRXLBmbE4RVKD5HR374RdCAePL4b7dpDObIgaqLP7HskinIoPO
         T4nTaTJnZIBbPIAlSNz3rk4agzwwNQ2BvJZGqanHTcwzCtYplwIwgETMdsFMCzXvmSkm
         0ZncRivP6f5FhLWUHFjscbhc1kD1ShvBKju1hWdITcbkFuWABtWFHSrKGDPAU0eWWEyz
         2L+qF4KoI80JdkNfkYcLj8iXZHAmexjRq0WdxTFm/j8EgWeSLaoTzh6ce4SeCQA82jIT
         DpBhFvaF5gu9qkRVrxGMrVCWMiSaQqfgibfUE8arQwYA9YmsZLU/0j0xL1QzTQYCgMSD
         6rag==
X-Gm-Message-State: AOJu0Yy8blfdLQmaE4JmBQ0B1CLOYiqdfcfXiTEov97g9vlb7810IVcg
	09Tgg6yNFwZ6TmPQS+8krKmYcvljTh4VRqxHdyRfSOeBJPwvqXJApYKCFBPjAaKJ
X-Gm-Gg: ATEYQzy5ch6ve5EJ5WHNRDSI51LFx7F4YgANtVpPLX+wp7n0XK2eZBAenRV0bnOPnoN
	bnjPLkY19gTPXlSGleC+pyjp3e63/tt8gKjcMRuLNjJxiNsBfaQjGUQoFl6DTAvQvu7vhL5KJDw
	0gmC7Td6DzqoT8nr9b9Vujl50GEq5064gmZNGQE5QWIcagefDzaxkyeyVk38QJBW/oVKTc1fMXr
	91iefYh538QxvtUZ1ef3aCg992sn/UogZMZof01fZKMRMDfRMChQlALh9WB+NUO0r8qCDQ+KVzU
	lgH5gIothcSSBQ8gP4fvXjrExuHTDkwH4CNEQMIAI7ielNsHREuw/ZyOwqkY2/wnpQo5eWJE3TS
	WZS3h5/SvCkyT1YSnY2ak8lamdlOVBIiuVpyfKr4dZ7BXB3OF2Sln36zutY8CFx4Rc6LL1ORHHn
	ochllWvyFaqL0swldpN4H+CNXIMjcGqlZeDSgea8CQXMsJ+3RygAumBko=
X-Received: by 2002:a05:6a00:b42:b0:81f:9c54:65df with SMTP id d2e1a72fcca58-8274da052f5mr6154918b3a.50.1772333000173;
        Sat, 28 Feb 2026 18:43:20 -0800 (PST)
Received: from localhost.localdomain ([222.109.75.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d55216sm9299322b3a.11.2026.02.28.18.43.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 18:43:19 -0800 (PST)
From: Yuchan Nam <entropy1110@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	sprasad@microsoft.com,
	stfrench@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Yuchan Nam <entropy1110@gmail.com>
Subject: [PATCH 6.6.y] cifs: some missing initializations on replay
Date: Sun,  1 Mar 2026 11:43:08 +0900
Message-ID: <20260301024308.80078-1-entropy1110@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301013911.1700044-1-sashal@kernel.org>
References: <20260301013911.1700044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,vger.kernel.org,lists.samba.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-222397-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[entropy1110@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDBF11CE639
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 14f66f44646333d2bfd7ece36585874fd72f8286 ]

In several places in the code, we have a label to signify
the start of the code where a request can be replayed if
necessary. However, some of these places were missing the
necessary reinitializations of certain local variables
before replay.

This change makes sure that these variables get initialized
after the label.

Cc: stable@vger.kernel.org
Reported-by: Yuchan Nam <entropy1110@gmail.com>
Tested-by: Yuchan Nam <entropy1110@gmail.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Yuchan Nam <entropy1110@gmail.com>
---
 fs/smb/client/smb2ops.c | 2 ++
 fs/smb/client/smb2pdu.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 138b3ed..4239b68 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1147,6 +1147,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	used_len = 0;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
@@ -1545,6 +1546,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	buffer = NULL;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a8890ae..595f043 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2850,6 +2850,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 
 replay_again:
 	/* reinitialize for possible replay */
+	pc_buf = NULL;
 	flags = 0;
 	n_iov = 2;
 	server = cifs_pick_channel(ses);
-- 
2.43.0


