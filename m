Return-Path: <stable+bounces-158063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C644AE56C9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3DC1C22E0F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE2222599;
	Mon, 23 Jun 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyBNsElc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E215ADB4;
	Mon, 23 Jun 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717392; cv=none; b=ho769FFObBzy0hOGfBq5N4lVWDr0cAXkz6OjMoSCAyzlBMISC0f7Riy3KcpAz1O6fpaXxYCGEVoRT1k8j5vPUz9BIhWuRVRme0JMbsIwK+UIie26PHoyBrQ8ft+/roHHF2/20TqPVerId8sg0yI1cucVq9zJw5oIvasSUvUJxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717392; c=relaxed/simple;
	bh=Mzbmyd1qtuh1N5imv1wTPy4eYg1r0sMKRASWH5A/enM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtQ3kuBptRie0AZ69clOTOKfmPIgHGPTtz68+zSUJiO4PJi23KLOpXwPEL+jBvau6p/NpkWMOo7wTsXr9omIIFPNo0wolFuYKYuqw3dWeElcuzcT7LpiQavKANIyZ1Q8iKUPP2bfG5ci3VzymuzhDqP5y4PoSX17Ix53/MwB/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WyBNsElc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A81C4CEEA;
	Mon, 23 Jun 2025 22:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717392;
	bh=Mzbmyd1qtuh1N5imv1wTPy4eYg1r0sMKRASWH5A/enM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyBNsElcPl3QW7CjphfWTSF2yJQ0gvpBftOuNRrnaEFSYrqUwMD6YSHhm50zzw3Cz
	 +Kptt3Nyz3V/Zp1r3u5BvMIOoYuLRMldwg1M+hp5suFJq+VIhaPn55nmKipuoCEIiU
	 Fs5hTtAC5ccDfjYuwfGtRFmYB98Z6qmZZ2FPge9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 378/414] ptp: allow reading of currently dialed frequency to succeed on free-running clocks
Date: Mon, 23 Jun 2025 15:08:35 +0200
Message-ID: <20250623130651.401978325@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit aa112cbc5f0ac6f3b44d829005bf34005d9fe9bb ]

There is a bug in ptp_clock_adjtime() which makes it refuse the
operation even if we just want to read the current clock dialed
frequency, not modify anything (tx->modes == 0). That should be possible
even if the clock is free-running. For context, the kernel UAPI is the
same for getting and setting the frequency of a POSIX clock.

For example, ptp4l errors out at clock_create() -> clockadj_get_freq()
-> clock_adjtime() time, when it should logically only have failed on
actual adjustments to the clock, aka if the clock was configured as
slave. But in master mode it should work.

This was discovered when examining the issue described in the previous
commit, where ptp_clock_freerun() returned true despite n_vclocks being
zero.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250613174749.406826-3-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1a1edd87122d3..b892a7323084d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -121,7 +121,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	struct ptp_clock_info *ops;
 	int err = -EOPNOTSUPP;
 
-	if (ptp_clock_freerun(ptp)) {
+	if (tx->modes & (ADJ_SETOFFSET | ADJ_FREQUENCY | ADJ_OFFSET) &&
+	    ptp_clock_freerun(ptp)) {
 		pr_err("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
-- 
2.39.5




