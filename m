Return-Path: <stable+bounces-241884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMi1EboE8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0DE494A3E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BB63064CF1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7D265623;
	Wed, 29 Apr 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2PPIDSk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332A154425
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468315; cv=none; b=s2evDxVhBrWktxBVtFMoWgucaxie36TqLtUpKp61z/e6FB0E8D6FLSp7CumYE9XI2B4S3vfVq6NquG/iP+HEUQxZCbc/OSGO4njXtwmfvUAf+OvQWaZnJAEWpPk8J1APD3W3BEGi7bhAawBTDYN8TqXHdGes+Q43Oci7lEpvtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468315; c=relaxed/simple;
	bh=O60dEyNAeg9/bJQwp+6nhzKbZ4rJnrr7+9Wd3xUIU2s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VJWfZLqhKWuPtSFShqwv8hFPXvXX7sfhnXgZ4Wh23E5G5IBkwGwqM8pe3iZcGwf2J/8VMVyhSf5GrgkXJyh/1mwsfbyomib/47EIa6BdPt7+yA4iwdneowl2eXsyvqv/x02nw7M7l7dzG9eRUrnNJrheJ9d8LSuCA2HItXcH+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2PPIDSk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d70b3e159so6722049f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468312; x=1778073112; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV0dHa1H26dNJYdioKxpR+rFrwvFtEas71faBHPqnL8=;
        b=c2PPIDSkSoRsX0uq+pdXq6oPFqObqHMvxOKRlKQQES+cYr1wBbP6Hf9HRKlUvYDBgg
         jJP88AneBtpG7PhxeMqCd9G21R/QHYAXZpaiyoQvsHrbs8K5b+XfGlK7zFKjJ7/rh9Xy
         dgXFtjV6RXvPWZpXkI2pkblqEzRaDbmJM4LYaV+EEHm6u/ajTx/jJe+2zpOBSVvVqby8
         A6E8IFRugXCo5YjyGKMVvK5LPWMaSI/vKFG74hTp1wGPjC+vQ/Cto2n0TqRhJJpQcr6y
         40xrx+nPwxFNCRIbr6DtGqCZtzLOPFIEKJUgqv0dKiaXxVifIBS2GTNv9M1/aaFJhuZ8
         xSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468312; x=1778073112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV0dHa1H26dNJYdioKxpR+rFrwvFtEas71faBHPqnL8=;
        b=fVlggEcoVhZPCfR/Tx+CCAZjJVDq6tyYoaLoUTWmKO5TxreWvRacS5pv3F4nN+om1d
         puw9wjKfGseRNbpg8DReQaZEPpRGrD9bGDH8rO6inKhDJyAlu3LW5k078bqvaNb0buIl
         7bpP1Y/htvf/3er1lqKtyBrsLa/iaMlGqld2f2MApolBXhKMmh5p0TuDgjUPVdlkLLGR
         OKdNYdkL4VVgRHs98/+BzAmd+xxnsKCir0SHN9bT2TqXLbPVoCA87UbAzrICwTGYN4kU
         Nl0G5k4sBO5TnSZHZ9z/1yj4PdKm+ihZIYt/wwXcaz6IZ7Z2A2gaqMiVt8/cKVTMOxDN
         Hp+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MtfKtEQe8CJfd1727QQw44WpiAmTt6+Yy1yG/pJf/KxXwKJZitdbNOyTg2+LypU918IBSoXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4kpTj9T6xjEWhW6b50AGqzyEb9wnBFhjNwksQncxnQwPeCmB
	Vzx8Br2aJasHaLIoJS/IbPmgIpk4mz6B/tQ+HvtD/hEWZ91TQz8iIyv40VCsB6YM1qY=
