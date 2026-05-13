Return-Path: <stable+bounces-247057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ID7NfUPBWrvRwIAu9opvQ
	(envelope-from <stable+bounces-247057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:57:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1E53C2D1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48955301A1C8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204D3CD8A1;
	Wed, 13 May 2026 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2awVYt9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A1175A68
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716657; cv=none; b=Z2STdg/I9BvQ4TzKm6WAuyDVA+Nta1GoUX3Jn7fMjH45fyin8Ul2CY+qadrih8simPM6umPpmwoqcTs/uWvaFd4AtgWwp3roRxotZlSN1YqlZI6OQHI7WgEjAYxYC7oXjQhi9T4/T9qdzEO7vK55joKO663hpCeFx2b3ZdHtXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716657; c=relaxed/simple;
	bh=bv9X9C6ybvBXVMAO8U6jO4EDYmS8S3AlJGFSYWl4PTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5s6gH4/htq7oOEgF1r4vFwuME+J8rNvyUrcr/diuBywqJwJN8po+DJcJ1non8jQRCL8IIKSKOoGPz1ld215mo3401ya0FzuJ2Y+UVMN2a1L2FhNovppXFJrGZlDlD1XJR8zMFrEbL2NZfpa9xim3gMPXbARyvtkLbrS3kpoMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2awVYt9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so3805652a91.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778716655; x=1779321455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OP4TJnoSOJJLQkWv+kPmUFMD5Nz5E/Le8rvbutXj/wM=;
        b=s2awVYt9NDzOeDjCZNowgJoB/WLvU09uPGBtWjpQyl/r9Y14ODqJ0IjYSzHN3xmfeX
         gW5S7bB3QDaDD2HqC4Bdp82QVswkvvE8qKuU7PeyCuixO8QTSXM/SzRICd/QHp1DxPMJ
         byGrDo9eBB5jqhvTbyMSHYlVxmcS06Vpop5ws0/dg5dNrSYTKqD9cSi70jGYQNaXEBgD
         F7pJFZ3V/mbgHqXit8Bhy6iYgtLaN+xvGE6qSOLORVk868SrHVmE8n2pcuBQPd/Vb4s4
         hlf8AksoVaHU/zerqOu6lOoO7s+qBHcOiN1F5ViNsq/pK22JL+j3V6HRad5gmGyOvofz
         9ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778716655; x=1779321455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP4TJnoSOJJLQkWv+kPmUFMD5Nz5E/Le8rvbutXj/wM=;
        b=QKhED5Kp3aJz5co4uFYCQRQJFQIwM4uPp5NAep7i4rWcIR9NBhIZZ1j5lvKtu/hHA8
         GsekkDqUQI5aE34YhvLEplnnIuROG/fkPD6FPNMirKJZe1Bh4iEOMktCElJYpjYY3vqN
         6BdpbvpG61rXQ7Fu31D8ocbooNa3fbhsD0yhoCWpkH98RoiWAVx022PqhJkRvzioYC1J
         SA6Ht9MzmH4ILwU1MnLr9hMDR9bgDU8Tkly5/XzRcxIiZDfS7ouVvCNsybuXkZnf497/
         3icnVyQGBhYJfzpLSr7A06rFdTBblhLRKynQMWDaSE8v7pKak0c1lSXYC3T3AvK2hfA2
         XzTg==
X-Forwarded-Encrypted: i=1; AFNElJ962DTew31sp63M+akneFEbt2QYYh0rTsng6/SdqiGrS2E9VznwYhEjRmD+3hLv/tFTtaLuIT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Kgi99JZ25WwLOaeVB/lz6sAHkUKVhnIjoq4qgXI1eUqGIs0D
	CL/pF3FkcEwIvjg6SMAA+/KWWVV3lvR42GGjPyWuG2gJxSaoe+N9OZ+j
X-Gm-Gg: Acq92OF2zqrmvYS/j6Mskjrz/TdEaYJdcdfonz1DYMjg5eo1U7eiw5ySyI/mb1g+LZA
	FlC3UkxkQq5LsHj9qbrnLMBS9BapzpO2BQ3svuo3wFm+Jo8xNQ+/gd912MCEAHstJOJENqUojaM
	fmXdcJSMEmoNX+CnFBD7rJGXdDuKsRVl0tjH4zpdMdjabMyEapAO0dxTVS2bIfF6j99+yHaSrYX
	psi8DdL4327FayXxshlsflDLjug5nOerUG4JINrMfdj4OaSiwAtSFKYu2viQC+PVXBW1oTiQguK
	yHv0Mx0JvgmVxpanOaeh3VucPlXp8aZn6Ivv86CY6OEaxrI1NddBOEb/Idz5AEDXrDgnpZoN9Xf
	NmDRi2PQhj4za+pp14lutCQmaGyfuCgLQluO6I6wIC5GJejygYV5Md5pRdaSF101td/heFSOBid
	Q0HBbiNc1W3jFIxeUoxcCQ3JfTmYNZF+NjodmTPfihSLpsV9wDUc073t9jOBhlgoh6cCnR4SyY4
	znahA==
X-Received: by 2002:a17:90b:3901:b0:35f:bd51:cf60 with SMTP id 98e67ed59e1d1-368f398c165mr5568015a91.1.1778716655509;
        Wed, 13 May 2026 16:57:35 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.194.102.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692e72c059sm425936a91.5.2026.05.13.16.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:57:34 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: linux-media@vger.kernel.org
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mxl111sf: fix null pointer dereference in mxl111sf_ctrl_msg
Date: Wed, 13 May 2026 23:57:27 +0000
Message-Id: <20260513235727.9451-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44E1E53C2D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247057-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

When mxl111sf_ctrl_msg() is called during early probe, state->d
may not yet be initialized, causing a null pointer dereference in
dvb_usbv2_generic_write() when it accesses d->usb_mutex.

Add a null check for d before proceeding with the USB transfer.

Fixes: d90b336f3f65 ("[media] mxl111sf: Fix driver to use heap allocate buffers for USB messages")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/mxl111sf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
index 870ac3c8b085..9908675c355e 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
@@ -56,6 +56,9 @@ int mxl111sf_ctrl_msg(struct mxl111sf_state *state,
 	int wo = (rbuf == NULL || rlen == 0); /* write-only */
 	int ret;
 
+	if (!d)
+		return -ENODEV;
+
 	if (1 + wlen > MXL_MAX_XFER_SIZE) {
 		pr_warn("%s: len=%d is too big!\n", __func__, wlen);
 		return -EOPNOTSUPP;
-- 
2.34.1


