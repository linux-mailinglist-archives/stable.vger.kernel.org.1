Return-Path: <stable+bounces-223388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFVCJHxDq2nJbgEAu9opvQ
	(envelope-from <stable+bounces-223388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A8227C5F
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB31D3036AB5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD64481FB7;
	Fri,  6 Mar 2026 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFbYNN4G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9D481ABF
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831600; cv=none; b=gIIpaYdDizp6q5rL/mcR45X+Oe3z0a2KLTOo+/3MMkHzkQa+kTKCZ7EFpNi6+arjb1IoiiQfkFstYEtdO8P4dDsBX63lpdf+qWcJhq7s4owNFgDZObp9VsG5wToh1g5ADke3rseVkXe+QV/jLjdIGi8B2D4JzNP6Ddx29tsfVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831600; c=relaxed/simple;
	bh=4ogALURRHmkBa3kJFR4OzsKE3FkMnZ+GeL96aI0IW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuEmVnWJBHVFGOD+TPsAr8vRQc10eQXmHMpfKK0WZaovOZWJzyLwfbxxxNxnXS9xZIS5Ajwl/kkMqxCS1S7kvI6C0qXychSgdIQ8tG9lKbUy/NLiNmn3NE1znSMnvRgrNxSeM+hLSBORj6l6TKQXqZdyOAML4FcT/IAx18eZ+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFbYNN4G; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a133502accso2501951e87.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831598; x=1773436398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+wVFXDJqFGNNH+A2DIP/hdXRUUa1ETvoAO9jfbvYfc=;
        b=XFbYNN4GMlsHd11bulc2VhNR5IGollN7ESbcPYRuKpTnLuSqqQey2Lyhz/AwFvzoT5
         rM1npqbtqjo2C7izY8TzWWC0LtBQ84KvZG3NxNeKmuu0+ux4igoFQbkE6TR8+jRO0NvY
         I4jcacn4kl7giiuo65W+B2IcTuyslTOZq/mw7Gx2mdLiNtC884vArftJNOISnEL3//Dr
         YPKxQdr/90RKZzO4IDxkGB1BlXkh8xSoSgv30VNkBtLu5vyywM5T/bZE5OlY9L9q42FH
         cKJchXLxtWMcsstAXY7PKvcWKAKlL+KWCVrCNMcr5gS7LsTCBqR2xwIh+HrMIgoq5vgJ
         720g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831598; x=1773436398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+wVFXDJqFGNNH+A2DIP/hdXRUUa1ETvoAO9jfbvYfc=;
        b=fdBKaGU39HVUTUBvxiEwrSTb20y9hsZtjWDaQvwr6Vgpa8h4lZzyIOd+TbiPlShVwo
         QaDHV6abD7I6Uc0BLbVmQsc6Rrr6tc4KM7w2iU1SDyPWqNlyfMvjh6kmc5j5Nq67hiob
         Adj1WfajpAyRtiwFJF1xVsOFA3X32EHLFw+lvKCkQO5dK9yscl042bPbhAxOwsT90eAQ
         4mVejC0HFjG2ZRN+DNNqYTaBuobae3ktsKZCG0xzluAs83flyOLYjJc//G4Gc4WdURLl
         cwIfVwJzaeBSYSw8hfL6J5Odh8u8Nu0/EPFTMkypUq95/xDu8uiFjjQ1Ia6T/65b7iIo
         DWiA==
X-Forwarded-Encrypted: i=1; AJvYcCUWxOykbq+9h8BuYq4y1UEJWdM7Z9jBNasj/31EVcFJT8AtL6a+U7rE4MXemNL+1Y9FQZhelxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgmxT5ObwYLJO9UveVrHXfg1DZiSskSZaORY5jtArcBXXf+1D
	dzW+tFMwKS6GuJ3f31PQ0wxSmk5I2Mvc28UdGv1NE/kBCnXJhsAiWs9n
X-Gm-Gg: ATEYQzwDOzpGyTPDc2jaN4DlvjSyjgvmGcrM+C6Qxyce2HjMOI0t+GD1r3mS77RcNyv
	ih/vYpbUfZlxYDqg+JkvgI2Iwl4HmrqDYe1xt0r49i9UtdLoxsrbjhq+4Fv2YCjfCUH7gvk+ggr
	iSuXDDI/V+zIDb5n0/C7GAK3xSvWmiEKezypN9fRr1qiYtzz5YMT1GFlstWDkrT5WSLYxJoSSWW
	l8kQz1Pf5ww5XFTHIgASp12gVBdwazpxNvhu4y2b1d1VdSYFRC7qjYOIrVTyMaTTGJJg1lmzVCj
	X9Yuz1ZdfX3StBpCgMB11tIQIK1F91lvvXdqyzqMtbcZgqiayw7Km0jTczloJvMwOrDMjGGrhP0
	MCdq37RUfmxbO9fo7cj1Yj4dJnXdTMB2zaKPPGSCqvSEhnU8ytx1xA6t2/9GkU3lYOOzfLEQENL
	Zx1vr1sReq3Z/dH10=
X-Received: by 2002:a05:6512:22c7:b0:5a1:4c8:a632 with SMTP id 2adb3069b0e04-5a13cab84f8mr850239e87.13.1772831597351;
        Fri, 06 Mar 2026 13:13:17 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:16 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 1/3] igb: check __IGB_DOWN in igb_clean_rx_irq_zc()
Date: Fri,  6 Mar 2026 22:13:08 +0100
Message-ID: <20260306211310.1213330-2-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306211310.1213330-1-advoretsky@gmail.com>
References: <20260306211310.1213330-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F7A8227C5F
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
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-223388-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When an AF_XDP zero-copy application terminates abruptly (e.g.,
kill -9), the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() repeatedly returns the full budget (no
descriptors, no buffers to allocate, xsk_buff_alloc() returns NULL)
which makes napi_complete_done() re-arm the poll indefinitely.

Meanwhile igb_down() calls napi_synchronize(), which waits for a NAPI
poll cycle that completes with done < budget. This never happens, so
igb_down() blocks indefinitely. The 5-second TX watchdog fires because
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


