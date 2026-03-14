Return-Path: <stable+bounces-225434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG2aOrqUtWnL2AAAu9opvQ
	(envelope-from <stable+bounces-225434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 18:02:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1B28E092
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD10E3026C12
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254002F3C26;
	Sat, 14 Mar 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7VVccyg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387E22332E
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507733; cv=none; b=Buv8+BnQEFazeeEK95uSPzLu8GsaxQIA1EtEcbyxVkJMBDhwok5cgHjlDREPyjGV6LOrFoK3AfRujcZQU2R0LEoBdNme/xuN3HT7Z7yPShBOezhlPCLUGuka7FM3yIYmZzBSciGiRzrrpJSwZnychc8++7FwwtdM/NKiIOoFv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507733; c=relaxed/simple;
	bh=pKI3AjG1lVa23KqAUrCKI+IQe27+GwOawv6PKd+Q5N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvBJGkGIS0RZsNnHc9yJQhvnF8IqO36JRQWR14gGRKtk7EoGuruBEXesCKjzRTLS7o+E8a6R5GCEzqZQyx1+91uJ5TtDmhOr7VyYpS0H5f4sJZcas/PePn0dVnaKWNgC7oFv5gt7fOMl7LoJ/0Tzh1+WMMyxeuXPk3Q69UjYmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7VVccyg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74c1157a4so3258807a34.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773507732; x=1774112532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LM37OfuWQSqpQhEds9aiEp1hWY724n1ZIFNOigUMwNc=;
        b=i7VVccygtZxgq2bgLlL76PB0wDdamDGgBdxs4KqrxF1eVFsTIvA5WtutoQbizVkIyF
         ew40h3CK/+NlCOO0Yomn1y27ADax2y6MvXIz9bwqipPuSTgDxZj7htRkpAYW7MzVZq2Y
         SpwR7Nj7Xi9mC2ywStEpaueocA6vkwHXsX+nEJyYXtBxpuJJQ/53Qt0JYV2MQtJ0JrWL
         kCBJor4bonrpD2PioOy9QSiq+rEyoZDTGS/BUjkOG43SdCpARWQEsZP1jVvSNTLdwt1n
         3CNz31odthFpPVdR79rFP3H6bAEp/uGKkpeQ/43STCi92/iuoAyfjX3g9iM9nu6Qg8cp
         Ygfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507732; x=1774112532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM37OfuWQSqpQhEds9aiEp1hWY724n1ZIFNOigUMwNc=;
        b=U4P3W0Q3fJWL7bRkPd037owitWqVmGCSZQA8smdpQ/l6ALtkvUgP3zlUN7gQ5K/emR
         Nl2rsaUif0TMfqTDiXX2JTPG3Xlpx2654YzE/HlxvpN41Q1+rwgoJiGUPI3aRdlT7ZL/
         Q37NDChOfRPtOSOKLE9cn73wBcc6TuKi6efUGeOX1ZqAiLHghDVQjndqiMQLGOl/i6Bw
         AQA+NibCGhVK9VjScANtyfrKAP1Tvn2OMuIW0vinzzjXA0Fi9U8mSKEVI8KshZtP8SJK
         N7NP95G/6MuRi7ldchvvLq2m5Bq29I10/rhkY2tsfk3jMiRyIaKOcH3bhxI2U4md7B4X
         H3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX4lxg85F+DlN1YHAv2YrpvZFWhrbuy+lDyA/iQXEMyKKVkZxZHDlqpoCN4PKySEa4OyjryrCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zV7POCrBuhQlfsnZe9SWrO0X8BA9KMKdVl3BIEW7K98bGjT4
	8N2WqFQ00wDDvRr+AugL72nPJu0ad3ODV95bFwqHS7+OCLMySMmgUevl
X-Gm-Gg: ATEYQzwNg81Q/zO/mysQqaRM4g1hvflIyqkhRWVpO6q3LLd2MENmaygHBtHBcEg4Kf/
	Iz7AhvlMH0ce+HSs5TnHqCPHViC8OB/CndpRgxDBMyVPZar7xlztLe4q9nt8rujzv1ZucwBnvev
	vjNtbPpQRb0rwYuo5tKq5NIa6HES8O+97tMNRxUJq5d9lCBMXryBIEeQl/bbeoWJUNsWD2+/02j
	qg0eSL1eL6sXo+8FFlQtnyZZYai27BRefxLcH/AMs0W4ETkO5sC9jG+4KLVzIdUBkorrZvM7ym+
	BTgJ0XmSlflxuyfVZNviD9EVzNs/vUbCNya3PpKxvnLhh+9ZrsmS4KvaistnMIzRZwTRRiq+Dqo
	TogsdhrJCnyz+mCad0XceHrqAnRGfHcRl9Mdar7/ZE0yVni6GMA+tHLbWyYC7dRwVjoL0VQ8k1a
	jJJydNZEYI0MAdDIj6FLzed75vNy2HsWo19u3ZgMtJ4jfX987YU5/1wEJHgK2Pqc+C84HsowkA5
	oKi
X-Received: by 2002:a05:6830:6607:b0:7d7:3937:97bb with SMTP id 46e09a7af769-7d78245c4famr5186888a34.9.1773507731706;
        Sat, 14 Mar 2026 10:02:11 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e2a17f1sm11610430fac.8.2026.03.14.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:02:11 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: tyreld@linux.ibm.com
Cc: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	brking@linux.vnet.ibm.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] scsi: ibmvfc: fix OOB access in ibmvfc_discover_targets_done()
Date: Sat, 14 Mar 2026 12:01:50 -0500
Message-ID: <20260314170151.548614-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,oracle.com,linux.vnet.ibm.com,vger.kernel.org,gmail.com,northwestern.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225434-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5CC1B28E092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malicious or compromised VIO server can return a num_written value in
the discover targets MAD response that exceeds max_targets. This value
is stored directly in vhost->num_targets without validation, and is then
used as the loop bound in ibmvfc_alloc_targets() to index into disc_buf[],
which is only allocated for max_targets entries. Indices at or beyond
max_targets access kernel memory outside the DMA-coherent allocation.
The out-of-bounds data is subsequently embedded in Implicit Logout and
PLOGI MADs that are sent back to the VIO server, leaking kernel memory.

Fix by clamping num_written to max_targets before storing it.

Fixes: 072b91f9c651 ("[SCSI] ibmvfc: IBM Power Virtual Fibre Channel Adapter Client Driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index a20fce04fe79..3dd2adda195e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -4966,7 +4966,8 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
 		ibmvfc_dbg(vhost, "Discover Targets succeeded\n");
-		vhost->num_targets = be32_to_cpu(rsp->num_written);
+		vhost->num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
+					   max_targets);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_ALLOC_TGTS);
 		break;
 	case IBMVFC_MAD_FAILED:
-- 
2.43.0


