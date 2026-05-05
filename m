Return-Path: <stable+bounces-244279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIa+Lftu+mngOwMAu9opvQ
	(envelope-from <stable+bounces-244279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D74D4544
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F2EE3051484
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7148B362;
	Tue,  5 May 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CauEmVVc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02449550F
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020082; cv=none; b=C5F47/uiU0oS+UsTkArdWY97z1QKg0zA2NESXDAG+19cwZZfcCTk+k8pSO/mN+8ASYx7triMZDklY6cxL44ZDaAmhcHxLkNBNhayIXaLk6rLCOB96mLq1m/D8EtSwAj0X3r8N0+KSkfkgBFBosqv4smBKW/cwZnTuqLlWQrJsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020082; c=relaxed/simple;
	bh=+Atx00ARAbRA40Wk89SUgueKtdYrSO55awDFW6fZeqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN7gIGBOT1vkERKBfAyCflyoOVW2D7DUQJRidIOS9iDMteLy86uKTBWmA+gDFfRmSG0Y5mu6dRIGOIgV18pcPJVOIJ6wKD6X09P2wyaqXxIz3ZD9c95e7jSMi4f5yuikERPBS/iV2wwGZc1mOc7sss9wHer5nz0SsG6ZiuymRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CauEmVVc; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-50fb1ad3734so3611361cf.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020080; x=1778624880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFgJm1o7U9xQEZ9b4LfHLjyrTl3yA1tMTPG1FhFRCKc=;
        b=rRWopfMAHKyXIKRziukhBXw+/CNCFjZepqhNj91PrMY57Ve1QePccp9hZx0PgfB4uk
         fu9DXTY1AnGB6n7KbTNQQ+H7+aUwVz4ftEUdOSFOicgdwIqNkwIE9c1DLkZxxMbd0eyW
         E+sOo6Cf4aAVWuBeXxSeNU2gzy+xNdtZyykJZdvURYRnZ8Jo1NvQbALTV6CGQAkrVEX8
         uBTX86zU7a/HqjgpcXhD28W6gZrgybRcMJ2la5B+WVG2+WUsfvXTG4p1VmTB4iiR284r
         kS9HGjGlNKfmsPO8FuQr752slghbLFhZqxX9OIhIt8rt0GP1qMTcPoS35JzOxM/o3ihN
         t2IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JEz0ar9P9QQWy8e4+PeoDkBReWZmunz18OHR5Z3uLErfzI56pk2DTsRGwbt2ujHMwJ4ofmWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7qjSOxMzXnE4uPI4i+/wioE0poyi9Cajucoj2Qj0mAIodDUk
	EEhDcURTcluNdBLEGmWCYDCjA2TjvCYK+Myza6ig9ILAcOgUC6R36m8UcYdH/Hb7jxH6Lyb94dt
	zf9+Ri80yJ4dibfPo/+X63Hl2LZMQ+bgbCiVlf/DPAKT0/sbJYPZzoU3BuOvtS0XaRuv1LMtzlH
	j901fd1T8oUUrwgcyUhW8CBemqXlC2he1DVpkfpvol8U+74klsJNUV5s6F+w703o/yd9ee62dz2
	xhLSyEC
X-Gm-Gg: AeBDievyrEcPZR3/LS4KqUxPZR7+K95yKTaCZjGatmwECEfBmwHPVFqrYQU4jZiVzOl
	OSqpo58y2EQK2tO81Xv6d1ZW1FeIBCZNk4tgskTB3PH0qjPIAI+BOKlmKAhc5EH6xl1pyk2zau+
	NEpwhkr8jkZwxOH3F82XpnmxR5P2oOMLJpCRmEfWqTcAksGBY6FeZqh8WtAwi7GuTAp0VajqxdQ
	PJB2yDMQgXJ1IwChSK/saSTtbetRAOOSQYRTKafctVjMKsvNlTZx75azN7iiMR4/RQUyOrlkZZd
	PZeznm+GdpuehHskq6wBDoprjMacn6xcA4jDHZjWd7E5WGdPzaycXxHFJR9wZpLUSWeFdKBHkqB
	9HLLVYXudV8C4g8C1EiVqcdHncuDm4UefTuIbwxh7xwxR3PzwjN77nxJz0wBs8yniJhP7/yf5K5
	+p59huHSPOugwrQgWTY8Y5xdSd+w2TXAxSHsU/Haq8nid8bn+wUMdYQgoWFgFWo6WMHnA=
X-Received: by 2002:a05:622a:1ba9:b0:510:4174:507d with SMTP id d75a77b69052e-514622fa3d5mr12617321cf.29.1778020079549;
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5104086861dsm8610241cf.5.2026.05.05.15.27.57
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b52bb3ff88so10176496d6.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020077; x=1778624877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFgJm1o7U9xQEZ9b4LfHLjyrTl3yA1tMTPG1FhFRCKc=;
        b=CauEmVVcDgZy9uKD82tdOa/pFDMYEkMspFE6zp7Z2ENzWqLeHvha/iPGZL/Fws6Dl2
         h9GIY0Bh/mQ58zBD+C417LHaK5UX3TePyjA0MO60s/JA0Wspp7s9kSD9fUVRlbUA+Wn4
         2w+9qeCDruYrv0HsEG66ErU6T8MKDm5WZPYt0=
X-Forwarded-Encrypted: i=1; AFNElJ/uhVyP6Wbbtx9pSKsKc3tlUWGFrA5jhrkXxDJ2E/qPhrIeGqXLNgAO331JsLd4QV1M7+XNY6E=@vger.kernel.org
X-Received: by 2002:a05:6214:3283:b0:8ae:660a:be75 with SMTP id 6a1803df08f44-8ba9e59e537mr80510086d6.9.1778020077254;
        Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Received: by 2002:a05:6214:3283:b0:8ae:660a:be75 with SMTP id 6a1803df08f44-8ba9e59e537mr80509316d6.9.1778020076102;
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:54 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 08/12] drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
Date: Tue,  5 May 2026 18:22:29 -0400
Message-ID: <20260505222728.519626-9-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 708D74D4544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244279-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Two paths through vmw_vkms_init() can leave vmw->crc_workq NULL while
still leaving the rest of the driver in a state that calls
vmw_vkms_cleanup() at module unload:

  1. vmw_host_get_guestinfo(GUESTINFO_VBLANK, ...) failing or
     returning an oversized buffer -- the common case on hosts
     without a VBLANK guestinfo entry -- early-returned before the
     workqueue allocation.
  2. alloc_ordered_workqueue() returning NULL on memory pressure.

