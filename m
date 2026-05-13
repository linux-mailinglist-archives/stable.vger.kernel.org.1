Return-Path: <stable+bounces-246974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKpVIOO6BGrFNQIAu9opvQ
	(envelope-from <stable+bounces-246974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4B5386A1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1B23176890
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA794DC522;
	Wed, 13 May 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IRtolmjs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E06349B1F
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694187; cv=none; b=kFnjfDu+GOHVyQafcZ9YYYeMjKJJWECrx2SsZDcf7rrdrtKvEF50AvznPveWtXcTBCDgM8G/qKv7xrfPkVE6QLl1Tv14Q16JZptnaOoXyVQzGOsqswtN7rcS7ziI5Cf2FQFFOMsjsSmDOO+KrM4+2gl9wkmEJPlJvzJaSVnIdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694187; c=relaxed/simple;
	bh=lc+IGH0poue7EOWyWEhf4BsBdmd01TDgiIasq1HkBDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnhKG9/1Rw1xxfSQRRbCMiRNrTGmaeZFZhpo36hMiKV2SaCzbc/UUtZDwi7lDbqBZK5FhGgi1F7fSMDlpejG8SYb9muAiY03XuQys1ZGHoLs0BNm6X3KprZlGgYKE+v9eRyCHrK/hQ0dSBcUW3OR2AP/ZCTSjp5MCF5UeqxqNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IRtolmjs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so75943285e9.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778694184; x=1779298984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/U/GzJ8VybTWe2MVWA1b3Y2w7oCzXqTk6bWcPUWOoc=;
        b=IRtolmjsDJxGpU++5UwtGo7mdJA/JaPXnhZ7Spux0y4tUB8WZmvFgSlG4BCWrS983Z
         C6t1kT5CwIu840kZy3F4vTU3rvoNLPOoGOX3DEKfkBcuOmEUz9x6nwznyTKNF7wamQxN
         /7Wy30h9g1xWd0PBt61YaMASPZfjhnabob4TpIccFU/6U3e/6q7vsJflxfuzG9J8lAZI
         jZyBmct9Ww1ytYK3icWN9twsoid71O7qhTxEuwYWyhcOYqsEcdyjjVWUcMBp3fkPWEhW
         92NaubFakXbhYyInHR6KHdWY+ormInw4gWV/QoNOA84EzRSvyJ35eI5+odjPQdWrXXnN
         h/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694184; x=1779298984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/U/GzJ8VybTWe2MVWA1b3Y2w7oCzXqTk6bWcPUWOoc=;
        b=orY9E9Lo0AFkqCMJcnfcoVOiop+IF3tDJHO/1i5DCF812yTzsK0PB2QZBEI3YAPcKo
         2Xk87Kv+mwddDomlTw2DEgzX/AsLRPt7pQLuQ4tV/eyOFqIbu2UfUlobGKhGba0ETjPe
         6MZo0sliRThalFHsQ3TmmopVEhGSRskehqYLiiH6a1H2dHiijdh2OgcIbyDCYS4AJJYa
         +WXdl+kwWbH2tGjROcrOc8jBALZhd7+qISwgmtOxwqhgYKr3J4icezCTWZJvyI5gkSYq
         I44YPeALix1uzuMoJYbaZFHY5a4QEjZ4p0/cjGRVnrfjva1bX0J07AFAKywvbbD3XeQR
         8uXw==
X-Forwarded-Encrypted: i=1; AFNElJ/pyIJiiWE8JnlKegrQ6mleTNEDek+PDwsSi7osHUIYtaRXCl9umKfbQHMvIof5PqMtM1sgf+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGCfPOuHF0Mibe/iIydDI7TJ37lXHCrm6zKkWc9wLkVW6TTmo
	P8j2k7gAwxLJM1i/NDX0sVgepv4Uju4lB2QPlO1Lz9bnlSxypTx3td9Y1RwSf+XR7NVpM86z6KB
	6GMXOaeI=
X-Gm-Gg: Acq92OFgTM23I1+BILMk8TsJIIcuh7hhI5UWriyAdDf6ZyCrou6DFri9jjEGYiZ7ENT
	1kc5/2deINEZ+sEEkfvAB3fyQeFSb87CVNlcdxDWBmkrVpijgLx6DCLBcDI//M1nKTQBicijjbD
	mJUc+fYKQhqmhWFwPxh4GxwU/T23uAee5XbFbd5yDA8Y1yS0P7aGOQc84ZaSobn2uLnsmzKsxBK
	L+ISjGWu1p/3Dm+0nCTGnrE9t9HCCz/IbLgO/Qh9DfICTb6dvd/zYhg5KJXU6vLfyZqAbspUPV5
	BbbDbDZB9kGnzteYn6kbzQGXigXQAbUBQyQg2ImxvhE4zxZOG2zWVP59sBM4deOBczriki5L7Xv
	9nZCISkUMArdjUudiJ/5wNT1zQp6GBo4iR7Yr8XtZUqiDDC/SbEh5xrXT5mTYufd/PLZ6bgfCE+
	yoPFvPK88dwtpj5Elu9qweGvlSipu8kAl1JAb+lcnHE+v/n+4u0x3Ek/6m9wdZD0SHftKfQJoTr
	J3EUm9dfGeoJDTPqqHtSAUu
X-Received: by 2002:a05:600c:870f:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-48fc9a0ef1cmr71204045e9.12.1778694184055;
        Wed, 13 May 2026 10:43:04 -0700 (PDT)
Received: from localhost (p200300de374a06005c73df0aad605173.dip0.t-ipconnect.de. [2003:de:374a:600:5c73:df0a:ad60:5173])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fd62b500fsm3897975e9.1.2026.05.13.10.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:43:03 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microchip.com>,
	ranjan.kumar@broadcom.com
Cc: linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Lee Duncan <lduncan@suse.com>,
	Martin Wilck <mwilck@suse.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Martin Wilck <martin.wilck@suse.com>,
	storagedev@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] scsi: smartpqi: use shost_to_hba() in pqi_scan_finished()
Date: Wed, 13 May 2026 19:42:35 +0200
Message-ID: <20260513174236.430465-2-mwilck@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513174236.430465-1-mwilck@suse.com>
References: <20260513174236.430465-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2E4B5386A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246974-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.wilck@suse.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim,microchip.com:email]
X-Rspamd-Action: no action

From: Martin Wilck <martin.wilck@suse.com>

shost_to_hba() is used everywhere except to obtain pqi_ctrl_info
from shosti, except in pqi_scan_finished(), where shost_priv() is used.
This causes one pointer dereference to be missed, as shost->hostdata
is a pointer in smartpqi. Fix it.

Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Don Brace <don.brace@microchip.com>
Cc: Don Brace <don.brace@microchip.com>
Cc: storagedev@microchip.com
Cc: stable@vger.kernel.org
---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 2026ac645d6a..5ec583dc2e7d 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2642,7 +2642,7 @@ static int pqi_scan_finished(struct Scsi_Host *shost,
 {
 	struct pqi_ctrl_info *ctrl_info;
 
-	ctrl_info = shost_priv(shost);
+	ctrl_info = shost_to_hba(shost);
 
 	return !mutex_is_locked(&ctrl_info->scan_mutex);
 }
-- 
2.54.0


