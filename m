Return-Path: <stable+bounces-244224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO/SE4Qn+mmHKQMAu9opvQ
	(envelope-from <stable+bounces-244224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:23:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74E4D1FA4
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F343082D21
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA44A2E1E;
	Tue,  5 May 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czbact+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331249251A
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001748; cv=none; b=QMKTejD81F3hGG1/zuehDo0zFduIsQh/TVOj9+2+SLoFMjZ64Lf4+kkJvCqHwztZdIwxphl0b9VciQ//QSNwLa9UR7GSdd4r09hLD+SLEk+9o7uzMrEyuhvAhmRR3FO/8vBTomZAI/09ciAnkxAgvDhNKnjRxOnBwU03xI5ZjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001748; c=relaxed/simple;
	bh=JPZzn7zMNDqGfRZl0IeSI470609vvY5b/O/uV34wxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0WzNClIIHIexsVqTzxECtvAa+cO2ciukTm+naidz72DHkpJDZu8dRvCStKRd7uYS0dchzDKIUUHrcAzbMdBP4uY7AQ9fzu3rEvdUWQNeM18YHiq9cr+2nG5erXId7eA/fTvzRr8TrYNspS9Lnsf8myXohJteN9Y6w8NjBwLT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czbact+B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4437865f8f.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001746; x=1778606546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/oPGZFJKTQjbJdiq9IFnoXRIzpps50+CWvpXCFG74k=;
        b=Czbact+Bq5DlfVlr+ZKaON8nSS9EEEn5xe+qso68Gt8Rq83Mg7ixc7kYc1yNVW7hgG
         lQ5eKLOnjdXMxJffw8yFTLguPe9Q5ncZvG1S2QYiHyU++ahEITBEsnarR0mi5VZ2IvlG
         xee4F2UGOGmojrPCa5MjJjYXANSHfoVxQeCtEp8YHucUK9x9oC95MOQhGP4zENa49DQE
         s97tFpse3SuzUlIPT5luR+eR7ExD+da1g+a79Szo1wcy6q6jZYZmZQKOWKqlx3RPk8SB
         B4K03evpzVmx0+atVKsc80sBwlku9/EbB2AZthc+qIHCZroc+z79PZa2uWMeuvUUuFNy
         Mshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001746; x=1778606546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/oPGZFJKTQjbJdiq9IFnoXRIzpps50+CWvpXCFG74k=;
        b=kHYrhgPDp5uHrXgTU9aZba84u1bdnITG6yz7T/ovLy6PYI0TA8xHcnOCqpJ8FbjkiG
         Pt4OMNYmWWTIySCMBq7vUXocEHkRvnSBQ/P7nWweH0V8yI0uapcEJ4g+fc3v2iySrsmR
         jtdVRtWceicEyv6XOFdJRlO61HUvsDG9i5kphkl5A3HXuuIDeJGUWLfqx+Ekz6hRd9b+
         pLlpUj4oMTFJD0ZjK/KPe25SxWfd92gzNyEtVIclylCEcYO/ez5mAf6bqsvsP2j51wI0
         dipYFZyPww3qnhLzFaMtss4BT9yPiqYqdMNi8ci8J7snzZqMKtcQ6bxYge2PLcv9b+tn
         qnBw==
X-Forwarded-Encrypted: i=1; AFNElJ/BYYPi48j+sJj5Wd6FrfhRET9702/njfiRX5IPzusMh6k1fICZfX3Na+yNwKr1/C5WfeW1Nq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGok3aFoICYcQcQGK165S4JJNZEejDH3OEf7oi1IPMTq8rqTl3
	y//WpArbBT6VzAARk7vD3pogSndIZ6CKmDpxZT5j9XCkubyEHr713R5U
X-Gm-Gg: AeBDievwvcrtcBdOUDjdeNDef5SH3lSqF4PAEs2H2SJU7U8EQ6avFSs/DRMWuEEhLjR
	uQRLkgmYzlT9FsnU/oMeKd4Y0r6Ijpnp2I3yyWvccK8192kc9eUsHdp9wykuezWlxcOW9/Hhxgu
	0HMxzVQWSJ2TgIAovL1Ij93f23TbSkFVx0+0cM1FP6rIssq/euqrpUaQ3ZLa+a/XOewAQCXdjWZ
	J1cCzTWLCS5tTveu09InHQPPUtRCGw1Z86iu6eLKiTSwk3T6M1nSaQO3Hz6vjHKhc4ett2hjr04
	roiSWTmV6YL3ESSY8FPiRcThK9P1TAu/7kMSmdXaQv6uD4zDQ1jIDfV9M1rVF5A4NKJwpBJpcbq
	eiThIJAOrvKIv10NvdYJHY+xIas0fJNqeKV/x2wCiaFICX4fe/Z8QxeH7o/t7ZLhKs+182uuN83
	7k2nMUOEtBuTknHa3EndIAcgQeYm5BmaeblABS7BN3kPFKWg/T3Y7nawGej0WQ+0KDFU1+h7cqn
	UiFA8xpWk0pFEmjvf3aXuFKY3xhG9Mutl8HzqGefH6n1nz6n9WOUpYc//doaawibK1d2KN7JGW2
	MlntBw==
X-Received: by 2002:a05:6000:26c2:b0:449:c5e2:a8ad with SMTP id ffacd0b85a97d-4515b524480mr55229f8f.11.1778001745557;
        Tue, 05 May 2026 10:22:25 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm6640747f8f.28.2026.05.05.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:22:25 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] staging: rtl8723bs: fix OOB reads in OnAssocRsp() IE parsing
