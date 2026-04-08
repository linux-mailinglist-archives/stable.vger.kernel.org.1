Return-Path: <stable+bounces-233937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFNIIet91mk0FwgAu9opvQ
	(envelope-from <stable+bounces-233937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDAC3BEB5C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E957A3010DB2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23234A3C1;
	Wed,  8 Apr 2026 16:09:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66318347FD1;
	Wed,  8 Apr 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664565; cv=none; b=mkdN3hua2MfgbqzhonWrl4PYcVOf24kqu19pjSLI7W6wkgOh+Z3niGk1gRW2BdUTMKdpRog9EjQNp4u5Zrg7vgEeI4twhwGUiSTGJMTIOaQ4vUfExQeDnK87AxpnAnDTrT3T9FW/pRLwux60/VOTrx4Xl6Je/iLZ885368QFYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664565; c=relaxed/simple;
	bh=MRTBTcUxuUL261/8JRtWYsWtc4LCfGGZgJoAnxCV6AY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=amJ29wCCiGARPnS8H1EoczPaWm7/vZJQSYpi8g5AsjDg6LqIrNN63c01DsyofDorj7I+zK1cF2Zf6rYrOFvjKv2X+QFnmU1tr3anxrbgTu9lWs2mceRidcVViJ/hAkwqvpnsQKN6roZcdolDFotD2JQAy6OEuft8Xumg2iPn4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from nixos.omp.ru (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 8 Apr 2026
 18:54:06 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: <jens.wiklander@linaro.org>, <op-tee@lists.trustedfirmware.org>
CC: <sumit.garg@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <s.shtylyov@auroraos.dev>, Georgiy Osokin
	<g.osokin@auroraos.dev>, <stable@vger.kernel.org>
Subject: [PATCH] tee: shm: fix shm leak in register_shm_helper()
Date: Wed, 8 Apr 2026 18:52:03 +0300
Message-ID: <20260408155203.817744-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[auroraos.dev : SPF not aligned (relaxed), No valid DKIM,quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233937-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[g.osokin@auroraos.dev,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FDAC3BEB5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

register_shm_helper() allocates shm before calling
iov_iter_npages(). If iov_iter_npages() returns 0, the function
jumps to err_ctx_put and leaks shm.

This can be triggered by TEE_IOC_SHM_REGISTER with
struct tee_ioctl_shm_register_data where length is 0.

Jump to err_free_shm instead.

Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index e9ea9f80cfd9..6742b3579c86 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -435,7 +435,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	num_pages = iov_iter_npages(iter, INT_MAX);
 	if (!num_pages) {
 		ret = ERR_PTR(-ENOMEM);
-		goto err_ctx_put;
+		goto err_free_shm;
 	}
 
 	shm->pages = kzalloc_objs(*shm->pages, num_pages);
-- 
2.50.1


