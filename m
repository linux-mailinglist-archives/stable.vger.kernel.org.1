Return-Path: <stable+bounces-223385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNorCTIuq2n6aQEAu9opvQ
	(envelope-from <stable+bounces-223385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E532272B3
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65E84301D0E7
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BD3EF0DA;
	Fri,  6 Mar 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/RWrIgq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F7423A8B
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826158; cv=none; b=qSDTaTbT9fXkHQw8ICfLsTIvHfSXf5yals/Im6PdIbMg5rFF2MBg0AvetorsGnDXdL+s8OAS7NzOcmVbyTQn9+POVQjT3fjKvTarMsoj6QkkNJw8LWhk3SJWSVdFHgtXmVjrY8gQstQRgErEa/Oruu90gxnyUWKvy9cHsaE/pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826158; c=relaxed/simple;
	bh=YK+Y54U96GRBS+z1qRIQBFTTPMEcbDyQJULkYV41Gjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lImOYauEqtk0xHnWJNPnOUsaxswJrFciWJwKk+JJ6NYL6Sx52Za2O0XBVtK/XBxVIYbRN03I681lCO3wVBfjFO6wmQjo2Vn1gS5XgpklZev4t9baTMRzCDeijkD5J3Yo3DG4Lneq3VTW9+thp8jG4N/cgvJkG4EjQ4s/+GjchUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/RWrIgq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12c19affeso2779394e87.1
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772826155; x=1773430955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x71R80oZPX+EWUfFkHezcVLeIdiVCuhQgybAe8h6wI=;
        b=T/RWrIgq7lVbX4Ja1hH6WkqGC8oAZ5kGoDwDePK20iaCB6iGHS86DjHB3Kxmta4ZMW
         xg6id8tWLIXOdx9JuPdKg0v1d1gwkvu6L8iXLSGvrEHH8vte9PlQfrqx2pUounOu6WfS
         C1bWsxBqgPEFICXyFwM9DMnLEFIdsg1D4ZBRGFMGGeUtEf6Uimfr5GjzoZITldDDySAb
         IxvcLv+u3IhWyebgAUnXfz6AmY2Pg0/6bRU9RgSSZjLbqxO3g1ixu2HV0MLDcKPvThuW
         oFO6rBeOzZaM+vuRUHLHkAufi3HJOAwKCSD8L9UBXa+fAicuwmvRfm228DRtOeHbTRqL
         Z4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826155; x=1773430955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0x71R80oZPX+EWUfFkHezcVLeIdiVCuhQgybAe8h6wI=;
        b=KxyUBqsJNA/ujx7GOOoh2eSXlFcSE0EfP7EbMGTUJfyf/wD1OXCmAv7OHUnUnGf47k
         KNiS5nNiEJApaCEuHtvIBl/zWfV1GTxABeLrImhIeDhn2N363JK0UmD4al+ICaq+gSVf
         TZotSqYR6xiMw4BH6Gbtm2Afo/v+xnTx7c4NAaB5Kvqj9L8dvma63BllbKycvQgvQHEc
         vHVQ9f6iY+/AIMcaU2QO8JSr4yQxBNNyL4ljtj4WAJiOqMtQGv8EQt7nmfwc4w+BMGbT
         EwWrITYS+oAsoGJ9Z6YJMzYUFkeE32nTRzPCg6V4fz8rWoqkParobViVxLGsleDq1mxZ
         FX5A==
X-Forwarded-Encrypted: i=1; AJvYcCXg5kYF+6bScoQL0mGaHvff/Um1BRmSaL1XocUjCF5Xn4OA/lS2ENJhZN7Dapsj7S/ngRX9V1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YztyINcQwKheFT3cwJZJ8sBPW/VDjPaxnWZNKT+XYV7tSTb9R6l
	TtvdcTFEyeBCk67Pb5nvOpqqEngCAQQcVeUyTZhkInb64y0h/Thby3+QrbWplSQ8
X-Gm-Gg: ATEYQzwzHTZ9cOJAdFvNQevOhAT6CQCAylcmlh22P3I26s3jCJ8s3Ksr2+IeTjifIaP
	BFna7Bf1jD7hRDbWRSmRDDcGfFEiFC0KkI+9eW8DBH0zD2W8d8EngwzbzN2wnz6WFn7kXkDTaEo
	M+b13W/DpvSno8hbBAYwDLm2ui8GOprscGVCjF1FVE5/EGSTApSpxvXQ2Lycso1UDC/DpokG7e8
	iGdmCwKy+iywrKp6n67yhhMNYfpGsxr9Q2BAdZQUdle/111YanEPHwCxhG8mBGFcZKoe0NTAbGH
	DkDIS/99CkDL7kQgagX66mw+NUA9ixpfpRQrzCE2CDzblufX6v1aCZvk7OEpXa0u9todhR6g08t
	yzeE/bZprd+i0/Hu5MOexR1chHrDaGPz/aGKtfRK7Xeg3MKxD9lG8loCuXiwDqY9CkM1GUKmWRK
	FDY5+F
X-Received: by 2002:a05:6512:690:b0:5a1:306e:ca03 with SMTP id 2adb3069b0e04-5a13c941528mr1263530e87.21.1772826155207;
        Fri, 06 Mar 2026 11:42:35 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cfabsm515709e87.7.2026.03.06.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:42:33 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: alex@dvoretsky.name
Cc: Alex Dvoretsky <advoretsky@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] igb: add XDP transition guards in igb_xdp_setup()
Date: Fri,  6 Mar 2026 20:42:26 +0100
Message-ID: <20260306194226.995095-4-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306194226.995095-1-advoretsky@gmail.com>
References: <20260306194226.995095-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04E532272B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223385-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.988];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

igb_xdp_setup() calls igb_close() + igb_open() when transitioning
between XDP and non-XDP mode on a running device. This has two issues:

1. When removing an XDP program that has AF_XDP zero-copy sockets,
   ndo_xsk_wakeup() may be executing concurrently under rcu_read_lock().
   If igb_close() tears down the rings while ndo_xsk_wakeup() is still
   accessing them, it races with the teardown. Add synchronize_rcu()
   before igb_close() when removing an XDP program to ensure all
   in-flight ndo_xsk_wakeup() calls complete first.

2. The igb_close()/igb_open() window leaves trans_start stale from
   before the close: the TX watchdog can fire a spurious timeout and
   queue a reset_task that races with igb_open(). Add
   netif_trans_update() after igb_open() to refresh the timestamp, and
   cancel_work() to drain any reset_task queued during the window.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ddb7ce9e97bf..9ba944bf67b4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2913,6 +2913,9 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
 	/* device is up and bpf is added/removed, must setup the RX queues */
 	if (need_reset && running) {
+		if (!prog)
+			/* Wait until ndo_xsk_wakeup completes. */
+			synchronize_rcu();
 		igb_close(dev);
 	} else {
 		for (i = 0; i < adapter->num_rx_queues; i++)
@@ -2936,6 +2939,16 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	if (running)
 		igb_open(dev);
 
+	/* Refresh trans_start to prevent the TX watchdog from firing on a
+	 * stale timestamp from before igb_close(). Cancel any reset_task
+	 * that igb_tx_timeout() may have queued between igb_close() setting
+	 * __IGB_DOWN and the actual napi_synchronize() completion.
+	 */
+	if (need_reset && running) {
+		netif_trans_update(dev);
+		cancel_work(&adapter->reset_task);
+	}
+
 	return 0;
 }
 
-- 
2.51.0


