Return-Path: <stable+bounces-238432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DUTAOzZ4WkXzAAAu9opvQ
	(envelope-from <stable+bounces-238432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C804179A1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3D33056143
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53136D51D;
	Fri, 17 Apr 2026 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLOwRKbP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7203371056
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408879; cv=none; b=lfjUJNjWWwD3+nJGou20wtKpDVMUplt8M+w4kXS/nsIyniPo4OO5sT6y3Qu/gMv6lkmmcDlaIxWzVAaNYN6rOz323RyIRrRHUfcGWd5QuVG23QQXoveaJVZPKxvQcSiAl5wBma2aXC+VY6TsZR7+y6SHfbygRLn59zUroLSV8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408879; c=relaxed/simple;
	bh=UdyI0MLqzaqJUekJ8644S6ZTpHQmBZWss+KW7Oq1u9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZgXAxbRl//PNzCmiRJS7EiovXqf06EJTZecM4y/Qpq6MbRYGykusSC7gxe84ThpW4Paxk8tjHiV3SS1fIwVSI979UL4qfa5utjB0Fbdr7CXJsj94JLv9ZQypeinObsrJGHCZXCmAf7a3QKwRXpdKfLp8HNf0uiBim4Vg7A8ttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLOwRKbP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d4f78fc9f6so40326285a.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776408876; x=1777013676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+U16PxstDR4L4OQVQNTIksMWdGsxQeNQ1RCa7J7x8Y=;
        b=HLOwRKbP7AwKrJeApv3KVfsLN6J5FEOZH9nJKLKZCuTjD8jugIK2a/Y2zHP/11kiHv
         Ile1yPrE6kMl49epVH/HnTLEx2N5x5AhD+eW7QCgQ9NjZA9j1/e+Z8mDFsukkvvMpyl7
         UEOn4cIExCzdes+iBHiBOCSwtYONLBAOvFLPBu0ioobdfeBIyAWFti+pakXy7XeILgB7
         6VjS28+Qa1VUe+igbM5ahtsnvh7nQOtyv9P8uXYIDWe++Zfe9jDrqrLF0XSaj80KS+Ns
         NPu3R/1pBKbXYLw79/cFoxoQAknGRJeSjM0bRnG5e07W+Jakwx3CYEH8PtbdKCMF6sPn
         m6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408876; x=1777013676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+U16PxstDR4L4OQVQNTIksMWdGsxQeNQ1RCa7J7x8Y=;
        b=C5GcU8pUseRcKR482JlJrkjhfxQ2TcJnRzr4sgh0cWupfhou+MQQ/IrwBBrN7iHBpa
         7dQs2zQ8qrsl6Lou7HJzAIlcJ9cbIuzY3Ik+pLiTM4Y3o8F/rKrmo9fY3U+rYE/HlwcM
         coceMRaKqufflPbu1toPDmFf0v9VIopIrvc3UW5UVcolqyzlUTmuPawvHz09yqy0D2sZ
         RQ3Q9YBj4fSvdpnP4gUP5Q+v+L0FsoClsRxLPHaszjoHtYsaIPPziNQK1xPxM8NOpC4b
         aK/jLivJJYEZd9CVH48qrpaFh6jZ+jOgRdxYViYYZhiVR0KT+/coot1/Vbl/wAtlWHeP
         ww2A==
X-Forwarded-Encrypted: i=1; AFNElJ8U5WaV8KN6B0aYo3biWRqW8SfPY6TqDK5JxM0ZAjSmL7sbxNvJ1AneLy4eIrziupZK7zP0UI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZ4OyGcP8EFksm9eR56nd2WNaYEsNtt5VwY0zTDCY2BwpfrDA
	bM+LhjNnY6e6WGw4jS3ppzIRzqWzEhFek91sGmOoKdeSJnubcXI8fUNA
X-Gm-Gg: AeBDieuPWBtMlVaQDp+hp/P6PYckYZOwg7qWIVvtIUTGjMCVo1Z5WFdCXMFmi4gXqKG
	Euqz7i53asMonrpU/+OXv5aNje74QY4sOY0fpGeVTZht9ayczPnHBU+BLCG5qD65L5czW3FUhrg
	t3dKkwlL/NfPe4CPsxDThszElVAI54w7fDMRZp9s4SF42QMEthVH21VUnXUFrQAgFy40OkRETQT
	6oAooRFffemd8ibz5tLuXP8zQhzWGY1u5hLjkk9WIgzhqM+rph5nKQP8FRO9K2aka9fucnYkoTw
	XzROPojUQJ/89i2emk7E/cELRYICJTSPuNOCKlvaU1JzHeW0aB95m6EwwxJOPylFMTwQhZF+djO
	KJVn+P2dGwpf0HZUj1Kz44iIBXDR/slZCoici04NMyFaLTfVSprhsizomrA7hMKT0a/4istV5BK
	qF9Pj1bFSBv/P5j7Wn1EfYUchgMq7sdRuk/FYiVNDEynRV+KEYtiWjCY6ji6VleoBpNbmkuvy0E
	nqTnlMoLI6+CEAhSn2SyOM6xXKchcNpjDaZC6w=
X-Received: by 2002:a05:620a:28d1:b0:8d7:3f45:b95f with SMTP id af79cd13be357-8e78fb18dc2mr206676185a.16.1776408876364;
        Thu, 16 Apr 2026 23:54:36 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d6ba19c3sm46771285a.21.2026.04.16.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:54:35 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v4 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Fri, 17 Apr 2026 06:54:07 +0000
Message-Id: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yaina.de,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238432-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 94C804179A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted AX.25 frame with a valid address header but no control or PID
bytes causes skb->len to drop to zero after skb_pull() strips the
address header. The subsequent reads of skb->data[0] and skb->data[1]
are then out of bounds.

Linearize the skb at entry to ax25_rcv() so all subsequent accesses to
skb->data are safe. Then check skb->len before reading the control and
PID bytes, discarding frames that are too short.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
v4: linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
    skb->len check
v3: remove incorrect Suggested-by; add symptom, Fixes, Cc stable
v2: use pskb_may_pull(skb, 2) instead of skb->len < 2

Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/

 net/ax25/ax25_in.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93d..d14ccebf9cdd 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -190,6 +190,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	ax25_cb *ax25;
 	ax25_dev *ax25_dev;
 
+	if (skb_linearize(skb))
+		goto free;
+
 	/*
 	 *	Process the AX.25/LAPB frame.
 	 */
@@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 2)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
-- 
2.34.1


