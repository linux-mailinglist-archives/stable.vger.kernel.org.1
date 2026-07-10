Return-Path: <stable+bounces-273150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9gAHWKLUGp01AIAu9opvQ
	(envelope-from <stable+bounces-273150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:04:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD793737814
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b="Kix/aeOo";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273150-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273150-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D72730180AF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00583A9879;
	Fri, 10 Jul 2026 06:03:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6C23392B
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 06:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663424; cv=none; b=OXmYPhNstQw177xoIN8O2PKbaR0nAtNiXH/3jS9EZtmhvPafqVFmDvGc+cuXXEz68gqCxvj/Mzrk8u/nzsX8tRrUNTb65wVvgpB2TJCG0/rl2ek79ZUDI6yRiW0YO1R4scBzVLxvZoZDIJmUGv4So9HAYqDaoPAlmUwng1shuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663424; c=relaxed/simple;
	bh=KhHHDAOTYZr9t13gx4YVukpxiVCL7JTAw3NnwbpE0jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVbMzRdIzenGqEa53pC/i2sLdcr7t5zeKFXFo02IaalRkSNCzqQGDfT1NK7ttpE+RnHDAGpm7Yuxc82S6dg6cn7Hv2yVdVnRfMWnLy9U4+YfY6y9a2A8O2SosDe5HXtRsotqDLTEu5mFzRcVd83UbM41WJQcyCdPTVBVmhYEcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Kix/aeOo; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so496253a91.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783663422; x=1784268222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YslU2XdAYfGanbbwAxmZPfELhZDR7H4hE15o+cNrNs4=;
        b=Kix/aeOo3J4kczTOWiOGZbJUnF2YX1qdHLdUYhnJU0L0kadpaF5D+OFCBxDTcpxFsI
         66JV9A1DXaYB7PED4qNf+GKBkYJ/jef+kMm0sBuGnA13yui97XVRiRytz/5JWZdE8pdZ
         uRN/wQRgSs0mr7bnmsifR6QqArFAxjBz/h2yzC/5uIWsHvozl25XNjI0AkQU4YGG5EQJ
         XZctxlLYju6c19t8Fx8Xsjr1oLO//leEwU4vjmjydLnjCjCjaK5q0Jprr8oijrLBTh6H
         nclBtCrKB1jzb7tfmGYiRG2Edh8cGUoD0Clc7V5F/FqF+ZgAKKm0NWaUclKfq9Pnpnen
         f9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663422; x=1784268222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YslU2XdAYfGanbbwAxmZPfELhZDR7H4hE15o+cNrNs4=;
        b=D3bIQMy8DhutgzauvllqQ93fA0HQeRrw3yt5nTLnblOvOb/jAO/usYkREBQFT0Engj
         Mkso8B4I19377eE/z+Inn0zML3gYWgmTlkEPeKCmJMTYz+xgqaIM+hLwM9ACBmb3jon8
         2BTgINLYUJZjGo1fEAcRBiMScEYUIUzO2ItbtvvfmE163Tmk70yOnYaIRAkapHOmVNw0
         5G39TIk0ER9qq15T1b1dhhBe5G8jc+5Wtr46oVIod4hhfgn0w1HeGbLvNjSKnb/eqyoc
         /cilqt/C39Mx59uMdp6OYMHA/T1aozr/2cNKBgmA9dQgcPyR10PgVPoeh0j69nfDFkZF
         yPVQ==
X-Forwarded-Encrypted: i=1; AHgh+RppFeyf+bfApn1vo17um0SYONb4W0Cz7p5GE/Wi/Z4Ymewl55f460DduRrJcjOThu/2LHrdUIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfqIExEDPZEif/BzOjZwfIM2hzcJGIBEhBTbI+ZNZRtebnWHW
	JTRUFOgdbD2KcGuboPbwJmrpVoLUZUgWbtKzJL/DPI1wC1U/a5jmhYXwRSAeQVhb1ao=
X-Gm-Gg: AfdE7clD2Nfsh4OQrW8r8EMEJ2NmSs9daOnYs6DHpbbP6PqkYhtteHGWvFEQ1adZQv9
	nGeNepmLINMEh+zrk5STSFDm9sX5nC/LnH4s4VAqme+9YFSm/LmhLG0EsH4HrnANOsT1ydbjEIb
	ZtgXvTuLC8uA2c4MYgu/B3pdfrol5LntTDb//a/c9oimUZqdnStEAPO2b2iMsi7141Uj+D33HbF
	uL1kdD9oqvHECyv1G1KZQqJ3Dcf0VNPsaixNvGg/uceazdCL7/P3YIasUDuzJYK3qBmGhIBPtrj
	1a4WrGp3EVj8d7P9RdKcrzQqhhtN0xNc6yrradTeglKiNeNjrd0hqIvq3MQhC0IP2X1aVWSs0bs
	qAO6FpfKI2yDZk+Wi3e0rwlKd1OelSDkwCNyDbc+St7xaa2+Si76cyQKgb87XODbYwgnR7DYp3E
	qZq+5b9xlCM88i/AJ0VJX7bwkJLUQNbN5DyvTaGEUe+Qi2vq+UzdxDMrAj5SBlcNdLZcVjaUdhs
	ESXNgoj6SNeJ1yUsgDv2zE1j+l2UZKZshVTf/QRIz4=
X-Received: by 2002:a05:6a21:6b01:b0:3bf:baed:c797 with SMTP id adf61e73a8af0-3c0bd0fa3d7mr12173891637.49.1783663422438;
        Thu, 09 Jul 2026 23:03:42 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm63639393c88.14.2026.07.09.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:03:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: fix memory leak in btintel_pcie_probe()
Date: Fri, 10 Jul 2026 11:33:32 +0530
Message-ID: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273150-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:marcel@holtmann.org,m:nihaal@cse.iitm.ac.in,m:luiz.dentz@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime,iitm.ac.in:email,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD793737814

The memory allocated for data->workqueue is not free in some of the
error paths. Fix that by adding the corresponding free function.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7a87549f587d..870939d8450b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2988,6 +2988,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	btintel_pcie_reset_bt(data);
 
 	destroy_workqueue(data->dump_workqueue);
+	destroy_workqueue(data->workqueue);
 
 	pci_clear_master(pdev);
 
-- 
2.43.0


