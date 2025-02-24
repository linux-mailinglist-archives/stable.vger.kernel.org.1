Return-Path: <stable+bounces-118871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA4A41D2E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A43817E2C3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A640260A28;
	Mon, 24 Feb 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KslePCxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C95272928;
	Mon, 24 Feb 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396023; cv=none; b=hfFLKo6Z44IPupltQaTDRHG+jU+aC1/35+BL57+cpQctw++CXI80MRi3VcBtrtbNUylq2FC/mzv7HsGpgnlhrgLTb8TBGcmhvLZTeR1FaWoAQFneGsFc6xPW6JaQBXbA9aHHUO1nuS0848r1svd2n2Gfe5B05b204SD+YB816ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396023; c=relaxed/simple;
	bh=rNoU090DacA4cJ1DmOPHPw14tb3y4AnAfJ1lxydMYtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbQkyqZ1ocMsNh5b8x2735Ai4S42Vxt2uTSHvuPRjPPOEhFRCNoQQrHtpO+VI3ym4h1zQQz9jw5fP7GyRIwInjlfJ/CToyDENpPPzWZPGLpVKPliHJvddGVS2JwwuclkenkulX6Y3cQSeB+OnWyRb17QbwVqRmO7EwvKPoPNfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KslePCxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB594C4CED6;
	Mon, 24 Feb 2025 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396023;
	bh=rNoU090DacA4cJ1DmOPHPw14tb3y4AnAfJ1lxydMYtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KslePCxvfWPFMym869GzXgkDZmegIqdhSEM6LkGovfzgfQAeQqiqkUlZoaE3LAmf8
	 ejD+MFKFszGeTBu1YNRsyD352mxkQMGlYYF0KSZxYaqCK/fXutg02blFlX/Wy1UvIg
	 OcifExvFTh2RHHgU9CV3WijINu6LfEOpIGCBjvEv5ya6BdP9fy4i542egGMTfzHqrV
	 920rVx/c92s2J6HyLLM1eIZatPqu3Lf+etxhrgYW/jsUssu65Wy/uakRIhRQGsRZzf
	 n5LP7wdiksY0Bli24/oP/yuUsmjcjyOY39Oy+KQzxK+fMK9VcVTy49f0h4ReSQffBY
	 RCn3JRQDOgOiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ryazanov.s.a@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/12] net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors
Date: Mon, 24 Feb 2025 06:19:55 -0500
Message-Id: <20250224112002.2214613-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit

From: Stephan Gerhold <stephan.gerhold@linaro.org>

[ Upstream commit 0d1fac6d26aff5df21bb4ec980d9b7a11c410b96 ]

When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
constantly being filled with errors related to a "sequence number glitch",
e.g.:

	[ 1903.284538] sequence number glitch prev=16 curr=0
	[ 1913.812205] sequence number glitch prev=50 curr=0
	[ 1923.698219] sequence number glitch prev=142 curr=0
	[ 2029.248276] sequence number glitch prev=1555 curr=0
	[ 2046.333059] sequence number glitch prev=70 curr=0
	[ 2076.520067] sequence number glitch prev=272 curr=0
	[ 2158.704202] sequence number glitch prev=2655 curr=0
	[ 2218.530776] sequence number glitch prev=2349 curr=0
	[ 2225.579092] sequence number glitch prev=6 curr=0

Internet connectivity is working fine, so this error seems harmless. It
looks like modem does not preserve the sequence number when entering low
power state; the amount of errors depends on how actively the modem is
being used.

A similar issue has also been seen on USB-based MBIM modems [1]. However,
in cdc_ncm.c the "sequence number glitch" message is a debug message
instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
silence these errors when using the modem.

[1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://patch.msgid.link/20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index ef70bb7c88ad6..43c20deab3189 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -209,7 +209,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
+		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
 	}
 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
-- 
2.39.5


