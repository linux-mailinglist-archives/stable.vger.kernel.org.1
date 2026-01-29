Return-Path: <stable+bounces-212741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JhHDUIIe2kJAwIAu9opvQ
	(envelope-from <stable+bounces-212741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:12:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F691AC76F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D5E3067F77
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763F737998A;
	Thu, 29 Jan 2026 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmiQr36Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C937997D
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670458; cv=none; b=Z+H1zc8aB4ibU/hYVi5EBZ1ZOALbilkrBLxlqCWlWhOAcntORnDQDHq4BQe42uwcBrjKhwmIdETJdgo55mKKIJQ5nTuAD2DDkQHwpkr//xVIEKobgAiLF8315YWhzhWLffH7DCDTMNhZe2sEypulgzKsUBdRcdlCgKJeoYvaf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670458; c=relaxed/simple;
	bh=cKG+sXr+1ziofqpBsJjwfmGfj2KJzaG2xyY+bHw/yFo=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=O8S54FbK5fSGiKTuKGRmyMW0vPW/gh35cjfTH3QR5JHrSpIBfVUdAyBjoaVHHdL3CRKbTEcDIT8+3/RRa7twBY4tBh1OGJju/j0YDcAex21iMWDmUHefamdKdVFuWwByIdWjUJ8nXCbI1/aa0GjcXOHEohDYB16BgHc51ZpfnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmiQr36Z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6124a9fb86so1425566a12.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769670456; x=1770275256; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqQ9jDDf7KcRrhdcWeUtqgvD39js2kt0QEInAi/KKEU=;
        b=qmiQr36ZDaE+svI/zAHJI+4mTt6T6b8cKZ+amYo9jMv3D+IGYmu0YbLcLinVVf2mWR
         S0zrfVI+dGUa/O4Qm2qv5yv7NA+JhmJgKRB8goSXN9gwLWDLe+jU39hTY7od1aKM+8fU
         rjXpSGBp+jXhLf48ZTXS3HpAJDELX5SQePRqwwJ13+KstAJK/LTKvj3Jz7C+9LYiEfoe
         qT+sX7mrzIVsR7+AodJibPRJQDdgrqqgKdgTMCtIgr1KkaNi55NZWRlfL2GR/vZvcZXn
         IUjMrz7Ew/hvInpSzCm251yHR4Z3tq/btmnGcjonizl+KwnTt6vTsE2KhN665GnHTdEL
         0OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670456; x=1770275256;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqQ9jDDf7KcRrhdcWeUtqgvD39js2kt0QEInAi/KKEU=;
        b=Che/AHqWmqrb9k4vwScJizLNa2ra4gChajf78+dFRNqQ2+sCuyVq2LJECLI8ckVEeI
         h01TtRfJliglPLi7jH7+7wKfWyPmAPZ8J4iVySk8HTXbECY7ZzV6mK72vYofFoPbHDsg
         Arrzv8m61RgJUw3YbPxlay9NE5lNqD1JN54zZq7LCfrbWyt3yuRmc6Ln+r23WqUh0JA1
         +OYiH6RTlZ06YnBhT+FLDH1sVK+NFMJ63R3FGhhR4+hJqJdQCKL6yUL+zIhRuvkq9r+B
         w+jOH/IQtdTFW7r3H28o+jIThSVFj80leli0kxZbmK15X4NwW6VaebqW6C0D9pbzWwP+
         th9A==
X-Forwarded-Encrypted: i=1; AJvYcCUDeKdFoh6dilGF+Nitrf+/TlR8hiOI6xtK9hGcRjaNr7izYFNcwupJwN15dUFrRu0Ag+UKtQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfAQ4pGJEAdxwvA8b84It57YkbcH2LuH7XjPuBWam9GRdPFDa
	RNCrQ8UIda7VBGWVCxBw7t6KtC5FWjtvOQcjA/+L+Q2ET9OtvqeeyyL6wzHNa9iIZNKdxu8RTDe
	irpifDO58OyU7h+WGzw==
X-Received: from pffx27.prod.google.com ([2002:aa7:93bb:0:b0:823:f96:63b3])
 (user=thomasyen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:7585:b0:81e:b2ba:5b36 with SMTP id d2e1a72fcca58-823692fd797mr6468252b3a.63.1769670456140;
 Wed, 28 Jan 2026 23:07:36 -0800 (PST)
Date: Thu, 29 Jan 2026 15:06:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129070657.678532-1-thomasyen@google.com>
Subject: [PATCH v3 1/1] scsi: ufs: core: Flush exception handling work when
 RPM level is zero
From: Thomas Yen <thomasyen@google.com>
Cc: Thomas Yen <thomasyen@google.com>, Stable Tree <stable@vger.kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Peter Wang <peter.wang@mediatek.com>, 
	Bean Huo <beanhuo@micron.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-212741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomasyen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F691AC76F
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

Signed-off-by: Thomas Yen <thomasyen@google.com>
Cc: Stable Tree <stable@vger.kernel.org>
---
v3:
 - Add logic to disable BKOPs.
v2:
 - Add Cc: stable tag.
 - Reformat commit message text for better line wrapping.
---
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


