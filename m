Return-Path: <stable+bounces-240038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OInsC28P52ms3QEAu9opvQ
	(envelope-from <stable+bounces-240038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:47:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7F4368B1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FC4301950A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A6336EC5;
	Tue, 21 Apr 2026 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDZmYboU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BA2765DF
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750404; cv=none; b=cK+0Wsr1iiegkaP9OjdOEeuI7STaDhLU98aHX/vv1631SF9wzSdLfMziV/SPoCOOh6RE0+98twgMLc3J6MlWiG0iZUh+bnscqFj9YvJ1tWWqdkUeZfdkJ1YLLp+GMHB04zV7Ons6hlF/TSCxdfrFyP5O2W/9XkYy6u3+Dn6ektg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750404; c=relaxed/simple;
	bh=Ub2/CujAcX3WFWcxCD/i+N7vpumJ3LeFtAn0W3AHdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzF7AfGhSgS8C8I81lHlPGMiuZdIUCiGO0KS83IdB3mM/AGVpNipYOP1/yW+FspfwTObg1l4y5ojQ0usS/LjctzYMvSid6sImmPUSwhvCxRVBGU6KhT1s6Tp2xhnqtiw8hiC6w3piM+umh2d8aQzJNNdD/VREXbvafh2QLQctPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDZmYboU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a3342d301aso40250136d6.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776750402; x=1777355202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=NDZmYboUdWSfSe+3MRBunxCTO4RXxFGjJMDbeFsPGXul2ZASg3Dk7uEjertgiabLk8
         53RICCXDztWaW9sNZs/DIHU3bopo/0OITO4zkkjSXbFXgK/+jGR6Z2ugZLuWWRowCMED
         rd7Kuw1HzfK6rprvU5kVqxmQyMcRUubApCFPbWUzSPqj21sMgpgvPgXu6joJNntnr5NB
         sKlkVqFfWFB42uvn1TjF6IEBCmjCWVqrY6Ss6j6wVP/3KQsRR54BTivGD3CHjQa1r02g
         fVyYHDzs2iIs1SeWRjbRAjoGDYOKpq7v2E21tRFIK0rQE32F9ncKAVB37mQDVAhlyQOn
         OLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776750402; x=1777355202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=Aa51jJcXDpIJD2oTVwgXc05BkfbjQ6NybNNcr55AuPyQR1JUVEY7AcDR7jZbanQ8/V
         y4iDhfGHvYbIzmGhuzYuLWsw7wzd5xukjU5bptdj2Xccu511wM3y4WxTlW/Nd8ojIiSy
         IO5pmoUMn0b+B7BgbGr9NYw4eSFGmq+5CDRBPNE8O/vIoxozs8WvHgB7zdi60c3y2CA2
         mqxFT3Er6x4Vn2ZeOQRLiwi+OGeiODCtDrzHWEC6hF1QX2LWsOacNAi7XZpLCIYfYETR
         cgGihqL73lDEW9HdxRphdHNc89AhPnCkx1o09xh+T58vBYGALLKYEKbQxCCRN2YS4DJv
         YX0A==
X-Forwarded-Encrypted: i=1; AFNElJ/eTm8VRWxw2PzVzunL3KsV3dC/wbW7cO80vQVsFkViKDg7JJggwODMD4o/c4ll//3axiAGDCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYLJSO3Mgu9hnA0+J4ne8V1LBcrz8ti+otwzfKueH7avLLoIP
	GsY+OqN3vXvMZs+wxZpN+CttIhObEOB+0gsWvNoiQv5Opt6Qs7fmbBX2
X-Gm-Gg: AeBDiesNfCzPFUpAl5Hofu5eMmcGqnT5jWhdRrQGs/0cHjFx+GiNXzllvCj4D7M6MEt
	5GpgTR+T4rWAIeX4lazSGqYNwtmFEzHWVbqTa6XFd7Uie69pyyLAzMMoJYE/BXoJOFTbhhbNF1K
	ITAXPZcO3ptyzIjeYOGqP3sOxBFFu+XAsu1tEeuy2xqt4lnM3Fhv8Ttb4w+sCgvqckXPy+Chn01
	JliVpsVZf9SxD60XsL9Giu6JYSE5WTas/7KMST2Z6UJ1/ngV9cCrUo+RS+0mX6zYR/VRmr4p6Wp
	SpaXCxnrqI/rIIJ/HaTzQqazIJOF8ny9Du/OxbWeWtJ9+78UQ7RjQWPFFJ1wcZWvePCEiInouLI
	U6/ALexrTUBpWFbzPh5JdbN3vCHguGFVgd4lwZMhY3gwiSHh2XcdGcrasN2QNgMS4EfrA9Dewe1
	98jnk1LWi/mfEf5EpX6GDYrnfg1Dsj2M+oPsxfQs1OgTsVPHLfe5pZ5tGr6xvaIrOKq/gT/LIGr
	ey5d7QTca5P4S6nV4qc5qfts7oKZ5uGgEw2vq8=
X-Received: by 2002:ad4:5eca:0:b0:8ae:6380:8f97 with SMTP id 6a1803df08f44-8b027ff9ec0mr283807226d6.9.1776750401954;
        Mon, 20 Apr 2026 22:46:41 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm96508256d6.7.2026.04.20.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:46:41 -0700 (PDT)
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
Date: Tue, 21 Apr 2026 05:46:26 +0000
Message-Id: <20260421054626.732399-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
References: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
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
	FREEMAIL_CC(0.00)[yaina.de,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240038-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6D7F4368B1
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


