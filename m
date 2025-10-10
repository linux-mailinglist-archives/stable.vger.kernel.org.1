Return-Path: <stable+bounces-184020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF34BCDB8B
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8922B3B8E70
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42562FB989;
	Fri, 10 Oct 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAsA5XFC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74A2FB62C
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108640; cv=none; b=cJAqVyEUPBkhg6DbOEebhBajE4/1SRFz+bi619xWxMQMOVICRHqluigFhlFKASRBj0q9vVnkaOFmu5jWwSaU0kyeLWtGqTtNlZ9lLPmW3iNoe5uorAefAqvzJuWJwUrihEP8QhcTtEgETk2gDcESuC82aszdQMLN5WgoWSvBRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108640; c=relaxed/simple;
	bh=wtM3KGXEQuicJ8O+1w9NeLqs1Q3c/AYVobYXG6O4xkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Crm69TFVHRszOXRaoSpbl6r0ukYNmIQrGQkngvdbsqAnTzFqcxp3PEneeWUtJPQMywFk5w8yj+jcm7tRuNlukQ0XX01MLd/kSkV/h1boaB5Qpf7XNBDxDWHV3K8+8ROBNRFp6pdm1/mhoQdAJnYYNQQu5MG7LAi5aq2d+nwDPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAsA5XFC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-796f9a8a088so1954704b3a.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108638; x=1760713438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=mAsA5XFCTxYVzysL5NVpD1wZXp+XChV0uF2ldflFpa+zYSSukIxbSNlJ0La6Ye0GQ6
         8pti4wD1xjGtiAKABlc4OBOCYVFPGcXrk0TUIYYRSmy0nTmziep8oDRwAgCogmIiGDpr
         kmYX8NHduTUiv2YbDSCg93l8rPIhtjUS/SbW4X/fOz6KQyMSyDvEozgOM6o4qshmoT5h
         VZUfng6v+E5oN+UJT1ywO5764iWQq5NeG1e391o0r/1Kc4Df4L4n2/sZALKMnGUtfhf8
         VcpjtZz1sW6jIQCoryQs8RQ1/5uA1Wk/ZaGBygN0y7D/2+aR0lWOTuahdah7MyCyFjVm
         lKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108638; x=1760713438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=j5kT/1HfH5DjPySW9EkQ4k8pIdg+jPtVuV5NcpGdEj0QkgtVRVYIcjCfJpaEIgmvu5
         SyUlazXm8FfzTtrvlHUPo0AOg27dFdQfPHwxHEa0+2J6mu8nLuyr6rd9VHKwiucESTro
         Kq/D6A5Tfra0Mm+Wkkaup30/dPLtG4d6AOSVddg9b9w/9UKpvAnaLNNlpRAlcoyLIkKi
         /nFyFvlY/7AMJw/B9TsMyOcdsKfIUzqU9NzwKe2hb9o8CLG+ZggKPBTs83MmX87ZIERt
         skWh++2dwNaeIHGJeQfoaCiSoxfkmlAGOte7TxA3BVC8FaK8v63pIEH24sKJIzUqk4YD
         jpNA==
X-Gm-Message-State: AOJu0YxnS0AcFpKiNeHgVwsxzso3bLuAD01c50NMNi1nex48yVWGIoUT
	CdMkOKM0S179GqDc1QfVRZjcDPtLMQfy6d2PKStSW3i2h2XWxWaYNjSY9C2Wwua+NRBW2Q==
X-Gm-Gg: ASbGnct55YOJpR6LtA8DMbnUMJXRniRmCn+k2kWKavsssPlC5reTs1R5/4lYkIOoxBc
	PdC8Yq9BmI7ulpA8iCPxkWw6GbT9fQYSdpBN4JJxUfxuDRqUyq1BfZ61h50uE7LxjmDpa12O69A
	6Swm+0bBCusm6Jjv6GkA9k7doosroitX5/GxLG/RZZYos1kWU7jzcM9/zitk6jz3Glt0+GKCTfa
	+7fqvzUGBOaFdwLYZg5HnS7c1vL+4vEvsmBvlNX3tICq6Lwcg33olirjWUpZ1yYHxIEXJ5W1yPK
	0RKDXQ955N3W23JzggkkgwxuOPcNBrumt/8Jmzj0SZHOzaaibX1BWnEXQ6nej/cxcoeXJSnXrCo
	wxH4+4rz+DcYFoYtujt/CjNz8l99V//THpiGPcz+PhuJV0IAv46ldNmFiglsywhORtGUGDtvP/L
	PlAOM=
X-Google-Smtp-Source: AGHT+IFXN/diK2DPzXd7rBmdO25/OaDRNzyiRkMUMQPIXVhrYKhY4WRAMZUZSE4jYyFbxCO9D8yEqw==
X-Received: by 2002:a05:6a20:2451:b0:24a:b9e:4a6c with SMTP id adf61e73a8af0-32da845e56amr16399655637.44.1760108637682;
        Fri, 10 Oct 2025 08:03:57 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:57 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 12/12] Bluetooth: hci_qca: Fix the teardown problem for real
Date: Sat, 11 Oct 2025 00:02:52 +0900
Message-Id: <20251010150252.1115788-13-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

