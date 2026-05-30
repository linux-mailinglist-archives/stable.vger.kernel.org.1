Return-Path: <stable+bounces-257526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNg1JtUcG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404360F847
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC45F30BF8A5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF63148DA;
	Sat, 30 May 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+ap+xpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AC3016E1;
	Sat, 30 May 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161300; cv=none; b=pE2kFRAasc9wA34WPoA5Hgd1o1KMIb0ipmSTpp8mA7mtTgzMIS9FxdMxEVz70IYqU0QfKRBE0T4KwVw3ybICJZDWRd4i5cYQVuyX+1eo0LlXpVkkghwW+psQJ4JGTcXiP07w1aCpVTZnWYUa1NnTDXYkN3rPNsywUsTK9MLg2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161300; c=relaxed/simple;
	bh=ZLkW+q0chPHY06CiUMSHVkVcu/ltoAn8fDF7MTTqTNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxsX6QnEKesTHVYZc1k3aQ37ACHAt649LIvf0bP5fbWRpp1vPWX1nWYsDATsmzSgw2y+Jin4fq+e1fI8DGPhPPZdM8SYv9OuQopxndnIjfdLhaQ5sfTZ8rK15H1jL5L/rat7d4/eeDdBmYmW7iThvg0GUTQ1/Zgh2ZwJAXDb1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+ap+xpd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD1B1F00893;
	Sat, 30 May 2026 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161299;
	bh=le7kyHbMPWBCD96+NGeA0GvmeQzTHb1Gqv/bEHFm9Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+ap+xpddNSZybym4A4b1YFNojNksnASwz0FnBZv9xunVHZVLvkSpQ8MPUU6txdFI
	 9TCJWXi1KoPvcB/xITAG/qXbB2JWqbwqwSdqxLeeNP8nBIDS+AHWFJ/v4qWkq5DdXd
	 fniwVrr0TbCa+3ekT8kNaU6V05O9FRB4SX0SfvyQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 584/969] soc/tegra: cbb: Set ERD on resume for err interrupt
Date: Sat, 30 May 2026 18:01:48 +0200
Message-ID: <20260530160316.537451305@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257526-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3404360F847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit b6ff71c5d1d4ad858ddf6f39394d169c96689596 ]

Set the Error Response Disable (ERD) bit to mask SError responses
and use interrupt-based error reporting. When the ERD bit is set,
inband error responses to the initiator via SError are suppressed,
and fabric errors are reported via an interrupt instead.

The register is set during boot but the info is lost during system
suspend and needs to be set again on resume.

Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 5813c55222ca3..2cf0ceb60bd0f 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -1185,6 +1185,10 @@ static int __maybe_unused tegra234_cbb_resume_noirq(struct device *dev)
 {
 	struct tegra234_cbb *cbb = dev_get_drvdata(dev);
 
+	/* set ERD bit to mask SError and generate interrupt to report error */
+	if (cbb->fabric->off_mask_erd)
+		tegra234_cbb_mask_serror(cbb);
+
 	tegra234_cbb_error_enable(&cbb->base);
 
 	dev_dbg(dev, "%s resumed\n", cbb->fabric->name);
-- 
2.53.0




