Return-Path: <stable+bounces-244989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FnFC0PF/2nf+QAAu9opvQ
	(envelope-from <stable+bounces-244989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 01:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FB502024
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E8E63003726
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FD3D75AA;
	Sat,  9 May 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvrA9ICK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE802F8E81
	for <stable@vger.kernel.org>; Sat,  9 May 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778369849; cv=none; b=bN0Lp8nnhARrEnPZa6Nv6dS/RWyWxwyJm7/dv+E2GzybEHdUTOBQD3dtyKn9MNHS2l9wEwPuhHtzR/xHc5k+pzetK1I2bKw5U7XfRwlaoYXGMgmzOo6ybjoGfZc7sxjjaMhDA8dRAbqIZNWjftsQhtO7zZiPREKMrRW/k+sLMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778369849; c=relaxed/simple;
	bh=wB0rO4Vq54oC22gYYNsuT8CPqOwfkNa++6ggQfeDxUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVgZZtB52W53Zga5CqTG/0trQSp4kFk24OrwBV7gKv75AF+CDbLaxd6TbE4VeNVCwPU24O62uzmtzZ+jfMS5CSlco/BfXC08X3D5GpAp+4L3il6YAerYRtJ+Uc/XibhepU3bnSIvHQlZdJhrPkmwgJUcj3XJ756N+cY1fwIRpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvrA9ICK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso5988145e9.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778369846; x=1778974646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r29aosCtCj2cefpBkZvqnxVffaLPnzU1untTuZlKxNw=;
        b=UvrA9ICKfF0q1rOVYvKosk/Q5KoxjckPAityq4ZbJx2l0IW+CMNpXxwVW4ic909KnH
         625T0nwaI0wSxHhwMoOR7/A7bOqIqqYamNRNhcGPl8gtlhWd8M3quIajS+umRk8M00br
         mUOf0ji1pfWCIhg85KmDwyJsRebYmFfCCUHwAEKm6PWjhdHLrUI8uGBBer3SecJUJU5u
         kfR7sHiIL0aWsDVCGwLgJIM2mKRCd2J/EtWL9uYqcSpIIWWPV5P0cxiiHAINk38MX5Wf
         4lfL4qy6Q5mpQbOjtyD2jxIr/slAQqde/jV44HeMFbJQmf+BiU/sET67IpPj2JFqQ8nM
         vzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778369846; x=1778974646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r29aosCtCj2cefpBkZvqnxVffaLPnzU1untTuZlKxNw=;
        b=EHiVVaOtGC8KKWTN2gb4N0NYsNE9gtlhdP/SHLCwJm68+d5RI4yEQd6HFvD/YgawXt
         5zanVdL0csvwB7SsYZKuEx9i+VbCY/TZSIh+/QBZECX63Idh4VyAMJKZb29+Cbxa/770
         f/KAoQnCsXgw+lDv+qn8HLf8p3eN9Hg48jwBft0P9QgaHyhCCML5oA82UZMwVP97PdNX
         pLcPCTQyuFscGKJ/HiJVZ1y5oym3XseRkDKjf+BcdnkIiEnXelydoStQfzY0o+fSPPvo
         MIeE0HsOxFtnj46i5l9dh8gOlFl+DfcHGIywbQY7gie9q+Kp+++Y4gICtS9ksZGpt0yK
         V5Aw==
X-Forwarded-Encrypted: i=1; AFNElJ/1TSnWVUKFrHjdsLZWBX3dYq8E+HMaxPZfx+c/W+h6SHFnvsJLcmncxzMY6SFOo3soyCxw+gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyoeof3xPqzouDLYxymmdAyXkeTSidko0Ydi87T9h+7VILW8U
	4r8HZe2IsD9wIypPaoEvmSEGp2IwwGYzAyVm9di+XFCPAYGejSY/fdYh
X-Gm-Gg: Acq92OEIIUYBuHTpVJqmKBiLMqQulnmAnQfCVzBJMw+uU3mkR+sRe2GqibU4BrB4wxe
	39XpFIOU6BAhW0CLfFXvjduQpBnnsFnPlcSR0uiAVpXxMIOyIYvfO2cyl/+m9ACWh+++IiQqkTV
	MQwTU3EHFcX0OAaEX6LB/R2PDV1mpUHYRX0oRxTVU19bM2yS8K+Z1EG3h1j3W8hI34Zj0KwDFDe
	hEuOPkkBtyPDVOHd4n5HQGxx0CWolzRp4Td54zagCrz0Nvt/aN1WU5Gw7djYLHn2lofa/DD4zyY
	bvrUIR5zLDsvkCDDi1Nyr12LDXgpEr+4QKUw16Y2mLfECoJuc9e80wBYGKxCgF1JLiFLOs6/c4k
	MAYCLhi3BZCB/opIfi8Uzc/KvbDUNSCQD/x+LcxFDWUJTOEWRpPboAJkw8f5nnRy5NtiKXkqmE0
	smtCnku1VZAF3LptEXRVd6v/byLw4stFkfQoJxfbaojIDrWfaW2SWRANiDxk+K6cvyGGXziin1H
	UGueaenuY8=
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr271656275e9.4.1778369845918;
        Sat, 09 May 2026 16:37:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf496bsm43195395e9.4.2026.05.09.16.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:37:25 -0700 (PDT)
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
Subject: [PATCH net] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Sun, 10 May 2026 00:37:22 +0100
Message-ID: <20260509233722.111895-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 201FB502024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-244989-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

idpf_idc_vport_dev_ctrl(adapter, false) sets vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which derefs vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

NULL-check vdev_info->adev before locking.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..3ba52a80d52f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
+	if (!vdev_info->adev)
+		return;
+
 	device_lock(&vdev_info->adev->dev);
 	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
-- 
2.53.0


