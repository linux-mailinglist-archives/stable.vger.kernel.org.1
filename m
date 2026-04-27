Return-Path: <stable+bounces-241276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFw8Hc4r72nt8wAAu9opvQ
	(envelope-from <stable+bounces-241276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B5E46FE70
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B11A300BC70
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6433B27E7;
	Mon, 27 Apr 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXOm7Twv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8439903A
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281750; cv=none; b=VsN84yll2/zLHGmWsaRUKmWowa/PnHCcO4xGH5IwyTffnWxwUjzV+dAM6M4ntzlyrk4nihxYto2ofOd6rz1eXl23TdYNfcFNL6mzUaYxsKMZbEffyB1GexK9JXLNPEpfxS63IYuMMop3dCT7370I7YZigMykt19IO+UhA41Y3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281750; c=relaxed/simple;
	bh=BSb64EzeNe+LAdM46kkrVWOCt/FZCzWzgFhyw7921go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx2C8Mlxlca8gSqRitVpQvTo5rrrsbCEhlRWiXeEA+lqSNxa6RpO7gl2CCST2t0qkrVRVYwQJi+akDTzP4ZcRXPpPW0B6JOdN6I7o/D3RsQgoRZJJX/pmb7JuQdqngUepG++jtQ4DtkEKP05DicRD9qGRpUHz7UnmbKZqDZY9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXOm7Twv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so7277271b3a.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777281747; x=1777886547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFZBmc0iscSfAT4VB9ZbI38DRL/+YXPqj1yfGMlW+m4=;
        b=kXOm7TwvUgOcQHjq2B2ixLP51P7p0GEoG9nOepzjYAMPKFTaXJpLBWPVjoOdaabd4D
         Qjt+W/K38lTf+9UpFJFrN5SMxAs+wMCg9mkJLKBvVJGoXQPWEkHU8FwqM9/A4TpUxYhT
         n3aUD5XZq9GnfbP7Gxu1unzqm86jaiJhdHYK5YBYqekZMY8WUEtO0B9H5hA0Ojm/9jzl
         8pEnXm4+HKCK/u4jf8tUAMNFtFUJ9lE46aKP0hl1SWBvpzBKhbyBwU1lV+1d/wyyzKyd
         VNPvC4LGxgpU+qzB/GQFLZEBybyDAD50vE7T7/akSCWj4b86rQDtEaC/dKuiWmg1hrwc
         Eahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281747; x=1777886547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFZBmc0iscSfAT4VB9ZbI38DRL/+YXPqj1yfGMlW+m4=;
        b=CDI1uW5xzfpG6K0ol8y8zVG6qD/Q54M/KW2mkmY6rvL8pEg6OGd+td9Oz/6WTcZj8v
         zYZABRiCfRVGvb4Ua0IHgi4U/QKb+Lwd/QKF/Wd2NUaJWWR2JozhZZYieZ/QnGUExsK4
         lQxYHxPFDAQl91Fy/4PjPcr+dNEv6Y9WKEO7aYskyTHI5MfAcEd+SCd3aJFcx88mAics
         PvtZZqClMoWu+UgVRZFAvFRwpOtESuo1+SPlqhoAeOZpV50xEFSl0g4r3NLxacUX5A7N
         1d2v6nAM/XGMXGExc+Lx5ShR8kDGqZaaCLcs33AQFFX/L7HQOu9nDK9ouUZx2A2eSWGb
         pHsQ==
X-Forwarded-Encrypted: i=1; AFNElJ86tFrSFZHIrAEzUHWGy0liT/TzcLHYPVN26Tu0mB8W3wAzvxI2l7GVUugfYy585fO3MTb43e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmssycI95TNVNoahAyNYG2t0dJj2TEc7ARMg+jInYMD832Wh43
	9GF/8zAE72SsZZDBEJV25yi9RsTRLEtKAJH79ippHpoDeMSJd9bdgXI=
X-Gm-Gg: AeBDieupW8izbkn5RXKiuQuw8QCqjb7SoBFiMd9iOVUQwpeHHKBLw5fY5lvb4WtwmLD
	bIl26YLzXYLZ6QwdgGVnbq7HbzWZwtT5VnUgs2E2z1ZzyCfDNfJpF52QVdp5vc9EjPfOgJkKflD
	0dQktJkPc6F84yhAHgim55Tzw53g2gyat0ZttNvmgpMkw01AXsNfRUFuJjvPgIu5SxpOCrT0Ao1
	VwQKPF6jyaBfTblH33aruTEkw7jMSJm18QewJDOAiIfBUPmzLXUccPO4nmr/DsRQcgetfuyslRR
	Fvpca0pK09q1AxTeDvpUrJ1p2mOT0KIhsluyjLe2x4Nz3gvXH8/UCy9IOyT/L2q9pPeVdKye/wG
	6wXHzW7F6eT69ku5wekl44ojFJiZFRP+LU3n3dg+s3mK2RP5yAgJ63u5Fx3MMCFAibrHQEFEjNi
	N39Wr2R7wf/eQZhEB8HDVc73YZcJTJwIje7uUpINWefHbw+7jvqx5Es1kdUxPJSt33AES/aaPUM
	0GvFR4adVJpay6bH8vI0NqLcpeIkNflAYrP8YWzP8SvQ9s=
X-Received: by 2002:a05:6a00:4094:b0:82a:955:50d3 with SMTP id d2e1a72fcca58-82f8c937b36mr43641207b3a.45.1777281747016;
        Mon, 27 Apr 2026 02:22:27 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fbb85sm36364449b3a.22.2026.04.27.02.22.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Apr 2026 02:22:26 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com
Cc: Myeonghun Pak <mhun512@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] scsi: qedf: Free exchange manager on probe failure
Date: Mon, 27 Apr 2026 18:22:14 +0900
Message-ID: <20260427092220.58365-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77B5E46FE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241276-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,HansenPartnership.com,oracle.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Myeonghun Pak <mhun512@gmail.com>

