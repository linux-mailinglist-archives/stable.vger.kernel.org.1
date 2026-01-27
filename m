Return-Path: <stable+bounces-211697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEnxOFcVeGkynwEAu9opvQ
	(envelope-from <stable+bounces-211697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:31:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8E8EBC3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93A53028EC0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086923E346;
	Tue, 27 Jan 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07SKOVP/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7324293C
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477236; cv=none; b=WAzBmuEQLMxzo1ZSK6MOReNsQcxAJLfiCgGtPuQs/F+zYU/oeirhVWvLct5+yaXJcBaft/LzZSQBcnsEREVv90ueIfaXi6N6UKkP6cb+fZuvz6yRLSc0Rc5vk+SQkt5kttIWQjyw3mPAW9zD3kCyh8Jm0TzcX5dBW9ZKX1NXQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477236; c=relaxed/simple;
	bh=2PkusNBvCXPAaSE7WSYZ8b1NjsEsw/WwT2shsz++lr4=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=OOzXPEQJiLyPZZaCFi2RwDODrhpqxNgbhfg6lwJ4ZvoDs/zcTYZ6gcLXy7mT6IHR8RWKT2wfBELfCaES5qxs7d+5BykiJcmX0l84EYvUnTcOSdxVp1895rbMHq/uOk81oQHb4Dlx+YvW1ZaHoaus2EaytC4Qhd8zCiBVL8xYxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07SKOVP/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thomasyen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so3690240b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769477235; x=1770082035; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=164t62qeBCYmLeLaFusukV4c4GOaOGQY6hBpjpPEgbk=;
        b=07SKOVP/wWQwOeO1sw12rFVja1wXjqw7V8WdnIy31DuA2ET/jcLs8eDKzYgmlDu/Ne
         HKP6nsRxu9ZAVx1rI9K1Jng1A7p8qu7JAtQR115DnGdNJ8Kr6K9EmNSZauxqEcIp/UeP
         BnNcRHA1OvhO8yFWpSB7AOg1xHSyJfVflDYea0ihwR1TalkdR5HqX4+ZVK4cckLi5tEg
         5giF/J2tkRJMLsrjMh79HcLcP+t8iv0+XckgPYkxIOvY4eWMmJidhE3itQTozqUHoqP+
         5Mt9HS+FevcoQCWjZh11i0rBeoS5+4Mn+j0119saio93ib4ZU+tKrqZKDmNWLgtERtXC
         JYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769477235; x=1770082035;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=164t62qeBCYmLeLaFusukV4c4GOaOGQY6hBpjpPEgbk=;
        b=akVSQnRW4MPe/eOGMnzSLNPexT1Lqq1TcZg2awIeaYTc+s0O8/y7JycDQJLWmzP4jz
         9FZutD+eza26jzVOIp+7yPcAwPX91AIMsPBdkLCScuI/4fUBmwyXxpSDxPN6VI6h4YIe
         SA75O7TZciKo8dkwUi2dtwLmpXk3LDZ78wgjQu5/jmmUM1/Npzap3zUFMjhCRDsCEfWg
         zpO9WfKtQWbv18yzEIOeH9fuVdOZojDLBN3XkIeYGWd4Co/GkRlomRR3mABnt+bjROa5
         2kLRIspJpEWMuBcHsLd2jSnAjQD0a+5v9rrQIlFKSjfttVQMcEM5R+kiI5a3sXGVCU+c
         lFvw==
X-Forwarded-Encrypted: i=1; AJvYcCXEg2WMWssB7hskxCnHJ/799FCYdjz8W7X/S6/j4H6FXjlusiysC3QWx1u4KT4UOzDBHSooEPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/S4iy+eP6V6oCDxJuiuqPGE5VmJR7l0bc71B0wgrcpH9TI3P
	l0i04/h+BRzLvx5+0Grpd5L6fkDwI/he5CapyMdyCSlXZhupvGGf+nZJIQcRv6R5uCmqhaph16B
	ixqmDNr8Z0yZPRXMzrQ==
X-Received: from pfbhw19.prod.google.com ([2002:a05:6a00:8913:b0:7e2:fa44:4fac])
 (user=thomasyen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e1b:b0:821:81aa:add with SMTP id d2e1a72fcca58-823691c12e3mr180205b3a.31.1769477234543;
 Mon, 26 Jan 2026 17:27:14 -0800 (PST)
Date: Tue, 27 Jan 2026 09:26:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127012700.3311649-1-thomasyen@google.com>
Subject: [PATCH v2 1/1] scsi: ufs: core: Flush exception handling work when
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211697-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25F8E8EBC3
X-Rspamd-Action: no action

Ensure that the exception event handling work (&hba->eeh_work) is
explicitly flushed during suspend when the runtime power management
level (rpm_lvl) is set to UFS_PM_LVL_0.

When the RPM level is zero, the device power mode remains active and the
link remains in an active state. In this specific configuration, the UFS
core driver previously bypassed the flushing of exception event handling
jobs. This created a race condition where the driver could attempt to
access the host controller to handle an exception after the system had
already entered a deep power-down state, leading to a system crash.

By explicitly flushing this work before the suspend callback proceeds,
pending exception handling tasks are guaranteed to complete, preventing
illegal hardware access during the power-down sequence.

Signed-off-by: Thomas Yen <thomasyen@google.com>
Cc: Stable Tree <stable@vger.kernel.org>
---
v2:
 - Add Cc: stable tag.
 - Reformat commit message text for better line wrapping.

 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0369043ca010..3a0e6c9ba86a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9997,6 +9997,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
 			req_link_state == UIC_LINK_ACTIVE_STATE) {
+		flush_work(&hba->eeh_work);
 		goto vops_suspend;
 	}
 

base-commit: a48ca06cf343423faa01c573aeafba9fa5f92577
-- 
2.52.0.457.g6b5491de43-goog


