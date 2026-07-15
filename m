Return-Path: <stable+bounces-274759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2XPILE6V2oCHwEAu9opvQ
	(envelope-from <stable+bounces-274759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:45:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5675B907
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:45:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k9Zg2VcK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274759-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274759-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9526A3016B97
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28E3C3BF7;
	Wed, 15 Jul 2026 07:45:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9538423D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 07:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101508; cv=none; b=tNU/yE0U5IewL7jiIy9kmdHKX72HmATUbBWZ4o0JVDa9eGraM9FVcsjeB2J49PoF/DZC7CNucOuuD6tM3ns6OwsdLdW4TojYQA7g5HD1y9A7AUYvhzhEX1knWjJJaLAMJ/1j+2VBkyWZIt1Mp9DOW+AGMBY+P91oAGfrXwk83/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101508; c=relaxed/simple;
	bh=Gwpwp1Y/9bxWn5LSGy1sQF/CdPB+qnJ7v0kooULMYYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hz82OPDdOslCJzIrkszQTs5l5P4oH3elaRlA7OJLHekUs+nnTvE36kbS3VC0jtO/MGQuVj5pamc94EAQmuE2IYDbP3EwtzQF7URmgwY5BxRsghS4XMuE9R+xSCVxNtN8T/cPLhR3rj6W7fQ58eO2wx+z+DVFDiYsLDZBTHL8dT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9Zg2VcK; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccf2360620so15803435ad.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101507; x=1784706307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFEOc9K8ZH4WjUhqE0lhCkuF5t/lKGFy+XbxPZKCt8U=;
        b=k9Zg2VcKs+a0eO/QqYwuS+2LD09w3su0yKUNikLuzff49sdxGahEvqCtlnGWfQDJHp
         hvKfHhz0BrKNwKnO8ci4nmw16STKHtYvOVUMwRxvjwMIDaLbn38L4Sa9A3VkO1MqCgB5
         N4BQVEeUdP69YNd4IJ6Q23VRw8L5KmI1kgoXx8T2aLZdacvtlbRddWRjp/H875cqfaNH
         zq6O/KpSaCSFKJNIQ8o/X8+EEy9SxPq2AipGzVnhkoQrBZiXx7vf1pBoUvViPkIVb5ir
         Z7kJgfAI8IHYtEugV4QqKuKhLPTtXKhw72L56+gBTS892yTKU9l7TwuA4zlF6S9sV+tS
         t3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101507; x=1784706307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFEOc9K8ZH4WjUhqE0lhCkuF5t/lKGFy+XbxPZKCt8U=;
        b=cRGBZjkrlDwgqaJqTBydLdmpRQBcwOxF6rgKyexjtPmdT8Vnlgetd5TTMTFx6gE/bY
         SsxemDDsjjXOHyVTLQOwFZmV/sePWcohRJWw4Qj9SZBh8ckStPoxagoKdpLuSLVxBKh2
         bMJNXOCx5NhzQqDGp0RhKuBDFY+CdeTAkbnr5kCN4AbDmqz6fm18cIeLrGyVMRBywqHO
         QpXWBb3DHD563mNTt6xUM5MPxK2u2FhN7PdZoWT/Cg625O1e9kuRAUanEjqpSNT8j3Ua
         kUzWVlx+j06da8qGv1X06kRs8OTXCJuSldTf41WWkF8UQpf58Ice9pXXtXsuU/dVNOHX
         xFog==
X-Forwarded-Encrypted: i=1; AHgh+Rpo91TMCbqebFVYVp3REpsZywx80/DqkXXxxz8vk+gx9aE/s/8Qmdq1zqvPU8A+gQvyPeHS4Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58KqxkAgDXlzF25KywyLMPqb2dDI0ru8FIe74NN7fj/lEQgMz
	RKixDEHyiYmhdpOffLzUNQ8K222Q7nGadLALjkxtZ2c0+OAB/slOUvA=
X-Gm-Gg: AfdE7ckYRj3s/fqweGCL0lTN7QH8SXYOyFddW0d9T/PN0OmpoKVrSEoEDPgEr2JejX4
	weIFb2lbgGE/w3kX4PRoDAfmjxx9Cc7xvNc8RBysmtqEUpRHMEQIVeoeYIntDrb8fxIPXS5SItN
	U0dEnO99T95J42/5ekia9RhMiOnp09iwsiTW5RTdaSsHxwrlia8j0zsR9vMhBbvaMKq6gSbZg34
	7+sDAWvaP6HVZniJqncSGFjdm9do4d9dPnRu6P+8taWRpo/W8HLxDBIFCl1IF1zFG0aVJmGcaMn
	RFU6wNQJtcJiClJP/wiGRQmJVd6xoNF3udb3Qh2bO27Tvqif6hwl9QZzIf3nvrlVg92LTvyYPiq
	zJuuyTpuv9lJuSCay+svSthiln/aE5E1/iQmKW4Yc2bSU0/3haFIq3E6OgrXF7dErlnhRLKOzyY
	UjZl/YzPutlShNn6JPEkb+2Po3vzfE8PJv3ls/KdWLKNC1PRkEuFCwoGzyFYC220gPn84Hmb0Fw
	UXyrvEsjdilDyVqxGbq9RoJ4ekOUYCAS8dDBz48MQVA1749qg==
X-Received: by 2002:a17:902:db0b:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2ce9f028b80mr152805965ad.33.1784101506574;
        Wed, 15 Jul 2026 00:45:06 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bd33sm130345175ad.58.2026.07.15.00.45.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 00:45:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] nvme-pci: disable controller on admin queue IRQ setup failure
Date: Wed, 15 Jul 2026 16:44:59 +0900
Message-Id: <20260715074459.50760-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274759-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FC5675B907

nvme_pci_configure_admin_queue() enables the controller and then requests
the admin queue interrupt. If queue_request_irq() fails it returns without
disabling the controller, and no caller compensates: nvme_pci_enable() only
frees the IRQ vectors and calls pci_disable_device(), after which
nvme_dev_disable() treats the controller as dead and skips nvme_disable_ctrl().
The controller is left enabled (CC.EN set) on this error path.

Disable it in the failure path, while the PCI device is still enabled so the
CC.EN clear handshake completes.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: b60503ba432b ("NVMe: New driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f0c05719316..07aa9af9bc89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2221,6 +2221,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl, false);
 		return result;
 	}
 
-- 
2.47.1


