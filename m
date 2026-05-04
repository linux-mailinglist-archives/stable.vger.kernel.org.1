Return-Path: <stable+bounces-242976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u9RlMUNw+GmxuwIAu9opvQ
	(envelope-from <stable+bounces-242976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714124BB73A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42733301450C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C076392C34;
	Mon,  4 May 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFfYAGX0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F7375F8B
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889313; cv=none; b=uCopJ81pEV6/fzwfkU0pSXwC8ctJZRL7vmv3hnCSQqGSeJLLkm1rb6wgTfsXuwbT4MBpoDBOYYHnk6JY+sw2nc0GL/0v+clyeNUiigwDf57hWbjlRB0hC+l4Vr0bDOA6EyoXOVK0zH0VCL8L1Vm/gbJBFeIhWE12NCn8N7wpIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889313; c=relaxed/simple;
	bh=pcbrlB3qHsPLc/y90rnx1LrG5b7iFx58tWFuf97lMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa3Gngj4nyyGuqF9yhn5YQouoNqiTTdc6FvX8JSo2vcVRHcf0RLatEAN5/uBq7apRUNBrykAnlD1HilV7OCCLob/q4qDk5CxPRDx+m0MHe9ZkDlK6w4tm0hgfcr5zSuyznleuQVAb70uxW1NAY5P90UebILbealo5rdoyzHNzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFfYAGX0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59dcdf60427so3416395e87.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889308; x=1778494108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=XFfYAGX0vIXPtCpbsD4kyc5I2cT9bBLjwffoBl7nKkEYnuDfT+/UjNRGrfv89lms2K
         7eyrxDHX8Gcxs5dx51ho+nsrojwAKrkJfO/KhpdaRtbkeCXxZv+CmSsAXvdIW9+LdRxn
         s4v6VrLECqUGSil46WyoJr3kGErya9ef/uKcEKkDnvm1dUQoGmMg+j3cH87L9iu1Hfjx
         18PXCmttSPiSHPAekzGw9oLN784QFfvh2mRPeSTvkHKHuw8qy/NEHzb61aCdovwovbh8
         AdevJy/CpEDkvwW58p1WPz5i6+yoOvnB4dcsRUf8NuUvYLQHyyMAm60PWONEPFInPmCd
         Xf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889308; x=1778494108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=rK4gunszNev7wLXqSVfNxd0SWBMV8QA6ZVq5IcghgKGMk06RZBPyAs8F49hKYRITyH
         fp95iYrgbdnLpBIrcU0zS4V5A6qZ4kPOHCh1TJH+7dvTDpDloJqUen5pJiQre4S8qFlf
         WmTQSYFgfJmmUnsMeSDFkn+7tSoPm6cATdtHeSZdS2XJphhsNIYRf+njOA7Fmua/0or6
         /KZpl47HFg/F6lJOxin9swtXsRQqrgMP+oPEU84isPNoXanIdowOG5Yf0DEgbrkL3KD6
         NoswVSlE7DR7o8NyEH8WomBhTboPQtXGdnBUzPACXBicqTQwotmGIok59nXUvqCt4qoi
         6efQ==
X-Gm-Message-State: AOJu0YyOmG/RjYwd31vUCSpPzIeFbrG0dBCbca5yh13fAYyhEQkTwG90
	U1HrYAMBkuZ4SAjSmf2Lkr4KRf8Z0LeAhHkfGXWnUTXiiwsZo9ktxpt2
X-Gm-Gg: AeBDieujLkjfO8EzV0J4Jf4VFiu96OXm2QF7yJ8LO1oqpLwSWqcmBXAtNcfmrYOD6HO
	S30oEfjo2cgnB01ZgzM2MLeXyiPbBwb2Sjn1OZuIyGReRFZH1hf0l9hJM7hMd7lJtuRyNSikVVL
	HddQU1b2mZGGZXCf+dvm96k1D5cCZ1asM+wLLDEWqs65YHJYDa8JbEoaBrwMD6Z/wG7Q9nllpXC
	OIoDkcdqjN570x8jojGNlrjqS197j4XealdJGtoWgwrx2mVcqpe+gNddzZgJ9zJTlQY3zBTjfpI
	50op1zp5pAipA13gd6+HFjAwFC1cvpZbDDdEYjT/Ra3viRx8YYTZ3BGsOnu5QwI0sgvkMBkNUAR
	kgJ0X923zPlFh7aOKm4j/9vQyzC+m4Pqrbtc5c4uwZwpsanoSjUC5HETeOdLvzs1wUgc9W1aljC
	/ZNyvaJBxyptrgUOtJFd2B+ILObomkJiorNg9B4FFs2xxbK3E/3H2Hr0EzNDvTrMwOq84/q18=
X-Received: by 2002:a05:6512:3f08:b0:5a3:f305:a50f with SMTP id 2adb3069b0e04-5a8631bdfafmr2578178e87.30.1777889307519;
        Mon, 04 May 2026 03:08:27 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c33c2ecsm2856217e87.42.2026.05.04.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:27 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: vebohr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 4/5] perf: arm: pmu: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:19 +0300
Message-ID: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 714124BB73A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242976-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When platform_device_register() fails in arm_acpi_register_pmu_device(),
the embedded struct device has already been initialized by
device_initialize() inside platform_device_register(). The error path
unregisters the GSI interrupt but returns without dropping the device
reference:

  arm_acpi_register_pmu_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- acpi_unregister_gsi() called, but kref still 1

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch before
unregistering the GSI.

Fixes: d24a0c7099b3 ("arm_pmu: acpi: spe: Add initial MADT/SPE probing")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e80f76d95e68..c2defbc32ad9 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
 
 	pdev->resource[0].start = irq;
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(pdev);
 		acpi_unregister_gsi(gsi);
+	}
 
 	return ret;
 }
-- 
2.51.0


