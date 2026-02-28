Return-Path: <stable+bounces-220522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLIiGNdMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C41C8175
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 363B932532C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2FC3CD9F5;
	Sat, 28 Feb 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyilbVrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC73CD9EB;
	Sat, 28 Feb 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300405; cv=none; b=dJDDuZvzTAR/HKz1qhZaibvjdFHotXDNv6eP4bo7mw/AOjtAkRhWNa/ZStPD1b2SBmT6tKTFu42ev/msLwmOn9hd6glmAJw/HVyzF9/U+1fkiltykxZdZxTlUzyokSzWv2Pq2Jgs/LHXUwGbQNd1HP6DnhkMrYbsl7G8kPHfhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300405; c=relaxed/simple;
	bh=9JOA6572BYDqfDjY//bb7H4d1r4XQRYQMbcpDHSnCOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpSb9jNbh5wb3R9BShlCxAbBbxrqBuXWGPlSZ2qJfGuaa063pJYH3kaMDhhwcesA+DxlvvtsiCt2KoVWJvexVy9ARwRuwNb0sc5ACgdZJYpV1MSVhmnFW3/eJD7iIqhJoGwtDsE2wB1At4NW79mevO4vH7rSu9O/UGFgYXMxJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyilbVrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00502C19425;
	Sat, 28 Feb 2026 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300405;
	bh=9JOA6572BYDqfDjY//bb7H4d1r4XQRYQMbcpDHSnCOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyilbVrNglLOg+OWxGZ0fECbxxFVKuBzL32kIXKAvp4PShzozdvym3fvebw65LSEk
	 w+wkNDdBylY1LTqHMhaqIShLcd24Vfl9lO8ASWmbpzF/fLBQ5Z6/fJSthk3LPTt6mv
	 o30kUIuYAHO/MNOPoP0y2I5r7kEez1oENE1enNjg9pP/FGVEAkpTue+2xQzncP4Fa7
	 /E4iDQZJyPRpAkntH4on1mOrwqWnipAbY/wMeQyh6Y9jioNfqk0AZI/6MwbU0iNaVX
	 YxleJxnUXHW4fB6dqOrzIPzEoopTzF/EOwEqK6WC8LW+Soecqa7ZTcDEBTvaxyGoTH
	 Od2nl/7RyCeyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Melin <tomas.melin@vaisala.com>,
	Harini T <harini.t@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 443/844] rtc: zynqmp: correct frequency value
Date: Sat, 28 Feb 2026 12:25:56 -0500
Message-ID: <20260228173244.1509663-444-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220522-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: 7A0C41C8175
X-Rspamd-Action: no action

From: Tomas Melin <tomas.melin@vaisala.com>

[ Upstream commit 2724fb4d429cbb724dcb6fa17953040918ebe3a2 ]

Fix calibration value in case a clock reference is provided.
The actual calibration value written into register is
frequency - 1.

Reviewed-by: Harini T <harini.t@amd.com>
Tested-by: Harini T <harini.t@amd.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://patch.msgid.link/20260122-zynqmp-rtc-updates-v4-1-d4edb966b499@vaisala.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-zynqmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 3baa2b481d9f2..856bc1678e7d3 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -345,7 +345,10 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 					   &xrtcdev->freq);
 		if (ret)
 			xrtcdev->freq = RTC_CALIB_DEF;
+	} else {
+		xrtcdev->freq--;
 	}
+
 	ret = readl(xrtcdev->reg_base + RTC_CALIB_RD);
 	if (!ret)
 		writel(xrtcdev->freq, (xrtcdev->reg_base + RTC_CALIB_WR));
-- 
2.51.0


