Return-Path: <stable+bounces-247272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKq1OcUUBmp3egIAu9opvQ
	(envelope-from <stable+bounces-247272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F5545E11
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F35BA30117D4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC626390229;
	Thu, 14 May 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDRWyMGM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B9357CF5
	for <stable@vger.kernel.org>; Thu, 14 May 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783426; cv=none; b=mukeemx2iNVR9ZhCdOYPWYIeZX63KbXNQRf6m1yT8iWsH4bpTjH7mMO8kIHW5wtqUJY59uOjxN7iGeZK8KS2PG8p2xeieR9DZr+pp6QFvViUhm13paJIbMIcUSOsKDw5yVmnMqoj6qsH0bYwC4gDEn0WLKeXYx8LEiRimIQozss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783426; c=relaxed/simple;
	bh=Geh2ltdSeCVx2RDd9OVcFGSMPDFuS/R9rLGG9L0n78w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNkgox79habwkcQeP6Jl+fb0KI7Q0gK2vn05zH3v32JitxKclSnMAfXA3WBGRj/7O61dDukPRbYJkEtnKNfATYOkEcFcNnBsIlJtcHQRonnRWbizE5o110Q3tBHdwYpwBDhlQK5t7nYwVM0grKcNINHbvgf97vXnNz2IT1osOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDRWyMGM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d102471a4so82401775e9.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783423; x=1779388223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDvdudeeJAHgJGuZXL6tml+bzI7syuTzDcLB+eMLOx0=;
        b=EDRWyMGMjir7OpKYn0HyzUeZIzVBWxj31SB8FtQr49EyffcWq+6Xj2MscHdzqwhYNe
         qrzkEWhuxR4rdKZFvWaoWzeqSTmgCjxZm+BOuQ/ZShdhk1cXPLel70PEzZlx/7wxU938
         /3cBVSN/twyjYPfZUeugziudPcDBg4OrKm3P23dLVVm50kpIq/9u90WFFeTgSEGJLn44
         TOf+eXa0v9v363ViOyeUGoq72nK6U9nBu1Ngdj/lhkNfg0Ma5ugk/uhofJAkFommqTgr
         u+pV8I8nV0JVO+XaAMxR7NusL9dF77VblO+h70UIlYa102sCgBJXp84iLUWZHrV9XBYc
         +i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783423; x=1779388223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDvdudeeJAHgJGuZXL6tml+bzI7syuTzDcLB+eMLOx0=;
        b=WRNIbtjfZTQsFpuze8gI9eFaJWT6uGvoBhDywm1GcCBgnxsv1tHeU1u7ylIAfGOtGZ
         ulXaUuC/1oBdEyJ5SqaVedmupxUZKhu6FpLCoA368PFrnFXy9cBmg7NR7+1zA5a7prou
         PHMof2/++FNlSXLDvdyy3wDaB9bz029PJoX+uCeB5imswDITTad3ma4/xZPL4gbUDVS/
         kv9UOyAUViXyOQnSfps4lC2rh47azTEmZW/ncTlv1Z14tlb9ubgmaHwLbwyonLTm/4ZF
         luN/iwGA3Ycezlf8bxpG0PVmUSTivQciyRjk73HF0OKPaTVv8aKBCPsFGlvGNsGgohbu
         qq+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+w6YAAxngeq0djzCYjnnFFZ7cIMHJw3PT/nfCbspCiiJ9XrK/FNNaOmI+NOHnowb7rg7Vfaes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWbghKE9EYZJeiTHOD6WSKLEe5inaZkVH9GV9zhKa40C8Osnn
	AWZT2T0ve0e/Gy59NwIYoMFNwHCK4MIS8GgereNfQ7NX/Zhv0u/SMIDZ
X-Gm-Gg: Acq92OHo1/KAq2IGIhG5lIhR4TW77N73Wx+W3Odtr5swaIY48ysHRVlV2SfoeCID8va
	sh/+/c2u1sUNFMN1FzGAoJRQUGoW36DLvghUPIvt96GFWmM2avlKxs73/o2ptRDwWNqRVoZsRU7
	1YXPQtSN84GqzG7BhuJJY7NK6ielTBDSDogafrb/O5pcxQmEc3IlAE+Zjanv3ZkYZrxwc6CUliG
	caYgAKV+J+me3QkA7UuLsVJkaM+NMqCKnMIAt3yBwSCe25xvtuiG5WGMblmRxGDxT4ifvmJ72+C
	+KQRstgM9IUlcvCvl07vBCS1VyLUZK6Xkw4OppNnc0xIfHWLclNomY3rG2qq4W2iHNsjmAv2rVL
	ArZZTpu81a8or1+Zgl2H6J7pxaaNxi2gKj3aYSIMX9UhNGH63N0thQuztXzkfgmOIIAxaUAiLt2
	lP9REBYOR/4A1Q4QY+a123OPmXSzP6qEii/KowY+T1jVikIspZ0svk+Mm2UzioCn/EQj/y6vBup
	Np+/VQVrJo=
X-Received: by 2002:a05:600d:8447:b0:48f:e230:80a1 with SMTP id 5b1f17b1804b1-48fe6328b5fmr5516255e9.31.1778783423173;
        Thu, 14 May 2026 11:30:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd76801f2sm31320475e9.7.2026.05.14.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:30:22 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Thu, 14 May 2026 19:30:19 +0100
Message-ID: <20260514183019.49527-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C0F5545E11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-247272-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

Cache vdev_info->adev once with READ_ONCE() and bail out if NULL before
locking. Use the cached pointer on both the lock and unlock paths so
the unlock matches the device actually acquired and cannot re-fetch a
NULL slot.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: cache vdev_info->adev with READ_ONCE() to avoid double-fetch and
    use the cached pointer on the unlock path (Alok Tiwari)
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..9f764135507c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
-	device_lock(&vdev_info->adev->dev);
-	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	adev = READ_ONCE(vdev_info->adev);
+	if (!adev)
+		return;
+
+	device_lock(&adev->dev);
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
@@ -172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 	if (iadrv->event_handler)
 		iadrv->event_handler(vdev_info, &event);
 unlock:
-	device_unlock(&vdev_info->adev->dev);
+	device_unlock(&adev->dev);
 }
 
 /**
-- 
2.53.0


