Return-Path: <stable+bounces-227296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKmvICv9u2mzqwIAu9opvQ
	(envelope-from <stable+bounces-227296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:42:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB712CC1D6
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F8B43098762
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4F3D5244;
	Thu, 19 Mar 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5S/awp5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7F3D3312
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927629; cv=none; b=efh+1Lp9oSFHHbZDABk/l3+RBmugAzbMjrFBfK0EVB9h2xESCieAqhFuN6qSUXB+Hvh01p+jFAdVhPePG0HmKYMHdvcbr0z9lIoFjkdkF8/PrdMa0Y7kbpb4snS6RQNDjwEPWFuwC5hn33n6AIl8zfGtFIJfjJP9fRasCj5ZuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927629; c=relaxed/simple;
	bh=9RFlBLdsLvwTMSO52ss9gXIOFrdI16jqMnmaf5txACo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHzYskloGWAhq5Q7kk3bsTbfhHP5ivYDTDfRBD9M5QMBpngtYAw1baHdlknnjdiEVttSasK+qhvFQsTjbwMd7dxk9vXx3PfT0A9+rxkNaVWqjZkztCRz7b4blrNxWRF4bH9bbtTsIQ97FrNsWdCNwIrn/DWW8nZOpULl3Y2lW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5S/awp5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82a62714fe6so468409b3a.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927627; x=1774532427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fk/YPao5MB3kYudLAhqn3ZbQm43GFyzl9r3q1s3aJCk=;
        b=K5S/awp5K6nOIoo1/YymCrJux18cUBrHcli/tPYdTjh7LRibzvxxV+NyezQxZUtXgU
         oQZW0C6FOwr/p0pkN/lo//TmVPZOz2D7oNNJi4XlDdalpO/+4+XQAiSfcLpjgDA0IBM+
         ith3q5HE2mAI61M41lp2RJuTq70P7+oV4ZfyBxOxS4CTsG4Gn1ztJmtMBF05/7wCpYGi
         2qQ+0D65bmeXW/kiZFjZHzi6hzUQKMNHPOSp+N7H+ZOJXVvs9NQlADnHBJk5rQuEWqNN
         yxH5FCJw+K0TdimqXm82F0AFJkrzbXM2TSQ3NDswF15N6ICQOVhQ52+3PS2Yh7tUEJKa
         WRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927627; x=1774532427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk/YPao5MB3kYudLAhqn3ZbQm43GFyzl9r3q1s3aJCk=;
        b=lZloy8msK6iOeMt193sWVFIgxSXUfY2mYysh0p5YNjyTV8OXsonETh4T8/moPk9kZ2
         qAJ5AABGyy72utokyxemv0nMjKO+wGMpQiCl5HW0rZjOTAmq6Fl+Kp1OnKo9D+BJ336j
         iYdotKqmTkZbhOfPoUa4xmpdSYQJmI/cwuemfU4e5NKEFzYnruY7qDZ3GZT7996rnM27
         dbaaWGW+rIJYmtsi4fQjxl/VNDGg6jgWzEtJHHx6GhXd5FPA1GkwxO/qssPcA1NmUj3Z
         kigzXyoMxkNvcTCHlrvEVnW6M1DuLWG55easm2gm6nHtqleiPRfXDj77hKbJJwpUpCSa
         UZUg==
X-Forwarded-Encrypted: i=1; AJvYcCWb5mo/VGRWNM9iXZv4wBjkdRmD3VgnsgxuMCeyVDOy7gh4Wt93qFc+am6jQDwhjWbfB7tSR30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+fLLyfaEza3QtEHqApZjrwwxUBj+GvhXP/Zj3MsOVToJwSSw
	ji7SE72tEjpREujoX7wbk6cZyelhESuTYmfUpR1Q6FGxjdkvjdTBAuBa
X-Gm-Gg: ATEYQzxdmd1O6C6UtrzYu1xmOi7mutDO+anvYnct0T6PiFqmKwehATSLuOsLhEE90zU
	B/lthbJX7lxAUYCi4sYKfF0q1d1+qTXsjmQZx8NIXZ2Z9akYdSqFlJbZjD0NTo9C6VDcikmTVb9
	jIicdxm8aEfWYlOCkz8GFolYoGbB3IbMA5KAY86BBuI3dJf4Gfl7i5fbzEe59oxWwY13xH9XPtt
	4S5DLArDi4qzk+910UGZnoJ/NQxcc5i0EhSRfp41exSo/G7wmiRY8jIi+/pBkuqoC6WeEJ+J0cj
	BM1oI4E26AHLIF1FIl5Z1CmiwGHotEqhUDnaTGMokDQul7zpW3EPL/jUhpBAh33FZ/Lx78CjX6V
	NvQw4TVadW3gOnyWSmN9hmEsVq5kY9r1jehiuXdbvqj9NQe2ZCKMK55rueiVhoA+AKiIhCUhXq/
	4yK/K1OsOTa2HHiA==
X-Received: by 2002:a05:6a00:1256:b0:81f:5a94:dc2f with SMTP id d2e1a72fcca58-82a7a9827c9mr2712844b3a.35.1773927627233;
        Thu, 19 Mar 2026 06:40:27 -0700 (PDT)
Received: from lgs.. ([103.86.77.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bee89d5sm6007465b3a.51.2026.03.19.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:40:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2] idpf: fix UAF and double free in idpf_plug_core_aux_dev() error path
Date: Thu, 19 Mar 2026 21:40:10 +0800
Message-ID: <20260319134010.684107-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,molgen.mpg.de,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-227296-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.703];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFB712CC1D6
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Rename id to adev_id as suggested by Paul

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..3152f4530347 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -211,11 +212,15 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
 		goto err_ida_alloc;
 	}
-	adev->id = ret;
+	adev_id = ret;
+	adev->id = adev_id;
+
 	adev->dev.release = idpf_core_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
 	adev->name = name;
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
 
 	ret = auxiliary_device_init(adev);
 	if (ret)
@@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, adev_id);
 err_ida_alloc:
 	cdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


