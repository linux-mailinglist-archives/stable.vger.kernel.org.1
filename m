Return-Path: <stable+bounces-212794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNCoLJSQe2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:53:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103BB2799
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDE33009B13
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44040345736;
	Thu, 29 Jan 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNwmq8wy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856E33ADAF
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705560; cv=none; b=f+ugyjsfE17Cf2grDQlq3dezo77XEzHgW5BCGsEHYxt0Zo2+Hm9twER+k/XcQYkd6C+JY8P2qR7WgX/lIvU/CUvR5aVBj5B8U0TR2xPR/PzHTwwmd2qbfjhyceKwOK/D1YZolOUJZd+p6860RzdXpPtEsOnMte6pFrTYUXdYlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705560; c=relaxed/simple;
	bh=B1MPTM/kJP5aRghCWlM0TtdejrUwSpsLDbd7d2LgvqE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aY3E17P62wAl5okjqsOOphjLwLQFV85fVKBDN2NZagqrtfC62n7XLt4jurrHkgIJzfPq+oOiUjEl5VOkOBQ581B3dpX6No4WaIba9UPVrUz/DdI1zh6Q/EbGGp2S/INd5o4jgxdprIwgFfEKoQcjHybaBKjeYwBSRW9LVVf1o5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNwmq8wy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac814f308so1834060a91.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769705558; x=1770310358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcI8KLWScQWADlApPVsSl8lWzsA1EUoFkehAyhaBPxM=;
        b=bNwmq8wyFYJMZ0neaxdFwkcnXta0wpe21vKFaIUtdA93jw2ttSVtfY8LBsSLnxaK8O
         miilxEuSKXfmSk+Stv2M6anfMbIpmhvHv7atm9N7TKXvsH6a5+kk46ZjT/XOjWTA3Xk1
         fcvTCB+pzXiTodOI+yNiig9bF0SdntWNGNCdA7hHWj+jYZkR2Cr+ELAMM6a/LjlGCTwE
         LZDRRkeAO3VuPtUEaX8sev9d00ZnQoUrkfR32dEbF03AHMLW/oVlCo53jhdBaKr57Jkg
         PE6KQcaJKOpoaENMPcu4u873Bjn+G9IAusQ+Pwr8kRTgE9FUx2Al9cJZkmN4XfvXQDA5
         KPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705558; x=1770310358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcI8KLWScQWADlApPVsSl8lWzsA1EUoFkehAyhaBPxM=;
        b=AsdxEBpppxwPyLtmBJFHtBkmrsvK3SmZtkCZ84p/4oP5CmRcdPSVme5IWgxXta8div
         ZGBxiA0qmdeuZbCFLT0cypmwWgmQ3f+pSw0fr9RUUkMgNiHHznHnPuNe7uqNC5dSU5Z9
         eGqsD1qJhsCun2wx0zuNljpepREzvScoK0eEQMNFy/SYugjiEL9fKmGmoAF64St9/nmU
         LouGp0eFxtBf5JfR2LAONhUMM6YlITcof5xjLEN6k2hw9qBJ19VTIRuNVY92Zold3JbA
         ugpWDClmzSjvjnD5E7sHUdotdw+1PQnMUOCHVX8T4mWuR3aJfpWEo7FuLbW49vGGDUZ9
         7okA==
X-Forwarded-Encrypted: i=1; AJvYcCX8h+wb8QUoPUNBe37Yz5MvXawNB/ORAtPpJBQIcdeQkpkqHDB7o+jdkvBypHCE7dlHmuVi1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeeZnUjacfjx2GSXVA8f7mFQFxenibEOanc93psZJlMZycidy
	vdmyiNc3LaQBn3hn91pTrkU8eJAQN51zjQ9+EwoexyYFPnBeHE7hXqJ6cNf75Sa14edHmM8kCgk
	LdOo09VNnvy11+D8PnQ==
X-Received: from pgg10.prod.google.com ([2002:a05:6a02:4d8a:b0:bc4:233b:be04])
 (user=thomasyen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b82:b0:364:13ab:4119 with SMTP id adf61e73a8af0-38ec628953cmr8347913637.15.1769705557995;
 Thu, 29 Jan 2026 08:52:37 -0800 (PST)
Date: Fri, 30 Jan 2026 00:51:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129165156.956601-1-thomasyen@google.com>
Subject: [PATCH v4 1/1] scsi: ufs: core: Flush exception handling work when
 RPM level is zero
From: Thomas Yen <thomasyen@google.com>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com
Cc: Thomas Yen <thomasyen@google.com>, Stable Tree <stable@vger.kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Peter Wang <peter.wang@mediatek.com>, 
	Bean Huo <beanhuo@micron.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, Subhash Jadavani <subhashj@codeaurora.org>, 
	Dolev Raviv <draviv@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, 
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomasyen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6103BB2799
X-Rspamd-Action: no action

Ensure that the exception event handling work is explicitly flushed
during suspend when the runtime power management level is set to
UFS_PM_LVL_0.

When the RPM level is zero, the device power mode and link state both
remain active. Previously, the UFS core driver bypassed flushing
exception event handling jobs in this configuration. This created a race
condition where the driver could attempt to access the host controller
to handle an exception after the system had already entered a deep
power-down state, resulting in a system crash.

Explicitly flush this work and disable auto BKOPs before the suspend
callback proceeds. This guarantees that pending exception tasks complete
and prevents illegal hardware access during the power-down sequence.

Fixes: 57d104c153d3 ("scsi: ufs: ufshcd: Fix link state during system suspend")
Signed-off-by: Thomas Yen <thomasyen@google.com>
Cc: Stable Tree <stable@vger.kernel.org>
---
v4:
 - Add Fixes tag.
v3:
 - Add logic to disable BKOPs.
v2:
 - Add Cc: stable tag.
 - Reformat commit message text for better line wrapping.
 
 drivers/ufs/core/ufshcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0369043ca010..8c88dd5c2cca 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9997,6 +9997,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
 			req_link_state == UIC_LINK_ACTIVE_STATE) {
+		ufshcd_disable_auto_bkops(hba);
+		flush_work(&hba->eeh_work);
 		goto vops_suspend;
 	}
 

base-commit: a48ca06cf343423faa01c573aeafba9fa5f92577
-- 
2.53.0.rc1.225.gd81095ad13-goog


