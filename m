Return-Path: <stable+bounces-217480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH/2NWVGl2m6wQIAu9opvQ
	(envelope-from <stable+bounces-217480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:20:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6D1611A8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37D531ACF6F
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B734A3DA;
	Thu, 19 Feb 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpEPYB/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AF352F8C
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521256; cv=none; b=QnNHCt/jEA036pHXC9f9kCf6XnSuZt6+WVS9Z6kdBh0Q7fJcIdidSXh+FE1FeycG7OpoIoJ73JTrvNX7plk40nOIvf0MET4WP3in5B+I2EtmFw/VaQ1o4Hd7FIF+sXdS+6B6quKKuytIbEkUxLsY1Yr/pLB1JPhNEosMkiSo6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521256; c=relaxed/simple;
	bh=wtM3KGXEQuicJ8O+1w9NeLqs1Q3c/AYVobYXG6O4xkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAVTnG276/wzX7WAVh7hu6HRW9WnyQ9f0tZPlAK4KmEjIKdpNjhs/d8PSh1j8mImKlKwbgfKjUs22IZzRru7QIWTNPnWlq6KECdPmsTjyih1SuylHcpVSq1xnfgxUS9X8gUELeNo/wsg4yi9f2XjCJaNJy3c+X1xpCpuGf8lcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpEPYB/F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a79ded11a2so7731325ad.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521255; x=1772126055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=ZpEPYB/F3ptJD1G/dWEZjed0xgEBHRqubbvxKeqMB8yXjHJNDc70RDIDfR/SH9bqKK
         TLQwWeazbfydFyIHc42gKGPP16FfhJis6WFaGAQX4iylSm0fY7VZ+6QxGvVUZxoOhqVz
         xUXuHWB58XOEIYeD4s2v7+zKVxsJbbeOp6T74/eHqqjLfv8weOytBW14YYnLvdXjhtQz
         vgjqRSeF1lZY4oEtkUA2bMBxnks+AerEFEBsFHLD7OvNCJ0Ypstr2V8rngP90Y92+zIS
         mKeIs8zxdlzCfvl/Aihdvda6rT9cFunclEoL3BMyzbqbEJj03bA5csUCM5iOyJij5bfQ
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521255; x=1772126055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=Rf1MDmqmvVekEzSykBY7BNcm+HY+zoqga2mwVT7hzRZBUZaCzHI/CtlzOkr3MjZIa3
         J37UIYUb8rdkKuyCi+NYfFpDGsIbiRLPo+ipR4stNWxYRtVPGaVo2UiHHl4+K8Ho19JC
         XeK1nYLWiN1wdZrnVFjxQ74FNTuLscHmwYDidN6uU8c+3q1aTetOg5O+9UZqAJFsWOK1
         DrSXYDCzsgmw6okc4B1YjmNrYZqTbNVmQzSXEWIFjzFWa4Mh4bygHZ+dywcjD8sdejH0
         GRqK+w8n8Wr4A9JSLAYuDYtYkuXfiM6C+G0EeE6A0VR8WKCVyP7C5SvShs+MXsqIUhIB
         zs+A==
X-Gm-Message-State: AOJu0Ywptu1LdQtQDcvSVYb4HrVCL2RmTJmREtk7cINx7vZhclcENE17
	mlq0wzRjpbuc2s7FGDz2WeujfAoMa1DFDQAiDtQZOKsrqMskgGTePLjEwjp301+j
X-Gm-Gg: AZuq6aJNJnIDEPUv4onilFioA1+gJiZH9yszb8Vwy50ujbK8hNuRP/aSbadmfoIWW8y
	RMj7+IljLk503OOPqxBKvXzwADXq/HbXV+gTd16n7pRHow5QPKM3DzYW02d3GEXCJbE91Q7tkCS
	y3Au9jIk4YJNZ/RHSJ1UaTlN9hrcSCYLxKVKOITj+6R9bG9ldX7ngL0d1D3elDVnEdPHodbYCYq
	/mNI0XZS5dB6kGspsdWwumIpAzQ9ZOH3lWan3FHCRZyjpstJ0xfDe86btXRJW5qVurLw8lNHKKs
	HGnzt2IvLXCrCne7C1PcRg5+MAwHGiB/37N+pk8ZeZDAs9WLxMmN5iAT3Lf0KC07snfLjTHJJNK
	hruXtCDos3DpugYQHlE93ZnSz1IKr5cQgETmXC0gejPYxGorDMVP7XxSscsvCSS7UufZxS5UBq/
	a0FAi+ihBOjiQfR3Ul8gockszPRihWRaTeKPO74llqSF70WtXdLQ==
X-Received: by 2002:a17:902:f54e:b0:2aa:f798:8c7f with SMTP id d9443c01a7336-2ad50fe0da1mr59033605ad.54.1771521254568;
        Thu, 19 Feb 2026 09:14:14 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:13 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 14/15] Bluetooth: hci_qca: Fix the teardown problem for real
Date: Fri, 20 Feb 2026 02:13:09 +0900
Message-Id: <20260219171310.118170-15-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217480-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BD6D1611A8
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit e0d3da982c96aeddc1bbf1cf9469dbb9ebdca657 ]

While discussing solutions for the teardown problem which results from
circular dependencies between timers and workqueues, where timers schedule
work from their timer callback and workqueues arm the timers from work
items, it was discovered that the recent fix to the QCA code is incorrect.

That commit fixes the obvious problem of using del_timer() instead of
del_timer_sync() and reorders the teardown calls to

   destroy_workqueue(wq);
   del_timer_sync(t);

This makes it less likely to explode, but it's still broken:

   destroy_workqueue(wq);
   /* After this point @wq cannot be touched anymore */

   ---> timer expires
         queue_work(wq) <---- Results in a NULL pointer dereference
			      deep in the work queue core code.
   del_timer_sync(t);

Use the new timer_shutdown_sync() function to ensure that the timers are
disarmed, no timer callbacks are running and the timers cannot be armed
again. This restores the original teardown sequence:

   timer_shutdown_sync(t);
   destroy_workqueue(wq);

which is now correct because the timer core silently ignores potential
rearming attempts which can happen when destroy_workqueue() drains pending
work before mopping up the workqueue.

Fixes: 72ef98445aca ("Bluetooth: hci_qca: Use del_timer_sync() before freeing")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/all/87iljhsftt.ffs@tglx
Link: https://lore.kernel.org/r/20221123201625.435907114@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 66f416f59a8d..204ba1de624d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -710,9 +710,15 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
+	/*
+	 * Shut the timers down so they can't be rearmed when
+	 * destroy_workqueue() drains pending work which in turn might try
+	 * to arm a timer.  After shutdown rearm attempts are silently
+	 * ignored by the timer core code.
+	 */
+	timer_shutdown_sync(&qca->tx_idle_timer);
+	timer_shutdown_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
-	del_timer_sync(&qca->tx_idle_timer);
-	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu = NULL;
 
 	kfree_skb(qca->rx_skb);
--

