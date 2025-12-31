Return-Path: <stable+bounces-204343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A29CEC016
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBFA030198CD
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64D315D3B;
	Wed, 31 Dec 2025 13:06:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4615BE5E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767186362; cv=none; b=F+r9s2qPhAIFcA1lNhrOBwai329lh1Qr5VvMMOlnCTAoRFa+WtjGkSYh7ovLEXm7irfQfZIlShsRxgWEcnfEwmCaATbs0tKx3YbQlKBUrKo5KYdHuHtgMNo9WKHjS05rlDTG59R8bkp/xUmgoebCg5zinZGQ+UUUD1Ta5C06BDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767186362; c=relaxed/simple;
	bh=MDcd1bGhccG6X9ai4kuqFpZk9zpxTDM/8y4BfsTO1bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hRlJpEkLdzPVVUc2Y/thKne+zfzZB/RYUltZaPQmn1QIgJGhlnvh9/e4gd6zCLgyUfp/BLbnkpQdjHcbCb/9Pu2nUCx/SI6sGmRE6oQ08+XWGW3DxBUbB+5Dmh2mPCt7SrzTtMsFhq2diivSLrvJLu1I6LIAvVPvlpa7ZF8klnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6d13986f8so8986283a34.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 05:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767186359; x=1767791159;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbnElRqbRnD4WG3UkShPsEoYZpnGixbcSQcdBWQX0Ew=;
        b=vgfYm0sxrqw8sNlhxANdvVcvT1RTrBXkY6yzW0vA//ojn8Uk+w3L4xy2+sM6t1ppV0
         C6Qk3GeMsybjfOkJtNgQ28pCYCq9orS53HomZC4SRXbuc7TZ4A+PINoikQnSLtUpEQ5D
         6PO1mcvjc6Ym40D4UJGgabdPE2oBuxCJynTPwQqX+kS20CrBsJXsYJXquxz52roI9Yyi
         ZO5q3XqJxWaECRnsuKb3dH7KhtawLo0fuwEpEcmbPGMdSwlfj+nOuWpkJE84ETlPSc2V
         yBJhS1Oo/R8GhP2+SNPISGXJeOMbF1UrMmFj/qubT7V+PFPaaSOhVDC7MhN6o+c40qnv
         ycdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0e+OmaosvK6wlfmiQYFk7Af3dT0mDtmBQt2e6jtafCw82SszhZVtBXR0g+ghXt4GA/nz9/Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZK0gRp6qrs08bkE6m+B3Pd7qA2MHCxFAlETQABkTpNXwrDvV
	IwABqSVYHPqmJOMsHtHTvnRPi+ghkep868Zho+O3wtmAZC138acLvgkp
X-Gm-Gg: AY/fxX5ii5fmFNa7ARoMIQgDs0Rmu0aVaYT0UZ2+LA2iYb0ZpFi+zj57peemjoikh0B
	WxxesaKKuSMcq8tvghBToz/tM/6n9mF1iOl56lU85HBEadFOzW52GphAC2ZmnptRORKn1PGw2E7
	oTCq9R3Y3CFDO3Hrdt/HhOZsa1nl7V4HR4FfRjzN2p0ciMivcJt7hxdY260K7MK6DtYaGiDyLjN
	1wxDHp4117gUZVfPtWkFRenNX+4rJke+elcPPOB0McE1YdZNdNDZKBJzKxzhBgxnUdx2vHw5RMY
	YZPww+SNqHTbnBqUAxU8ZTgYoEyGKURGzbMPkDYT2LN13gkvxA5NZOsUfEHnQ1RrzEogDBpHCcY
	pYDrugr3LqhAM7F78eD8/y+fOWN+/lJM9fi+THG//QwsP1NEHCzaaTa4PnujY/vCmPtwDeW8G0r
	VmEMKCv893Tm2AGA==
