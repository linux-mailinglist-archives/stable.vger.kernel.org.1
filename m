Return-Path: <stable+bounces-217804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ5tIX2NnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:25:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF5817AC2A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8AED30427F2
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496833123E;
	Mon, 23 Feb 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="hCwTYxPo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B733121C
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867458; cv=none; b=U5VdMWiO2LbqWebvYBP/fWLTSqXAHtohdvBuAscXPC5fkp3FgHtfrO25Q759Ote6UBFhYnE5Kl8h8AOV5dpWevils9v6lMj+Hn6GY2duA4gBq+2uj0WHqOxMoKTwAyvFhwPgjPuvnbEFeW0Xs4ZFuV4Q/zha3G4taKozHO9wTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867458; c=relaxed/simple;
	bh=Efzx66bRigpP2u+X3GHlHWuzfR2ABiVPc991fIPA9kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcOVHClcsUdu6HHZBiGRjALor2GWwUsc3Gb8dxNloRRcqY7snxYmE28NdchY6MoBoMjqpZ+X5WB0/SzJX5ls59dapTQ6jLs/YWCf20MpYmSOO717YN78tcOIo2LDhEjzXvPYy68CsuSPGBir0wOzDm2M/Y+Na2eA8kzIM7xewaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=hCwTYxPo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso1918606a12.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867457; x=1772472257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNHyGNAyEqFR3uHLeuiUimMy9GKVCPy3eo7HwiOI0Rs=;
        b=hCwTYxPowag1s53MVwsMiu5M5sb4GbCw/PtfxUwRMEOF2c4n/NY79v+SSDasyXdqk8
         cJ4JB/ZL7g7HmPia+T0xF9bfffbJTNOiPMzf+gZVEPF2hBi+IiooNl2YUVLtjMCVEiEB
         AzYd3NYBLXBB4ouBAt83cy910CunryqJ4CI8FROejyZFrtudWQrZMTnNYD5lRNI703Zg
         +lPz1cA781XZRu8mibMhUx1ujjHgXXy9MfnQd0ola4JZqfUjPkyakvjubX91aQezrhxp
         qbeWcfgoHvTZwTyo1Y+1nbmD9ymmQUU47Eku4odgdC42RYg5UOs4GVGXUQRusChmYhsG
         YUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867457; x=1772472257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNHyGNAyEqFR3uHLeuiUimMy9GKVCPy3eo7HwiOI0Rs=;
        b=KtKdS7pTlsM3Se1cskmq5/mFLadeLg1SidH49XNYk7kHqEW6x5bsWjwxR7QO/sq3mp
         N8qBvj4CwK4iAitm1M8+KO/0pGUJ2vqS8lNPSEzkGwFv6N64Q53wrRAi5ZoYcXJli3JA
         lm6mjlZr217qUWLNdhhf6MtCgREuth2kzp5vi8D9quaqu1L5IY4v7N0ApURcWz2aE81W
         WxyPx5U8GL3r12rkJbPnt7g1Y1SQKWfGMg1J5kmVR5FWF/PqbsGX96uXTPX3cxnH2rHT
         Ycfgjr+qT+/+C8X26sUrZwkc9COJhcX9akHfLVjVPHD3/iqA7HhoxGHhlAKysblf+dDs
         w3Pw==
X-Gm-Message-State: AOJu0YwwmCeyofXuiaLPIY4S17Dhf225Nw+KZGEomtvD9U20tMfUfhsX
	fdbtVa8wLupjxBBzTbnxxvEjuzSdb50ZAwglP2VTGN5qvdZHQHIYXMc0XeX1cbJxwRsnPeymrF6
	hcbtA
X-Gm-Gg: AZuq6aKQqgCCNy+ofUvzvo/yGOyM0HOWs0VdZqZCfgdm+XmnwI6WpsM6BQWetUT5aQP
	T15bJo1UyqAdsqtBoU2DoaTHr2YfFs3jqUWhmVRcyLdE9tkh6ryh9c3vWsc1GIIvlDsQmWz1mac
	AN2/tj2TIrDF5bTRqMS13xpwZ5h4Do/5idiTaZdeEppdbPYZyPTQFfIy5hQCUcU9eCxf4XA3N+9
	/R5dk0J8PEwTA4Eja06GoKHq0Jedo1+W+k4H5Ejr3h3CXAha8pHebf5ZbRaOZZIoToZGA0lc8cw
	wAO9lL4jIEsLyfZkAvsHlQMNKvJO5DHqxurA5fjJyT/dDfh1RKqe83b6tTjdrZk9w/W9UBFSbeZ
	lFFmzTZtQg/YaF+ifZkgCNvuWlMOwSAKfavY1PSiUDsZ+0p05Ktl8GQsljdhmInSL8oVdWGpdRq
	Q96LPvndhicfrX7B0bqQJalBoixqcOwoQ=
X-Received: by 2002:a05:6a20:d43:b0:393:5fcd:cec5 with SMTP id adf61e73a8af0-39545f7b08emr6929576637.58.1771867456515;
        Mon, 23 Feb 2026 09:24:16 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm7802332a12.16.2026.02.23.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:24:16 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 6.1.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:54:04 +0530
Message-Id: <20260223172405.292040-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172405.292040-1-jsingh@cloudlinux.com>
References: <20260223172405.292040-1-jsingh@cloudlinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217804-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim,cloudlinux.com:email]
X-Rspamd-Queue-Id: 1FF5817AC2A
X-Rspamd-Action: no action

This reverts commit 3d81beae4753db3b3dc5b70dc300d4036e0d9cb8.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 63bef22095b4..9b5976c80803 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3264,6 +3264,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3334,7 +3335,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


