Return-Path: <stable+bounces-191692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DCC1E6F0
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 06:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D9C4E4C04
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 05:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D210254B18;
	Thu, 30 Oct 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB2M4pOf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810F1E766E
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802472; cv=none; b=uJ59QtMDYrBjHQDB1Q+C7HofHE/r0V2xcvdQp4LWUzH5TCql/H6e+0gxPmWU8Wev9U3oUs0MV6Qm1sZjgq3iunDgI+co212m765TNOKXDhou7XMrLOVG3xkQ4BBlOh5cTgxmRUb2LWlFEHQxj9ltFknDTM5RbkUiGVnwVcaEanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802472; c=relaxed/simple;
	bh=NTNQiMekt27MGuwOcDMw9rk0PNy2ygsDrUNNQVYYVdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgmmjuLHoSMnPb+xClSQUKJZL6143JS6fNsVNnaE/Z1UVUoKG0Gjwl+uR55slrS/QrfW5rQ9V+YSrx1EtZRbsPVapT14GJHSnQAk2vIRgEabyE2DAaTZOlK2xGa/pUYbw81i6F5aikrs4KCwlOnK7FTKdbkEWmaL9hhn6DUHrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB2M4pOf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78118e163e5so1526751b3a.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761802470; x=1762407270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=cB2M4pOfpgSXw6gXxmxL8SWTnluwBSBVaRO4WAKwO6ykQsiDxAvTVNPap0hL6MskL2
         x2rxHKCbNwCjhDxlEu2TuEVBlcTfV4RMkHGprnOkJchlnSfojeb5Natx1corT1M/LlJn
         2YI5YhL0QgunaQEkhJbYah0fEMKgYpT8mwrp6WtN1qSgvdc62Vkyo2P0Gw9NrI/dBjKJ
         uQo77PbBm7bxVOiR6UvkKiJuchf4zbVj5Yr7w8FDkyS/+oFI7cpO/ngMqJH+4yIfTwSZ
         Tr0h/3rd7OEq93SQ8fko2b+6DDc6aiMSSAXeiYYZ/sYprBVuR7DU7uzeAodFkNyopPtA
         Lg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802470; x=1762407270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=FsZs1ft1uLaZVtdgBcLrPSXtSSjY/BriIxU09/lp8SoWFZUROGovNGXg5usH7c09nB
         6c4fpK52QDIalkLI+dXTVougmCM9JvtUAoB8OPy6qyLw5Ro7IOiFSZUhHtWA+lwINt5K
         7UPVEUermFUMQm2v0G+YRUvC4WTWM3jCoeiYjmhiSRNdLJlrNaqd2vcr4GJBFBGtBSfM
         /XgBfAp839rwyhIJ74dDLB5Bv+tvcn2zxVPDrlrbFPB/4g1TzGU/3huHgoKIROtneY5C
         G9oQ0HkK0/o8/0KtnKjRH3Lo5txOyduFx6ntKHxHFZw/G664PsSxXhZntdH1skftHF7i
         fnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPSLN5o/yB6I+IgQX/bYGMj+uwEESJfyB0gR/bCVRNa2ooWUqhFHQgiH1siDbdcHYdrGOMAMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyAip0bN//bE80FBzQMDx9/PeQ36mM/ZXIbGOr2X0+qwPw//J
	XF+BgfoqvHvFi3OS63OUBG1YMhHJrqael9FCh9/fm6qL1e9RGEGOOOTT
X-Gm-Gg: ASbGncvBCoMuPMh1pQ0BbBQC04tSYzcdz7tUk2EFPRMMMgVDwMDNbHP+c3Ruf2cRvFM
	63sAidgkc1CYl/VwQ4EM6gCvFL0B3I4BiSNeUDX0luvBcPlJte6nsFGE8QG2gzgrOQCmDXpNE8N
	7G2pBJXGD4tZ/OVlvg6wqkvgPBDXQtoVJ6BuNTrNoJQ7qPedaYBYeio59XN4jsAoQXY3vhbZc5f
	AsPC6dAo4IgNvKo4ga/7b9alDDJw5iCoP+zvzOSGaI3pGd4p2IZ3/HKqu6709Xghgg7OpEK5s8f
	ilJ+nVk1YJu4PGI+/cs/q9slBjTflFCPT98y4aM1jlHW/G72okpIYdlyggvSNZew64v9O2aEa/w
	ZSGpA9NKDBA6310OPJ0rfXHgzhp4fesXMlasWsYInaMdefyD06YGVrU+9urv7H1unt5+yjzMCNk
	cUqiVQmFdwWj5kOLkcjTVPEA==
X-Google-Smtp-Source: AGHT+IHQSoEeyg7TPbHVX/naAJ4cljI3iJJFCjsar0UsVAbSVgztH3Vp8TrcvbDMPwYpGQRddkd2rQ==
X-Received: by 2002:a17:903:190d:b0:267:8049:7c87 with SMTP id d9443c01a7336-294ed08da86mr25707525ad.14.1761802470013;
        Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm174659995ad.74.2025.10.29.22.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:34:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] bna: prevent bad user input in bnad_debugfs_write_regrd()
Date: Thu, 30 Oct 2025 13:34:10 +0800
Message-Id: <20251030053411.710-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
and commit 7ef4c19d245f
("smackfs: restrict bytes count in smackfs write functions")

Found via static analysis and code review.

Fixes: d0e6a8064c42 ("bna: use memdup_user to copy userspace buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 8f0972e6737c..ad33ab1d266d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -311,6 +311,9 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
+	if (nbytes == 0 || nbytes > PAGE_SIZE)
+		return -EINVAL;
+
 	/* Copy the user space buf */
 	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
-- 
2.39.5 (Apple Git-154)


