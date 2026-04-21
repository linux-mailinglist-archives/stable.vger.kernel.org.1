Return-Path: <stable+bounces-240039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yChsEeYP52ms3QEAu9opvQ
	(envelope-from <stable+bounces-240039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D573D4368D6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C8E330058FE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73513358B0;
	Tue, 21 Apr 2026 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlNeSH8+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44623329C71
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750562; cv=none; b=YRb1V5aLjPes6aRgXnsYmualjZRDzQSuncgnFK0woGtHzPw3rB/lhonAVDgHHrfMSGvoB/EY9wvMdPowdZzu3WzjO8Pm1Rm4qHLg40HaeiBgWEchyaz/l+DSK4YXJx5WqBh1gpNaZ0F/alOER/oLq8zpgVYEJtdUIUbHZG/CQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750562; c=relaxed/simple;
	bh=Ub2/CujAcX3WFWcxCD/i+N7vpumJ3LeFtAn0W3AHdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X702khOpIWeBmntDm8vRqnnESNJhTPjCU05N9RtI6JN4InMARsX21bv2eCCdlcKBBRdvS0W5c7OsgzM07qnaY0U/cU+3bSNIjLGDzfuaO48L7W4jgqPQ/JvmiqR0ds7t+XC6dkHVfClGrdYyEgBxIH5uOQmIFMyOzdU9DIGvZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlNeSH8+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d76492e51bso393703685a.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776750560; x=1777355360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=NlNeSH8+6HVZ2mvFduxG05QSjMQ4JS3vRfPoOLIqWcTzh0bCHxC9cRjz+1lbTcUfbf
         P8WoNOj+gcB1wLZkgom91xSWVrkuJVVfUKy97Wapaer/xcjeJxCtyAChBaOfVrHjDyxX
         LAPIL54e6oB9zCs22cB3t27uBVa6eeU32CxrwZCDKS9UXFFZ0cJU2SoEexpBndIWSj42
         nJZXTHD1RydUlUzsjsbcCN7MexwXeJ/zncrDZjmuO7r7ROw+1qRkl//+FOeFVUX2Tndc
         g0UXEmS7eL5m4Zy0nbtnYpIIrlKkReWOeQBrA3lmM6FN0SYnWjCPqQJDcs6kIyW2/n7K
         2Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776750560; x=1777355360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=P8gCgaUwUweMC+5VMisW+DjvXxHsnaXcET80+HCE6JvRJhTr8y8qfrkKo0Z1BCOBZv
         xShzQW03Wa23IJJ+O7lgAZS7ZCwOsXXW3AfyLFPjrvfD2d1g+/m+D7Ayq0uFsyUbKgrb
         iG26wODsBK5W/aNzlFPZtaRlHcxMWf6nqNsz23f8abouh/7hXShkt316knXEmrMtum9C
         if4FMVF057ocg17cQZxJT/s9tR7v24rBWcERPdoqU2akiUkOSDDFHVCOtyHGTAc0g4Ps
         JlZfq/H93SvAl54TFz/zzwpEwF3gRESv5lbX/LTU9IwL+p7fsBlVOv4CEgIaec+ygr6t
         urZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Z6KBMroDzaLPDD41aepvQWluOFfCsVJEJQogSOHXRM9+Am5TGFgz4tR7DLePegpt/mWNzNgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFAwtH4/on2/DNPoB3Epmqx+aI4qc45eJ6OeDQZBs8X36PlFA
	vjIUdOdjn8kv/MTEbLZxNGu6E2l6uXK2XWMgWruM/6Nuzfv0Sjn3Zjjm
X-Gm-Gg: AeBDieufP2slskalFzIAHRQZHyBGVSl6zXAEFsn3TEUkXtIPm4HRuJYprURUVR9febI
	kQRqWd6E2Z9RBo0GHOvnnqGlsiIrC1/ZC8g45SbT7C/0vCI/TZ+BiEw+y/E21jF7rU6mxNCDyKL
	DOpNC/lCL2L/SF1xs+Wti/dHUbRBaAWHqDAkJrk7UiHKlkN68kmG+l20q64tZwDwgLV5Qx+VL9q
	cW0TJP4bebRM9rKoiFE8C6RveRmX4Jm6tsAtKCsSmrDXJZBKGxfErrP7ynMWV1wmTIKTrVnVdWe
	4aG4CEzCNtyRbNp3984sT2wNU95sPZVwLLYQ2L/1s/MTKv1wGrO7VW1uRqlHT9VA7PkoCCFGZwP
	QVrjjKwh6pofO2WcHS6oN50FFUM79Mu0qWoEGb9NzUtSmTzNF86t5rQYBatGAKqRwhX0aSM3exl
	pmrV5OoAJDIxqZ0sVyW/OIAqWt75NVfChQM/R1JyA+ZzImpBPMy2rB4QGnq7aI0pV9M11DBkDzD
	XXnFN+uLPVzpAQfpJLrs9IuRZOhwLCPc/ixD3Q=
X-Received: by 2002:a05:620a:31a9:b0:8cf:e0fe:f227 with SMTP id af79cd13be357-8e79030cca6mr2392122885a.26.1776750560194;
        Mon, 20 Apr 2026 22:49:20 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d9abce59sm1151715585a.46.2026.04.20.22.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:49:19 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org
Cc: jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v5 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Tue, 21 Apr 2026 05:48:58 +0000
Message-Id: <20260421054858.732939-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[yaina.de,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240039-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D573D4368D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted AX.25 frame with a valid address header but no control byte
causes skb->len to reach zero after skb_pull() strips the header.
The subsequent reads of skb->data[0] (control) and skb->data[1] (PID)
are then out of bounds.

Linearize the skb after confirming the device is an AX.25 interface.
Guard with skb->len < 1 after the pull - one byte suffices for LAPB
control frames which have no PID byte. Add a separate skb->len < 2
check inside the UI branch before accessing the PID byte.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
v5:
- Move skb_linearize() to after ax25_dev_ax25dev() check; avoids
  unnecessary allocation for frames on non-AX.25 interfaces
- Lower general guard from skb->len < 2 to skb->len < 1; the stricter
  limit incorrectly dropped valid 1-byte LAPB control frames (SABM,
  DISC, UA, DM, RR) which carry no PID byte
- Add explicit skb->len < 2 check inside UI branch before the PID
  byte (skb->data[1]) access
v4:
- Linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
  skb->len < 2 check (per David Laight review)
v3:
- Remove incorrect Suggested-by; add Fixes:, Cc: stable@
v2:
- Replace skb->len check with pskb_may_pull(skb, 2)

Link to v4: https://lore.kernel.org/netdev/20260417065407.206499-1-ashutoshdesai993@gmail.com/
Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/

 net/ax25/ax25_in.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93d..c81d6830af48 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -199,6 +199,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		goto free;
 
+	if (skb_linearize(skb))
+		goto free;
+
 	/*
 	 *	Parse the address header.
 	 */
@@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 1)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
@@ -227,6 +233,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* UI frame - bypass LAPB processing */
 	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
+		if (skb->len < 2)
+			goto free;
+
 		skb_set_transport_header(skb, 2); /* skip control and pid */
 
 		ax25_send_to_raw(&dest, skb, skb->data[1]);
-- 
2.34.1