vmw_vkms_cleanup() then calls destroy_workqueue(NULL), which
dereferences wq->name and panics.

Fix the first case by removing the early return: vmw->vkms_enabled
is already false on the rpci-failure path so no work will ever be
queued, and allocating the workqueue unconditionally keeps the
control flow simple.  Fix the second case by guarding the cleanup
with a NULL check, since alloc_ordered_workqueue() can still fail
under low memory.

Fixes: 7b0062036c3b ("drm/vmwgfx: Implement virtual crc generation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..0d499917682d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -214,14 +214,14 @@ vmw_vkms_init(struct vmw_private *vmw)
 	vmw->vkms_enabled = false;
 
 	ret = vmw_host_get_guestinfo(GUESTINFO_VBLANK, buffer, &buf_len);
-	if (ret || buf_len > max_buf_len)
-		return;
-	buffer[buf_len] = '\0';
+	if (!ret && buf_len <= max_buf_len) {
+		buffer[buf_len] = '\0';
 
-	ret = kstrtobool(buffer, &vmw->vkms_enabled);
-	if (!ret && vmw->vkms_enabled) {
-		ret = drm_vblank_init(&vmw->drm, VMWGFX_NUM_DISPLAY_UNITS);
-		vmw->vkms_enabled = (ret == 0);
+		ret = kstrtobool(buffer, &vmw->vkms_enabled);
+		if (!ret && vmw->vkms_enabled) {
+			ret = drm_vblank_init(&vmw->drm, VMWGFX_NUM_DISPLAY_UNITS);
+			vmw->vkms_enabled = (ret == 0);
+		}
 	}
 
 	vmw->crc_workq = alloc_ordered_workqueue("vmwgfx_crc_generator", 0);
@@ -236,7 +236,8 @@ vmw_vkms_init(struct vmw_private *vmw)
 void
 vmw_vkms_cleanup(struct vmw_private *vmw)
 {
-	destroy_workqueue(vmw->crc_workq);
+	if (vmw->crc_workq)
+		destroy_workqueue(vmw->crc_workq);
 }
 
 bool
-- 
2.51.0


