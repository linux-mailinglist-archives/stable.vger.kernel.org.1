Return-Path: <stable+bounces-272349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b/1lGDWUTGoQmgEAu9opvQ
	(envelope-from <stable+bounces-272349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 07:52:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B70547179C7
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 07:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=bOYvrGyz;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272349-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272349-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D0B130409E3
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51C38735E;
	Tue,  7 Jul 2026 05:46:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00A318EE1
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 05:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403207; cv=none; b=phd0MNYKNUhbB1Bd4p8E6p1E+VmDm7Xd8llXwXG1Q/751yJDnEmR0h5INM8T97Q7yQxqErzK69oivEvAMYn3fbDknDqFV+hhnyT59WbbzqdBw0qIbzwqfpJrVHHAVZU3V70fU6ytfRF5kgUdRandIeGmCjtGmuwxyRxe6SkqIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403207; c=relaxed/simple;
	bh=v1M232dO9X7uVE5dOP26dl0Q353P0zYi1E7BcK+8eiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHu8zSFqjHnfpwhtfJKgN367HIi6MB6KyJ+HT/11oLY1mPQ544zgjtk4vP2d0qhd/docj9jkM7D/hSNf1jQS0xDRJCheLOgoUEJTMvxroPmhJnveCVopsFvOY6d/iQb9EjqZHfryx9mx6+D1ZF0C4MLeyX8BcCaSaurbyKj9imM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bOYvrGyz; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso16586815ad.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 22:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783403203; x=1784008003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4L7gYHZDRtRjX7hFao4DIYHrV+U5n/xFwuS3PyRV14=;
        b=bOYvrGyzZgle/Swf3SsVSLJnb5duYr8FYlYLt4ERI+3Ay0n7EhUTQerwbUZ+plrXql
         iBKEeuPwK41yHiZDUlN9PPHUHXTu6t/tegrn2XMvXVijESIad6/1Ka7EMrhdn+e51O/D
         b3kk4qMfpYkC0gVaBdNqohxvxFuI7Vp7gIjf+k0vB3eiclD5GGb1SnruNeU8QmjYt9Lt
         B2c6u+wGuFik4h3ASvzNL7ZTm7v/aXRm8rcQjohQKUoNPcH3lzy0w6PNv/pcFQEfNt0V
         wCFmQSopJzilB2O70VRyjUqJMFN3FNhHNjWrM0gSnoONlZaSBGCECnpPtGiqML1KYseh
         75jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783403203; x=1784008003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4L7gYHZDRtRjX7hFao4DIYHrV+U5n/xFwuS3PyRV14=;
        b=bjZ7UWdJczBVn/0awaBIWYBAXUg/Qn62ouACvq9D0FEoW3mLF8JAfQkeAFNAv0hzPY
         RrE8XAugEiyP5z90ChMHo02y9H+PoI0huDpLEOnHyll/FhVDnwi/h/m3Xi0vrr5YGQbV
         3V63ZPrA8zPdIg2+bHhnw4gnaNxXxIPjNn5P1YqrZZBJQ2UoTi5JzwUhb5nOyjlHWJOC
         bY5/9Bcziva/ZXID5CFnuyVbjpAjzMLx8pKsV7ChytcjIE3fJ1TLgOWHMxuo6ne1FTDg
         84m2Ik1IYt6rClm7V53dehcz1pWSl2b6Wr7xWOn5Gv6hxwwuwPN5iV7mROXQ5gGG/2g2
         N+bg==
X-Forwarded-Encrypted: i=1; AHgh+Rogei7+8XuSWN44xSRNPfePQrXvGiuGiEMJw4X19EvgUWVh1WTZRx4WoOQ+vzlnrfitPVZStFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmxoW4J8GB72dsh53D9w4WrOF58Lfg+tEHBthIb9GR8uNuGVW+
	KoggmZ/G0Qassw3cUFoo6ytiu83F/fcMHduAW791SX3Mms8yLpgqSCgJxFy7Rnq3DW8=
X-Gm-Gg: AfdE7cksQhF/3EipvNxXTTlYrLs9y+RFrwu4fciEu/wfnvjIUL39A0hpuYQnaOvC2ui
	hNRy3bJFOSYoyy9LMbnN1y2Dj2yChdysQ4N6oHfXQeCm7i9ICELY7HCnRiQwNJRSUyWYWm1MNl9
	tj1YlglA6MNNZXwTKYvyBjA6YiKX/xaKp9s9b6VVcNcWhffLlKo/JjGu6aYVB+Y+WKLwPv9YoFc
	uoLdpnu/Wb2fw7z4FB5MNmFxc696Rw1z/LN08sE+QGsX8CgS0E2CmBjHHQiyF4rBvcj2Y5G5GYo
	+TZA6oT3675iwledMtiyRGWKkZmaLv5BYiDKtZ06YA/XEJiWq1Pber6VYzdzZoJjGE0TbAjjJSv
	kQBd7smDKkOokrQne6RyLAc8tT7RU8ZrlOidKCC143Ce6R2RrJQCk3cDku1jotfiSDLedaWiak+
	3MtbQcPDWl5zLObfFMMFSSA7EIgSJFcaby8htzI24WR/54Ljlb7bX+r9PeRspH2M8xeYFHyvOSR
	QSXhLel9VRkLQo3f3yT84SygslWNr9Wiyg4Nb+reyI=
X-Received: by 2002:a17:903:288:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2ccbeb17e6dmr35870015ad.17.1783403202764;
        Mon, 06 Jul 2026 22:46:42 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc1fsm5320255ad.55.2026.07.06.22.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:46:42 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: skalluru@marvell.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v2 net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
Date: Tue,  7 Jul 2026 11:16:16 +0530
Message-ID: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272349-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:maciej.fijalkowski@intel.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime,intel.com:email,iitm.ac.in:email,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B70547179C7

In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
may be called with bp->fp uninitialized. And so, there could be a null
pointer dereference in bnx2x_free_mem_bp(). Fix that by initializing the
fp_array_size after the bp->fp pointer is correctly initialized.

Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.
Thanks to Simon Horman for pointing out the Sashiko review.

v1->v2:
- Add the correct Reported-by tag for Sashiko as suggested by Maciej
  Fijalkowski. Also added Maciej's Reviewed-by tag.
- Simplify the fix by initializing the fp_array_size later, as suggested
  by Paolo Abeni.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260701065030.381836-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..5a9742fd3ddf 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4742,13 +4742,13 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 
 	/* fp array: RSS plus CNIC related L2 queues */
 	fp_array_size = BNX2X_MAX_RSS_COUNT(bp) + CNIC_SUPPORT(bp);
-	bp->fp_array_size = fp_array_size;
-	BNX2X_DEV_INFO("fp_array_size %d\n", bp->fp_array_size);
-
-	fp = kzalloc_objs(*fp, bp->fp_array_size);
+	BNX2X_DEV_INFO("fp_array_size %d\n", fp_array_size);
+	fp = kzalloc_objs(*fp, fp_array_size);
 	if (!fp)
 		goto alloc_err;
 	bp->fp = fp;
+	bp->fp_array_size = fp_array_size;
+
 	for (i = 0; i < bp->fp_array_size; i++) {
 		fp[i].tpa_info =
 			kzalloc_objs(struct bnx2x_agg_info,
-- 
2.43.0


