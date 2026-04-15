Return-Path: <stable+bounces-238192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHL0FwXg32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC14073CE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF5830F302F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B8332906;
	Wed, 15 Apr 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHazUc/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CD23370F
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279336; cv=none; b=MjrK8NFW5CMrGL1XbT38lCAA/RdnmrJqEEBuVO3I+OtqfnOw/3QGtMKYAfYHfpFGpyMMDNxVOQVlanEelVte8US+06cCMEqSlkbgi048hBLRD3kh4+kPwg2vNV2Q6GHzm2I4hA4DVQndpoEYG3rciaIyT3VMCWFrWZh0Ui+ZX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279336; c=relaxed/simple;
	bh=AMAk3cxwsNhyA2MXfiMcckkHbXFD6bfBWxE14QBYKWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbQL7IqiZyvZoe/BCIzqpfM6DSWvfVe3z6pA61C/ddjKpATDzJUCPDJzvItNWcYxDaWsFFbkREc1RN0TwY9HDR8Nl2Pl79xESuM8E29lj4Du27jmvAe0GWiI92rEmnZ/LeR7rrkAuBlnERcrmL408tYT/7bnVSwuz9dpYUkzpME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHazUc/e; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5674d8be45eso2234514e0c.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279334; x=1776884134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktjLVczqk0oTNjxVLTAvpBd6V50DhQU6m2AdSOXWKC8=;
        b=lHazUc/eNSMqv4YWeaQiU5VGsgntIEoP0gpWIEjh2u6bxn//dp1XpczN3E+r00l46c
         NOn8WNdIRSQa2ajMeJW+s0mgvAJiRnCpGA85p0skzznPUOC10au3aWQX2NdVMhMxQY8F
         0ENuin8VK5/5D2OFRVSqUi2uxnDbNgA9K2YQH9oLxNQImhgA8LF38uRbTZpJhGJeDUgw
         f8Kz1VtUJOj1zmO4MYRs4odpgSMiS3oXmXUdGq7MhI5ZuEeXpZzCFC484pCm/D+wvFsa
         5c1JGd1ekq63VB3igcxp/lJABcL+KtjamRaWG+KBUvwzQsqjrTAhPMWQcGsVmWI+qi29
         IaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279334; x=1776884134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktjLVczqk0oTNjxVLTAvpBd6V50DhQU6m2AdSOXWKC8=;
        b=mk5fMB397E8j8dpH30RQxg85IyumfV/t0rPsJ5FGnsj/oXcEqr9jGL21uXqR2aLCl/
         TJGETLD8h/tHCpFgh9I4LrPMISk7GfqiettvanAVMqZYAiZLC3JPUCLCx7C69S0Sq9Wr
         I+MTdkNuJvBMxs1omavPNGyH8xqMKVDR7BKBMECZCfXKZuvaGMNONJEirN5MBgacnS1X
         gi+ZVzJJT11ckzXOPLbwqG0bm1xBRESR9aEIMnQ/dGoJ77w7HH4F736l5xtZQdiiDjp0
         GRr7l6QR8XGWUYwcmcxRAMXhUP1aTIxRtkCOnrVdtfOAnj0NbfOp422Vyw9/RyaGdvc2
         AYTw==
X-Forwarded-Encrypted: i=1; AFNElJ/mrft6h0bu/xFJQEN85+4tCVptMhfK9gYULuO0k7TjICpuhokPHvgF8qsjhLe6IFGN9Mqyw3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCM05AvoTKhpa8Pcdn6wsLqKrS+oGC13aSxgdJI3QmoqkBMgo
	ZAskmfv50n+3BsweYmbRCk6BXCz6/B3AUaylUokF6FQyARkcKPo9FZqC
X-Gm-Gg: AeBDieuMkXWsKVEcZ7Bz16XxtDYjk4W8WA2iXmn9upHZz9BkySMib2GXXTJE5/Oukkh
	ufaE2gvJp/DM43Uw+lEwlXkPU82MR1gLdYIW16Chs9on3BZjXZ4/ZoaeRt755wJ6npJRWRu+q2i
	RWtOHB83G4huZ0XgxdFlpnW6F7RHd0Tf7Wn2LsP/Oz1az5RvtYbDa9lG9quPY7hsj7GhCErQRz7
	HV7qXFA+/bhaMPMhu1gT2JkcmfI98uPlcXJVeWT/pmYlCmU2oGP+SnlZUDzPXWMmB0+Td1SaGcb
	ddaT6u7M8ukZhG4joNaApWr5/FzdjRobSz+KoB20+TS6dTj9JDKsJ0OwXT564Lfp5UjgORxoWBA
	Vjk4RZOMW/zgWsNYqsxs3laBOaJO2T5xdZq6mMoiu5GEAUr+dI2voKFX4hbZDvpXKTZJF7JoB+h
	mbQKxm0FDfHPOxQUwyKeTOJdmQ5sPIWWXSQCE3+R6rEzNSJEiN7DpE9MXN/8cHN5U=
X-Received: by 2002:a05:6122:2887:b0:56b:5e7e:d3fa with SMTP id 71dfb90a1353d-56f3bbd2603mr10605366e0c.7.1776279333765;
        Wed, 15 Apr 2026 11:55:33 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:33 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 1/5] staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
Date: Wed, 15 Apr 2026 19:54:57 +0100
Message-ID: <20260415185501.440492-2-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415185501.440492-1-delenetchior1@gmail.com>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238192-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00FC14073CE
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
buffer space before the memcpy().

Found by reviewing memory operations in the driver and tracing
buffer pointer manipulation through rtw_recv.h inline helpers.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v4: check return values of recvframe_pull() and recvframe_pull_tail();
    drop unnecessary (uint) cast; add Fixes: tag and Cc: stable
    (Dan Carpenter). Luka Gejak's Reviewed-by dropped because the
    code changed.
v3: rebased on staging-next; sent as numbered series with proper
    Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
    apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d508dfc..a739c2bada2a1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1127,12 +1127,26 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 
 		wlanhdr_offset = pnfhdr->attrib.hdrlen + pnfhdr->attrib.iv_len;
 
-		recvframe_pull(pnextrframe, wlanhdr_offset);
+		if (!recvframe_pull(pnextrframe, wlanhdr_offset)) {
+			rtw_free_recvframe(prframe, pfree_recv_queue);
+			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
+			return NULL;
+		}
 
 		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
-		recvframe_pull_tail(prframe, pfhdr->attrib.icv_len);
+		if (!recvframe_pull_tail(prframe, pfhdr->attrib.icv_len)) {
+			rtw_free_recvframe(prframe, pfree_recv_queue);
+			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
+			return NULL;
+		}
+
+		/* Verify the receiving buffer has enough space for the fragment */
+		if (pnfhdr->len > pfhdr->rx_end - pfhdr->rx_tail) {
+			rtw_free_recvframe(prframe, pfree_recv_queue);
+			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
+			return NULL;
+		}
 
-		/* memcpy */
 		memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
 
 		recvframe_put(prframe, pnfhdr->len);
-- 
2.43.0


