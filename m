Return-Path: <stable+bounces-240500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE30HmIq6mnfvgIAu9opvQ
	(envelope-from <stable+bounces-240500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:19:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344C45392A
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4AC3011C4D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4B317176;
	Thu, 23 Apr 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVmuJglw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BA3176EE
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953950; cv=none; b=s/7Atx4nuRwbGMfV0yt4qsm84ohEm0TD30YxLrnSitKIrmN2NGEm+BopFGpO66p6tYlL/A8C04wzVNszVx4unMYwdmmsJOsyzRvvfyEBL9MEavPg4eUNwXnHGl8H2f0DY21M+zfvBJBQ9iwzlzK98/Yv4d8ukF9uf6qGE6pvRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953950; c=relaxed/simple;
	bh=Alq+UFc8DGGiXf1MTbZh93F2hTozhdw1uQQbLdnroEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s9QRYIGf36FC9x8pOP8qsIPPf9nCZ0i9JvnqCMnd44Cg1l1syRG1U7ConEuTKM9Y/sMiI11Ae3kKEBroKXpFQh6wfo3JDgn7xNnpSYvpLWLCGysXbWgNYSWj8X//de16yuYHMXxoPfYkfCZvDNI37up9SJi+M29YrLai4mtdIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OVmuJglw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso4096979f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776953948; x=1777558748; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eROZPmLE7RDR7HyOBddBTk7UV5IVzr9QqgC4DMrC14=;
        b=OVmuJglwJRfS3rzZCLqMjq1scgfn0TNZ2IbIbOY1G7xo2tpg2VfWDKUfTG+4DrA3GL
         Xg7fBjXibKHXbUfL1mpkaMqRvZ3632EFDJ7kWeyNw2usuqgxd2xz+j5xQ93VJlsLsh5B
         GjAzkC8PFmk5xQlQ8VR0JGF0BPQkP+aOrThw0m7I8NVCOEA1d5yCAiWI/Y/wIV4WIU2b
         6yfDfFNfOzbaylTwgMg9oo6vpp/tYWaJDTrYTDzIJPQcBiQngjxZfhevbE2OhP+fE4MV
         2ePXfaco50gTPza62s0Hi+9gmZTkEPTspO4OQjR9Nh7+oN+HsL0tszzd1HsjUyxqpbBv
         qBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953948; x=1777558748;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eROZPmLE7RDR7HyOBddBTk7UV5IVzr9QqgC4DMrC14=;
        b=j7kGvB0YCc3MUwh9xjpmu2owSTOW68Ddz/UIPjHjhuGN17P5U6PnP6qBLkcTXh0Grn
         E97dIgZ4DEr9XGexKYmf0Ogm9J26sflb5O9L5VvPHsP7zNzOEtkdSIIOsbAPHLDXbddg
         blN3e3nlv3xqXGzmoucsFmo0g4F289k7gWqSKJbEsxr3mP/3N9m/2lHAEHfhx0xjPnQp
         8Dcv9l6UcWZP9DI+g7SN/zt5O088Ci3jt6DglDgfLC3eU+mcV/5NDx/NWgCHIeqiiY5F
         TePPTmP/S6fEuLe4SZUwt5h18R5Wo2vJtIRLq2t73dAWegO1pReYKTiqhBGXJliFgaMm
         NY7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bZq5ZFw8WXhw4Q5LkwbbXAX0lF1FC5SBBXe4I1mMI6KuvNO/MBWyl6A9pzveCJ5cemsi+fm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2TO7NqFyyze65hTKHcUWpV9+Q3OW7t6vgfpV+kigi9rs83WG
	SmdM1CCq48o0Qt96TQBZfkyU2+E+UrqH7qxcK9kNyosTl/WYf1zpX8oYR5s0ZkM1ZMg=
X-Gm-Gg: AeBDietKDjM5EtIP9610WlplmJtQCYkdck2ukzTQ1WXc3GuEaoJhGOGywnQ6PK13Rds
	SwhP7D/qUEHhiVbWWFU5UgD6ETp4IuGmPGpplWcRqgD/R7RRF494dz4JHR7V0AAMtmnSFkfG04s
	UGyXo6Wg9I59QPVjQAwF4NhS73GgvnnabMh4V/j7MF6sOZYFDYKlPz8mFXSbf2Q3a7d6S7DNhvc
	01mYgiuUbDnEDvWZ9JyGyE4Sz6OTa1pV4TnPSCKDjzZtGDUswAkl3LXPZfBItKoOXLjlKAi3tc2
	8eFd8srdbFGqBfmkntda5FW3EGGtM2sY0MrtYuPIKRO7sRHMQtnBT/g5k6I5P0MX7FfL468q5zl
	XTShRc1xLH3rKyLExETNzazXaROJUsG2Hubzc5KmAJx0Gu9BTB4pEsR+e0MH+wLdPYPRfhv9SOY
	xJRAT+zjVUBL4D9XbRhkGh54gJFF1EITI8Aq/FSPfCZuMkAeRmzbvG/hvXwShVJCUo3yBfYCMnD
	aTOJ6wY33G5jg853w==
X-Received: by 2002:a5d:64e7:0:b0:43d:5ec9:246 with SMTP id ffacd0b85a97d-43fe3db2d0fmr42764796f8f.12.1776953947709;
        Thu, 23 Apr 2026 07:19:07 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm51107483f8f.31.2026.04.23.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:19:07 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] firmware: samsung: acpm: Various fixes for sashiko bug
 reports
Date: Thu, 23 Apr 2026 14:19:04 +0000
Message-Id: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgq6mkC/x2MwQqEMAwFf0VyNqBdFfFXxENXnxpEWxKRBfHft
 3gcmJmbDCow6rKbFJeYhCNBmWc0rv5YwDIlJle4pqjch/0Yd57lB2PztsoWWBGDnsYerv02mOq
 6LSkNouIVU98Pz/MHNrxb3WwAAAA=
X-Change-ID: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776953946; l=984;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Alq+UFc8DGGiXf1MTbZh93F2hTozhdw1uQQbLdnroEg=;
 b=5DnC1cyhRATJzyqTxlio1EYxDf1k9YJhfl5xiAUbAVVIwIPmD7bB8J3dqNBJV0meH2h8Ki8ik
 SFDjLBuZFdsAHwNg4R6zvzSOZ/46k36OIzRA7vcVEJFamoTEXFT2y0/
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240500-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 9344C45392A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes for bugs that were identified by sashiko when proposing the
GS101 ACPM TMU addition:
https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (4):
      firmware: samsung: acpm: Fix cross-thread RX length corruption
      firmware: samsung: acpm: Fix sequence number leak and infinite loop
      firmware: samsung: acpm: Fix mailbox channel leak on probe error
      firmware: samsung: acpm: Fix dummy stubs to return ERR_PTR

 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  3 ++
 drivers/firmware/samsung/exynos-acpm.c             | 32 +++++++++++++++-------
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  3 +-
 3 files changed, 27 insertions(+), 11 deletions(-)
---
base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


