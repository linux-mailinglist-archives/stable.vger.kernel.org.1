Return-Path: <stable+bounces-204749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AECF36A6
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC12630B50EF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68733469F;
	Mon,  5 Jan 2026 12:00:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA91333451
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614446; cv=none; b=qr/kdmehX9yESuBlK9kapShzCRTislwXkMzZCmWK7Vr/SMkbT/0A/0DHWgnTsyi6Uo3qt/8H8mWlUkjyyUbNd3+Kk+uInGweleiXB87qvzFQkdLNZZDMiD1fmOIRCCqgp2bSWUBAxxWPC1GOgIjJB0/HyTCBFeW/WoAX+ZP0OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614446; c=relaxed/simple;
	bh=ofkk3fDMXfaDqdL6mAbClhIKaLqJwPvhJFxDHVlpUhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r9Xw69+trwUwQWk1Zj1KzAsMY2TgIndQDOCZZJNAWdZHzLh3Cw6OnS6pEYIxtB77onjPkz3J5yQF/iZLH3bg6UO/sRkGkvAbaMSepJCrD4WnO15+Rq2iB67kV6d5zEpAiOpJbeej/7UtY6Zb72PBEDz8OpwagmuwYwOmjDYG2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c7503c73b4so7527357a34.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 04:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767614442; x=1768219242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nGI90FgNg6Orxw3QE9KbiBZzXhpcXBalJ+YBtICfE0=;
        b=BdiJGfy0OOsO8NJO5OuZu4x+D5LvxFO8qDayGDfCf/nr9muU2mSvGCFeybTcXCmnzb
         W5OUYvytercHH6kr4UPDAAOsVJFd5+/bXN45olFQ6h/R7j0aqlrfHra6llgSH63bhHkI
         fvELTnmAgOqp5xvSdHejitQL2p5IRUQCL1mghd3ZpcnJYC/YPZ5ul1GkLEai2aWAqWtf
         wIxI3x9a+ZpJSQztT74FcevBEEEHMYwm8vlgFUSlm6aZGqs3yHUv49Wf7cUprvbhpzXk
         gve8e+3CDvBy2Hwv79jLfIX5vMuZxLReLb4HrZoypfq6XqI+uRJNSygD0bPqLTq4Ia4C
         1GOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7AWpB1Lnjso4BUl/xl047k/ec9hDaZK0P1Vn0JMBTK1yAjt7+xY4Xz1VoxqCtd4yLye0Hiag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXb8pn7DyOyWQtWHcXkUOQU0fL3dRxlY1doAXCxViEWk7I/Hs
	EyLZS/S/6oIIEcm7opMroNac5z9NeKGcIWElwNruiAcYw+bM265XazR6
X-Gm-Gg: AY/fxX4IFguqu96rsvBeqBB70YtJPNlPgIt7lYbxijuUPoRZqTh7G2PQOnmMpRt5pme
	SILhbZYwRrRp3CX4s+xZB/j15ldE277glbwsVs8CW5e4JSqFrX19Ng8EtiYai7mp7cPCDsiM/U/
	OZSYEt51bt7kwazQmoYwYKjMyrRPCDpVQ77Vpdq3a9caaCDG8f5++5y7S6MIMWOF6EuAIt1B4h7
	fKEMoaxVVh/UJn58SMSYhfkSpe3vo5NBufJsMQXJOZgmVkYvLI5w8wuVJP/y6sExo8ZQ6BlzCQN
	h+B1qjS6wHYGf3Drall8TIEP1NVnEWqpSuUNxufCCIuv/ddw2CFDRPZoQFhAXBizXHm4royMiBC
	GbUMeKCL8cTzHn23bTd7loJoD6RWHOHrbCPYnoB+tmcEvpQuJfvLVcX/SNOgcFyz5HUkmQXJJP8
	azy/XGzLvzPaLJ
X-Google-Smtp-Source: AGHT+IH8deTVPke2vXyRK4ncJdp0pK2ey5NcMLE1Kk9Y3AUkKsrGoLMbt59kO3J3OMAbGgUYNScKQg==
X-Received: by 2002:a05:6830:4119:b0:7c6:a2da:ce4b with SMTP id 46e09a7af769-7cc668a4bb0mr26188912a34.5.1767614440673;
        Mon, 05 Jan 2026 04:00:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667fa674sm32887148a34.29.2026.01.05.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:00:40 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 05 Jan 2026 04:00:16 -0800
