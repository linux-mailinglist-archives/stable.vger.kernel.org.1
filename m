Return-Path: <stable+bounces-222396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GFULkOwo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:19:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3F1CE648
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5D13048543
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75230B51D;
	Sun,  1 Mar 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqux1boc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FA2FFFA5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332901; cv=none; b=PNFrnugj1lGYyKk0hTUpYQHT1+ZYQATRuZHfE5cqaHjKvXW1wDNmar9+yTzIidW+lZZMR0iUrv2cPzCw1kX6h8pPF0ET0G5IXz/6isaYYi7CR1PgrtTdefScIVWc5ubfGQv6CLOoVkWnXZFoeyQ2KVPTOc7UOLPPwOdlSd8dJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332901; c=relaxed/simple;
	bh=anpL46cBIm6UrMAbUnBQkqKmbT5nOqCfjQPsoRvAfHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAIG0NhrQez1YjfFoXpu6rj2ZthaaVNz81Yot6AomGHTk34CpI9KulIi8WxwTqjujqL9FOyFMqWDtmzkaTKB6Cc2N7d+trMrDAIrMznA4v3z4lgRk/EnrQK7KlH5c8CPg7wlODGIS6A7tkuVrqCKEPta2Y8P76wxYwLcD2yDzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqux1boc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824b05d2786so2752402b3a.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772332899; x=1772937699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtIGa5DeHX6GKNql8ZP8pFgIuTIayoQ+uGd3ozZ2QhM=;
        b=gqux1boc96rstQk7s34oWXn0IjVf16z5kS0aUBkWyv9JgXsEHKBfS18m4wrjq+qhm7
         VpZw1H2mLpx23eLeTf5WpWTncXiy/fx9sjj/sswCHRAsQu03na/1gmc7GtJDxeoNHDeC
         JYbT6+XUfOXpkKMXqmKJ5/ZUvY08TxxpmMXDk0v2ZBBb2QJgVvgePKl8+eTN5oQ+zzfz
         XTM2EPWpHGTeM+2ndnpYYYrwxYFvfDherafe0U9ndRZ2ewhzO1D2gtVxPDXJyBctw8xo
         TK0S97XwQtgwqopFPygYGO/CRHQ5az9DlsEQSKD5/j1LVtI94v9GMxiXg0SsV3+Wk904
         Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772332899; x=1772937699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rtIGa5DeHX6GKNql8ZP8pFgIuTIayoQ+uGd3ozZ2QhM=;
        b=f7/YK+dkeGS+nooPwHWIJih5070EEV6gVDZXI6PxpYv7uy6ImvLi/ui7ydexT+ai2C
         RrAdUVLU8YQ809hTgLsk8Xyw39AbOt10GamHAjB6muZ8LVW+LK1z74VbTH3hQLZ3W4Kc
         JA9KO51UoQKil5Q1hcTy/Kg+Ezt/ffUu1HM1lM9Q6VSZFySCa3KyRGf5xHXGSq1HPTND
         og17NXQqw+Tv0VIX1DgDKAfBBK6e//WA/HGlIUAHoh8Vcg2SVuGNbLN3Q6I79jMhq84J
         Sfn+aiRaSMnmERA81ZsFEilRI/0NmeYKgbi/3fzdu6LDFsNBoII/29i2Inybreab665f
         OxEA==
X-Gm-Message-State: AOJu0Yy5cdAuigWClDta2OV597Q5tXtZWIuCYkHI3FbUdZ5UKXbIjkrO
	9jOQM1P5g57UceYUObQXK8nDwDP7nJ6mF4vZjHAMf8SM4TXTnZUSKMoPlwjwEWLU
X-Gm-Gg: ATEYQzyHXfc+cMtQphiItJfmNsMvNfHVoa7VahJ+IHVvJ4x4gfm7ZhPTwtgNZGrsV70
	jvMzhJCikAcI8OHe4S4gw4Qz2txBBZwcHJBY8gnkbkiyB6ogJ+UxQKiopDyjOTSxAANeQixPiWo
	AEADCwBmXb5NFhUmcKGI2W1KEvmAG+kACz2ROsCaXyJUR4f8VXcKtehzPWHS3TB3rLO7rtqASXz
	g44IhWMXKqv++JfcsrYoo8yENewHQdNFg0Z3TsX2ApMz48bRPsIIY5BN3/2M34D/cOGEPL37ipb
	9t20emiWwwQ5k03BqGpO8o0KWDHYoRpZB1k1JkiSfMZ5qFwt8K8QoVktXdCIcMAkIRWTB/SZckP
	J/Wj36m6OnTwvrCoanpLU1+vn9vBZYHo2HK2RH8MFgjEvcvj7JA1xm4tXiKrF8ByIhoMabtM19B
	HSpy4iyqjAJvWmh0Yygyk6AAE6lbOF1mEmVK04YJ8oebK8X1dvI0Hnmkc=
X-Received: by 2002:a05:6a20:a127:b0:394:f9f3:588e with SMTP id adf61e73a8af0-395c3ae862bmr8668720637.43.1772332899049;
        Sat, 28 Feb 2026 18:41:39 -0800 (PST)
Received: from localhost.localdomain ([222.109.75.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359037af175sm11857110a91.13.2026.02.28.18.41.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 18:41:38 -0800 (PST)
From: Yuchan Nam <entropy1110@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	sprasad@microsoft.com,
	stfrench@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Yuchan Nam <entropy1110@gmail.com>
Subject: [PATCH 6.12.y] cifs: some missing initializations on replay
Date: Sun,  1 Mar 2026 11:41:31 +0900
Message-ID: <20260301024131.79122-1-entropy1110@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301012846.1686559-1-sashal@kernel.org>
References: <20260301012846.1686559-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-222396-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 59D3F1CE648
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
index 4e7e6ad..48d66a9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1190,6 +1190,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	used_len = 0;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
@@ -1588,6 +1589,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	buffer = NULL;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index b0ff9f7..9310dd9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2856,6 +2856,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 
 replay_again:
 	/* reinitialize for possible replay */
+	pc_buf = NULL;
 	flags = 0;
 	n_iov = 2;
 	server = cifs_pick_channel(ses);
-- 
2.43.0


