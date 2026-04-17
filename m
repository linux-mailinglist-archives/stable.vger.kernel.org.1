Return-Path: <stable+bounces-238395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBORBuui4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8E4166BA
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFCC23012852
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019792DFA2F;
	Fri, 17 Apr 2026 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llnGPklT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A93502A4
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394972; cv=none; b=jV/ru1Eeg4sDZphw4ynbT/t83XQHVUSu2u0XQaFWYnZvZCCK+QidUeOZhF0Ab0x36EqeZaI/MFx3uIy1bCJIqC4/3wtDk8Z5v4vlJI44EZaBHUcZHgINYEP6Bh+u3wA2Vwxf/yustHYyk+ve34717wIz/RKId7yZegc2nWnhLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394972; c=relaxed/simple;
	bh=1RX4ZJXRy1W+znU6njTURTqBy+hEg0UjYtH5Zu8szko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYsVO4q+L4EtzaF9DkyFi5jUoZhcyUiV1DeRrgySCbNxAGtPwmy3W3OizceUmbE5huwk+aMFmjGVbTo6r6yyLSrLa+hG9oBZaAPmadPQt5bHk1/C0kPTG3F9eOBeFzZzaK8ChcHmQMSsmAJjkqqbgY2MVsrA/YxrLApmS1G6j5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llnGPklT; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d89f35940so69498e0c.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394969; x=1776999769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n8KTIeckYp5KCeaWdljqxwsv5Ka32yuZHpdOtik6UI=;
        b=llnGPklT3CAzVUl8rtmYVJvrQFHMSrvU5yFCi3QO/BesIsDkXIibl23CsUEz+gv1pJ
         /XYhSHqw7RcQN3my32wl6BDvi2ErcnAHFLFHNIFZNP5IUMaaOVaCzk+HPUkyk0osIAJk
         X1/bRarc+sSaBSSJ++ySV2qftlQPa0xS9wWDpMrWzGt+7zYGioF2R6xN5GQzdj16iqjg
         +j+YEQT/BkqyxxDMuBmHeEeRc0lxm6cJRW5PG7aqQ+JNZSdhfaDGmf6DVpPeo8/oC8+w
         6JhlPCgI5XS72oQTJXA/D4WDFB77+CJcxbgTld5R6hxFckFjA2Au0tOMrylnJs6CZSfm
         CzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394969; x=1776999769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7n8KTIeckYp5KCeaWdljqxwsv5Ka32yuZHpdOtik6UI=;
        b=DtDQi1Ou8v5MEw1eEcM3N3/2m6IwlEonZMyQwjSzbBoxH58c3mb7tyhQ29ZRgyWUqY
         7OWAPe3cCcPmOPqnuZEpCf7rqjv5uETo5YwZ6WXiUGCY4z4elYFW91tECyvzPRIOeCPS
         j0HDY2LnhNgT3BM9w1adRDs4jOQOzoKmc8oM0oMN1YkJfJo/Rk3csZ1glxS531wdxjDJ
         vTjSxdil+NUx8Vg1U7BRBlnkU2+w4f9OLEa5r7jebHVv/36EWS0pSYeR5MGXNVkTH4eD
         vphBAKwbJtYLnABSyHLf0QQOEC7t30Cjowx22mJIgjNwaV9NXOo0tIWjhboJ11XGKQVk
         TOPA==
X-Forwarded-Encrypted: i=1; AFNElJ/rv0+19V/21nIejYsjPfTvvA8puri+f4RkKkW3Du2FmpXTHDnO0IVCkUorUzfUGDcMigji1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WqyTjttaG3BdeI+zfpWpplU2ICwccUeDTpgZ5FZWkBlsuWKb
	7Ovf2A2yHvQEm2fSwozEqu1RpqnNqUd7CU92QIflbAF5RW1jS7x3Ud/b
X-Gm-Gg: AeBDiev4H80B5XKKlUhWk+gDz7AWIYD3NKKKViottPpdaCpPFzX2Vj+Gpys0RvCDiWh
	XL6D08WkfKQnbUfhtRyOdtIR9w5IHuMhtYJxjyGIWWGKIvJ9qfneIxeaIsDpucf/xfIIqChCNbu
	Ecvb7uG2q+apLVAYvKTMIdztGbX68LnauWbVybjtEB6Veywvh4kGZ0qKPbgi8uHWxJIy+V4SkZC
	9Gf/u/+9CF7M8eKqIqfvoencvQal4u4BGOF/uSZhwa5INa/pkbOQ6uHTNHrISQh0QTRnyH6XPAs
	63g8eIR7/FTr9KFAiPYYNXhF+rqNwGJvInuy/ckQn4x9oOZqLjMJomtUROFEy/YvEjlL3iNIHdF
	or6fcKSbgvpwxkXj9JPalc5OTtvsUnlIQElbg0sL6cSgDdx45FQ4GBhwjvVMGJWhN9/EyyV42Kj
	3RcPqu4K2yrGS51hMEygCMe84FDJkj3gt3UHIcmerGsHE5sP9QcsS2
