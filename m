Return-Path: <stable+bounces-235989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBBdCSXS3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:23:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 896503EB3A8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C55030115A2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C03BFE3A;
	Mon, 13 Apr 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH1w5m0/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8693AB28F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079249; cv=none; b=gJJ5n4mv4u1NsHbwmBJp2ogIdzLs18Mlvi1Iqb5ozok4WxFc1MSs5tupCoUhcqRPx0r5nFDv6dIsgWaBwdmcw+udgzTzMqQQy9k0OdhTrEu2SNG0BySdFXuEkCU1kJWaPiYP/zbdpkne0Xy1VqERMpvE6O0UyLxmTe8SQ5jbl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079249; c=relaxed/simple;
	bh=R5urYhnoHecl+KVX4m8FZXgsJfZf3ZpUYspi2EHPFBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuA/mG16xUeTQOsc40Igprd5n0xdGNQB+VNkUE6CY2UrEAALkhZgh541/vh7t5+KsjFAjzcbo9F8I1pMaw8s+Ow4wlEoO0k0Cmy/iYpq1BQDW1aHk+IZmIg1JnwmGq2t92QPsXs09mblTGG60U6YSRUwNGjCNAZ/05K+ldhT+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH1w5m0/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso736730b3a.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776079247; x=1776684047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
        b=dH1w5m0/WlAoZqvADSMi1fTBWlr7hchAIJlgpfCiiMuqLTucEhlMLKpbMXa15uJQJq
         2Tz79GD8D2or5W65WoFY+OHew59Se6fEm7aeHj5uCUvneffTU+0mn0GDaivxMbCSLFyM
         7wsb9n6E4SHVQZTPAnB6ig7iEkePBU1uPr2Ie89U1qk0tZ8PeMn8cK7203+VHVJskavb
         2EZgekwIdmpqb1OeDPFbg9bXjG3ZWaBhvP77HldYwnquWlcGcSkmJWKtZ4bmP25mI/Gi
         Ak3Rzjrj1qT6rOSGcvcVKOoMK9HEVb2VQ2R2w9RGU8109NRgB0nH6NjNx4aWlpIAM5Pj
         Mo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079247; x=1776684047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
        b=h8ZyY/y6kr7xtxDLIDGDAjviC4aj9i74Nnr4+bMjuc6cztflTuDmBMVF7sAbSQTxQd
         2LmUpltNy/5zyeH5+A/IfqMT69FY/GEdAI41ASHwfB85qv8zUOun0YykqtAfe66+t7uV
         afnvpOhKrKkqZC3NgySa28Di8YcvvaEdoMMDEHY8tgAZ4ViLuVV4LNsc7ZVS2ZG6b1a3
         hQevMZpwvQZSobj18qSRrFLfSDfy6Ia7gKxnxRmF2HUDKmNCfWIbRxwhhshhZLsvJMcz
         yUQKfmrX3XsUe1Nyn+U9h/wu1ZV0vSft6aJyk240V1j6s1E/PzIlqP6qe2fZez0djCvA
         1FqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mLlwdGyUuVpRVjgwLXU8gVy8G0ju35Llpp/cVHnsQaFVlDHgPXZIjG2WI497foFelX5xUeNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RaYtNzdkhdeNCL5Ji9CgeOtKVyLgd3lit0gV3//ugCxLtNOE
	M+SITdVMpgCuZ7qUa3NQamE89vWPRNedG9cu4C7XNVzUBPjeTVNqUCrv
X-Gm-Gg: AeBDietjv8WCFpvqtgjVWJJTbd6ZPEaK/yY/tMjmKLaLkssS4SpMLx6MCFrz6iwKn+w
	nQ1tM7QTU/JYfrRnHiKr3vwhY+19IMbmDSO/rM5cQ8kNd6rZXm9PBuSWcg1r5phrcQLumaXgjyn
	f2J3WjQqY9/zgbTQBGWdWrwO4jauBLBKicu3Zz184hicyY+PBECnj8mobP4wl2YkzScD+sBkC1c
	RFcZn+CVMrjcQBS7rc2w2PdavHMdlHQRLX9J4wLRWpeNJLf3pzjH8DxePRt9tK0czae+UTP10Qk
	UZII7vsL9kkUm4aDW4AwRhPrnYwDTRux/bGwdA3ihqeW6EO0gWxX+Wg442PIMQ56an1YV7NsuXF
	HH7ZfqMZu0ht1WvLMoO3iyWyyjjvBCLgbKkzlmp+0EvZsF8x/Iyz6LaQo8y7pv+lrSRTgx3toAI
	YMYUp2clr3TeNibw==
X-Received: by 2002:a05:6a00:1887:b0:829:924c:348a with SMTP id d2e1a72fcca58-82f0c26b71fmr14463158b3a.45.1776079247519;
        Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm13555346b3a.43.2026.04.13.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
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
Subject: [PATCH v2] dpf: fix UAF and double free in idpf_plug_vport_aux_dev() error path
Date: Mon, 13 Apr 2026 19:20:30 +0800
Message-ID: <20260413112030.2694563-1-lgs201920130244@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-235989-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 896503EB3A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, idpf_plug_vport_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_vport_adev_release() frees the containing
struct iidc_rdma_vport_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..2a18907643fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -74,11 +75,14 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 		goto err_ida_alloc;
 	}
 	adev->id = ret;
+	adev->id = adev_id;
 	adev->dev.release = idpf_vport_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
 	adev->name = name;
 
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -92,7 +96,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, adev_id);
 err_ida_alloc:
 	vdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


