Return-Path: <stable+bounces-216483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHN5A8JzkGmxZwEAu9opvQ
	(envelope-from <stable+bounces-216483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:08:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21113C11C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1F83020D5A
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5942A9D;
	Sat, 14 Feb 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+aLND/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332E23183B
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074430; cv=none; b=jpTHPPdLYNl+DEasKy+td5DDChanFEoRlgpfn+0qNROCywSLZKPLPLKlK6cFqDuPUVXKpt0uPK+FN02XjexP8SFglZka7EkKfgXoWDfHekAbXhHXSXQUEWivrSatfWYQJbZUnHiC4xtn6fpsEFZ/vdXwkL8eVEf73KQFhKTx3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074430; c=relaxed/simple;
	bh=oFjwAFBbpEqkWb7J9rjxfaX2HDa2WcOxalZpGcADY7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKAChUuaW4DcNZWury6wwrrCqxTf5VQ296HahHGEdC1lxkdeMLoNXmE9tCs48lQo67oo8Hc0e2C0EG3zPFWZq7WP4luXcZCCAcZIFJEwhlLsb2Vk2Jq/Afmd9iGH+N9d2VHQHgf/sLCSBj5AmW8/p0M1Hd3sI3eksbvWBDSN2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+aLND/e; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so1921816c88.1
        for <stable@vger.kernel.org>; Sat, 14 Feb 2026 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771074427; x=1771679227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pWQnDuja70dnDBF3+5g2m3Cq8SMK2BPpVuO+rxHDm8=;
        b=k+aLND/eDgoJILFU1aDhhyEyoc4t6EOiKF2rTJMeCG+vPd1TLu+JAmibehjBrBwaEv
         Ss9r73qfhes/68FXgfNo4iq+6IpatBs1uzQVuRVEoKepL4gquxwy/Sb8IpQnddXvjiGt
         ovBbkJkhS1YiR7oqnA285im19lpvQXEXmKYOq1DWu5Kz3RmNfA2/XsFKui7Lmp63UZQu
         2eCfORabFC1xBKHhEuQ/h3LccEwN66VUBfsCtwY8TXDfkL2wCEjHYdpxYvCRbz3neELb
         BxVNwwvNHf+5Fk2Q94aiD0u2lDuQ6aUQPPWxqYjd1JRbTZpiUzeUrKMOuzuSnWABJuCB
         fPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771074427; x=1771679227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pWQnDuja70dnDBF3+5g2m3Cq8SMK2BPpVuO+rxHDm8=;
        b=SuLgEJDoruKQWbG31bMRWjHm8fOG89gahRjr5md1aihlbjO9unxA8xTfxwGahRlSzy
         8RtP4xA5wDGSBdEn+DUALc033xvbi2B9pIwbAQplG1SOgfbC47nOZAxd1/5/hcaJjhU8
         8bMgPBurbqfttrbj4kchtM2yfAPp9LKjTjl4SnWs71Og26XwYvEueEd1cEKq3odiDgdo
         BKp6zFnl0V+MnQ/TI952SoLL8VFwb+H9Qlp0u1x5PBMXajkvTk8PKdr9Nu0gGt5HAQiE
         qPO3LMHCGdcwnLIyDkUuagg3qkH6AOlw21uM1bN/bD4DFFHSdTTPWbMMxEdYFV4OYSdd
         httg==
X-Gm-Message-State: AOJu0YxYF0IzF28irfN+eavlC/GQRco09TK2u8d0bRagPOR/qlc8tbpr
	PV70OwnVAYsexFP+jONtUQq0fJ7kfFbpI/2aHgMCgWv6XThBJDkFtWSD
X-Gm-Gg: AZuq6aIb4A/W97WT0f/ZCBbatPR6T0VNIjaWqjBhhEAoQqHjaqqBeC+nwtqSUMGvLrn
	x4uE7soYRNxbWsZ7FabJuEJLND/n8Yqf0MNTulm5Y5h/CsBKXhKVgLZjRuhCYyVGv0gLw+P6140
	e5NzUg5ZrFxUN2E04FbP/mi5VIcbIUr5uAmN6/YgOiQGuipKekyaLM7aGr09H4nXOty21eZRJ/Z
	K8qPwlEgUCfMY7HuZrg5gItbRln7tnSFl++E3wavbJdv80SAjQoVJwvQLeHGFU3+ndET1oymeFS
	kOFCzkq0X71ly7ZlpuSJBL6ZoXJgbGrXAnkVvkjtVhQMakr67vKjWjjKE42F7bVC6Ly0SOWmHpY
	r29o+Upp5Izw73z50vLro3UCQjQhKqeOdWiDmQTVofvXx9DopzFdVaRbKFDsC/dTftnL0Ks7gYz
	6Gc6lMq1D7k/3Ez2a50cy1tQSrU7XMh4/sm1K42Ibn6ndu4G4i4PtMQt+djd1iibtdPi2qARe7T
	I7rpdUfh/+0EuHs3JZLwuVNmg==
X-Received: by 2002:a05:7022:4189:b0:11c:ec20:ea1f with SMTP id a92af1059eb24-1273ae40123mr2155474c88.33.1771074427199;
        Sat, 14 Feb 2026 05:07:07 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6430asm2170362c88.6.2026.02.14.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 05:07:06 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org
Cc: stable@vger.kernel.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v9] Bluetooth: mgmt: Fix race condition in mesh handling
Date: Sat, 14 Feb 2026 13:06:10 +0000
Message-ID: <20260214130610.68236-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216483-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,linuxfoundation.org,holtmann.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D21113C11C
X-Rspamd-Action: no action

This patch addresses race conditions in mesh handling within mgmt_util.c.

The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
mesh_pending list without locking. This patch uses guard(mutex) with
the existing mgmt_pending_lock to protect the critical sections, as
suggested by maintainers in previous reviews.

Note: The heap buffer overflow fix previously included in earlier
versions of this patch series has already been merged upstream.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 6ccc3a3f68de..eee4bc05f6e5 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(mutex)(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	guard(mutex)(&hdev->mgmt_pending_lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0


