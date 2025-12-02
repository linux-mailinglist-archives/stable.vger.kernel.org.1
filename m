Return-Path: <stable+bounces-198055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE3C9AA99
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 09:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E95803459BC
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888F305969;
	Tue,  2 Dec 2025 08:24:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362E21FF35
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663859; cv=none; b=dGarXdnboqMHT9JE6LChT5MZbVWBEaG5JQF6XhS/Tv+nWq0lHQZvsBidbA8aZj8s8nvjFngruJoVQBXatTVGuB0HJ8lk9iqZLtv6MrkRfhfJjQki7qAQeOMNEW453tMLMhrelg18CTuaWWYYqIQEryx4uHqVjgjVc39ADeiADk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663859; c=relaxed/simple;
	bh=EzFpgYjmQuINI2GGfdl2ZN/qNlPlVdZOzb2bzMy21b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMI/HgMhy2EddDsQTS4m+faTQrjqccfU0Zp73UlX7o/OgHdnvTNRcRtYH7KAsxngtIiYyhvApwjKqQn10nijhM9V7ufQ+ojqLu48aAOvMVgbQYq21m+uzMxbGaj+CUICZaJC6I8ntzY3PCe7379SwIllkZrqkoTaH6sEr8zLwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 46ca03b8cf5811f0a38c85956e01ac42-20251202
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5b0a11d2-6636-4121-957c-d19857d13a91,IP:10,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-INFO: VERSION:1.3.6,REQID:5b0a11d2-6636-4121-957c-d19857d13a91,IP:10,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:30
X-CID-META: VersionHash:a9d874c,CLOUDID:ec9fa82b32e5a8364594f7b54fc66544,BulkI
	D:251202162224G2J2RGFC,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 46ca03b8cf5811f0a38c85956e01ac42-20251202
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1168385708; Tue, 02 Dec 2025 16:24:10 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: fix memory leak of repeat mode damon_call_control objects
Date: Tue,  2 Dec 2025 16:23:40 +0800
Message-ID: <20251202082340.34178-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A memory leak exists in the handling of repeat mode damon_call_control
objects by kdamond_call().  While damon_call() correctly allows multiple
repeat mode objects (with ->repeat set to true) to be added to the
per-context list, kdamond_call() incorrectly processes them.

The function moves all repeat mode objects from the context's list to a
temporary list (repeat_controls).  However, it only moves the first
object back to the context's list for future calls, leaving the
remaining objects on the temporary list where they are abandoned and
leaked.

This patch fixes the leak by ensuring all repeat mode objects are
properly re-added to the context's list.

Fixes: 43df7676e550 ("mm/damon/core: introduce repeat mode damon_call()")
Signed-off-by: Enze Li <lienze@kylinos.cn>
Cc: <stable@vger.kernel.org> # 6.17.x
---
 mm/damon/core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 109b050c795a..66b5bae44f22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2526,13 +2526,19 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			list_add(&control->list, &repeat_controls);
 		}
 	}
-	control = list_first_entry_or_null(&repeat_controls,
-			struct damon_call_control, list);
-	if (!control || cancel)
-		return;
-	mutex_lock(&ctx->call_controls_lock);
-	list_add_tail(&control->list, &ctx->call_controls);
-	mutex_unlock(&ctx->call_controls_lock);
+	while (true) {
+		control = list_first_entry_or_null(&repeat_controls,
+				struct damon_call_control, list);
+		if (!control)
+			break;
+		/* Unlink from the repeate_controls list. */
+		list_del(&control->list);
+		if (cancel)
+			continue;
+		mutex_lock(&ctx->call_controls_lock);
+		list_add(&control->list, &ctx->call_controls);
+		mutex_unlock(&ctx->call_controls_lock);
+	}
 }
 
 /* Returns negative error code if it's not activated but should return */

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.52.0