qedf_lport_setup() allocates a libfc exchange manager that is normally
released from qedf_remove(). If probe fails after the lport setup has
completed, the driver core does not call .remove(), so the exchange
manager and lport stats are left allocated.

Release the lport resources from the probe error path and also drop the
exchange manager if stats allocation fails inside qedf_lport_setup().

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/scsi/qedf/qedf_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index da429b3a42..499d42e46c 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1765,8 +1765,10 @@ static int qedf_lport_setup(struct qedf_ctx *qedf)
 	fc_exch_mgr_alloc(lport, FC_CLASS_3, FCOE_PARAMS_NUM_TASKS,
 			  0xfffe, NULL);
 
-	if (fc_lport_init_stats(lport))
+	if (fc_lport_init_stats(lport)) {
+		fc_exch_mgr_free(lport);
 		return -ENOMEM;
+	}
 
 	/* Finish lport config */
 	fc_lport_config(lport);
@@ -3306,6 +3308,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	struct qed_slowpath_params slowpath_params;
 	struct qed_probe_params qed_params;
 	u16 retry_cnt = 10;
+	bool lport_setup = false;
 
 	/*
 	 * When doing error recovery we didn't reap the lport so don't try
@@ -3625,6 +3628,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 			    "qedf_lport_setup failed.\n");
 			goto err7;
 		}
+		lport_setup = true;
 	}
 
 	qedf->timer_work_queue = alloc_workqueue("qedf_%u_timer",
@@ -3704,6 +3708,10 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 		destroy_workqueue(qedf->ll2_recv_wq);
 	fc_remove_host(qedf->lport->host);
 	scsi_remove_host(qedf->lport->host);
+	if (lport_setup) {
+		fc_exch_mgr_free(qedf->lport);
+		fc_lport_free_stats(qedf->lport);
+	}
 #ifdef CONFIG_DEBUG_FS
 	qedf_dbg_host_exit(&(qedf->dbg_ctx));
 #endif
-- 
2.50.1

