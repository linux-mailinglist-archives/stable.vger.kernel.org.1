Return-Path: <stable+bounces-223066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMvnDhY2qGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:39:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE220089B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260F9302FE8A
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99D390208;
	Wed,  4 Mar 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVCJ0+qX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C73976B4
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631558; cv=none; b=q5LV0VED2p9AeMc2xcS3LhRIGmoSN50/jPUjcYY5qFkbEaFQrq7jTgRC8/IGHrpfIz+qNxTU5tRqeQONNquPmRLF2kd++KpjIL9t3LDFmVwQS7Q3Vt8V3U0BzDwZp+1eYAP9uXKxiaDrpMv7Xr4dy08djHdWh6ZRG6PZ1AedB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631558; c=relaxed/simple;
	bh=01P29BtZmzNpQ2Nkv11D8b8c/nkBZN5xBfxPwD4BjUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtCXV8ChhBS9NCucPLN2wT5NocTTkjlj8eN17X9c1af5MqosC6iyLXgoeDqNLuVFGEsVo0rHI/8rHq6ceFriy5fHE2PZEplqDq9EnYuhuxrJvzBxkvmsWXYPRgBYkAmbH2PvNGplYmuXt3WBaaxDU0MZw4xV26NBqS87rXiK8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVCJ0+qX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso72085075e9.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 05:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772631555; x=1773236355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8/l0DqRmwmsXc8k8WS7B5LdZ6TVBg1kuXNAWb3/QlY=;
        b=XVCJ0+qXQu4SXBFxCWyI6KlswdMMG4n9xCXBs0Aab4mdxt6+skOHZd1nUz7rqC/qK7
         Gg2GnvpxAQ6PIUsVrPjd235xIeMNV8283Bn3VPfTMGaF6vouxwtv6tyhs1GuowcOdbZ7
         6VnjzRNNVR0jiLKtYtxLRZOLGzaQSPK6TFif2rp2bwnvTG0Isl/19yn4siEnaX0T9Wjr
         EG7BFrj+CO4L3CuQweQcOy8ZYlfIPnAj1JnheMWaXt7OCf7BY6M1r+NO/RCOkLVJfHR5
         VL+gID7dzD7Suz4x9DnqnO6T4pwJkbVEJAJb/q4cEQ/Q/Rm9xj6Pg3nlUZEN4oVjOSMR
         ZJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772631555; x=1773236355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8/l0DqRmwmsXc8k8WS7B5LdZ6TVBg1kuXNAWb3/QlY=;
        b=BjTK7zM+XBz8RBol+3cYnQBoQztNR/BMuY0gyW9k9t+eSFFjXI5l1KaR30DSGQq2PI
         zHtUaGnhNXuDPmMGiBTLE6T01EeHeTIEgxUaSfXlIAX8QZ1XCHBLB5c1ySYNXY/DWVs5
         cZYJxEhoZ8NqWc5Uf1IWNjI8y/+IFvY6+b/S22wQUZZ5LFdMNJJpgXyW2xb6xzGSSCpm
         orrKFe/hRoOFH0V/B3KIgZS8z+qlYqEitnd9DRAq3AcbHkwtTrLIQG+zqjBPFSjvMPfr
         FtOpoyL69YXQg832AA0KN0xaXLKWhxZ9aGucggDxa68MPUEMt2r0FU7rKeUGo/pDfyy+
         HwYQ==
X-Gm-Message-State: AOJu0YyRIuZBo5XnEiB9GcmMc2Z3jNtwMLpQezeNF5bbOUjXEmaLxZkZ
	Iyur/h+e4xK7UnJgxh18pBZxeqhZ5f1x2bPdFY4YmsgZCjUMQFeX2IncO/XqMF0v
