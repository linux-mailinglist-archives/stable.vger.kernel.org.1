Return-Path: <stable+bounces-249470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPY+DFoGDGojTwUAu9opvQ
	(envelope-from <stable+bounces-249470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D0578419
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36C103073F7E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021F388373;
	Tue, 19 May 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="JhWK8ac0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6937A4BC
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172131; cv=none; b=sAsSKkaAX3zeJ/VkgYQ34jrCWBAIysgXcwDBxv46hfb6gTQdtZYSXoUhgwVcIFVw944pWq7dnAbBXGjo3VkQq9GV7t9tJMytOOinJHa7kqToi4gVbS+wmWYiJhynYA4/XrHrI6f3GD/eIpaW35zMhMfr0+yyi342ts/YQF4fYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172131; c=relaxed/simple;
	bh=H6RNv3g1Ds2kKIb9mbKPwle8pMhHto8h2eiocv6qV68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCBKOEaX4AEP6G/pPIUlIIjDOn1NOazc5SYKnSRG3s2xMlnD+K5lnb/iyopEQuIKxEkKuOS8XJO0brxcYdg1kIOrUAlj6QkNebPGemHpWM52LBEJ5h4tbpmn7xZDbiLSWXD3TPWSXnXL7eRP+etpdNCJZSoXJ86pCRzJ0TaZOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=JhWK8ac0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83d31ac4017so1391152b3a.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779172130; x=1779776930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zUEbH0RzskapC2a5NR15SwMDD1KBLfzEqEE74hnw70=;
        b=JhWK8ac0Cpa6D1/fLMmJcIEk7hAANA+AMuFfPkT7pWPDCLxCJ6sWm3Vs1bExv5lTc/
         Gi4qARbwwI//nPz5ysZvxIoASaSnlkaGiZEerxy6/w+NYZvHlz+1muE1QNPHWtKu3AWk
         V+WCF2YKNh7lfpFeMJzTcSUQI6JPCvDOm/zUbwGexjPmemEb/LwBgeKkZcAy6I9/2mhV
         /jXdfOpr0b9ohCodE2n2jU6/5lzG4XPCQdoQKjti5owMGgjGh09kDsWp1MZtB0wfj4yx
         cwJFuuZlRe8YzPQOVp2ug6wD8N3MR4HnAWVzxhKFkdfyyOLOoblOpf8VSf9UnIPl1XEM
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779172130; x=1779776930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zUEbH0RzskapC2a5NR15SwMDD1KBLfzEqEE74hnw70=;
        b=l/lENSfjEMJUZ+IwxBNmi+hSDh8cfG/QBGjteQGohJD0YTrt/D8eCGUbbOjYGrIfRR
         i6hnYBgAMr+W77P7FyHP/rbOTIbOhppYBt7mWN2JPJ76/xvoHoxXALZooC+57pVhEZv2
         IET9kx1uTDWYC3GCOIwAe7ntMIZSjWywb6LnkUnfuVIaRUNw50/LXxMk6F44vcAb7nr2
         oFuhb50pzLure7BDr4kYHmSemLl8Oc4ZfvcHSGGNXYyu0V+Sg2oehXMOYjxHy2Q6eQ5Y
         v81NPNNpKqhan7L+spK9izSk8K+OQbMgq22J/ECfzadasOz/tfhHz7grTaGu6M18El60
         spEg==
X-Forwarded-Encrypted: i=1; AFNElJ/Qlm42vqSm38wLg9zXAv03y/GA6Qz8+WGttiw4sT3ZVNH5isymogDu+qdTI0Qnm3Xlg2OhBxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAA+eKoVyQpubvlzFp0yegxpLCQwATzNzIYeIrxYTCDEb3Tsi
	TR02ijmE1tKbnOz9nDllgyj645Vq3Lz6lyA81zSG8SznOxvMZpW3njcit27y7iLswOA=
X-Gm-Gg: Acq92OHJ8/TX3tj5mu21Fla6omP7/2EbrsRyzYtX/7ueEsyHp1uApOpoPlthDVHbGxd
	HOOI1n/uxanxUAeXhE+9fUETKjP0HGA+lCDrPALpqyt6d9/Q8Oromibk0z+DQ838pm4fw0SytMa
	WC2kAuh3AEcYigGYrWXsTuwjA3pJUadsIK53LIrPn0A9hE/1JAJyteGAQFcPCFjxdh5g1bScltp
	Co7wt7826S9C4J0aZ563vasIm19MPGaPBZQJ9LR/fxR/vC0Hfjo+/nmAh7AAD4jkKc20vn4d+/i
	rAz/VCXlMfUl5r6xpSb7cX6W712sDjPvSS7TLpISkInzw19ZrOSv2bdyX0KqDTe2x9/DdNySrcm
	NyJE0GEZSNjAIqQ6uvOzkgIc7s+nFtHHuYqUp//wcHnKyFPZZeqlSseWcif4PHWRpMeuDrkAq8C
	uuMUPTZnxuNQXT+aNcOv2T5itHChm/ZpANJaNzWVF486mpNM6V9dZitXsxDAkWup1Y6LEpL8ntB
	z6ZxDM2HX6Z4XdAF0Bx1TVRKzPg4ZM+6pCjAePxFb6M5xV5VnJvHV1kdGDwEclGBNco
X-Received: by 2002:a05:6a00:3e22:b0:83e:f208:b113 with SMTP id d2e1a72fcca58-83f33c541cdmr17707506b3a.7.1779172129825;
        Mon, 18 May 2026 23:28:49 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f1966471dsm17045725b3a.6.2026.05.18.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:28:49 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: loic.poulain@oss.qualcomm.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Tue, 19 May 2026 11:57:39 +0530
Message-ID: <20260519062815.55545-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249470-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iitm.ac.in:email]
X-Rspamd-Queue-Id: 2B6D0578419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
v1->v2:
- Moved the ipc_protocol_deinit() call to a point after the tasklets and
  workers are cleaned up to avoid a possible Use after free, as
  suggested by Jakub Kicinski.

Link to v1 patch: https://lore.kernel.org/all/20260508092141.82495-1-nihaal@cse.iitm.ac.in/

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1b7bc7d63a2e..4405c8531888 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1425,6 +1425,8 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
 protocol_init_fail:
 	cancel_work_sync(&ipc_imem->run_state_worker);
 	ipc_task_deinit(ipc_imem->ipc_task);
+	if (ipc_imem->ipc_protocol)
+		ipc_protocol_deinit(ipc_imem->ipc_protocol);
 ipc_task_init_fail:
 	kfree(ipc_imem->ipc_task);
 ipc_task_fail:
-- 
2.43.0


