Return-Path: <stable+bounces-217801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNdSEsiOnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:30:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86B17AD7C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1D03143568
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EB330D26;
	Mon, 23 Feb 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="WhYq0RsR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C969330B10
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867428; cv=none; b=sy/GGyFM48n47dSMvhWoylNmxXQYh3y02uQFGGjPSMxBfjQUulbxBNhVJ46Y0BFjnwne3jIbohri5B/E5LF6PJ+UX5DNS5k5ovwmeedWdzjx5/ySkeMOJX+C1tt0blXaP8zOLfp6f4TVfde/NCJLO1vL5uiH7V240+64jm5Yuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867428; c=relaxed/simple;
	bh=HdKcWIRXvLVamXfF7ZeFDsbncN9MIo9MT+ODsJsfhJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0cVwIcPuBsUDjIYnryUJ2+XoS0DuPOL4sxbNb+iHM7SRik3OpCbHDc361132dE2y8awD0a0nbZi+1ZRF3SO8trzJBpWhzrlW1NgkrR/5z7yB19CBYi2hgwX/9RUrffzW75Fzdna/PCxuxAn3PdMt5Nt5Qrk6umJ/ONbj/57dL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=WhYq0RsR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8230c33f477so1965146b3a.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867426; x=1772472226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYRTIPm2XKejelZxbfd12xi/Cr57PQ2HDO5pVWa4Q2s=;
        b=WhYq0RsRCnlbtAKr2ltNZSDCkeP14tGRpIL/sJXdbaFn0Dm7SYWC+2sJ1WG3FAvk3r
         ILHa97xtaZllAllCUpCzlCWhsDIzQTuN+s5j7oLGdi9YPfyI2VqnLBl1/WinK8Rs5PyD
         GEHQqpj0IUB7hksddWdEGldz3NetNbtvt+gHSiVQO7NsF99OW7cYNa3rzYFfKGsB6lX1
         v6b8ou4OubnWs6oc9HWMsw3FxdmX9OpzG7/rCIL467mVdUhRqh3IJysjeSeo5N3YjKsq
         kwhpq2k6FnKtEHU8WSHVh9rI2r+zsELdS5FDgPJhJGfiSlNWdZiB8chZG7CFI/BXXFk3
         3MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867426; x=1772472226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYRTIPm2XKejelZxbfd12xi/Cr57PQ2HDO5pVWa4Q2s=;
        b=bZqDiP/DaTQKq/nyG7i0b65a71v58nBf7DM/+0PF/bGgGBJvPbUgYRc0xaTsSZ3pyr
         bTlDUKCtJdUcPIpFFaRSi6z/nYAsugoxYFoOep9PlV+D4ABr1kv8e77IW2HiUwfCMDRQ
         3QKbuEriaITcOmHQDg5yu6rpfAa9gDDrjYwcsmqVaOAqxTVkrYDn6hRp5QH4oSsZivMY
         hjGaZYYxuZOq8l5aCZWFeFUrc4J/OIOIEsdI8ZmBQnKOEoOz3faWazmvtM8CKhAaiJxv
         Q6TUBXhgv3uRfCyA275ClsbDu5pLbVE8++uDe9NW7E9xXNVFKqz3HwsxuiPG/LUqlqCr
         ndMg==
X-Gm-Message-State: AOJu0YzsTC7hgrLIvGPkv3r1a+0iSywEoejDy36dMTgQ4d8vjppSVx5h
	W3vvvc03GhJvzF1+Wr97FsFmLKx26dn1gIUDuPws2ax52FSqT7nwzdQ0mDbPHpLANXWnclqVTFR
	+KiSr
X-Gm-Gg: AZuq6aIHd6+6BjcriACZeHQdILID3xlnDJzXNwIg3rK9H0TZNZYj0gQGCMd0YEVw8jW
	INvcH+U3kkmVEmahFsdcJjFurdaNVcmwvksc9i0SGAU6Ni+5zv4hb2Sc03/kUVTKUQZ26KVoO4q
	U74C2h+C7WKTndzB25guibLRdnI19BBGg9Gi9eOBmHtIZvC18B61wEStnuKsuQyIwYmqlZkN2Kc
	u0HCpt70neiOJ4e2OrZpvVom3P0KUwAyN74ujReSrrmL2iUwv3pn3QG+CPrmuHyPN0HaG8vTVha
	+7nA9vZlPmb3UZheQPJG7QnrWvHjDDRacBzFQ1BC7oWGtRqy/Mr0Jx3WaehFSmFD8pm5enXh/2I
	J4jJUsbkAAbR/9dGIsiiqB/DJynvPkx7xz1Js1mqGaYiP4AX07kvh7N/XjbnpJN6GT/FaC6V7FW
	hO0M6Nd6KObSRHd2uqROptmkDZ20xaGos=
X-Received: by 2002:a05:6a00:2794:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-826daa66f17mr8441167b3a.44.1771867426585;
        Mon, 23 Feb 2026 09:23:46 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641313sm7876162b3a.1.2026.02.23.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:23:46 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.15.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:53:31 +0530
Message-Id: <20260223172332.291881-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172332.291881-1-jsingh@cloudlinux.com>
References: <20260223172332.291881-1-jsingh@cloudlinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217801-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim,cloudlinux.com:email]
X-Rspamd-Queue-Id: 9F86B17AD7C
X-Rspamd-Action: no action

This reverts commit 60ba31330faf5677e2eebef7eac62ea9e42a200d.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Revert this commit so the correct fix can be applied.

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ac1e4482011e..a959b2c9ae38 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3263,6 +3263,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3333,7 +3334,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


