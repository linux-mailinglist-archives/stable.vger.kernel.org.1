Return-Path: <stable+bounces-125281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E01A6909D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077108A08D2
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A71D86ED;
	Wed, 19 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCNqs5Qn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E81C1F02;
	Wed, 19 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395079; cv=none; b=rlG/oC0dIpEN6LtCmP5XQzrZRKIVx6Dw4+I6pkALlNpKs5fFNKsGckpVLz3I6Hqm0hlx2z/jNxXbyvxoCd5erpme8CwmA4UV6PJruRV/1AVTg0IUrCvpRQqCvIDWKK/WWBZqOQV8N6k65WmRkSOB+lcKShRkIIB3BNt8wxH1kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395079; c=relaxed/simple;
	bh=IHGYgn5DiuNODoDMr214mn2ajZiR1KWWf1Qz2C16Pog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbezcVuBpinB9g0XpcvRReFgST569kW9jQF9wXL06+mMNHASa5/KxL4nJy3HlyzyW8QbSxg6dKbM1xX8E5WRr/VipjFODKM0xsKIgnon9opUCxvKOlxXWe9ygzvfuwoofqcjVHfnF6jFxYSFIKYxsS0eFLCp5OGYE6eiAlfn/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCNqs5Qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE48C4CEE4;
	Wed, 19 Mar 2025 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395079;
	bh=IHGYgn5DiuNODoDMr214mn2ajZiR1KWWf1Qz2C16Pog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCNqs5QnpzDkOFFZpAL0E7bWQoSsxu6LufmwZ7+RWd1ClpgzVwaM7HQRnA7X6PmMN
	 kgaK+4RjLMqyBX7uh9LTY4CkgZV4nbkqHJPrgRmNRQxgqq4Gs0iNrEmvbqC2AJHNqN
	 v5eH2UeuLcOiaeA+NblsuPDrx9DDM5mpQ0F6HVB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 119/231] net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors
Date: Wed, 19 Mar 2025 07:30:12 -0700
Message-ID: <20250319143029.783177254@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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