Date: Tue,  5 May 2026 19:22:14 +0200
Message-ID: <20260505172214.3650398-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172214.3650398-1-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
 <20260505172214.3650398-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B74E4D1FA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244224-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Three out-of-bounds read paths in OnAssocRsp():

1. Missing minimum frame length check before fixed field reads.

   Before entering the IE loop the function reads capability, status,
   and AID from fixed offsets relative to pframe + WLAN_HDR_A3_LEN
   (at offsets +0, +2, and +4 respectively, so 6 bytes total).  There
   is no check that pkt_len is large enough to cover these fields.  A
   malicious AP can send a truncated Association Response frame shorter
   than WLAN_HDR_A3_LEN + 6 bytes, causing out-of-bounds reads and
   loading garbage into MLME state variables.

2. IE header and payload may extend past the packet end.

   The IE loop advances by pIE->length + 2 per iteration but only
   guards on i < pkt_len.  When the last IE has only one byte left in
   the frame, the loop reads pIE->length from pframe[pkt_len], one
   byte past the receive buffer.  Even when the header bytes are in
   bounds, pIE->length can point the data window past pkt_len, silently
   passing a truncated IE to the handler functions.

3. WMM OUI comparison reads 6 bytes past a possibly short IE payload.

   For WLAN_EID_VENDOR_SPECIFIC, the code calls memcmp(pIE->data,
   WMM_PARA_OUI, 6) without checking that pIE->length is at least 6.
   An attacker can craft a vendor-specific IE at the end of the frame
   with pIE->length smaller than 6.  The existing IE bounds check only
   confirms the declared payload fits within pkt_len, not that it is
   large enough for the 6-byte OUI comparison.

Fix all three:
  - Return _FAIL immediately if pkt_len < WLAN_HDR_A3_LEN + 6.
  - Add two guards in the IE loop: break if fewer than sizeof(*pIE)
    bytes remain, and break if the declared IE payload extends past
    pkt_len.
  - Guard the WMM OUI comparison with pIE->length >= 6.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v4:
  - Add pkt_len < WLAN_HDR_A3_LEN + 6 check before reading the three
    fixed fields (capability, status, AID) to prevent OOB reads from
    truncated frames. Caught by sashiko review of v3.
  - Add pIE->length >= 6 guard before the 6-byte WMM OUI memcmp to
    prevent reading past a short IE payload. Caught by sashiko.

Changes in v2:
  - Add IE header bounds check: break if i + sizeof(*pIE) > pkt_len.
  - Add IE payload bounds check: break if the declared IE data extends
    past pkt_len.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..84cc814f069c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1379,6 +1379,9 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 
 	timer_delete_sync(&pmlmeext->link_timer);
 
+	if (pkt_len < WLAN_HDR_A3_LEN + 6)
+		return _FAIL;
+
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
@@ -1400,11 +1403,16 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if (!memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
+			if (pIE->length >= 6 &&
+			    !memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
 				WMM_param_handler(padapter, pIE);
 			break;
 
-- 
2.53.0


