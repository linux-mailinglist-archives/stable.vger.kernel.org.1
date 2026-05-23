Return-Path: <stable+bounces-253895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HPfMkw2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E95BD364
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C7D8303C2BA
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5133120A;
	Sat, 23 May 2026 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLGuMEpt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C732E6B8
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512819; cv=none; b=iDho0atlYAyd6Hz81rGBagEHfErzvamCo5t0O3GTIt62/IGpeDH3smABP6gZ8A0nx95xwhSODMtiKKFCvkDRIjBDRrcZ9by5XY440hbRgfUzsUOK02vPwbjqLs11pWwoQCsKGB2FwZzo8dHhSQohsbumUpeeopsDntV4JiyUq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512819; c=relaxed/simple;
	bh=MlNPLgO0GOSz+HJrY3JUc5wo/gOXs2kCDyQ3NbipUxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S19U1CWVvtNznsg6m97RouHyAkWDiiUbiqMLcA+t4WUUtLwRv5PzHMx7zyzsHLxgzYdwqUq9G1DyQkcF/cj4fB3sSEPpt8MawZiJuCQY4TVJs6H+mqjo1/Cx7xY8n2cVQVVhCt3Vl1zWZ+r9r8tcBSL2Vm1Y3M18gfFVJXawXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLGuMEpt; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f30a4601bbso8133079eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512814; x=1780117614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbUNHVP+Sayv9nlw80jQ85O8z9BYRMlkqYBRJNlEspo=;
        b=mLGuMEptwCpq9Ti2JdnzJEOgRGLlZNVqo0BdxRtqdZafkX0Esx9HCcoBy2dQsiYSRa
         kvFs8Xq+DnJbUKjtxrpAzK2qFLI6cfSJN7xhieWqDHDac46Lvrf+iZQLEYBiS4M3SsEN
         wbNS48OsPQddRTpHz8A+iKawZy4/+44cGmgcgdaQH4QQe8pSfGnVkxtVsxZyL2sStg5a
         ms7VNlSrOLbzUIJkGYYNCTDgMFzKwfw3NBoe02bY1a1kQgMf4PcFIS13/OeqA+xc6JcH
         jDQkySZ4m90brEEd4NAXjbebCsk98t4DlvQuUN4+ftQj0FRmt1YmSqPescN+rfuZ2nvl
         vaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512814; x=1780117614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbUNHVP+Sayv9nlw80jQ85O8z9BYRMlkqYBRJNlEspo=;
        b=Q3oCd5+/OrdLsxEHHY18CoNavQx+/lx5/wxdrAtdXSF5n7Xq90dzLmaQKCpeEIUBIL
         3sazNNNE6TT27Cg1E6l8Gg46KDIWDzWKAKUp11C746gwd8RrMwc1MND8EXG3H0inuO4v
         JDy02gmfeIJewrxN1NB/IXAso5U2IlwAM9TA4NFysQsFAZPKxjH19NIN/lVLQm057rp5
         wO42nbDprJlzk1AhSgvg+k/rDSfBPdk+g7JuASvl+rNGt60DDBC/MDRKRGpfDppgxVvH
         nz1DXVNW2j6MwfR3h/AwZZWjomb09ZrjvuZ1iWQrw/6bKwSHGzbJWXqA/V91/sTppmfd
         9WEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YY788jmDdb4fVy5cZ7In/dscu7ol/ruGjKIJ2VtY+MzcX2lqx5LJzJJGrtXdR/ZYh79IQv+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2i5RV9715Cc4X99IqWEZnZkCk/m4IwYH6/cYN/EOSDZ3id7Bh
	5TXA88gDv9NOZh7IZDpavAo7iGjz9HMRiqir4OICHwdM1sjI3LFg23eT
X-Gm-Gg: Acq92OGI0pYemABGaGYe1rh66huivKg1YZwLhQhBfB+2h8/truFmk9R5rNAIdmsd2u/
	noG5GelqvnAfuQ6MP+R3MM8btrU6XCqMzPNERrcvsMINu0QejInQeCnrCwscVM0ZJO7QR6HCQ46
	KJIoENYwPHZwUQ1QV/bmEDe+QD9ghdDmeMHH2kK4Xb3wdPPEg8v/fjRCSqdmJvm5E+xpY7+o6JH
	bgIjqG2CWLB7rsFt3cX90KBnQgEg6lPUiGTPf1iDlxrYmWx3RA44OYoDPV11jQmof03/qcn3OO8
	ssn5DYLX5+W07IRGoYLSF3VgdOaQczdSnpywgUjZeRJxKSa0hG0UySXBi3Ld0WYfZIbpKkXMq8V
	tX5xLW7VU81zSvhLx73GhQxhQPCwh+noszFqBvMrwQ075yQjC2PRln5jgWoV/vuL4jLrOCXG/1x
	eFWfulbAG1E0PAsT2Uwfc0pbgJqmUon4g3PQogzUCRUXFYKSHjfEpGX66YyLKPB2nZvVreF6/Zv
	TEnPCEpaIb08A==
X-Received: by 2002:a05:7300:6da7:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-30449054359mr3500635eec.17.1779512813893;
        Fri, 22 May 2026 22:06:53 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 08/11] Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
Date: Fri, 22 May 2026 22:06:26 -0700
Message-ID: <20260523050634.501509-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253895-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B7E95BD364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The debug logging in ims_pcu_irq() unconditionally prints data from
pcu->urb_in_buf. However, if the interrupt fired for pcu->urb_ctrl, the
actual data resides in pcu->urb_ctrl_buf. If urb->actual_length for the
control URB exceeds pcu->max_in_size, this leads to an out-of-bounds
read.

Fix this by printing from the correct buffer associated with the URB.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index cdb46b2297a2..23e576500890 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1529,7 +1529,7 @@ static void ims_pcu_irq(struct urb *urb)
 	}
 
 	dev_dbg(pcu->dev, "%s: received %d: %*ph\n", __func__,
-		urb->actual_length, urb->actual_length, pcu->urb_in_buf);
+		urb->actual_length, urb->actual_length, urb->transfer_buffer);
 
 	if (urb == pcu->urb_in)
 		ims_pcu_process_data(pcu, urb);
-- 
2.54.0.746.g67dd491aae-goog


