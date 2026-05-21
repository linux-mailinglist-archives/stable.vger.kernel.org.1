Return-Path: <stable+bounces-253469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN8mENK9DmrXBwYAu9opvQ
	(envelope-from <stable+bounces-253469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:09:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F945A0C6B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C863300B9E1
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46F3A05D7;
	Thu, 21 May 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQljZwvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB431F99E
	for <stable@vger.kernel.org>; Thu, 21 May 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350708; cv=none; b=B8UVpq8CzfNa4HxBH1PQNrWDnGzmaCY6AIHMHr9zVBTmLoKm+KRRiP8DXzOG/jiq4kTGYmRTUw4TfLOetZiA0Gr0SB3RhqZX0MivLAgw5TWBWB0twW0JJJfPkl+PGO/mihNx/yhb9qLhmQc8GUoNMU8+bh8vD3QqiZxQUkIysF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350708; c=relaxed/simple;
	bh=RL83CSKyQUpDiyBsLzSdeCnSEtC6fKm5Rq4HrB5Vzao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgeSO7DQVRbFUblTfLP5w79JIXAm5W12Ho+GdaOHlZcUmWF0MRoAEH7HiXPDF+XgLNW3PNvT/OVTOi6xnKMts4oOK+L+p9k/v/QXTtYDGdg7HfgEDb1Z0neWFMgqpBmTGrfr5ynZzVajmfDVbO5w+mJSTDz6R1JfhLXDojOWAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQljZwvQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-368ea877adbso790904a91.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350706; x=1779955506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2KomId72zCewKwGpKqCRi1v/6H+d0pzbRCY7T9vPPE=;
        b=IQljZwvQ57N9v2+gt6xdjTbg2+HXAjWm7EH4E469zxgf42bfglIeKNoUCI+UyhUlLw
         0kp9ayyYYGiqLKaR1tuEXjRBKkz0p+IY2l2eNTm6p7Lv8sa9q4GlkjKklfJn6GnMgmfF
         00Q6LxH3TS0fhxMSBcSbzonE5MXI8CM4OCUdfeqEjnDRs+oTyn8qa1sJLB6+l1qv5hcM
         43fRqMVstBTeperqIetOfOjSMdxxctIMd+E2HfHaPtSO4LQIA5S2edyGOjwcbjWqcCBD
         AyreiMS9p9DZnELzKhnsVGZhcbhxoa+O6wJR59s5ccdcO/0UUU7Y9J+03eF7UZrnTdjk
         0iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350706; x=1779955506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2KomId72zCewKwGpKqCRi1v/6H+d0pzbRCY7T9vPPE=;
        b=BfqSuT6JvEe/OG55Ac37RUB57Aj9itmrCRvIZUjzLKXmXKNPjYoMoq7MdRNdWMODgI
         u1WXxLx3nuoykY9xMLBX4QEm0g2CwRdkwiU0rfbIw9cnWjK2ZAGggqmBOSpO/G3frWlj
         0CuvT6eQXPespEmBFaiflkRlqS/FcmOco9Rs5stda0GnzFmkWuIIu1HqSrOBfD08jLr3
         yLtemDqmwChMXSJDsT9PRnVw02o05wDWTaz3hxnc2wn/G262Y7Zy5OLNnZwleN4gM0yr
         LAl5DaCiYz3637Fmc1fUj4K+O7ZpoVW9ikyphIxgRDHG004IDyp5yodXXgmjTh/ga/QS
         hl6A==
X-Forwarded-Encrypted: i=1; AFNElJ/JoY/SyDgfQRxsmzZE8UxGILlOy3i2XJn1pPlDatAYiSLEvVO4KJIlbEOfmQtQNQAFo+HMHwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqd2A56ZAmdLnXCxyKkhnheKBacihEfXxtbsTmGGnJZ1fsSjj
	yVzgLbBCIfUYI2nBqIgL52f5sbAjJ4z0q8328zUHbp4ECsz5x8DXGu7ffgc72prZ
X-Gm-Gg: Acq92OGpXy99oISJ1bNH7oTaFbKggzubkJQPIV3Kn74Aa/sE0Np5ZMCD96A7FiSQpJo
	WG1jqLLLUjNMxlvEwGgFL/VdTqYHYBr1RVrwXqYrgTV5aHTcUZ+Xwn1FX9g4leFzsSIBaiazK+5
	v0SZHJsMMhESs781BAgUIfiH3W2LlCKUkDFrLjb4VFfOSisTDtsZ0Ch8TQHk2o0ECrzQh7fPqSn
	E55Rb2bDQGQp72S+vp+tb4yzL2SHDVW4x/LgTRZ8EdMP8GZJuBsxAdIaM0zDae74ROwsyY+jN0U
	5kDKkF+qySAx1F+PdXR2JvRH/erOpzKborjAn1kl30SP7cUdRmB+OEtuUJIhjyaHOod1xVDJMA7
	rzjwPtqn/G+CZdrAZ5gFnYVP+yEXsXEvzja2uwhhx0Jl1Ox5XX4pJKChzt89NMgzjJ6Jb0ajGad
	kc1yNf6dFkuXu0uEprQbC1covv8nsE
X-Received: by 2002:a17:903:174e:b0:2be:9c3b:7b0b with SMTP id d9443c01a7336-2bea2fbb7dcmr10885165ad.2.1779350706128;
        Thu, 21 May 2026 01:05:06 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9179ccbsm2992325ad.14.2026.05.21.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:05:05 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yang.li@amlogic.com,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
Date: Thu, 21 May 2026 04:04:14 -0400
Message-ID: <20260521080414.44460-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,amlogic.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253469-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 45F945A0C6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
returns 0 without freeing it when neither pa_sync_term nor big_sync_term
flags are set after evaluating the PA and BIG sync connection state.

This early-return path was introduced when hci_le_big_terminate() was
refactored to take struct hci_conn instead of raw u8 parameters, adding
PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
failure does not cover this path.

Fixes: 1ffee96604de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2..9c5a3dbf8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -803,8 +803,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 			d->big_sync_term = true;
 	}
 
-	if (!d->pa_sync_term && !d->big_sync_term)
+	if (!d->pa_sync_term && !d->big_sync_term) {
+		kfree(d);
 		return 0;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
-- 
2.53.0


