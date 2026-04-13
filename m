Return-Path: <stable+bounces-237643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLKmMMpE3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:32:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37B3F2C4C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BF230821CC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FA3AE1A5;
	Mon, 13 Apr 2026 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+SmKk4U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC038F920
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108411; cv=none; b=KGCiKFSWVlUEDH706Lxq19Nt4YiC0w5TxvWMSYtjj38jcZnIpZWkc3CxigOjgnBGdPfEvFQQl+Rr+4doEL86EN468mTQNZ2nloeL+gLvrM4qITfhIzED454k6rOo8+wGdQ8vxd7iP+3etBU3E3zdpO89y6XgrdVtYLMhNqHEWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108411; c=relaxed/simple;
	bh=RSH1PMIUdr+dvUF9RK/lpWJRWvghUBzmx0I+NUVcmEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwahe52dLlpxemP6tHAc7CKu03JggWRM6AWKdbEpIzOEH92J8PHSR3zmhw2b/D28eCu3ArvJejlyCwPY0QuYfPEXaK/3ihT0MQdhVJXMjo2ERBgA/ZBEX4CwhckFAX2bffAQeOUJYgCS37T/SxnImRJI4PQixzN+das0/KfmLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+SmKk4U; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7d983f79so12072851fa.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776108408; x=1776713208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyAV4CsxeBNj9l27xq0ng1Ca7pq+jXSdxBThfycX8Bg=;
        b=M+SmKk4UDy4D9uoL2Id8cKEPyUrdn7drTihoq+/6uDtjIAQ3E4tzyonbnF8DYr/UGa
         XgQmeeJKH/LxvFd4AP7xvj5De9oZUaTLjrXlFtekmu3cHIGo8H9KfuaU6N3s4ZzuQG/G
         EKhXOcdA9LWqZWqXh8iM/0ZubFkyY8b6N6UzFUJmujd+jo8VwYy+HaeFileBnSGs3ewK
         /dO8LdXdYdGAhW3jOKMVs6xImQW/6hWtWZK35uONjcz/hA1LsRf7BmbpLNBDqxNUObS2
         rOxEJSxpOI2bghbs9rtQiT4XvysBrRD/7n4GGUYP+isJ9TV31m9dTMHTSG+OCdsd7m9s
         v1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776108408; x=1776713208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyAV4CsxeBNj9l27xq0ng1Ca7pq+jXSdxBThfycX8Bg=;
        b=VXEmHQr4y/FohSzycYMaWd32GGHDFeNMZtG6JuxGux7TDUs4QTL5tO/gh+TphOAiMq
         Lowa5sbAKU5GABl6xY1/Vgv6K58FHkdGChF5tdtjdgGD+xxMTYZEh2qJAuC312yX6J7s
         XwSREgUGJcfJs90mPk8F3xJpP5fLeJlmDgHIjiWrl0oARx6kyMhvCRijoQzucOXEf2Dd
         th7XfEgvKDvp7T3SoIpqdG5iWaYNF06oIRuadvgIAJXwHY37+0lzNf/7+TCtCVIwZnar
         QrPE3gSkNInmWmAFD/70/qh3oGZHBt3c8tLm8bSyY/n193AXzIh8SIpdgPSr84Ce4jxw
         NMEg==
X-Forwarded-Encrypted: i=1; AFNElJ849rLolfscQ0Ec7L2eKVgpyrsrkGLQWeDeMoGLYFIn2VLJ+re6ByZkvG7wZITuhEFfd8nqkUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2aNce29Ksu9IBRSOHNLF1d2Ak/vIiBdHs6kKrIbZQ8ppMdcVP
	cyF0Pssy42TCH4H5WH3hmvCzk/ZEUNlowCpqygQDcT8oXLy/kQ7DahwB
X-Gm-Gg: AeBDieuAulrQygcMholGS2WPBSnGJXPArNOOXzIxHVMYV4lEXc5rD3j8hgwdArVL6mu
	0qchvkNlRCyxGUmbqcW9a4zdS9vKNI34IPmztbmr9lxgMf/YLmiBYbD0v2yJ+Erclv9efk/OREV
	o9cd/W6HRkYP/TczEDA2Rv8d7Jy4PdSBDk/h56GXaJz8shqk7oa/S1QfyT+ft05UroLSrXl9P1K
	ObeLIp+Cpi1pqutF/I3Xkc11Le/LBNfuIyu4WVkQNNoOZu3Xju2TkSCrznigJSF1z0yDDweMsKh
	2G/hRUNtM3Y1OT6Hn3wNhn+tnde6/YNUJ5GNvF3kErt5cEXLVx8bZS3bWTNTl72RWPxb7Uk5Ofq
	CN1CPfHWd9xGy5p83wu4nMqcbnZRBABcuNjvUbEiQRkE4lZYknGUQDwk9AW66GeNitMfDz0jlUo
	AJrBVMdpceQbH2MzE=
X-Received: by 2002:a05:651c:144a:b0:38e:827b:98f5 with SMTP id 38308e7fff4ca-38e827b99f4mr12058721fa.35.1776108407898;
        Mon, 13 Apr 2026 12:26:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495461b7sm26191241fa.26.2026.04.13.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:26:47 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	stable@vger.kernel.org,
	chenyichong <chenyichong@uniontech.com>
Subject: [PATCH] mm/vmalloc: Take vmap_purge_lock in shrinker
Date: Mon, 13 Apr 2026 21:26:46 +0200
Message-ID: <20260413192646.14683-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,uniontech.com];
	TAGGED_FROM(0.00)[bounces-237643-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F37B3F2C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

decay_va_pool_node() can be invoked concurrently from two paths:
__purge_vmap_area_lazy() when pools are being purged, and the
shrinker via vmap_node_shrink_scan().

However, decay_va_pool_node() is not safe to run concurrently,
and the shrinker path currently lacks serialization, leading
to races and possible leaks.

Protect decay_va_pool_node() by taking vmap_purge_lock in the
shrinker path to ensure serialization with purge users.

Cc: stable@vger.kernel.org
Cc: chenyichong <chenyichong@uniontech.com>
Fixes: 7679ba6b36db ("mm: vmalloc: add a shrinker to drain vmap pools")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61caa55a4402..676851d5cfe7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5416,6 +5416,7 @@ vmap_node_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct vmap_node *vn;
 
+	guard(mutex)(&vmap_purge_lock);
 	for_each_vmap_node(vn)
 		decay_va_pool_node(vn, true);
 
-- 
2.47.3