X-Gm-Gg: ATEYQzwvHH1c7oJemiw6LGwnWpDwkBEV/rQmYq5H0jFmN0vEqhJNBBqGDYwfcb5uV3D
	rQgrDlKjdugMZbAd2Ty/gVHBoVBAz1g15Rg+06ZdQiDw2Rgps5WHWKyFr1vSzAloLWRUlcoPw6q
	cPiI0IeKGAtHnBbZp6HoyKbXbi88KUegSYL4CzGRjbWi6lVMuBrq0MyASDixc5uHQNq4GtXT1uZ
	enyovcAISmfW8ck/t3SVM64fUSAQhfhiGT/msOwnk4t8wwT/vaBD2gqQQ/eZSgvB1usNljxMD5V
	VlAgpiyuqGblRfZpdiXBK/hpY9K/GVhGDyw20JwdTlTq0+uZGdsIBAkg6DrdVI3jkHApzRxvCJz
	TphorOyG1WxmukiLz6ZwkM7MRngN04QUP1RP46xO9VnW25lZsh+Xtq1DU0YmdCivj5A4+k7itFi
	zn8ZvpuDE13kMdjXjrLUQfnZPmrA3xPh/FS/I2yi5hBu1gOXZiQoveAOOyyPrT5XohWCzFnm41u
	ey5vIufNnwYUIgNOHZqwtaaFkz2xSBKWXO/7KgUTpk0f/sM318=
X-Received: by 2002:a05:600c:6386:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4851984ba56mr28481765e9.3.1772631554619;
        Wed, 04 Mar 2026 05:39:14 -0800 (PST)
Received: from DESKTOP-8H31LON.localdomain (bba-86-97-188-15.alshamil.net.ae. [86.97.188.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851880724esm101091675e9.9.2026.03.04.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:39:14 -0800 (PST)
From: Natarajan KV <natarajankv91@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de
Subject: [PATCH] netfilter: nft_set_pipapo: clear dirty flag on abort/commit clone failure
Date: Wed,  4 Mar 2026 17:38:59 +0400
Message-Id: <20260304133859.28372-1-natarajankv91@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2EE220089B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223066-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

nft_pipapo_abort() and nft_pipapo_commit() call pipapo_clone() which
can fail under memory pressure. When this happens, the functions return
early without clearing priv->dirty. Since the set_ops->abort callback
returns void, the nf_tables framework cannot detect this failure.

The stale clone, which still contains modifications from the failed
transaction, persists with dirty == true. On a subsequent commit,
nft_pipapo_commit() sees dirty == true and promotes the stale clone
to the active match via rcu_assign_pointer(), causing the lookup data
to reflect operations that should have been rolled back.

This can lead to incorrect packet matching (firewall rule bypass),
memory leaks from unreachable elements, and potential use-after-free
if elements freed by the framework are still referenced through
stale clone mapping tables.

In mainline, this was resolved by commit 212ed75dc5fb ("netfilter:
nf_tables: integrate pipapo into commit protocol") which refactored
pipapo to use dedicated set commit/abort ops, eliminating
pipapo_clone() from the abort path entirely. That refactor touches
3 files and modifies the nf_tables framework, making it too invasive
to backport to stable branches.

Fix this minimally by clearing priv->dirty when pipapo_clone() fails
in both nft_pipapo_commit() and nft_pipapo_abort(), preventing stale
clone promotion on subsequent commits.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Cc: stable@vger.kernel.org
Signed-off-by: Natarajan KV <natarajankv91@gmail.com>
---
 net/netfilter/nft_set_pipapo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4274831b6e67..34a108399fd3 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1708,8 +1708,10 @@ static void nft_pipapo_commit(struct nft_set *set)
 		return;
 
 	new_clone = pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
+	if (IS_ERR(new_clone)) {
+		priv->dirty = false;
 		return;
+	}
 
 	priv->dirty = false;
 
@@ -1743,8 +1745,10 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
-	if (IS_ERR(new_clone))
+	if (IS_ERR(new_clone)) {
+		priv->dirty = false;
 		return;
+	}
 
 	priv->dirty = false;
 
-- 
2.34.1


