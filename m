Return-Path: <stable+bounces-237616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNyaOEQs3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427C3F1A7E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E2943007A5B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29663806CE;
	Mon, 13 Apr 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKkiGT3U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE12379971
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102441; cv=none; b=i3ral8qXfY0xXpGOn/h87OjD1hrPBRSM6kvstZEpPg3YoKTEDxXoa7zL1E6Pk7KzGKaQiKYlmc1uIQtjUrssZ7pLPYkIayWaUNBR4ytEbMjlMewkEV/QRsFPuXQH5QO+lhDT+nLT+40O70/O/NvmfQutB6vtCK2Lj5iZVPFSPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102441; c=relaxed/simple;
	bh=GtwmbLiPSWMmwAX9UxYBj4wwkd0cc3klEapfAfVXbC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi1IjDCRhVvStW7r+OzndL6Ij8xsDl5pteOmqAqRety/8aq9gIRhTVbMUwuj2aofQkThyr5NIZjSSGOUZdx9lS9B6wfev6r1lbzapy/I4U0QkdarHayPb652wsZeBKzLowWndD6AyVeRYtqPfEmi2O7jNAmjl5CKSVG5GE7OtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKkiGT3U; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cbc593a67aso427191785a.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102439; x=1776707239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0lUUpSXi5MAMiel5JSrhfv0lEsBngpxl2EK1emznGE=;
        b=NKkiGT3U6YeNzoDBv0RHgkuMtBhNIkWxXX+G6MG/1gw14E2M7t9MMAma/qF31dCvHb
         dqH+3C7co80SsmmYURETBWOpuDlSRnVKIMng++j77q9qHa82m5k65gzy+tRRQ7WFcrb6
         BYVgl75vv/YH82ZiTKm9CjyfrNin1cS8OUp4MMR0iaHsS1aqlqbpFgzifyUmfVdk8Vmz
         GiRrIBrodntGyH/OztFl6O66mvg0JWPWLEKjGtuv5se8vTe0ydY13i7EgZL+reZEe7XJ
         ZGFwv6xHdECf06VtBSAgEqd7hCQyJfM6TTsqur1Z4osH1Bz9iQMNa65W3dUmV1ohE6L5
         Ui8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102439; x=1776707239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0lUUpSXi5MAMiel5JSrhfv0lEsBngpxl2EK1emznGE=;
        b=V2IPku9kEFagapU6QUm6QZfxS4woVpmmvAlbmfJ3NG0pEllmahSr4LW7JgDHXJ3MDv
         HjeL+4tlFZ8SvhF5nHyAiEkwShzBTycr2DxdwVTlEQWTNrhqSeZIC5vbWoTuLdCm8rJ5
         SQv4z48a/1yDHUeuchT/pfGqoi4ir0Q9XDyFhA7DL5Cuds26iolAH/ARc4s8b552XRXy
         kcym96llm5GhenzW++vo6u4OAtu4bTnlpHyqlUMSVyKCec9NeDC73eqOIo/NZNzsfYEA
         f3zqe8jfrB94dWvfF/BX4cYFBiRNy5xe1iPiTxzzNSjuHzLTGXjTEctl5LW3MUHFr4m8
         9twA==
X-Forwarded-Encrypted: i=1; AFNElJ8bSBp3VXEiErWtjO/3Va4eq+pLbULMHUJQJ3XWHpVHCtHsuMgI0WSGa+t5r+/Dixx7xLUa8vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwigoOOwUDR8a/OOnh36cqNIYnfUV7KgdJHBiqG3O4cD7Iy3Lx2
	3o+zGCszDyB4tsdXq/3XPWwG0TA6v4DY5WCwKG+CGGrAH9TMtwaz3jRF
X-Gm-Gg: AeBDievhuJQADU4DsiUfshRfz+rgVOi4kQ2iXyZ1wKbkUZCdI64IMChMhEB2oNrpLHc
	e3bpE3qfC6C+RYNY7vwg2UBz7D1xGsaRyc734weICINnKEyE43ncJT9u6lGi2SWk440N7XGrYFK
	/uHpgWiRck7kl8ojOz/4im+jC3YbxXeU59H3aXpzzDPlHCrjj8mDo9MPnZicGz/bE/pmCNZnX8R
	zb010Ku1pT+4yMy53oU0+v/+FjHE4bPBXwlrIZPHhbXCJPFn9ODHCzXwCJGo+pdy/YK/p0aUhD7
	ly/mkIt7hff4qcl4eVfZl6dKdRxCMNKBx3Typ1OE5TCZqibJlN5J442+hf8h+byzRAIpoeNCySI
	1J795CDLetHS/1yF1rCS1Z+uJTcQLCM12xFnugTDBoaH9rkAeQlZE2zwxfEum3OdxS+PSWNcNZl
	bTtIlVHFMIx9NcfAHFwh0ESS2HQChkVQD8JuV+Tx9XM0G+Z4isQYj6WNcEWELRrlkXD5FimpQ+Z
	U03MEDqJ4R14CYu8hyp
X-Received: by 2002:a05:620a:6c0d:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8ddcf9b4288mr2016896085a.50.1776102438999;
        Mon, 13 Apr 2026 10:47:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb915b46bsm923141885a.33.2026.04.13.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:47:18 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Simon Horman" <horms@kernel.org>,
	"Kees Cook" <kees@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net] NFC: digital: bound SENSF response copy into nfc_target
Date: Mon, 13 Apr 2026 13:47:15 -0400
Message-ID: <20260413174715.197640-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237616-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0427C3F1A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_in_recv_sensf_res() copies the received SENSF response into
struct nfc_target without bounding the copy to target.sensf_res. A full
on-wire digital_sensf_res is 19 bytes long, while nfc_target stores 18
bytes, so full-length or oversized responses can overwrite adjacent
stack fields before digital_target_found() sees the target.

Reject payloads larger than struct digital_sensf_res and clamp the copy
into target.sensf_res so valid 19-byte responses keep working while the
destination buffer remains bounded.

This was confirmed by injecting an oversized SENSF_RES frame via a
patched nfcsim driver, producing a kernel panic with the overflow
pattern visible on the stack:

  Kernel panic - not syncing: Kernel mode fault at addr 0x0
  Stack:
   4141414141414141 4141414141414141 4141414141414141 ...

Found by static analysis with Coccinelle (memcpy-from-TLV pattern
derived from CVE-2019-14814).

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/nfc/digital_technology.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..5ef49f813f70 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -768,12 +768,18 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	skb_pull(resp, 1);
 
+	if (resp->len > sizeof(struct digital_sensf_res)) {
+		rc = -EIO;
+		goto exit;
+	}
+
 	memset(&target, 0, sizeof(struct nfc_target));
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
-	memcpy(target.sensf_res, sensf_res, resp->len);
-	target.sensf_res_len = resp->len;
+	target.sensf_res_len = min_t(unsigned int, resp->len,
+				     sizeof(target.sensf_res));
+	memcpy(target.sensf_res, sensf_res, target.sensf_res_len);
 
 	memcpy(target.nfcid2, sensf_res->nfcid2, NFC_NFCID2_MAXSIZE);
 	target.nfcid2_len = NFC_NFCID2_MAXSIZE;
-- 
2.53.0


