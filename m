Return-Path: <stable+bounces-110594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35596A1CA3B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DFF7A30A8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E882201028;
	Sun, 26 Jan 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s66odchk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EA20101F;
	Sun, 26 Jan 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903434; cv=none; b=eF2+11DtJsYahUElVEkigWhDw0BNeLJpuzAleSXprs5fyRIDWUg96bqkGqXdka4+kGsLlTBawAqO6sdbG0ZyLkgINi/33liVYw6jBejTBbZFF7ryha1h+W5hc7drPLrp7Nm9Ep6xEAmq1+QVb4kmxaLISO6kaNoZ1d4IRBEIMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903434; c=relaxed/simple;
	bh=CwCieZey1HOpLg0h9YP4UHk5y5gLaSq8fmlaJ+qzid4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BC0zeHrkiWvcADfHLVC+Qz2tDNXdZh0/6/dQhgOp1ls1+iuSsEFEQIJspSk68dAvce9zYCVHbcTK+CtaXU3YrDHUSGzgabxZgvJkF2o8yAxkVxNJ4lBZQHCiXXAbM7S00aCh9o2WKMxPbB5NUUKiXNtQg+nxNyAz++oEQvW2fHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s66odchk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3474BC4CEEA;
	Sun, 26 Jan 2025 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903433;
	bh=CwCieZey1HOpLg0h9YP4UHk5y5gLaSq8fmlaJ+qzid4=;
	h=From:To:Cc:Subject:Date:From;
	b=s66odchk7OrcAnRi59vuqPNWvW6kJiGQB4N8+q1B0OAuvSa0jpcryKz4vfnDOhRzP
	 SlQvgfIQRWesra9onshx4EjDNaTtnvJdWNNYZO2Ko/lCpgMCLxs8R0Cy9lTWBWH1nL
	 IKPQ2lGOpYZX4C3bbT2mq15gB/TLEHOul4OTlPV+ly5/wQVwV4FzGi8V0O2oe1IbGR
	 vdgS9LVYX9cTKSGzGNlsXBxxiXxiiwhPHH/T5hKreXJA70cLGhnJ8Jlqo6U/0lO1Jt
	 kqsJU+Uf8adxT5TkBAvnTvOCdpntnxoM+xqMIUhijS6X446B8F2yR1XeGbL7LP1g3j
	 wfsQ33DGnQwFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 1/3] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:57:09 -0500
Message-Id: <20250126145711.946014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a ]

Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
leads to undefined behavior. To prevent this, cast 1 to u32 before
performing the shift, ensuring well-defined behavior.

This change explicitly avoids any potential overflow by ensuring that
the shift occurs on an unsigned 32-bit integer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240928113608.1438087-1-visitorckw@gmail.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5e81d2a79d5cc..113990f38436e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -403,7 +403,7 @@ static struct latched_seq clear_seq = {
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
-- 
2.39.5