Subject: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
X-B4-Tracking: v=1; b=H4sIANCnW2kC/1XNyw6CMBCF4VdpZk2NUy4WVr6HYUHbKYyLYtpKM
 IR3N+DK7cmf72yQKDIl6MQGkRZOPAfohCoE2GkII0l20AlQV1WjKlGasGZp68qVeHPaeIJCwCu
 S5/VkHhAoQ/8b09s8yeYDOLKJU57j5zxb8Iz/3QUlSu1b66hpWm2quyPDQ7jMcYR+3/cvpkq7k
 LAAAAA=
X-Change-ID: 20251231-bnxt-c54d317d8bfe
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=leitao@debian.org;
 h=from:subject:message-id; bh=ofkk3fDMXfaDqdL6mAbClhIKaLqJwPvhJFxDHVlpUhM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpW6fnW7MzHTVeSjf5pSIQjcuOIopl/jVai0jMP
 G7iyXAaFYaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVun5wAKCRA1o5Of/Hh3
 bWsWD/9JLfEicI2+EMVUr7Q2qY/ChMUsiCsxDBicYYI8wwK9tpyNuyFextX2bXbYY8obVfl3FD1
 a3Nah9zOpJ03BQhU7huiSbEMG58BVvbuuxFuZSq5jHuSbXwTdhje1+4KGuTMH9+uRekVWzVIUME
 mcX47ZVNQ5yLG4jks86VO9l35fXl9KNjRIq/6s04yhAXFqC9/qcBQD5VWsp0thLEfwv3ii95GrY
 7ew+PhHMsfJORRW8aVGkAkbMkYzXzoCBkpMa4aSCnmPLvASLWaURTAkOMQwYpKMjv29PcvVCM2p
 9a6Xpx0Hqj8zW3Rp1M05eJg/mHb7Teho44fGLOR3okE4SGx2JJA5w8Srz2Cr7/8I6l6D8b3S6MW
 HCzslV+zyzazoCFBO+V39CqrNrqx6mP/Jj2442rbHNoJVeh4pdmokF1HljLpeloJhJ+rK48nqJ7
 +9NmdtDxtot9HoBcDnAyjGyCGFOeXxOsibTMkHyTRljahrBXmkVBLzGSUFg2EvpIZIVdOfjegoA
 kKswRQQqv4LO1+5qy/OseXyXYNXAPdGIzDi4D23e/IntHd7sNjAVtGDeyNGL5rsNis4tw2yNatk
 1J0eyxXTDax4ZasCYGekoIW1kC4zsh2OgegB1VRTBWWqqLuGiZQQVKBo6+xKKwBd+CI7BaQoUEf
 xYHV0cjCWwncmRQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When bnxt_init_one() fails during initialization (e.g.,
bnxt_init_int_mode returns -ENODEV), the error path calls
bnxt_free_hwrm_resources() which destroys the DMA pool and sets
bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
which invokes ptp_clock_unregister().

Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
disable events"), ptp_clock_unregister() now calls
ptp_disable_all_events(), which in turn invokes the driver's .enable()
callback (bnxt_ptp_enable()) to disable PTP events before completing the
unregistration.

bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
function tries to allocate from bp->hwrm_dma_pool, causing a NULL
pointer dereference:

  bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_int_mode err: ffffffed
  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  Call Trace:
   __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
   bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
   ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
   ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
   bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
   bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)

Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")

Fix this by clearing and unregistering ptp (bnxt_ptp_clear()) before
freeing HWRM resources.

Suggested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Cc: stable@vger.kernel.org
---
Changes in v2:
- Instead of checking for HWRM resources in bnxt_ptp_enable(), call it
  when HWRM resources are availble (Pavan Chebbi)
- Link to v1: https://patch.msgid.link/20251231-bnxt-v1-1-8f9cde6698b4@debian.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d160e54ac121..5a4af8abf848 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16891,11 +16891,11 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 init_err_pci_clean:
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	bnxt_ptp_clear(bp);
+	kfree(bp->ptp_cfg);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_hwmon_uninit(bp);
 	bnxt_ethtool_free(bp);
-	bnxt_ptp_clear(bp);
-	kfree(bp->ptp_cfg);
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;

---
base-commit: e146b276a817807b8f4a94b5781bf80c6c00601b
change-id: 20251231-bnxt-c54d317d8bfe

Best regards,
--  
Breno Leitao <leitao@debian.org>


