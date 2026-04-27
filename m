Return-Path: <stable+bounces-241342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D8DHN1772lKBwEAu9opvQ
	(envelope-from <stable+bounces-241342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:08:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A0474E7B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52EA3302F253
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CA322527;
	Mon, 27 Apr 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub76ZJLN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CA31F996
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302253; cv=none; b=DlTqLKoFZxsgPIfGm/p+B+Gkw/vNiQ4QTRU1PqBlUVHWH90I6YN4frkdq7DZ/vFf6TkCKYyBHjHNw5koOhVPOXTmtZGgJslq6tE+Kdf2wxWOYv8QDIECvrXhCNinioz0tvXKMg83GZjE6xpm/KJ/RpWIdyzyFe2L9xi7JsaYjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302253; c=relaxed/simple;
	bh=FkIFbqu0c8XIHL6u/4dr6OiK07WQv3wNMNPw/3F+U1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CDYSNFkQ5pCRN6fbRKavyYOy9nfB4HBgqkTZ/VGERsWRoH9+nfYxX+IhjoSNuE8a4n+u5iG6T+fT5Nz59Q5zY121C9ZBv30WD7IXQ4HZ0HhAk7xftegDTL+4Lo/DDFBsyOkRR1EHZ3g4kX1MxJoSlwu/DENA0844MPYeEhEnO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub76ZJLN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso77728175e9.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777302250; x=1777907050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QR1R5o6VCM5Z4T+4o9C/Uwm/kY5zS3IqERo7Ty4MIk=;
        b=Ub76ZJLN8jCWrfwdPHYwwsJbHLPSwGB9CBg+zM9SN6WYwo0otVneI5IAjB1yMnD7oL
         LuvGOHOL2eDKqqA8pTMgInnoWiiV1RcPYTDP5IHMdZEQNA4fV6H53Dx1UADRdcp+oddo
         4HXiMHDPJNV8SDdBqVewBfBMJeMKUInOPk1mNnsBlM8bEo5/jz1//QnIuGmZizNir9PJ
         VMaWvU7ltk0ulFnNyQmWuKDwI8eaioWPxexQmG2QxvImOOii5DRsYmX0irxJkcyGnBi8
         1MOFrPKLYVAp3oq/+xMwqLMbIb8S4bKbo3sMfkLYorXSbSFX8RfGNGQXKbRrTJ9PdGe4
         OzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302250; x=1777907050;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QR1R5o6VCM5Z4T+4o9C/Uwm/kY5zS3IqERo7Ty4MIk=;
        b=SawoF5zLx4MzXqhhIxnmKAUOHhijk/Zn4BiUYAe+s5VB6Yy4gEnVHdcXdZLYIc2gte
         zqMCpDQJEX/3JRLmI6UFSBgRcE2DQ1/6EF9aeSym+LSmRWxdIzv6aIipszZCNp+wgvJi
         RtQQV4aRJ919CN9u+aoZBmCzNtES9CVDRo7eHHiVUxxsKoCT8qUmc/IZYx1GXC1yuGJ/
         K5gnoDS7JGITolTww4EVVmQ8E1RKosGMx3LiXFyZfO7BVvircjQRtMOupyCq7M7gkqZD
         uBqy2KPLzpO6iapIJFwDrO0AzQAZXIjFnvazF1L+obA5n/qgVaeKc4ifembbWqQLh+7c
         f2HA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ou1X/8aIMdCfI/wL6FIOPydOEwIKz8HAucZB3UEenis5rVowdVQ6h74HsYob+fN0sn7NOb8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtHfLDRAOmZY1fOXFVjphl9/MAqsAzJgqtCPv1gDhYnvw1I/W
	mqImLAPb0nsUEPRdOP1RLCmWLbVg8z74RCB9qeKe29B9MYSqJMSGgH71Uk7DlSBa84c=
X-Gm-Gg: AeBDietiVSMQa2gRXlOB769mMO2BTxmHTYhBhty7yZeUn8UTNwaaUIXIl2E/xcpSpDm
	XxfptuqZfcVWsIVjXRC588ntODwedFJiqXnvhfsDXruo3WwKwkzZwHJXYghyEz3dd8ZSu4UPy6T
	8SE0Z6fKeJI9MJ/aOsIvR7CSH6x731BO5ij3wRa7rIJ11K6YH5ptPK46aCYr7CtMmq/pxN7Gwwg
	ftqFYMH7ifSKG+S8CmBI54pC+h1d+StKF1JqnC1kWnu00P2B26/y8vRvMu9ByhihGt81U0MJCqb
	45IUFIWXfd/9SBMEG79bmwoLqwKvkVsaGWd+EBRgsJVAjjeMr+2lR2WXwvS0Ap66hWJEL83Wb74
	MX1U0eoagupXyct8hwLG3mTwYmUBVB7aCIFy+ZCe3gBA9xceh4+MncLkSrsFxAolL1NsNVDe81L
	vdP88bJbgI2c7wU60CxORDZlnjFyYFkP3r5HiYwKkWroFjE4FvS3mQA2PYsYcpCItRPopz3gYH9
	PZZBQspHSvi1Yleow==
X-Received: by 2002:a05:600c:c101:b0:48a:54a6:b29f with SMTP id 5b1f17b1804b1-48a54a6b3aemr309871915e9.17.1777302250228;
        Mon, 27 Apr 2026 08:04:10 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm235370215e9.26.2026.04.27.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:04:09 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/6] firmware: samsung: acpm: Various fixes for sashiko
 bug reports
Date: Mon, 27 Apr 2026 15:04:05 +0000
Message-Id: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOV672kC/42NSw6CQBBEr0JmbZuZVn6uvIdhMUALHXWGdBOiI
 dzdkRO4fJWqV6tREiY1l2w1Qgsrx5AAD5npRh8GAu4TG7RY2DOewHfTC+78JgX1OvIjgtAUZVb
 whFVbUJ/nlTNJMAntxbS/NYlH1jnKZ/9a3C/9S7s4sIDoyrasbY05XZ8cvMRjlME027Z9AUguS
 enFAAAA
X-Change-ID: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777302249; l=2292;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=FkIFbqu0c8XIHL6u/4dr6OiK07WQv3wNMNPw/3F+U1Y=;
 b=MixsNd6wkgvvQDOhSDRPyCx4QCoo4FWY2Wr+553OosW0lyVFKYqMz0mugD9UWVPKnlCfr9Yka
 +reAExTwe1fCmfPhWLr4XOxnRsRzANdmqq9eAyzbaFJK7dBW5ZpAgkX
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: AB8A0474E7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241342-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
      firmware: samsung: acpm: Fix memory ordering race in RX path
      firmware: samsung: acpm: Fix out-of-bounds read and infinite loop in RX path
      firmware: samsung: acpm: Fix infinite loop on sequence number exhaustion

 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  3 +
 drivers/firmware/samsung/exynos-acpm.c             | 77 ++++++++++++++--------
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  3 +-
 3 files changed, 56 insertions(+), 27 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