X-Received: by 2002:a05:6122:d25:b0:56f:6d27:cadc with SMTP id 71dfb90a1353d-56fa589b2f6mr601517e0c.7.1776394969182;
        Thu, 16 Apr 2026 20:02:49 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:02:48 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 1/5] staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
Date: Fri, 17 Apr 2026 04:01:06 +0100
Message-ID: <20260417030110.42991-2-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417030110.42991-1-delenetchior1@gmail.com>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238395-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEF8E4166BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_defrag(), a memcpy() copies fragment data into the
reassembly buffer before validating that the buffer has sufficient
space. If the total reassembled payload exceeds the receive buffer
capacity, this results in a heap buffer overflow.

Additionally, the return values of recvframe_pull() and
recvframe_pull_tail() were ignored. On failure those helpers revert
their pointer updates and return NULL; continuing past such a
failure would leave pfhdr->rx_tail at its pre-strip value, so the
subsequent bounds check against rx_end - rx_tail would operate on
stale pointers.

An attacker within WiFi radio range can exploit this by sending
crafted 802.11 fragmented frames. No authentication is required.

Check the return values of recvframe_pull() and recvframe_pull_tail(),
then verify that the fragment payload fits within the remaining
buffer space before the memcpy(). Consolidate the five cleanup
paths through a single out_err label.

Found by reviewing memory operations in the driver and tracing
buffer pointer manipulation through rtw_recv.h inline helpers.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v5: collapse the five identical cleanup sites into a single
    out_err label (Dan Carpenter).
v4: check return values of recvframe_pull() and
    recvframe_pull_tail(); drop unnecessary (uint) cast; add
    Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did
    not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 37 ++++++++++++-----------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d508dfc..52d029c28ab1f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1090,14 +1090,9 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 	pfhdr = &prframe->u.hdr;
 	list_del_init(&(prframe->u.list));
 
-	if (curfragnum != pfhdr->attrib.frag_num) {
-		/* the first fragment number must be 0 */
-		/* free the whole queue */
-		rtw_free_recvframe(prframe, pfree_recv_queue);
-		rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
-
-		return NULL;
-	}
+	/* the first fragment number must be 0 */
+	if (curfragnum != pfhdr->attrib.frag_num)
+		goto out_err;
 
 	curfragnum++;
 
@@ -1112,13 +1107,9 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 
 		/* check the fragment sequence  (2nd ~n fragment frame) */
 
-		if (curfragnum != pnfhdr->attrib.frag_num) {
-			/* the fragment number must be increasing  (after decache) */
-			/* release the defrag_q & prframe */
-			rtw_free_recvframe(prframe, pfree_recv_queue);
-			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
-			return NULL;
-		}
+		/* the fragment number must be increasing  (after decache) */
+		if (curfragnum != pnfhdr->attrib.frag_num)
+			goto out_err;
 
 		curfragnum++;
 
@@ -1127,12 +1118,17 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 
 		wlanhdr_offset = pnfhdr->attrib.hdrlen + pnfhdr->attrib.iv_len;
 
-		recvframe_pull(pnextrframe, wlanhdr_offset);
+		if (!recvframe_pull(pnextrframe, wlanhdr_offset))
+			goto out_err;
 
 		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
-		recvframe_pull_tail(prframe, pfhdr->attrib.icv_len);
+		if (!recvframe_pull_tail(prframe, pfhdr->attrib.icv_len))
+			goto out_err;
+
+		/* Verify the receiving buffer has enough space for the fragment */
+		if (pnfhdr->len > pfhdr->rx_end - pfhdr->rx_tail)
+			goto out_err;
 
-		/* memcpy */
 		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
 
 		recvframe_put(prframe, pnfhdr->len);
@@ -1146,6 +1142,11 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
 
 	return prframe;
+
+out_err:
+	rtw_free_recvframe(prframe, pfree_recv_queue);
+	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
+	return NULL;
 }
 
 /* check if need to defrag, if needed queue the frame to defrag_q */
-- 
2.43.0