X-Google-Smtp-Source: AGHT+IEYrzaVvZv/bIMY6srXwLcMFuv6qqbv2T7g2ZyO0CjurEzavAPpm4aq7O+Bni2FRGchzZfHgA==
X-Received: by 2002:a05:6830:11c2:b0:785:6792:4b3 with SMTP id 46e09a7af769-7cc5926f15dmr16552158a34.10.1767186358781;
        Wed, 31 Dec 2025 05:05:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667281fesm24446233a34.6.2025.12.31.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 05:05:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 31 Dec 2025 05:05:34 -0800
Subject: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
X-B4-Tracking: v=1; b=H4sIAJ4fVWkC/yXMQQqDMBAF0KsMf22giUpLriIuTDLqdBElSYsg3
 l3U7Vu8HZmTcIalHYn/kmWJsKQrgp+HOLGSAEswL9NqU2vl4laUb5tQ63f4uJFREdbEo2x30yF
 yQf9g/rkv+3IFOI4T3nSalG0AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=leitao@debian.org;
 h=from:subject:message-id; bh=MDcd1bGhccG6X9ai4kuqFpZk9zpxTDM/8y4BfsTO1bE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpVR+1FiLsstnJScE9knBwtFyXA31Y5m9+ra75Y
 GxF3pU4EnGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVUftQAKCRA1o5Of/Hh3
 bfaJD/sGSpBK+ivtrCA5bmOPt6CGYezAsTYL2EcFDmCkdYSp2NUHIj0RjAiRmCHC/YEONVg5xWJ
 KUGiQ0kfwVmtB8IpXO7iBxKtvM1JLBscyF88FzpqWhf5xqL2xBgTKgQXMdtXuysYDY4/EiEyAp0
 M1i5v0IKphUqV9O19F01GkikQuYLO/J6F9a9rjRaQBh6SDm+WKP3eVqGuP3Pb64zWRTqSwmFQrU
 svD+BFYUjaetg9RHd7yrPih1lX29NejtU33VEGdodZS4zwBr+vIMkY8CE4sAdahzyLb6PRbwQLB
 ZdmRWNkjfsqi3qpu9G9N9Di4KspHFeWPepVXtI0j7hjbFBERJNHWkPXQKBKyHDI0VAVAA8eVTW6
 T+AL9arnKOEh0EKK/qhI76SgIQWSGVTSar0XP7E6y9nFgdihoBQ1YvYTKdn7beRBZqcyHI676iN
 w7zJaUPhDpoSMpnstQ1Ol2skw1P2w+54CNfKY4DZTvjrZ4x/F+KLXQdWmn+U6YbJK5s9mhMC78k
 blVyeWf+5SDHCU7KG1P/RHA2LBKyPBuSC7O3aUniARJnNqC3cDKwGcAzHmu4vgluHgBCTAN+9I5
 1SYLzAzKlbikZmbTtbnHNzt1P/+J9IvAwpKcjEZ1HCnva3EoV7jngH4ojExALGfhRqsiG44bMvJ
 Gx3RixyKlyf/dTg==
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

Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
bnxt_ptp_enable(). During error/cleanup paths when HWRM resources have
been freed, return success without attempting to send commands since the
hardware is being torn down anyway.

During normal operation, the DMA pool is always valid so PTP
functionality is unaffected.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a8a74f07bb54..a749bbfa398e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info *ptp_info,
 	int pin_id;
 	int rc;
 
+	/* Return success if HWRM resources are not available.
+	 * This can happen during error/cleanup paths when DMA pool has been
+	 * freed.
+	 */
+	if (!bp->hwrm_dma_pool)
+		return 0;
+
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
 		/* Configure an External PPS IN */

---
base-commit: 80380f6ce46f38a0d1200caade2f03de4b6c1d27
change-id: 20251231-bnxt-c54d317d8bfe

Best regards,
--  
Breno Leitao <leitao@debian.org>


