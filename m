Return-Path: <stable+bounces-267468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQjsDCEyNmrw8QYAu9opvQ
	(envelope-from <stable+bounces-267468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 08:24:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E266A8691
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 08:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=kgJPyPR1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267468-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267468-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9134C301840B
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0238372ECD;
	Sat, 20 Jun 2026 06:24:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E854654
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:24:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936670; cv=none; b=YPTgEu1+2V6lqWKriolWD/lMhOf70WfLBrPd5Rb9Ci7ZZqujJIdgdtX2bNj7ADd7iSgBS3rhcMmwyRLoWluzqHSerh8CERPhd51p5ZbkBnc+kfESbh1C50ZcHiP+jTNAAQx098CSwScE4BPPXvrUVmQsgRyzTqzWAweua+hod+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936670; c=relaxed/simple;
	bh=RsSAho1Pzk28o91OKru6XLgpA+3KQiuhOPhWSfAqX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUN3BXRl8nH0FbJEIG35RG/EC8Wk6+UpMQOCuUv/qXxxDSf6o3Ej1sFOXerdyeV6s3o8N0EO5u8YS3WRiK52gpOFMriest+AA6NNB2QERWwCoThy8KpZMyOf42In41QzP8NDvjzL32z6gSUqIC0IT6BZ26nbwzE+tvMvVkjia2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=kgJPyPR1; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8857a27041so1206061a12.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781936669; x=1782541469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1levBq2VByeRMw4NnVrhw7VKzj5zHwRoGDl6Jxfu4Q=;
        b=kgJPyPR1LZ3XxfSZlvbpQW4cr6Us2+Z90L/t/162JxtCaeeofLduLGilcjzDWLvCKE
         Ubw2ZOG3LHZbl1sUH/neDL5nfWy2JcaLTZjL0jPwQP7vtN9weYi0nsIIr3VzI8Bi0YcO
         OG5nG+Svr8KCokmYfbtlIcuCT1ZtauDefZeMGJJCwMpZtMUQDxn9boG1NzYlRUxmJB5k
         4kz+w+77EgdUbxJqqvGayhFGqd1h0MrOO/of53n9ZtKfY+rv6cwL7RCdpsusTAccWiBX
         klNuWTIi85BoU3yVke/GwfiPdsTgEkKUG7qcJQnRV6Pg2RnlNu1M47gnDbp+DtmIP6Zd
         2bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781936669; x=1782541469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1levBq2VByeRMw4NnVrhw7VKzj5zHwRoGDl6Jxfu4Q=;
        b=Gq9p2jc/z1r2n51EP+TnIPHgAZ1q9eYJWh3MEVQN2ArFab7HSbPTSpvTQRfy1H/O2h
         IXVrQIfOmED4yTUlcHzEFrJ/RZ7Q3vOz1W14UcFBZ3uINzqlniyrtroT1sgZBVSasViv
         LvkC0Cs/cYTlT5DY1YQ3mP+9EvOPmHMMF3qLQMLiiB02TEuuW4wkAbqvy04lzSzsHPqV
         1/q6RmPzkcgAfJ+sknocT/dNgBEoWkP3TEZL7pUTW29C8HzCs+mCRxQdB3zNirJJC45U
         o4pR3dButNRY6sXny+88mEhpgHj6nj23vGSyuqz//GH++n3JhxzN94UOLWSjmLug+stj
         o5Uw==
X-Forwarded-Encrypted: i=1; AFNElJ8xc1RDPZYZ0nLGq1vbp56Cqm+KtzzEpoCIj4pmzt1r9quygC2zT3uA9p3j22+YwI/o9Hp0Hnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7+Eh1NSCpnYrVjhmeCTJUCBBQiQZD99U0c9e6oKF0zC1sZ6y
	3xiz/2PRaHJ16Sy2OEcfOolzYhuD+2Omy9uwoIghwNqcrqEDI2Pd53++Ak5LRObW5fU=
X-Gm-Gg: AfdE7cn81T/iC8fgopeEuK2roeqiRSHys+W/R/ZY1O4kaTy8y4tMziMUi71O34OSaCz
	Z59arZIwFPoqX6K73C8FT+az60mgPms/HLPExPdPM5AJTftqM4B2dTl9LunmDc8xsV4JH8LYriY
	4wx9GNBvnml9XScKoQFa1BYfVXRN3BqLu5EG9Ky+ZttRs4noDLoDAcEDbSXVuQZQ/srIYS2TEyc
	8RW/LyuVlHD7fVci0vKvd9MsqMkWwL1mVf8u7WPUBgOvAy/jIwrNvz2Vkim2rnPo7rzVDwo7B1c
	js/acZ6iDxIG4hWKzkguASYwpkRqS7O/0JJFE+uMlq5W/cY8fop2ctduBvwtTK1ondTtDmP3Lzi
	BL/yzkDJSO4gzchceyGu5/mMKcJ3o3A/BgDhdw+6OrkGm/ZLZ36vwXT8EY/kV1RqOJKRY3RZf8D
	PXptmRdHxyE6QXjaC+cmrVoxQfe8AggluNEniZ/wxa9iLBeRWuGcpTomXyus6RCLo02uuRiJ3H0
	2j0d55DBccxri76R2fHpWtiurSvLLy3ecDdZut6t4K7mig=
X-Received: by 2002:a05:6a00:9296:b0:842:7296:dba with SMTP id d2e1a72fcca58-8455079fd74mr6874865b3a.7.1781936668977;
        Fri, 19 Jun 2026 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84564d89dd8sm1139652b3a.15.2026.06.19.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:24:26 -0700 (PDT)
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
	barak@broadcom.com,
	stable@vger.kernel.org
Subject: [PATCH net] bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
Date: Sat, 20 Jun 2026 11:53:50 +0530
Message-ID: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267468-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:barak@broadcom.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iitm.ac.in:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91E266A8691

If the allocation of fp[i].tpa_info fails, the error path will not free
the struct bnx2x_fastpath allocated earlier, as it is not linked to the
bp structure yet. Fix that by linking it immediately after allocation.

Cc: stable@vger.kernel.org
Fixes: 15192a8cf8a8 ("bnx2x: Split the FP structure")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 19e078479b0d..5b2640bd31c3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4748,6 +4748,7 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 	fp = kzalloc_objs(*fp, bp->fp_array_size);
 	if (!fp)
 		goto alloc_err;
+	bp->fp = fp;
 	for (i = 0; i < bp->fp_array_size; i++) {
 		fp[i].tpa_info =
 			kzalloc_objs(struct bnx2x_agg_info,
@@ -4756,8 +4757,6 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
 			goto alloc_err;
 	}
 
-	bp->fp = fp;
-
 	/* allocate sp objs */
 	bp->sp_objs = kzalloc_objs(struct bnx2x_sp_objs, bp->fp_array_size);
 	if (!bp->sp_objs)
-- 
2.43.0


