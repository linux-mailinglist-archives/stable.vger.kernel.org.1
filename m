Return-Path: <stable+bounces-249659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKe7LnGpDGoIkgUAu9opvQ
	(envelope-from <stable+bounces-249659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C69045838AC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06B7930210C6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC57367F26;
	Tue, 19 May 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtGfUqBY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39858352C54
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214698; cv=none; b=b92gMIU184dXr59+cZOw+z4lSTbyhtd084R59XHOuLon5etR+kyBKarqkFkY1t7+NVtrBEY8p0n4MEU3HKHqVuN2m5HATECElL5AmsaLCyn/Ae8KeU23kcJrAUV/r5enpZhFs+9vGMhDvUVCnpfy4f4qO8Kf65gMXV+yZvBvQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214698; c=relaxed/simple;
	bh=eXHp82baqxaLH1q4iRY469trvVd0cOQSdBovZjXWxvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAcBa92irGMNKnqc/3F+twl6FTk6Pq4ViK9K2m0BoitxLnpecTGWzRkxZhlECJq2GMfA4HUh0kUIsW0UgiCnJOz/3A/CkEC/Y9LGzX2BPUsaE1Waua9LkRBVOFqPyZQuzXzDLi93T9edpWLW9qw9z9TLstX1nrDTRbz2b3fCbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtGfUqBY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a74032ff8so2800544f8f.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214695; x=1779819495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=qtGfUqBYduP1Yqkr80hR5CRBMSAVJ/GH5tic7dtOMSJy0cHxqs0oYFbEFMJXPIyDMa
         vt5BYb2doWXGl5USANsICHwuIr8zrTlwZMbvyV59toTY14aIkI/DTpmKJ2VUQKu0iJx2
         jG4TI6zNHoT9cAeRSG85IGvVr0weQpp02Mx8kUTlXQyJkmaGFdDk01FuOzomnKzuuTpz
         kEeprK3vNKmY1yuDjLIEvI/7eiLxCenY7YL+zyOIIfrnP2cA7mDd1lmp4fGBgGilPLuc
         XplfuMCpepzt/LvswZdv7UKJx2Wg58FgbM83dCvUrZk1UoVVFsRu41F9G0bbSHaIEg8t
         rkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214695; x=1779819495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=jXFPphzcaAGHo2krZBOBMxMOufZkvJM/O3MbOOmuZKgQWSHmxV3/ZNnL4lQyGBRi8D
         RL5eJeY5x+YdoRLtEEC5QHwKRvBYCq6WgoyFH2mHJdeYpSPQ5fQrxZL6vyBQ2ZYqu9fM
         7FzAg9HnpGC7GdIuA8rE2WUawEd8UrBUiaVMqRPv5eV+uDx/aBz03qoRM67chzMFKicI
         kL/9JWaFkSYvol4Wnv0hD3VmOHH7k1pkoZgVErrKeYplItAhFhzogiBj5bY98jxlJUZ0
         x551BN3mri7y1zL9sMp8CHnc62zh1DLSa5jWWcyJfq0/bW90MV0xYDb50p8GNRpIuobS
         Hujw==
X-Forwarded-Encrypted: i=1; AFNElJ9sWLzH48q6l5iCd+UJSfVEMTfUarAhiWzmIOKxkIL/wJxg+J82yxrAVmlNMgtPVeyraY6Mo58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTbIFb3P1371nUGOowye56+B8TLujClwahVqGb2PjSIleIc77
	XCsSRqA8+kPBYF8G+2qo3va/gFodTWqYVZ8206MOYpF9LS28CwvYTPkU
X-Gm-Gg: Acq92OGLN19Kl5XC+QrSzMGNYS31BlkpvnHy87/o7H2iBZLJwZ+XZsN6VFTe4jHoPnZ
	crrrHjtrfVke6nhU9zHOjbke8MdAv3f0AQ3+jZXghSS2dX4qWLVu6AoubEc44TTAI+JhvKummBI
	X7D45E6zzfaAiDvBQSacP5aenTSuvHmg+m1ydCCIdOKeU1MWnTX3YQldaei7pWxR2rCW/hrE/C/
	6xLRMan5ZCZt5RlzArAlqmt2Y/NGJ2Hi4o/QDMrppshX0iWdI+4dXS5OmhS0ADJfL6kFf3BcEnH
	aPtaZDL5Y5rY80+jba4IQCRk6kp6XHnU1Wf5LbiQVi/nHbMISIpv4e2slcax6LdjpVYY9OA+L6v
	QqKuKwluStjFzBLkuLKP9XjSqWpLnxG7f5uv8X+lLgJpm0GAiV+mTNBG8XEU8q/hMQMFidZ9y05
	VSnR+e+ERI2aP04tC0sm53imWP8cCsMnFLKf+G2FqXaGBoc4QlBYDm7fkldcaOMEisV4WrA03KF
	QV4M6J64Mys
X-Received: by 2002:a05:6000:1845:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45e5c57d2fdmr33277547f8f.6.1779214695304;
        Tue, 19 May 2026 11:18:15 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm49915487f8f.23.2026.05.19.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:18:14 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:17:49 -0400
Message-ID: <20260519181749.15746-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-249659-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C69045838AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..66eee8a86 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
-		/* no session, so free socket data */
 		kfree_skb(skb);
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0


