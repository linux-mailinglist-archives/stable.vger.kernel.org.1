Return-Path: <stable+bounces-220523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAV5Ft1Mo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864981C817C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 931413068649
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7953CDA0F;
	Sat, 28 Feb 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK2OiP3P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6C3CD9FC;
	Sat, 28 Feb 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300406; cv=none; b=uFjhlxg0x8cb7plDKsLqVBCl2pL28OGOLEezf7HbQSryX7aEF9XdFYSsS0ejeAU6hEa4ghNrCbRrvhWUHLCnTVw7N9a0kY10hba2jYKRze605a1sXigF5ubKKWcpQ4jzr5sDFbg21doZvaT/PLQ4jFHJgDHrcVY5fijlHga7rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300406; c=relaxed/simple;
	bh=stzw8+O1qLWHpiBs5B6E30/TaFmQDt6Mst2++3fJidA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbAdyhXAkR695SsCtuGKbCV9zKSVayXmtjYQ0Lkc7FdWdalgQMKsP6TZCZUmy9C6TZnx5Kk6ctlLYwS7fJ8GBXdO2y/hIgU4fpZ+vI1gycjqC4XzRqrG7yVd/xGccice/dWXzYvXIQx0dQs91jUD8MABJW/w29IxmWQYVGwvjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK2OiP3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D4CC19423;
	Sat, 28 Feb 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300406;
	bh=stzw8+O1qLWHpiBs5B6E30/TaFmQDt6Mst2++3fJidA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IK2OiP3PXrB5feiVfQCIpQF90/SbZkEl7gDXaeXFH3NQmnyu6MlNBwPF9Z3epuE4G
	 qH0hplPEbBoZRUH0gAbzPiFBQua2i0nKHeFGsNhiX7oI9BsaHDCtztizWRHpSz8aXw
	 obS1/5BGFAZLa+vs5rs2mctnwBV//fqh4dYi+0AJBxIAVjlIItjsPtqyDOjNKnC2r5
	 zJXsJ7Xv/dGxt6sCSo5aFsNCSGM/ucQUZ2j4D1LIyqx+rDVd9jXcE1AY2ExcjrsCPG
	 o8rnYDFatl8SDnQpTIPjGBLwanxrZ2I3gNFTcwWAle4mOIMPoiZoj0FY4Z4pndflXK
	 uWHHfJt/t+6Hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 444/844] ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
Date: Sat, 28 Feb 2026 12:25:57 -0500
Message-ID: <20260228173244.1509663-445-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220523-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 864981C817C
X-Rspamd-Action: no action

From: Maciej Grochowski <Maciej.Grochowski@sony.com>

[ Upstream commit c8ba7ad2cc1c7b90570aa347b8ebbe279f1eface ]

Number of MW LUTs depends on NTB configuration and can be set to MAX_MWS,
This patch protects against invalid index out of bounds access to mw_sizes
When invalid access print message to user that configuration is not valid.

Signed-off-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f851397b65d6e..f15ebab138144 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1314,6 +1314,12 @@ static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
 	for (i = 0; i < sndev->nr_lut_mw; i++) {
 		int idx = sndev->nr_direct_mw + i;
 
+		if (idx >= MAX_MWS) {
+			dev_err(&sndev->stdev->dev,
+				"Total number of MW cannot be bigger than %d", MAX_MWS);
+			break;
+		}
+
 		sndev->self_shared->mw_sizes[idx] = LUT_SIZE;
 	}
 }
-- 
2.51.0