X-Gm-Gg: AeBDieshCeHHnpWZ+Cs3/d66u96kz5r6RylJIXPBbgjplFhxvHeTznmGvYjgSKRhKt4
	lK9TBI+UNfNSr7e4bWKDAWGGhqA9QKjonNARNMWdHAE8WPkjlAZd+2xupwGCQYLWdqnDY92wNww
	zRbFb2yTlS305Ipm0Wai/Oq0aGMJkVkUUP0j3NoavaeMvaFhjAq5pNoqfuZG5yPZRxADzsZTe0V
	MwTMa3tRZVETElSh8yCTbM28sxRhB5EhvJ8rHgpLXGxpDHDAU0jN/xR7/qtoJmxyWKGoM3Rg89X
	QBecRBwBKWXE+68QnudizXs/ThqiojV02cIrZcWE264/5iK5eX4fbgJCMO19PZKH/xP6FZj+pO7
	XL1vkO+MXUxrBv7mPmRHaEplQuAplzEUJJEnESEvqnBscPQ3ZS4JON+AJ/3IIPawicIzDupg0Cq
	cjKi26Q0Xt8U+JtcjCktQK2aeM5GJcGTAUw+SvOorHxcry9wTcLTy0i6+emdSXXdRLvMdmlqNcl
	tiBpnXGSbipWBDQlg==
X-Received: by 2002:a05:6000:420c:b0:43d:613:4036 with SMTP id ffacd0b85a97d-44649c995fdmr13980592f8f.37.1777468312077;
        Wed, 29 Apr 2026 06:11:52 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 0/6] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
Date: Wed, 29 Apr 2026 13:11:49 +0000
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJUD8mkC/43NzQ6CMAzA8VchO1uzlc958j2MhwEFFpWRlSwaw
 rs7OOnFePw37a+LYPKWWJySRXgKlq0bY6SHRDSDGXsC28YWKLGQGaZgmukBnX0SAxse7M2Bp8n
 5mcEQVnVBbZ5XSkRg8rQvxvvLNfZgeXb+tf8Kapv+xQYFEhBVWZdaaszpfLej8e7ofC82N+CnV
 f60MFqq66qWdGa0Lr+sdV3fhGeJRxEBAAA=
X-Change-ID: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=2613;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=O60dEyNAeg9/bJQwp+6nhzKbZ4rJnrr7+9Wd3xUIU2s=;
 b=FCGUU44RTE/wiRQEp69ZEhQQ+fxvOozPURXqNN8E86+ml1DTCB3s3/1Cjt91nRXJZ7dmP5zkH
 vqHTqqZgVAhBVRn2fAnlbXv0n0hctdhA3YVK4PceOG7cl/7RhEN6u+x
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: BC0DE494A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241884-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]

Fixes for bugs that were identified by sashiko when proposing the
GS101 ACPM TMU addition.

While the bugs are sane, we haven't hit them yet, maybe because we
don't have enough ACPM clients upstreamed. The fixes can go either
as fixes at -rc phase, or as regular patches for the next merge window.
If the later, we'll need a dedicated branch, as these patches toghether
with the other ACPM thermal preparatory patches will be needed by the
GS101 ACPM thermal driver. I'm thinking a dedicated branch and a tag
will do. I will respin the GS101 ACPM thermal driver series once this
fixes set gets in.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v3:
- validate more SRAM parameters and queue pointers (sashiko)
- consider/fix the acquire path (Krzysztof) - patch was moved
  last in the series to avoid touching the same code twice.
- Link to v2: https://lore.kernel.org/r/20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org

Changes in v2:
- drop patch "firmware: samsung: acpm: Fix sequence number leak and infinite loop"
  The patch freed sequence numbers on mailbox failures or timeouts. Because
  the message is already in SRAM and tx.front was advanced, a delayed
  firmware wake-up will process that abandoned message, stealing the
  sequence number from a new thread and causing silent data corruption.
- fix mailbox channel leak when `acpm_achan_alloc_cmds()` failed. Did it
  by  moving the `devm_add_action_or_reset()` call.
- new patches, last 3 in the set, they fix some more sashiko reports.
- Link to v1: https://lore.kernel.org/r/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org

---
Tudor Ambarus (6):
      firmware: samsung: acpm: Fix cross-thread RX length corruption
      firmware: samsung: acpm: Fix mailbox channel leak on probe error
      firmware: samsung: acpm: Fix dummy stubs to return ERR_PTR
      firmware: samsung: acpm: Validate SRAM shared memory and queue pointers
      firmware: samsung: acpm: Fix infinite loop on sequence number exhaustion
      firmware: samsung: acpm: Fix memory ordering races in RX and polling paths

 drivers/firmware/samsung/exynos-acpm-dvfs.c        |   3 +
 drivers/firmware/samsung/exynos-acpm.c             | 113 ++++++++++++++++-----
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |   3 +-
 3 files changed, 90 insertions(+), 29 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


