Return-Path: <stable+bounces-267918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gHBFOkBsOmrR8gcAu9opvQ
	(envelope-from <stable+bounces-267918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:21:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9BC6B6A86
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:21:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vw2YvPfh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267918-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267918-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A294303BBB0
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240203D34B9;
	Tue, 23 Jun 2026 11:21:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D50377574
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213692; cv=none; b=ibSvX7LehkYX2bgFnHaiQIdtrDGycfpRBHveThsTlPK7b7SQMxdn89G/kexEkh58YkurFd8+a36xAKj6xbA5MmK3mY8XLxW21mKcO6WJG0SMmpyQM87tWWZ6XBVOuB66SIvR6BEKMXbe6tWUswIcRtLp8rHf/DnwKOrNn++77Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213692; c=relaxed/simple;
	bh=DvUc4qs6pGlAq5YVheN9HonjTAdavu+DHluLkjiJn8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmDJOVe1UhMta8ah13T1mOpobcDY5MODXwQOc2npV4FyTyw3i7RHWVH13tOEnIcWgRK7MR9IuMScGrOMHnUqYGX5oYSkmOwzhXTgMv7szWXbvx9UAb8uubCt9YiI8jrgif3BeBY+YdXhdY8hrbZvO+IWGYHV4EeEVVTCvwvOWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw2YvPfh; arc=none smtp.client-ip=209.85.167.169
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4864a5c83f1so3059031b6e.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782213691; x=1782818491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMH/IcGTLo6vZoiysZQe+TRMu5P99Nsjkh7igJAUCYU=;
        b=Vw2YvPfhpfKU+mNZYC+++Kf3Z0vI7PnmU4qOhiOD0WO+ZoAUnfK6sjl1b8qcLrHZL9
         gFEpWmhYqN/D+nNRIcLtMOOeYoxtAdDyfbPBOOVmB2kUaDLpwA4iOiQes7MbIzZLO66T
         Jn7dYQxwejtoik6yodSnJRS2juf+nyRH/nZKKDgAC8A2eC8ngverb5Px7/VBL4hR6vKC
         N3Vu/pNjeSGJijnMSP+G45kfefskSA4qhuzc6YtpwL+iJGYl6bFACRTkOcBCTq2L0Sm/
         rgBdruLgAL+bA6F+3hoXjwR7wKHiWLRbj8G2MYKFdRxPNO9S35UM63rAYJjgdrWvrE2n
         iDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213691; x=1782818491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMH/IcGTLo6vZoiysZQe+TRMu5P99Nsjkh7igJAUCYU=;
        b=m4XaU4UZVnbO2MFFvIoF6vcO3oPzjlW7Tif5M2E7DhHmObuK/5phNoXYmsWHiGj3X9
         qtdu8JVee7IJ8KCosoM/u9eBWXNbKK9iRBuBRJUGcFu0wHQdWTTkuE/e9zIKvUTMjBQ9
         Oj+kp/QO9XLSvytQ4EkbBbm0xOvr+Y37N3Yj5AlkQYk+xDFdCN4bE2uEvQzWLqi7ZRiR
         2q6HcT+2nxRWVaEpiYfUGvACPDbnSlm2WDJGyHy49+7Lv/q8ELgGt0ZrfMY9zKwXZJup
         3nXoEKZpcQnWvw0Z+O9CjkF+D0TPWl+aUXXf3MTpUZKZJQf44f/dac5wVrCfLFUf2n5h
         mhuA==
X-Gm-Message-State: AOJu0YwXliUegeTGfkjY14nJtm3kteTESDCHomzWzoCuzB3j8dqPdAPV
	XWCZ9vbTCwU49ilYPanD+avMky2eje0BAfkftxZr8HBPVvoLq8UkVk1jL990dxXd
X-Gm-Gg: AfdE7ckzOESPw2KTO3v5tlpqFwPRttdYmhGRCmtcf552jCZRb+tgCh5Ke8ftlhWXBl2
	/DbaswFinaFwxPUJeDSWsNluW+ig3yLBC1VvoCo5WDz5M2QK4v55Au/szxYL7eMCPMkvhPfdWo2
	KRXpqiokkp57tb/Zq6goDwJvzgH1K3GBI/n7cCqRkaEyY1rB0vyGxu/97o4qro1rwDyQbd65LT3
	I1WhOm1p8XBTBYtsrbbkckHqA5pGXenTjkAH6642QWGWmrRgDsg0v6luZW/9WeQmGBWObsO6v1c
	qrenrA0brDoGepU5nJ2b6pjtrjNnz4yBwXDxKsO+0Uyfxqg9FNvQGyboGHTjuHaXEWLnue1wGKK
	r4NVKEnrCs9udpaaxgMCDO0sVpz4u5NwcmI9GD7KQ0kCWbdyxrbDQgoUzIcgYTMAPa1C/I/am+0
	3xO46jk1Gyg65gLf5IaTMug86zCxof
X-Received: by 2002:a05:6808:1204:b0:489:5caa:68ac with SMTP id 5614622812f47-4896aa62383mr15259240b6e.14.1782213690647;
        Tue, 23 Jun 2026 04:21:30 -0700 (PDT)
Received: from GINKO1.localdomain ([216.167.189.32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944068feesm8291748a34.11.2026.06.23.04.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:21:30 -0700 (PDT)
From: Michael Pratte <slatoncomputers@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] s2io: only arm hardware LSO for GSO skbs
Date: Tue, 23 Jun 2026 06:21:31 -0500
Message-ID: <20260623112131.752148-1-slatoncomputers@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267918-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[slatoncomputers@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slatoncomputers@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A9BC6B6A86

s2io_xmit() enables the Xframe/Xframe-II hardware LSO (TCP segmentation)
engine whenever the skb's gso_type carries SKB_GSO_TCPV4/TCPV6, and
programs the segment size from gso_size:

	offload_type = s2io_offload_type(skb);
	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
		txdp->Control_1 |= TXD_TCP_LSO_EN;
		txdp->Control_1 |= TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
	}

Since commit 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
tcp_transmit_skb() sets skb_shinfo(skb)->gso_type unconditionally on
every TCP skb, including non-GSO frames where gso_size is 0. The driver
therefore arms the LSO engine with MSS == 0 for ordinary TCP segments
such as the connection's SYN. The Xframe-II LSO engine treats an MSS of
0 as an illegal descriptor and aborts the transmit (lso_err_reg reports
LSO6_ABORT), so the frame is dropped before it reaches the MAC. The
result is that no TCP can be transmitted on these adapters since v4.2;
UDP and ICMP (which never carry SKB_GSO_TCPV4) are unaffected.

Only arm the LSO engine when the skb is actually GSO (gso_size > 0),
restoring the pre-4.2 behaviour. Non-GSO TCP frames take the normal
transmit path.

Reproduced and fixed on Linux 6.6.67 with an Xframe-II adapter
(PCI 17d5:5832); bisected to good v4.1.6 / bad v4.2.2.

Fixes: 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
Signed-off-by: Michael Pratte <slatoncomputers@gmail.com>
---
[ Not upstream and cannot be: the s2io driver was removed from mainline in
  commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
  driver"). It still ships in the 6.6.y and 6.12.y stable trees, where this
  bug is present and the patch applies cleanly. Please apply there. ]

 drivers/net/ethernet/neterion/s2io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 1e55ccb..9988ff9 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -4105,7 +4105,7 @@ static netdev_tx_t s2io_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	offload_type = s2io_offload_type(skb);
-	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+	if ((offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) && skb_is_gso(skb)) {
 		txdp->Control_1 |= TXD_TCP_LSO_EN;
 		txdp->Control_1 |= TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
 	}
-- 
2.54.0


