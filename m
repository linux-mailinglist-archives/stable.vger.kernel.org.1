Return-Path: <stable+bounces-224665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPixEApFsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:33:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FC262438
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F13013021593
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97E3CEBB1;
	Wed, 11 Mar 2026 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4VoKi6r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054413CCFC2
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225074; cv=none; b=uHwKu6w8slKJjJXztSZf90Rig7Oc/rAsJqeSDFXNR3m3sEWyDCVo/1iJen3/Z4/Uph8XamCdu4y4oG6nXPipYuKb3kkCDPRJWokPnY8ailiM3XqIvj/ziJQBdJPD1P8tO+9QnjCMf7lkDvus+KZaZ4O7H7Az6BY+1AZy6XGITQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225074; c=relaxed/simple;
	bh=oaIaFYpedRQK44Y8qICGJZRi2px9mwsMuZpuVRYRpaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgxDtGBTHzUsKSgLu8DeblFBHzEQ6hkQ6xWiTBFXeYXoxldkYgBCm/qsIHCZY0WwwSuwHy+q5k37q+RhzBB+2utfbvJNH7D0IenddoiOI5eFq0LIFENPTtNmZz3BaFJ6QJPmS1Dq9yMSsvmlNlzSD3BKBaCImlNgqejoLIgeG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4VoKi6r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827270d50d4so13662200b3a.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225071; x=1773829871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfjId/EpLdm+RxO2tIlmAYHD6wfm6GkL4KUKPqjqPag=;
        b=V4VoKi6rykeAKnYgGABIJwfoOrQx8Z04hvkyNiFAsyJJ2Bm0IzygdA4rBLEjuqM3HJ
         3cc+n91k9aHIZWbw2guK4TBntns3t7YnwayL+tL6UYPYeC+aQDbyQpvgPpfI4uQgmgLB
         4LluVt5PCu/CG3HZlCrcN1m68oCG8pdyoiiryXXJ3zLnvIIy1Pd4BBudmEnwWJAikAgB
         FqQV8zflARjbIFo8QlaIlLM2p0ApzVb+LJ2YqrkFfRdyE4YtmhCNHo/XjV5s+A5SRPcY
         IFVu4uSOnGk+FPayD9mnP+FPr4+YVMYpJU+GUsx/4vZ9BfKWkU50Gw9vxPsCsrNjAXmY
         bGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225071; x=1773829871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfjId/EpLdm+RxO2tIlmAYHD6wfm6GkL4KUKPqjqPag=;
        b=Th0tgENXnofTMaUy9OdPX04Gjx7sx4XoKKx5VyEWtsK1ySifRICqGXYP0UuWmzDvKI
         yjX6XjWoJlGm3/CRnlg/RbQcuYI7GlBm2VQl1jkIUsGmMUNxv776xi+TyS+1eXr3zYGi
         a1b8o0FrTIqnNNlyZPrJxCb4A6w3XRTMw2oHaW77iQ5WWRAq0pQwwUySoy3ZvVqa+wCL
         g/VOxa2tvPvsFhLtXS+ZX707Y0M83kcsmo10OxucIilBH9RGIOlCST/1ocpYxzE+0Sjw
         9Iogppi+ToLxqsfjPJbSBZRUb3fKN2qNW3Yza7PJbUvJASQV2E7e4rmX9jwcG48u1Jmg
         8DkA==
X-Forwarded-Encrypted: i=1; AJvYcCVX2mqy8NUyk6s5ogmsElEJV77FzPZrewoQ9reqWgdwQz3QiLfJus5EJnRCWfzQZ5DfqwVMtoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCpNzyDhnDucKX6tKSb995SXJF7tvj4DBgxAq3bC0aqjRVoum
	yhdZzdqQpDRYkrGdOCmd5Ixgx+vi9qDEaqYrnzjkMB/PJUkvflcCbYqs
X-Gm-Gg: ATEYQzwEB65UsOTB7bmxxPrSc82s/UvOjvbv1LM8g8rhMB15egs0WcUukOTZO8c9l5s
	zKWqCMKZFruFWOQaz/gOEBUvfI1BKQtrvm2UEMIjj61h03ToGxAMflEuV/TZCTvXhnyykScWdMX
	UDwaisf6/e7Dg/IowpHWWlF47ivUB29mlZ0v7Iaklve+4IXS9vzLFsGsT48dzxloOETr4MR/QBa
	ybhO9BkTgIp9ezKc4DCGa//RpuYFaa2pRYP9YZRJzL3d8X7od/uXR4/BY1494+2G40K7e6kxHBr
	8LEJYquY7E2mCHVFT78F/Mo9PCaU8/dvq7gOsTXZu5PrE7g5d2KB+tM1AEgLLwvibYMY5kky45H
	sMhbmemkSjOrhnzpwhY03pk9kI3Guvxg2FRo1GAKvYVyTD9dZDmQq9IFF+2N0IY5LyIFQ8nJw39
	aUTRrk1tm7fDm++ZPi2jjOxg7dPVezgA==
X-Received: by 2002:a05:6a00:1702:b0:824:9edb:454 with SMTP id d2e1a72fcca58-829f70d130dmr2083250b3a.37.1773225071345;
        Wed, 11 Mar 2026 03:31:11 -0700 (PDT)
Received: from 1f3ae71dd79f ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebf57sm2052558b3a.38.2026.03.11.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:31:10 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: [PATCH v4 0/2] mtd: spi-nor: Fix SST AAI write mode
Date: Wed, 11 Mar 2026 10:30:55 +0000
Message-ID: <20260311103057.29-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B17FC262438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-224665-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dicortech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

This patch series addresses two distinct problems affecting SST flash
Auto Address Increment write functionality:

1. When writes begin at odd addresses, a single byte is programmed first
   using byte program command, which clears the Write Enable Latch. The
   driver fails to re-enable writes before the AAI sequence.

2. When the SPI controller lacks direct mapping support, the fallback
   path uses a probe-time operation template with standard page program
   opcodes instead of AAI opcodes.

Changes in v4:
- Resent as new thread (v3 was incorrectly sent as reply to v2)
- Patch 2/2: Added Fixes tag

Changes in v3:
- Patch 1/2: Use local boolean 'needs_write_enable' for clarity as
  suggested by Michael Walle
- Patch 1/2: Improved comment explaining the fix
- Patch 1/2: Added Fixes tag

Changes in v2:
- Split fixes into separate patches
- Added detailed commit messages

Sanjaikumar V S (2):
  mtd: spi-nor: sst: Fix write enable before AAI sequence
  mtd: spi-nor: core: Fix AAI mode when dirmap is not available

 drivers/mtd/spi-nor/core.c |  2 +-
 drivers/mtd/spi-nor/sst.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

--
2.43.0


