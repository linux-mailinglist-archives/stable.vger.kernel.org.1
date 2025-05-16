Return-Path: <stable+bounces-144569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEFAB93B3
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 03:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8566C3A5D3F
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C742222A3;
	Fri, 16 May 2025 01:36:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A8216602;
	Fri, 16 May 2025 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359394; cv=none; b=M1khtzSc4+Ad5Q0bEniF3EvNZ3YXWLC/0V4ewVJ0HFt4RLHaR6QfQoOcqtkHw8Qu412Dn3rZ75ocXXYZUjGopkbFNQYlU9Nd83pM/HuT1nBmz0h6RbDX5Lfr3W49yO5zxMq3+OoeSo4KfwKWFkTiW5Enz1mNBb0jaLFM1k8IAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359394; c=relaxed/simple;
	bh=sCkbU3RMh/bIIjYBcK3nrAk4RNNwNoNK1Yd3IBGCQqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=op5zx/sqBncooQeslBGA1BWbZq2YUz0fM9qvSUPs/HZSZ+mYXYXfBdfDeD2+GJ2IPKO5PHEshyEYGGsy51E0TCN2+/ae2jK7I2i05nOifbudbJC9To3MfnY2yFy5Sq/pf9hxh26D8awM/IOMNm7xyn1RG1FGQC+3G7LTzn8Q73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACn4wuLliZo4bJOFg--.63396S2;
	Fri, 16 May 2025 09:36:16 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ste3ls@gmail.com
Cc: hayeswang@realtek.com,
	dianders@chromium.org,
	gmazyland@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] r8152: Add wake up function for RTL8153
Date: Fri, 16 May 2025 09:35:52 +0800
Message-ID: <20250516013552.798-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn4wuLliZo4bJOFg--.63396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4UGr1UWw1xGFy3XryUtrb_yoW8Jryfpa
	y09rsFy348XFy0ga1UCr1IvrW3G398KryDGFWku34kuw4DZwn5Gw18trW0qa4vkrWkWF43
	tFWkAFsxAwn8CrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkEA2gmkZUYnwAAsE

In rtl8153_runtime_enable(), the runtime enable/disable logic for RTL8153
devices was incomplete, missing r8153_queue_wake() to enable or disable
the automatic wake-up function. A proper implementation can be found in
rtl8156_runtime_enable().

Add r8153_queue_wake(tp, true) if enable flag is set true, and add
r8153_queue_wake(tp, false) otherwise.

Fixes: 02552754a7ac ("r8152: adjust rtl8153_runtime_enable function")
Cc: stable@vger.kernel.org # v4.13
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..cb708b79a7af 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4004,10 +4004,12 @@ static void rtl_runtime_suspend_enable(struct r8152 *tp, bool enable)
 static void rtl8153_runtime_enable(struct r8152 *tp, bool enable)
 {
 	if (enable) {
+		r8153_queue_wake(tp, true);
 		r8153_u1u2en(tp, false);
 		r8153_u2p3en(tp, false);
 		rtl_runtime_suspend_enable(tp, true);
 	} else {
+		r8153_queue_wake(tp, false);
 		rtl_runtime_suspend_enable(tp, false);
 
 		switch (tp->version) {
-- 
2.42.0.windows.2


