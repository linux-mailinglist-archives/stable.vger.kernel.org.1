Return-Path: <stable+bounces-223390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMNCOo5Dq2nJbgEAu9opvQ
	(envelope-from <stable+bounces-223390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC63227C9A
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C533301DB8B
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA6481FB2;
	Fri,  6 Mar 2026 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeHB+x30"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2F481FAA
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831607; cv=none; b=UjT2J7L7GUhTD745/l7Ig2LAtb0a14T6N4XHseROB1+/lG1POwkcNnseFajb3bBwFoYdH9JceEQ0Kvg4F8oQQqKD5hO3+farE2sX704JbQoshAwHPM0O0ZZH/pMKA7tJEjAu/nbj34h98UpAnSbA59B3mvOZngmEdqi7Dm/jlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831607; c=relaxed/simple;
	bh=zmHZKOzqChOfGFaw8PX65dX4RvzOanOgiUgNjBp6msI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbwkT1+ECvwAeYzDROm7X/WvhIG5CPJBSlRtSBcj+TIdb5oMmPugW/S9QuqO0FyGj3xyJbsIYNcW8HMN9l/APa2ksa03vEpJArFQwtYmTFe7XBfnE/kJM7BvgEhjzKoBEmeVdl9mE5j9ZxLR77gCCDfhWkkBfasoGKuln9pvKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeHB+x30; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so859368e87.2
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 13:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831604; x=1773436404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMTRV/w5uF1FJW7BPbinMB5ysdrzJZZCY3sqGJfURo8=;
        b=WeHB+x30zi6IWaTAYuqnv3H2gKx0k+d6i9aaqqO31rViPbq7Gpsai1N9aLteTS8DN5
         0TVTTCGwOak0/NXtSHhSMwCPcpFgRqW6L5xzNHQVJyGXK9YnC0B+cNLOR9nhXxuJYDNX
         lTmx7xCeiQyKCp/F5IXh3ieh8ToD03pXVf5bHz7Vk5URzJlvsR3BchW4foTE/1iJWRbs
         EdlPNx8T2S6dQxw9jdkl78QJXkcN4ar7IqgGqLAlnmgXyHWyKJBFCuJn0iKTxS1XWNdZ
         lp0skjd14WYZvhXSw8doLBBgxlU1Izc7IpA0cKPjRZxeKPUP4W1kOt+4hYwFhfA6KR4T
         wx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831604; x=1773436404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMTRV/w5uF1FJW7BPbinMB5ysdrzJZZCY3sqGJfURo8=;
        b=GDnZ4fEtx52B1pZ7heaBL2zYyo6OW4Olqo4JZfe4PPKdiJwjmt5wrv5den+Ca4USrO
         j+SM/+E30PF/Hp3VH2ONII3zYL/eq1dks/s7fdSU38gryS9fxTSsP3RTnuNdPB5p20e2
         sxTNI0H90VqjRIduw3dfzbfr8yls8R7OiPpRcfzr/1Im2FNwPwJCENabmLh7DcpRHZjX
         uwO/Kb2lYLVIuQiwBPLhkcLIwxiLgQx7lMrMrR4unmSk9T6bZOjkSqWwAxFd9m93ONfX
         65NTKkyfPsUi4aarVKsDIjTcO1hbnwFdsf6FlzY7ybTqyLa3w47J5MyRSj/9oglgF9KR
         RgVg==
X-Forwarded-Encrypted: i=1; AJvYcCUlb+BJn439DiCdFvea8QjpYQOJ4tJAGdCnooQhGPUUVbup+iaDMxkqHbQ9siBaD14LPQOd3hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvETG31CiCW/zTF7CHJlmrLtNldsBY5EhSEqcM3lL3IJULO+CH
	25MfYUYvOJqVeAVXA3Ha2efPsDromy0zuPirwv15XyiCcgIMvywqwKJo
X-Gm-Gg: ATEYQzw3lYLqgbd9NA/SW2FHFbo4zU3dBMkWQR3E26DrcsQsVCFsK1TBeKVSy6fKIyx
	NQv+ZCAfi0uOX9qvagteyXrgUaaidZz25f/qCyBiL7xbv+CFAchgbyVxdOY2CQaoHvoexWZGpk3
	J5CkWua6oP01lRVnB2iKoc1YxOTJeEZmGM3htkKEZQDmqs+jeWaety/fDE0ndzhFiZpa710Txka
	Pi1SYSZY100QkUFaLuaLyYY1h7E0Hw22pLDI5C/UUyCPCdnGHarFsO7Mm3t8T2aQkJxDeIBtxoi
	EQ4pUqTKI7uBEt1XKGYrpdXIyfZfzSmVCHB8YlW4pSM5aDPQIcgoYJEbJAS5XDCk1JONx4k/Xik
	6Fo3uQfPh5qA6YyOa4xFjOxxQCvU3RKySaOKdUWYKfNErKijBp+044a5GeHq+1yLp6I+O4yIU/D
	l1aHkY
X-Received: by 2002:a05:6512:3b23:b0:5a1:2f7b:b5b0 with SMTP id 2adb3069b0e04-5a13ccd4283mr1149039e87.23.1772831603857;
        Fri, 06 Mar 2026 13:13:23 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:22 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 3/3] igb: add XDP transition guards in igb_xdp_setup()
Date: Fri,  6 Mar 2026 22:13:10 +0100
Message-ID: <20260306211310.1213330-4-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306211310.1213330-1-advoretsky@gmail.com>
References: <20260306211310.1213330-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8FC63227C9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-223390-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

igb_xdp_setup() calls igb_close() + igb_open() when transitioning
between XDP and non-XDP mode on a running device. This has two issues:

1. ndo_xsk_wakeup() runs under rcu_read_lock() and may still access
   the rings while igb_xdp_setup() removes the XDP program. Without
   waiting for an RCU grace period, igb_close() can tear down the
   rings while ndo_xsk_wakeup() is still executing. Add
   synchronize_rcu() before igb_close() when removing an XDP program
   to ensure all in-flight RCU readers complete first.

2. The igb_close()/igb_open() window leaves trans_start stale from
   before the close: the TX watchdog can fire a spurious timeout and
   queue a reset_task that races with igb_open(). Add
   netif_trans_update() after igb_open() to refresh the timestamp, and
   cancel_work() to cancel any reset_task that may have been queued
   while the device was down.

Note: cancel_work_sync() cannot be used here because igb_reset_task()
takes rtnl_lock, which is already held by the ndo_bpf caller. Plain
cancel_work() is sufficient: if reset_task is already running, it blocks
on rtnl_lock and will check __IGB_DOWN when it acquires it.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ddb7ce9e97bf..9ba944bf67b4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2913,6 +2913,9 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
 	/* device is up and bpf is added/removed, must setup the RX queues */
 	if (need_reset && running) {
+		if (!prog)
+			/* Wait for RCU readers (e.g. ndo_xsk_wakeup). */
+			synchronize_rcu();
 		igb_close(dev);
 	} else {
 		for (i = 0; i < adapter->num_rx_queues; i++)
@@ -2936,6 +2939,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	if (running)
 		igb_open(dev);
 
+	/* Refresh watchdog timestamp after reopen and cancel any
+	 * reset task queued while the device was down.
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


