Return-Path: <stable+bounces-223267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEXmN1baqWneGQEAu9opvQ
	(envelope-from <stable+bounces-223267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 20:32:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59162217939
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AAE4300D928
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB32E7185;
	Thu,  5 Mar 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDRQapOY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182D13D891
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739152; cv=none; b=hqLoAxjrz9wLjFtUeTqt+zA2M6I9TkerfYS1kREOij8kydlMgxZfLXXARm87eQdDxF6lrkTAv9N4scoaDocpHBw6ql963GkNSf0EOup26ibz7Iiqa5M0TjmsrtZhviPUk1HnmMK6YTwh4NBunInfODAMq72MktHo0If9RWKLOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739152; c=relaxed/simple;
	bh=F8yKZIQV+gdODPzHgzDqYospjCHYKr90Bu5fAIrXze8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYlcEuE31KHV+W/UUp4fgE4SGlJSaxWuPKuVFG7s0Lv2JXsZ7QVYP/yv6PMQrFdqttDNTN9QuY6wtD87IDRZ+w7DsE2tHf8k2V09l9adkoWwVkPBHS31SUuZfI/PbirZxX+r8dPgziHlUWgeE5gVZx4EShRf+W1cV3YbU8/Xdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDRQapOY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79628fb5c05so69926047b3.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772739151; x=1773343951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWGzOFn/dLr+0JASN1nlbhCeckpCAXU9j/BcQj2Bi/E=;
        b=lDRQapOYXEvj3gPjQ9I9A+S9dBNNdk/+ddKSWxW5fivQ1N3+0SMDM/jUGWSDJMgdPO
         U9M8OSa9qXT5Z84a99+vimxSvvutWjagYsWk5gVUhBTXud9/U99VDhtuSAilmdi7Utfp
         ls6BDTJonHzZOiNszgM2PSkVaA6z7v+zu2qmZr8uCDMpSa/xOp4RtZaYUtSc4+cp6GLn
         iGPjPhK18JkCI2ebVDD3fnWSNxv298tCDwX7hHO+EjwxeP42dTEF6kB+OI8rDCIDu145
         ohYQuqzQSF6+GyYufxwpyt8YbzY0X3Q+Yb/RwprfsqQEOiZ8Qr7JmnJOftJzg3/pOD+T
         fuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739151; x=1773343951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWGzOFn/dLr+0JASN1nlbhCeckpCAXU9j/BcQj2Bi/E=;
        b=ICXqnbz3qqE7fsxAMwMD8EbfyozN8O6DzJqbucjiNe47LDE0YCbevjmfAnL9pYhG9T
         YPtcS2Li1a1/1XgQktZR4PM4nRG2X/GclZ5y/vYwl0utCJX3nW3hnswjlu7dyEyI+KIG
         3esQOLdO3F975IOx/pOd5ZBDuYGszZhqmRDargX/aBBnsax+oE6ZHKOlFIhUdRxY6Po8
         B3TqIZ1vLuq0zr+pEC+raE1k6T7K8eBlVL/XaC8Ess3OAdUZjyVBLYFs3VU/eGcjkJ1h
         8u1D7ahlWRnJRqtX+hi79wvk376ND/NYg2iCe5bPMv98FftefyzUTT1SmAxbMZC97gq5
         b0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXRBUmZEyoxAWtEN7nlBO+pwZ2fPJob2cXTLOEXrgqrovCBtV7tKDATAY+6lMPh4DwnxABQkpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9t/WOtzv8gbSysErPf37e24dgtfvKSzAA9SbGIE99SBLXwCxL
	4iYcrS3MiWXeKy/NRRMRtv2isiQoaGauGnzjRBviEI5yvNAIZhxBKi0lxEhJ6h92biw=
X-Gm-Gg: ATEYQzy2zmtYtZ6chPkYxU2IMoJ0HA5g3THJrVmEn9BYe/FEUbeVtZx4gTyQuJK1z5g
	4IkVtEYN5MJGvMUZHZLBe1CaBsLn84K+qxlDGMDZOdRxyEnoCVnWkOStQFFzqTXYegDfqQQ34/M
	Zj0oH5SuEtVoFyya4fYGxI9uT6ERv+12Js7wi+INI9MPuE5nYmcP+mB1c3QhEe9yLj+vsBRAqeb
	yFdoZo75xyU0i6kwnvmFMjyY9ov6k0RLFdByIhjBCYcLxNG7jm1bF2BHlzD85HHGlOiRROF6z/T
	4kGohYdI0z4JIsji9MMWv/oDDdN/t2dHhbuuU9HR6OpMc7aRZM9hrZ4BXc244TIiv2FgqOkDKcJ
	Izt53XMxo3mR+DHGTMx3aYAaJmDb+AFixWI+5ky097YslHeUzkMuXkf2+f2gaOs+joEbZJya1XE
	jG9Xj0p4OP1ACGm4oE441uPzcAreV3SKIxy20JH8qVn87NPO/wgYqdJygy
X-Received: by 2002:a05:690c:4446:b0:798:6a34:74bf with SMTP id 00721157ae682-798c6bd9218mr64283397b3.5.1772739150760;
        Thu, 05 Mar 2026 11:32:30 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a9004dsm92357617b3.6.2026.03.05.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:32:30 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Thu,  5 Mar 2026 14:31:46 -0500
Message-ID: <20260305193146.304526-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59162217939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
set_capacity_and_notify() without checking if it is NULL.

ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
(ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
handler performs no state validation, a user can trigger a NULL pointer
dereference by sending UPDATE_SIZE to a device that has been added but
not yet started, or one that has been stopped.

Fix this by checking ub->ub_disk under ub->mutex before dereferencing
it, and returning -ENODEV if the disk is not available.

Fixes: 98b995660bff ("ublk: Add UBLK_U_CMD_UPDATE_SIZE")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 drivers/block/ublk_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 004f36724..41ed30a18 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5006,15 +5006,22 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
 	return 0;
 }
 
-static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
 {
 	struct ublk_param_basic *p = &ub->params.basic;
 	u64 new_size = header->data[0];
+	int ret = 0;
 
 	mutex_lock(&ub->mutex);
+	if (!ub->ub_disk) {
+		ret = -ENODEV;
+		goto out;
+	}
 	p->dev_sectors = new_size;
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+out:
 	mutex_unlock(&ub->mutex);
+	return ret;
 }
 
 struct count_busy {
@@ -5335,8 +5342,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_end_recovery(ub, &header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, &header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, &header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, &header);
-- 
2.53.0


