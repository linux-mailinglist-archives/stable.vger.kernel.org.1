Return-Path: <stable+bounces-216790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePYsFDhclGm3DAIAu9opvQ
	(envelope-from <stable+bounces-216790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:16:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E749E14BD79
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E30F0300D4C7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE553382D9;
	Tue, 17 Feb 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeN9iB3w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9903358B6
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330611; cv=none; b=EuTIwE+k0b8ZQgumGRBzSzVYsvwYpihLR2zQ0GPnP31z4fTW4dj2JdAELVPogdM0TZ7wyjIJe4KdAtHt/dDVMLrzWHbzYdfz+WKVsR26I8MNbu/9CVZwPko97WSyA7E2KpF3eYp4d2c5z0Gjvj0djKUAasZugYJVzC3NY8YgUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330611; c=relaxed/simple;
	bh=5IUOI+GdtYbqqt1hDN8PkLCp9ZIEhC7SZGm9CzRP6ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kVL8Iwie4452Jb7Pp53ZVDd0ZgOYXS1323c8MiMKCmvsui+41FDb02GaVkxbAtx5knbdGYsvB7hsIaiBK1OMzpxx32kXN6qtlWWmlVb9VN69FbKmSuRRmHvOIM0riHxBVbFmlmRGlxNWWH/ILfBFjVU9M9So2rnfu3CCefGumjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeN9iB3w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab47d8b33cso20774875ad.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771330610; x=1771935410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAiOkzjJS9iAgqAV01DIUVkGS9wp9fVwp/L/ZMMWkl0=;
        b=TeN9iB3wwH3UDniSM6WbMZEH6zxqmtVNnvdAfXmAzCdhgJ5zY9bAOIQsqUQt5W2ue8
         lHji+7ThTqIIf+Lbe4zbkVsJOVvZW4oh4FUO73O09D7lBflrtPXn8TzWDP6p7EGJ5xXl
         1ViX7Jd0CtdsOiojVBhPYgjt57mIeyaET40SbLQiTM/aOFuQbwJBOnkMlO89hfoR5/Yc
         3qtdlrmznQKWP4ayI43Yj6rJv+aE/vYPGcNTKY8UndN+GXnY75pGmoBunqIKSMmLyyvP
         PrbVmiowRQILPsR7bVIme6fVojXypqKOUrQxu+2H5KDxhFXCIyfGWUExTENAK9NIWBCu
         Dhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771330610; x=1771935410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAiOkzjJS9iAgqAV01DIUVkGS9wp9fVwp/L/ZMMWkl0=;
        b=iPLXtG+crXBJkPIiowBjJUE5xvxMQeyntXE0hRuOZu9MK9y48PN8LS9LgD+zwQn3ME
         nvxb0VVMihs3FGrUOROtEqbHZPFIdNzNURS+w8tiqGgnWMj+QcMQ04PP+WKffvSGT0Qm
         7fEcXyWrejt+lIMwUXm+oWHi8yVssTgT6P66/OLAWgZYWM4ZWoMs6ro6a5lwMl8DzO+y
         QHbRzoQEs07K3usJwZZcm5/OEqs9gJ1HkyBNl6EmkYelfVWEi+ROV7AXohJ1rbIP3ri3
         bD34/Hpd3sdodiH1fNR53KtVe8l9KxU3Zvh0KPR7w3Tvnq7mezXwOCYJC0b50OxCjo1J
         wdKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAwdUMQfZvlxAsWG3GypeUN3iAVwg5T3qKSOFjn6yU6h70XjtSQulgP++Btd4R3FvS/fh3UZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVypLf/D57iNSYzSne11AJbGAbFbCrXGre7WGTI/8CA7LISjmH
	cbipoYXqWJRE5bTr1m+mkImBUCgmfmu44qZlthhxn2S1l4qOsqonDZav
X-Gm-Gg: AZuq6aLARkrtYm+gUA63OO7C0Ed0n9fBIyl64Ayyv+aJQ+z7Z+Rg6LV0MBX62xMbnz4
	xR5yQMhSihQ6tvHIQMt4WrW3prHigw8ZwWwQNYAudzRbdb6udz88iPzvDgF1Zmhl2LRvB2dWWpz
	8Tk7M+qBUrjnheoUZOAPo5/84kEm3wyEkMFcPYyLKF8LxIekA/hjMFQWOd7dvLegnPw3JsppH3f
	8EZK97GQp9iDVauZhLWBlq8VPS9vjkld0o/Wk1Nml07FybnA62mOrBxK+LA3KhVrWRmAM47t26S
	vECfptd7r0UUfSG5d0oIMZ9M2DCI8QJY97eEhOoHt8e/2Mm0nXRP1I+ZQ1XnEVLnLeNJDzzdJQJ
	Dy+Ha7T8j+lbYXFc3JiqdsTr+sv1tAuQs4UAUelbDBKqTEO7UP6KwRyNshgtQEe8O+qnNypjQ/5
	pdo6juARMcAUP+6/lIDXYxmaWnwq4JawwY
X-Received: by 2002:a17:902:e949:b0:2aa:d287:6949 with SMTP id d9443c01a7336-2ad1740bcb5mr116348825ad.5.1771330609634;
        Tue, 17 Feb 2026 04:16:49 -0800 (PST)
Received: from localhost.localdomain ([112.145.86.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d595fsm94123945ad.43.2026.02.17.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:16:49 -0800 (PST)
From: Inseo An <y0un9sa@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	stable@vger.kernel.org,
	Inseo An <y0un9sa@gmail.com>
Subject: [PATCH] netfilter: nf_tables: fix use-after-free in nf_tables_addchain()
Date: Tue, 17 Feb 2026 21:14:40 +0900
Message-Id: <20260217121440.3210432-1-y0un9sa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216790-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[y0un9sa@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E749E14BD79
X-Rspamd-Action: no action

nf_tables_addchain() publishes the chain to table->chains via
list_add_tail_rcu() (in nft_chain_add()) before registering hooks.
If nf_tables_register_hook() then fails, the error path calls
nft_chain_del() (list_del_rcu()) followed by nf_tables_chain_destroy()
with no RCU grace period in between.

This creates two use-after-free conditions:

 1) Control-plane: nf_tables_dump_chains() traverses table->chains
    under rcu_read_lock(). A concurrent dump can still be walking
    the chain when the error path frees it.

 2) Packet path: for NFPROTO_INET, nf_register_net_hook() briefly
    installs the IPv4 hook before IPv6 registration fails.  Packets
    entering nft_do_chain() via the transient IPv4 hook can still be
    dereferencing chain->blob_gen_X when the error path frees the
    chain.

Add synchronize_rcu() between nft_chain_del() and the chain destroy
so that all RCU readers -- both dump threads and in-flight packet
evaluation -- have finished before the chain is freed.

Fixes: 91c7b38dc9f0 ("netfilter: nf_tables: use new transaction infrastructure to handle chain")
Cc: stable@vger.kernel.org
Signed-off-by: Inseo An <y0un9sa@gmail.com>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b278f493cc93c..1aa8ee4a79831 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2510,6 +2510,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,

 err_register_hook:
 	nft_chain_del(chain);
+	synchronize_rcu();
 err_chain_add:
 	nft_trans_destroy(trans);
 err_trans:
--
2.34.1

