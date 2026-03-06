Return-Path: <stable+bounces-223383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YON7BCsuq2n6aQEAu9opvQ
	(envelope-from <stable+bounces-223383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E69112272A5
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D672301DB95
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9842669D;
	Fri,  6 Mar 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp7HrUIt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C2331A43
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826152; cv=none; b=T0F1B+jTyu/BYR5wzYoQAXhKHb29GTep+Mo4AhkAH0J9mZ6456Jh0jX6tewD4hH4jzM9Lpp1t7yG3bfqpde9h1BpqUTuHmxiBUZzcKzavAVxc3Yz22f+asQFw/HSgMxQZxcU6WYpETlayh3t/RR8RuKsNWbUrgQgXlTk2BbGfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826152; c=relaxed/simple;
	bh=QyCiCFC1ECgVgWK65lOVKlnDwha5jYw4E23o/9/yenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIAGo1dGSoXlmqznm4/EW2XherUI8QzOdEh8D0CBhFgj4OBo9h1h6B8F/yhhN/G3esxy7jqlHCRlH9RsQf7FzOc0kuOpvrD2AZy6cNUWKv5hEdaJpbnJTFtoFVYExM9gCW2SLCGKIQuJPPEIpFqURS+2YprryFDMcAoobXErECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp7HrUIt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso2543564e87.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 11:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772826150; x=1773430950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg0CrTw5bn++8caa5w9iDm4bmWhzQ1IwKlUrGcmtKr8=;
        b=Cp7HrUItRjL4KLsA2xWgtxyDjR72/5xbq5wEyfP8DOIpTwdT5xoBlzO6whNtkqbwFm
         coqcJiNMpu5JxCw4J+MDB0qX2qmoO5wrpLo1lXJpfrOZL6RPY15kiQmFeY9MAdxNdH/8
         Rg13F6vwUNproUbVFqfTJePPtiKUkPs06XfReNn5TorLEEzYzG8+1FZghvq9woRlnvb0
         hhMnL2hHonPY4ev/thaSfZmENh4Pt2BlQ646hfz4dSykptOpwUnDkflaqpo1yv9RSvmY
         bmyNf61HJMPt2UUZEfgFoM+Rgc2kvWDR7UOJHvqUC1ZUYTQVPVEQ1WFFDVjdQRY3oLu9
         99tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826150; x=1773430950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mg0CrTw5bn++8caa5w9iDm4bmWhzQ1IwKlUrGcmtKr8=;
        b=Wim5NM2mDxRDDB5YV4Zxsqr3uaXFIKGn7IDVQm5FvsNc+wyxuT3qfak+7o7KZiapTN
         tF+N15ygWYYnXTj4hM/QkXPxaHYwafbKys1/PcRhLkYmRwbhSOBTjZojrFmxvCnubqNT
         WrkhJvGA2ebLiF6b9Y2CFCerYqFhZ0RD0SRs0XpyyJEUQk8n+YoDhchkExfu0Ug0H4UT
         lAoe1eqYwzxN8ABoAndwgsB0OM0tUuqbFFEtuxshw8Mc5oa6KI/ChmX78X5ZQ8wULw+i
         lzbQHiVtO6EfmtIIPGtciqTYRUTNf18/bp93LyrpdpXB0NrvnUDf1m/gBXsMP18kqouk
         lQJA==
X-Forwarded-Encrypted: i=1; AJvYcCWFvXDFydRVWZYxoOFy/q3Ck+RiDgb6yFBHc75ixgEZtZHdRJlho/1GWvbDfsSNQ9RnKaPwvdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2K3oupW9yl2fJcu7OZ2fuSx5GIFo03D8B1ernHlSdK7r+vz4X
	Rfb4SrCL2KYV+SemD1W1KucJR6uVWRt0a6AFINJzNhPoFlJY1BnISP/f2gqG/w+4
X-Gm-Gg: ATEYQzxJ8okjImXYn7LiCg69ltXWZD//RKXOROIYT15PXhbnsRrfxVw/uVfV0jPXdta
	myWGplIT85H314vZ2/EkkUks80xm9ezmixDQmD7iFH3/qj3PynC+z9OFWuNmNPGJxDGPNv/CoTn
	xmkxYekJTmAlVrLbXU3MHueBY2Ne9QL/m+z/XSuuLoTLq/smWL+8JhMxUiZwcW9kce+v9dWUvQh
	RB4AgsqjbwlhHCiGJn73Au3U85teQ1eauFoqj/rd5Yu1Woz43jCWpLa0NcYTIKKmP6oXenjSBBh
	jBsxlwV+cuYDK/YKNv31NGxoIMtrAUwPD6s+ktGGhIL64hHfqKUIi1B+XjhqE0tPlDJmEo16Xly
	CiAT6C2DVEtU09hbWmgi4ur5aEtBmXlVAlLbahbrwQ6cVHFgLRVgbD7yQdjJUUAnu2cotF5ench
	daFvaKUInJRDWqVkI=
X-Received: by 2002:ac2:4e10:0:b0:5a1:2efb:918f with SMTP id 2adb3069b0e04-5a13ccdd63cmr1393025e87.28.1772826149755;
        Fri, 06 Mar 2026 11:42:29 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cfabsm515709e87.7.2026.03.06.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:42:29 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: alex@dvoretsky.name
Cc: Alex Dvoretsky <advoretsky@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] igb: check __IGB_DOWN in igb_clean_rx_irq_zc()
Date: Fri,  6 Mar 2026 20:42:24 +0100
Message-ID: <20260306194226.995095-2-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306194226.995095-1-advoretsky@gmail.com>
References: <20260306194226.995095-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E69112272A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-223383-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When an AF_XDP zero-copy application terminates abruptly (e.g.,
kill -9), the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() keeps returning budget (no descriptors, no
buffers to allocate, xsk_buff_alloc() returns NULL) which makes
napi_complete_done() re-arm the poll indefinitely.

Meanwhile, igb_down() → napi_synchronize() waits for a NAPI poll cycle
that signals completion with done < budget — which never happens. This
blocks igb_down() forever, and the 5-second TX watchdog fires because
no TX completions are processed while NAPI is stuck. Since igb_down()
never finishes, igb_up() is never called, and the TX queue remains
permanently stalled.

Fix this by adding an __IGB_DOWN check at the top of
igb_clean_rx_irq_zc(), returning 0 immediately when the adapter is
going down. This allows napi_synchronize() in igb_down() to complete,
matching the pattern already used in igb_clean_tx_irq().

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..ca4aa4d935d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -351,6 +351,9 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 	u16 entries_to_alloc;
 	struct sk_buff *skb;
 
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return 0;
+
 	/* xdp_prog cannot be NULL in the ZC path */
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
-- 
2.51.0


