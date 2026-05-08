Return-Path: <stable+bounces-244719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGXnK+Wr/WlOhgAAu9opvQ
	(envelope-from <stable+bounces-244719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:24:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A04F4374
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872223021B34
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55213A3833;
	Fri,  8 May 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="HMPT7Qxz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AE36C9EE
	for <stable@vger.kernel.org>; Fri,  8 May 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232161; cv=none; b=uckzyz968G+KWX9Jli+hG2CWrhlew7qBjCphEjDzPn6htex2iMbcHCArgkftzvnWvWMYSP8onqnsLIdEPXdmoDdnlbx09GCCNc8wZeUneTi3A44q6GD9ptGOSm7cbuEYav2df14qK8V9FUGOJi7CG/C7XodurOD58X5bulG2msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232161; c=relaxed/simple;
	bh=hv2NETYo2I9M7dPx7h5jpVQA4n0c3N4NMGvDoMF7Bpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsaDQS8Btb3g5bNSO2RFkb23qlGMRcHR5TUl28iDPcl786/GqFKIDJjgcLYCSQpbpLeNykj/V9gzplLrtcagw3EVpqtKTttmqP1giEp7F/GK6UuR3U7Xj0ltWLu2ASrBIX2Xj7fuWRKq7aE6sgthIM/CXOc4TgaI7Ryy8QBeJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=HMPT7Qxz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80167f5716so719648a12.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778232160; x=1778836960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KU2uqSMH44pMMKukBSajP4+Sg2CY7L09ZEK1/3akP0=;
        b=HMPT7Qxz3fXRbL/x3JxZfTXZODe2gMQyYM2NHMlUUvY9wdFVOoDLYsR5ivcF5z8yU7
         s5ucTc6RSI2LkNmi2q8N4D9qlNM+jjcqC8rzULMioBkmeicu/xkmUNkvIxACHFyet0q3
         UlgwFLdSc/AkFqXh7LUtIDVhw7PTZzposzVX2SomGfU45jFAfuTpnTDUTWK3E/sEoibJ
         yZjRejiy0IUIpv4cN+LGkUUaLQUWuy0Rkl8FUg7u2WgXriahiPSOze8/drqQIY0rd61n
         r5XD6f853YFo9iOxLMWDMwZZdwRs7Rg/d3bgL7gpG/fD3pRsWNktElV1QN1wQlSj8KkC
         Kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232160; x=1778836960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KU2uqSMH44pMMKukBSajP4+Sg2CY7L09ZEK1/3akP0=;
        b=dMFxqRdHqMZ01f7j4kHX4GPieq9xbWylzEz91qQKJ+GO6KAttY61zhWnFXd04MvOn+
         xSpu0awA5MMySEVx2pYGb6xGAiTaO7I/X/Mbgd94C53sJPkCNqX8kA2bsQW47GxxbubN
         MkA/pFNt7Dj2TdjvEHpj5rB0wbxEisFjyWdwkuyCXAnVgblwDaXwbJb5lgWyXigapCpd
         gd8NKg446dDNxkpwq/4CdQivP1Vv4uvYUHM7LCyxgHxCdLZWbUFKHjtxAhDloJNImc72
         eMoOoRu0kB1nkbXxCvWKzT9kCaWhbz2wn5VkK1mocLheoG5zU00DPeuNrx3hV7Ex8hMF
         bV2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/uAjBvyeraW1G8kMI9MgEdBjdbmGWwNqFRlJxQnwudQsZcYEqftED7BPoozmFTomf00fSIK28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8tudWQrVHe+zr1g/sJqTAr0UON6r+n7snob9bdpxCITBeOhe
	EP5pSB9qesJPAgtLbUe7yKv1TR2/epZctthE+dbkTw2LadjU89ETHiWN/1yK+uBwFIs=
X-Gm-Gg: Acq92OE1qrdVYchW8z0JuGlHNc9fZF4R7e8E69mGwpQmn0/w8dKGsCqWHXNEhHgs2Be
	UxmeLua023PmbU/m+yjAz/bqDW28yOEExQe+sgwLYNQZBZPe6HtSpRuM7TCIs9nFbQX4e54DhIo
	0QvDXp/lOtgtvTwAQHo6PosxpeQHFAs3EwkVQTCj/AQwqQREH/wtADBilUiRuU7ekLq2A4/3k80
	Ymu++hqdGUe9xaJyeVbekaeDOqvA+APJodkkWtchZ0y4nquTTB71hhRCT4AVnO7saK3yBxHRG70
	sywaafTwsFPW39WbFhiUCgpAz3OrBe7YQ9Cvmnj8LEWWc63fnop3Ric2OTAvSlDlciuWbgFHuN0
	Rq4RHemv/z/rvtxCXWvkT+g5apBUHIqiNXv17TXeOz9RLdPSwFHgj8Kp4IQxMSwYB1wP2gvO0nB
	rU4K8mJsX5wRGDG0q3LpwWTIP8BpBnM7fSrV89QDdy8sg5r5fkBcHUgmDfLwEu21LHYsHE8b6Y3
	35Tx/hzXg/n0iRazpojsOcEuZ+S+rOnQomVXX35YJIyW3kQAaUcDuYwDQ==
X-Received: by 2002:a17:903:947:b0:2b2:5857:583e with SMTP id d9443c01a7336-2ba798bb607mr118453155ad.31.1778232159686;
        Fri, 08 May 2026 02:22:39 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2baf1e36c65sm15107615ad.40.2026.05.08.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:22:39 -0700 (PDT)
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
	m.chetan.kumar@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Fri,  8 May 2026 14:51:39 +0530
Message-ID: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 116A04F4374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244719-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1b7bc7d63a2e..f4edb277efd9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1422,6 +1422,7 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
 	hrtimer_cancel(&ipc_imem->fast_update_timer);
 	hrtimer_cancel(&ipc_imem->tdupdate_timer);
 	hrtimer_cancel(&ipc_imem->startup_timer);
+	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 protocol_init_fail:
 	cancel_work_sync(&ipc_imem->run_state_worker);
 	ipc_task_deinit(ipc_imem->ipc_task);
-- 
2.43.0


