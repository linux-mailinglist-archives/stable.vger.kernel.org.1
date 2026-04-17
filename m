Return-Path: <stable+bounces-238417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Af1EWLP4Wm0yQAAu9opvQ
	(envelope-from <stable+bounces-238417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:12:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA44174CE
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A705130719C6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BD363C46;
	Fri, 17 Apr 2026 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZTNTFWV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA2351C28
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406335; cv=none; b=Hqd2YEFp110S3T+xX/WPgBaNvR04bX7RKHMK8XUcdbbw5UBiMYre8ZMZRnpCB571uvSsTyBPChkqoAZlEN1MXYA204LW1wd2Ts8zaAc4wAbXTSz997Yovqa8ZFjjGbhu45p98oC+DSQHw7tOxCkxrALhbPZftnO83G5bbRiOLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406335; c=relaxed/simple;
	bh=hAE7G4N9Ya6db2lFHzOOzat8Ysmrwdz8cUZo69vB634=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhnUMMqcLYx8Je73xdHMN8wSkjJx3zlNFG4m0WNn9yEXfH/HS/es9vmiaawH2Gl5tBRUynMgrM8WkYpn6InIdb9EgtpYp8H0XE3UleBCJ2LQoGse7uYTYnP8vG6EHVYok+20ud/OJSqrJLYIJnXODYleXYSMZYV9FTQyl5lW0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZTNTFWV; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-60fa13bde2dso233699137.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406333; x=1777011133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es+n8UsduHXyp24gV37gSZyOHkapEOeq0C7l32e5LWs=;
        b=kZTNTFWVztvzet7cddAq6qOiKKMUuTdsqhxHZuRT1iB0a6t4ZSUDN+s+5A8rXJB9oM
         efMYmj8kEGAEH1wMlXmSK2KYiCtkIxdfKiGKljCeYd50b8Y3NJl/ltlrTD2mlW956IB4
         1qDGbM4S1JmLP29dz6dDmRDKTPrUHsGbRACFeKtsNMDP/gwsN2Cvvvev4n0V5tjjAnHd
         DbpZA1MVLIvxb7ZYX1yp61CH9EyDolUZRHkQGbLGG/oQ7ET0ysYMIHA1lkZsGUwJra0p
         y0bViC1jS1NBk0+rR59bef7I654tknYS51i0xji5C2hEwOto9qGRLop7hm3rv7Sk0qx+
         PzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406333; x=1777011133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=es+n8UsduHXyp24gV37gSZyOHkapEOeq0C7l32e5LWs=;
        b=S1Z79XiBOylrBPd5LmC5rRmVHPBPVGfI0X2PCWI2OTHJ7w2D+dPipvEYdmKMViXXSY
         BxIPUTyzTv4u18+c89MjyaPDQbc76QEkXMw5cfG7RsvWGou5sFO7nNwSV9IkVVtR6u1M
         qqd5ObJgrJc3eD8CT+/u5tbkiwJZCYorHyvEKhRvymbAnrIKhaKKAunf/WOlXLkPtUKs
         S1P9LQKmONOTxixsEH0vW+9b9eJ23IdhVHxk3eFFfc62tLlh/hPkoeDE4BH5vCA/OZue
         OD9yOuoz+BNgn5ma+0N8VMF4MjB/HRs6UYFSlgYFAiMyP/klqiyaMlGcQziZ74wkyX9k
         j6yg==
X-Forwarded-Encrypted: i=1; AFNElJ8umTA4QUPaadPGr/wourdrD+1OZlaXdTPOwYSNpd4beQ05jwgwFfe0jwe7nApO88AcdUs3eVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zdA/EAI0mWCAhptleZSzJuKA3i9Higcevxvhcm9TLMXuGK8m
	95mn5+hamHTDePqn+Ubig0/HB5+72MPBqGpAk496VgJVtLyx0tP8Yn3S
X-Gm-Gg: AeBDiesKK+b66bJuE4BQ04B5shiCIUFAZ+qnoocE3xmKIid2DzkHI9eQC4yW+2mzUBq
	slPGEmFlaJ6106lifWTznD6wpFLM9AkAOYO5uo1rPW+mnT/geeCci+hEtUj2HFV5crEDjGaoDf0
	AGNBgGwmdDEDvJWUEjyk309+5R2B8ucL0T8pxnhDnRMiS5AgDh8q4zPt9Q/29eNi1cekYLzPVf5
	L2w0881eE4+G6bX6hlyYRjDw1Z/fiFCDUq7oEyD8LgvdoBhfivBglagZO2odYhew+PVyeolgBy3
	CLenVwS1/pAFVQa2XHZgekVydk4gCQowFiBYi3wribGGxRfGrJVcE4+fv5UW5t83hi0/6wQ+yTl
	vExnQWXJjkqEsRwZmB5ZqBVfmg4tgnIY6/E81n1Vb2k9P5ZX7yvGamtuzqyZaHFjOXkRqJDpBGr
	lN6qgTdzB50RJfpbmTwvbAFyqpl2vkdTq9BleVJ3Xsy7ayG2/lJvH7
X-Received: by 2002:a05:6102:6cd:b0:607:5cd7:cbbe with SMTP id ada2fe7eead31-616f58a6866mr649466137.13.1776406333287;
        Thu, 16 Apr 2026 23:12:13 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:12 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 1/5] staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
Date: Fri, 17 Apr 2026 07:10:44 +0100
Message-ID: <20260417061048.62484-2-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238417-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1AA44174CE
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
v6: restore the '/* memcpy */' comment that v5 had removed
    as drive-by cleanup (Dan Carpenter).
v5: collapse the identical cleanup sites into a single
    out_err label (Dan Carpenter).
v4: check return values of recvframe_pull() and
    recvframe_pull_tail(); drop unnecessary (uint) cast;
    add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and
    did not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 36 ++++++++++++-----------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d508dfc..8d5d9a6dc4db0 100644
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
 
@@ -1127,10 +1118,16 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 
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
 
 		/* memcpy */
 		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
@@ -1146,6 +1143,11 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
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


