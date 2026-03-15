Return-Path: <stable+bounces-225467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M0EIdqbtmlAEQEAu9opvQ
	(envelope-from <stable+bounces-225467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 12:45:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ABB2908C4
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13400302D979
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A863382FB;
	Sun, 15 Mar 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2xNnlg5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEC1A2392
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575119; cv=none; b=kve6M6GPbo2MOmeRw61dZJIV5Jy8LVID6NiFQt+JXYQMa38V6rTOlziZ8axqkDODgySDEGyxPffw56GKmHqjOrwN8Bnh2hHOuI2b/QzypMe6qrKAkoF7wu6ZU37u5l2uHRb7zgSt5/Y0S11k/PVTuduhEV+KeLE0D8MJSeWmJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575119; c=relaxed/simple;
	bh=ekePeo7xFC4JcJRPKdRTzFotIT38WWC5cJ1Esdr9dfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o85jRzkGVZTI0TIScSTLKEdqXym0HmRw2PGZD2VnoA/kRyF+dr12JtAAkw8OQGRsrLkRrS5iwJKZ0WJdqZXT1scAjmze5j6x6+LFEzJJdVwiFIWi0XRJJD9NBYD5wjl5QRtUwZYgya2WiSub7UfBq+62lrXfSB5VGhZmbRPbk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2xNnlg5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a0ece9f14so45902866d6.3
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773575116; x=1774179916; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uDVHudfcd1lMVGOAwbARh4Bs+Hb4RWQ4xLnldj9Zw0=;
        b=O2xNnlg5i/SUl6LOrcYsfVoBQr9+SLht2lg5DB2B2Zwv4725H2ZjyGsU2PaKu595ef
         PYl+Rf8GmgM+qoOlhUECTFZQRB36YNC2YWnIodCJNfuCdAng+CagrMEpiMQutwHCd8FH
         t/p93Wqfg1PTH8YifIDHPF4MZJswU2vyrv5dSbwgEzEAKDkAIPfJ8cZ8xDHgurE8mb2L
         OKbv95HEEZMrLPnL5EbbFKDP61Nka30uZH4trHuRtl2pG5m1lb1uSSyXiG2e9jPGngIw
         6+WxRGn/ZghpeNKbJOdBjFtCNoVREik32aAkF70GT2KZlCRpblMqY3YNOCqbknb/ACR3
         4U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575116; x=1774179916;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uDVHudfcd1lMVGOAwbARh4Bs+Hb4RWQ4xLnldj9Zw0=;
        b=kLtKuoyx265mjU0xk97uZnNXzmpLGJn3/JM3s3ecFf72mxpHCQwJS86iOAE3QzKlaE
         rkGJ9ajzeX70L6wut22ju25O1hPgiydtcfUqq5XuH5BZviSx9zDxwxo8Jfz5OdC4D+/9
         57iqq53tpo7rinitRv9doDCwD+Og+SJZAjsRodtaz7T0iFNKRbIQ9L2jYHDutvgCQpHU
         GDyJFgDk5CZfjmyHGWyesYBPuLPcXVc3QnJ2kUSE72nFxXxTwvqfeH0HeS0L2Vb5ijUi
         PvfNu+BqF9pZHiWY0bnq8if+DcwjFIdr4YdETpYW6R5RfffQIBsnT6H8f/ibY7BPMMpl
         A0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUHa8bSojVF38tHLJYaz/eUVor7hQa8TqRZa8G9AI3nSxo0SXKjxjqhAqaefEuMLfYCBIt2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVD8MzLizS6cpmcvVVGsXBjPNebivwuJt1v80pM6fqr5/w/I8d
	LlOm+Nr/CFF0z88ComTPc//9MAayjg7+p0IXxdXqKOpLHSqMx9NYR34h
X-Gm-Gg: ATEYQzwaqyPwYW5eJ0GPNcLOwVtQLDlcN3BuDLbtLmVuZ/v9ts78p1W2rbkPTtBpixS
	TGj+npgsSaOPHRcowhwR+sHnaQ31z9zH7W7K4HEliTsFyALkRyVDurfQsEsU0VFZQEQRNEdwHek
	0d+g5cE3zCrIeyg4qBT+4keLugp1wxMOCBh+jqiZm5oqOgva1Upjrtz5Lk/nQkMrDZxwqQQ5mmX
	lind4jMSH0x/DpOjQXkY/q1CYGFLKyrsy0nnQLnxqaYKPBXhYmYNJYFD+QFHdlEb6OvGDeMkk2u
	ZVcFC8mseasMjlgSsl5c6OnqmjOmU0lp/r4PqpT6f721TzmFJ0DkHP+cXg0wHwh+EYTLqccDgf1
	TRGetpBCR1QzMsgi/RgPjf0TVHhWqikyRRjb3F+o8iVht2DB6MI7FR1kK1RqvlvbhkpBesVB7Gn
	HznSBMLm6+xdkUU5vACPLM7FXl/mqi9qYmDX5lnV42v6c=
X-Received: by 2002:a05:6214:509b:b0:89a:b0c:7268 with SMTP id 6a1803df08f44-89a8201b511mr126210196d6.54.1773575116135;
        Sun, 15 Mar 2026 04:45:16 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65ce339dsm98261896d6.26.2026.03.15.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:45:15 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: macb: Fix two lock warnings when WOL is used
Date: Sun, 15 Mar 2026 19:44:26 +0800
Message-Id: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqbtmkC/x2MSwqAIBQAryJvneAHwrpKtPDzqrfISiMC8e5Js
 xsYpkDGRJhhZAUSPpTpiE1kx8BvNq7IKTQHJVQvtJR8t95xShfXgzNWN1ww0PIz4ULvv5og4g1
 zrR+DcvpiXwAAAA==
X-Change-ID: 20260311-macb-irq-39b8a3333bd8
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, Kevin Hao <haokexin@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:email,amd.com:email,microchip.com:email]
X-Rspamd-Queue-Id: 45ABB2908C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch series addresses two lock warnings that occur when using WOL as a
wakeup source on my AMD ZynqMP board.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: Harini Katakam <harini.katakam@amd.com>

---
Kevin Hao (2):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::in_ptr with RCU lock

 drivers/net/ethernet/cadence/macb_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 6ba8fb373522ad9ee3e828c8e77d8bd1acf3dc33
change-id: 20260311-macb-irq-39b8a3333bd8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


