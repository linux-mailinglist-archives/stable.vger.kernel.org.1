Return-Path: <stable+bounces-118835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E84A41CBF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974B6189BA3D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E22676EC;
	Mon, 24 Feb 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgP5KVMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A02676E2;
	Mon, 24 Feb 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395940; cv=none; b=TyJx0o7NDjq7fuUfk2GqZVA/z7fY0NB3x2ZU67TnrZ7KbHvU7mAIxoPa7zRavrbCOb+h5Ag0tYCKvqTykvGVA74G1H9HqAigk8+hmwMuUcRzFf7FxAFwm1vaHiQ4XrmYMH5kMJ//t/TJ8mOhEQKCyH70Op532RaRiG/KpQeKpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395940; c=relaxed/simple;
	bh=Yt8h+P/Ab1PqMPwTIR/NKBuYG5UsutrYZqQ75QNYbgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdhrZZama36F+JuLLnl8gRZUZVFUp4fTnqbM1ZiPva+C0W3zKCbF+H0W3zpsnrviOPxuNnTfl2cPb2DDUc4lpT1UKXKB1HvJ4tUNWvQq0nbj5ecMExbUDDNj5FRf0Hi3YyF4YGOKbhy4sReCbNpja0KyXtg1VgrFs5prsqo3tSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgP5KVMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814F2C4CEE9;
	Mon, 24 Feb 2025 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395940;
	bh=Yt8h+P/Ab1PqMPwTIR/NKBuYG5UsutrYZqQ75QNYbgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgP5KVMcBmE7t5vnb1wwBygxOAHYBnagk6HLnNncv6FW6vAlOWDjL2CGgA1rQm7dO
	 FVwYXMgpcnQEGAcGQ95RXAeewhoLnEb5It7zAfkARxp1d1Cr9BUv7whDNrTvVyCcMs
	 au0H2MyJcI4ZLlIQ5FUzTbW1XsbRYC+SopAKIMruXxd56aKEb9yOMrwaSz25efkVAn
	 woZMgXjiJMFw1DxJ+2EPSQjNSPZ5Y2oPI3M7clKrP4k7yWFtGb8rJ5GpBSWVbO+W04
	 /MQEDyvskIaNAODybklW59Ij8Ihbq6BKpZLK6BNa/kyYvpMwzguL8sLpEqFc80zhqu
	 YgpTVDsvXPkaw==
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
Subject: [PATCH AUTOSEL 6.12 19/28] net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors
Date: Mon, 24 Feb 2025 06:17:50 -0500
Message-Id: <20250224111759.2213772-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index d5a9360323d29..8755c5e6a65b3 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -220,7 +220,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
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


