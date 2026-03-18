Return-Path: <stable+bounces-227107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JbyNtjdumk3cwIAu9opvQ
	(envelope-from <stable+bounces-227107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:16:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD262C00AE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8F8D30A2059
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8953CB2DC;
	Wed, 18 Mar 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfjCfClz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B982EF64F
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849154; cv=none; b=rBpM99RwuJ+s5GpO5U1zAWrOugjWFwhe10EIta48jmpC2dK8TCGT7PLjaqugi1fYczH1NTtC1oUOnxlHvCGgKkQ37RwGpaitA+P9tE46x9NJrgUy8Trnt8Wz+YjFQ0uORj0mMTlhJvYoy6vIYVmmuv20QCvwZN4NMr+KiT8RHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849154; c=relaxed/simple;
	bh=TV4oxLctJgNhtEqbA+524wrVBNXAvcpMJdvANV/+k9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrIFCuaIxrMCkj0Af6UQKt23FVf72sSK2sp1ku0ZsUKV3l4uBnXDn/nqtvLtMiXg8hk6G26OEdc+ovKykvx9zTYG7OQXGsjWcMID0yS6CG0x1A8r156F0aSvk2f+qsD8YRwR+unMGh02tEI3vNN7NJz3girTp4Ujuh2xmIBmsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfjCfClz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaed195901so33396255ad.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773849151; x=1774453951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqkH6mzjHCAxqSeaCcRc4i6txUHa48rXIDuskLcyMco=;
        b=TfjCfClzuWnwhZKuj6uWtF8WI/Ufr6tDyCG9/38Jah6XXZV1ee9lmsdW2nUTRaPwvf
         LYjC2cC1eDxEjyUUF9yq/TPzszaXyg3s5ga/b+ODW9k6K/OgMB1WrPQ2Vsicy/RSWvna
         omNCylTApwrayuloguDlyGNVV1/JqAiiWbqpP7keMi/dIBrQWCtUm0OXPu5ROmg2/kTT
         uU4nwmqJc4CtI8/Y0vDAT5+30/axkIjg//izTUgvwjNjjY+qbzzkqUfvMeE/CNwQLzdZ
         8fNmQQrhsPulGctRzeJlG4uH8Dz/wI22PLqTEkPoZarLOTd9lZyB2IUWdlsTZTbGCCHi
         24Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849151; x=1774453951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqkH6mzjHCAxqSeaCcRc4i6txUHa48rXIDuskLcyMco=;
        b=KpXe9rtzlp3RBgcFGI6hGhDzwX0XEuONiMAc0oIgDIDM9Gy1uuPJ3TdQI84s2JvCtF
         2eZ/i1pY9G078wXMl/iMAIzBdD1ecOElCSPQe+kpqTAn6fWFT46RTTVkuAFCRvXLWR0N
         cVZkDFtqlRAPuuku9Xea3xTnZEl0Fe/Tji70YFKIDOG/95sUxOWpbw5pLSvniU82J4Lv
         pG6rZubCpuzPDxRqCcjO8YQatVKAORuGMit/kJDB6D6AH0jWw937zD7S8EFr4FhRYRGm
         k60bgF5l798kJfYoeLoFcvTxeigaV7ER2bwNwZgC8x35QVMBbzWvohLph94hPWJlW70X
         KHYA==
X-Forwarded-Encrypted: i=1; AJvYcCWReXws58+/woTjtcDFZdKbV2BxmkbFoeJ1uH3elTKi/mWnSQe+x8uAChWhVJdp7uLWPwjma1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywte/Y6y/akL6QvHd0vRY3AVfaL3eRQ9BYgUqvdxPSaxbDxQ6RE
	nMCfOZOnt7q5LNuArl448wgEpCte22dHSd+rIDEaatGEcQQQMVnlAgE/
X-Gm-Gg: ATEYQzwRLIIB6cPfsMXfERnUaujgwxsGTfpubv/MsTlgXOfBRywhbGO+38dQJhuinkp
	6s4IkpBrD7spbM4i2vHk3ailrbtqEnIpRe9k9N9jjUD4piC/uhw8DnXNcjtTi/zJf4mreLuAXIT
	lEGAUPowb4siCsnpOAvQtoP/kJbtIw5qSARNL6VArDIQ92vUEMR7rjtMLIahd5c3cNkdyLj4rMC
	RAXjRWCGtEEdlqTf1oaYoLN4mWJmEzFsTrg2Y3iY5pJfe6/0OQsZXMkMmJVRXfoVg1bkwPOpeI8
	QltENaCQGkRrKek6J+UDzyhc4emG0lKp9hCqq5aOM9BQPqtvBuXy+vep87gjUQfGIzEHNkKyNaS
	1Muxz7bv4Bs9mEDxF6cTL2KxdqO84HBTZFskvYbjW0f54FjmnOn1OMioQGPyKQD7AccJVZXdhzo
	0iq6w4fwvG0lvhWg==
X-Received: by 2002:a17:902:e5d2:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2b06e385ab9mr36407775ad.21.1773849151329;
        Wed, 18 Mar 2026 08:52:31 -0700 (PDT)
Received: from lgs.. ([36.255.193.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e43074esm31892605ad.19.2026.03.18.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:52:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] idpf: fix UAF and double free in idpf_plug_core_aux_dev() error path
Date: Wed, 18 Mar 2026 23:52:20 +0800
Message-ID: <20260318155220.642160-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227107-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.857];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1FD262C00AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, idpf_plug_core_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_core_adev_release() frees the containing
struct iidc_rdma_core_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..0fcbf9f1ddbb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -211,12 +212,16 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
 		goto err_ida_alloc;
 	}
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 	adev->dev.release = idpf_core_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
 	adev->name = name;
 
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
+
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, id);
 err_ida_alloc:
 	cdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


