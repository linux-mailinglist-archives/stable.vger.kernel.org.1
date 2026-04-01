Return-Path: <stable+bounces-232847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDJ6AylszWnvdQYAu9opvQ
	(envelope-from <stable+bounces-232847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:04:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A543D37F989
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8004D305F0BC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F531A05E;
	Wed,  1 Apr 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="J1+TawQP"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B662247295;
	Wed,  1 Apr 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070160; cv=pass; b=FDWaCPBnK4E0O1xUrFcIY0SJuEdBZXj+9xNMiFhgy5BNCC1BBkRyQKGxAFSJWSlD17lGR2eEJKx2+PSDK1PDdBx2IxT/dcf0vAlQZMD+tFv/6n2yi3L6gfvPwbMSMKMnaVhlJn2M/JNm8m3TXPzLeUDTB+eo64WtYtbEvI8Flfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070160; c=relaxed/simple;
	bh=v5dKzljNePBFaemZmz+iFNRtcPfnjlDZ5SF6cQuY8Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDo8zQ2neYSpwF7wUDNu9/ItEZfq/zRJaOsL2QbWQCf8Qlno3DH7scaLSphermDxDIq5Jmwu/vehQnyH8a5Ce+SlxONuIYNCennm7/q5rrgYYuLJymjW7Co4lxON0oviYaySjb1wi/+Kyobu4MIJTRR+fm5pJiXV9ljjhV2skZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=J1+TawQP; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1775070149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Or0W6OQQPP8DQNVofRpKyMSF9VsBaHrgEPCNO04cRAiCnfSdhS0lpD3NgooVT8CmNGXpbH1CTlHru1Z9ADzzfmJ0Bf/jy1PaDjUyO+hDp7iQ3zuwJZcBLdmWzrCuPlP/AYgAmd7krjNzAn2E+8lN2H2ns9skfMfL7e/gK5LUXPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775070149; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yjGruuLNbYry6JyygcnVNDcA/cl4nVFtzQi6sOYnPMw=; 
	b=m6OfH6RqGkdN+mzdRGM3NWs61mVKSLft9M4rWc+WOENztUrtdNtPj1QVYWXDhzAliz6BDEoLhplG4KJv6IDQPAf5PYUzz1Jcz/zl2Pm3KpQoYoL4B1xZqbVULYHvWanj4Psj234uiDqpZV6T9INhkwG4XyD327TMtHAGf+g60yk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775070149;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yjGruuLNbYry6JyygcnVNDcA/cl4nVFtzQi6sOYnPMw=;
	b=J1+TawQP4ujUK0ZPJFUk7Sksgj9257PqtXQgz62NvVHTBCCc3gU7QfNvf1YizfCo
	YNlhYmBKtUSuJOEUrcll8dSUg3N8+llgrFLVPsbmAQzlxL/py6lhkM4VxcarVn5OTzr
	Zw54dJYb36TTooOFmeGFvrfbMisVnlHRRkd3XHg8GgKuMREEc70VouDpuOAxXD4Y+ki
	pilzs+pr8iubFOVCAYkLw/rj5gEGrMaHuDvWhkkwAvZW7QQE7OSs/Snytb0BMlgEft7
	gnW3bgkqlv4VNxKGsk8PK/LRgG51Z++v44+nvBXk01vCAVeYcEdQJzGZLFTM9vwZxs4
	u/oTw2HU1Q==
Received: by mx.zohomail.com with SMTPS id 1775070146569314.8129352025503;
	Wed, 1 Apr 2026 12:02:26 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Kurt Borja <kuurtb@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Thu,  2 Apr 2026 03:00:55 +0800
Message-ID: <20260401190221.1595264-1-i@rong.moe>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
References: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rong.moe,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232847-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rong.moe:dkim,rong.moe:email,rong.moe:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: A543D37F989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..80021f59d1ef 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -55,8 +55,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	ret_obj = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 

base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
-- 
2.53.0


