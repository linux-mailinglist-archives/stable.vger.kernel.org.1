Return-Path: <stable+bounces-244071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK/JJ1bA+WlADAMAu9opvQ
	(envelope-from <stable+bounces-244071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:03:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270F4CA5C5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2F46301437A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57932ED24;
	Tue,  5 May 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBDEzFL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC13321BF
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975375; cv=none; b=J6cT97S+PTgXDwzwiFUgjRJ7eOcJIaLX/f7Lrdmg1KSa8o/nUgaJEDLlvD7P1GB/lN2VhTmV+oI1SstjDr85bzBOtqp+KX2cN7/TMjdnpi5LS4EWf65hBnfb71yMl5IwguHzw6WFV7kF4IYrvLgBLXnKuNE9weV2S/mV1A2i6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975375; c=relaxed/simple;
	bh=+yqT1MwNh9umfWYDcU3XfKsy3xlPJST8E649FEiVySo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKE425pTmEWeHC2lF8flOlJWOUa5B+zIDgRQxkxgrWWsE3JeQ6j2ztMfK4HAM72U3XKPuXM7nLXRlZNyHV1VSBCJ8TDo4xCoql0L9a4LHEDJsTGkkIkebm75Isdzml5cCVmob47bOW3jIA1F1e77wm+Q+jUxkNddmEzh0wsNyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBDEzFL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB49C2BCB4;
	Tue,  5 May 2026 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777975374;
	bh=+yqT1MwNh9umfWYDcU3XfKsy3xlPJST8E649FEiVySo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBDEzFL2vCNtFQNAu30rW5TDZ8+8vxoIMIYKzs5PxStu4czph6DCWR6neZ7SdiKe3
	 3nQxUvmzihFSiv2KXg5ZsrZhjhfrty3os9QscNIpqbghzrdIgfEjB2erhJ0JHiXaMK
	 SHcsIig9ZVC2bLUUZUKV2k+wWMSh8BAw9ALEH1jtRmWDWmcizq/9NZyxUgrcns8X2V
	 W8IZQ0gqCvFPBJyCeL5HY29jTqz469X+m4mFrj3Rz7o491hijCFe4ZCH2csnGXAmjP
	 5MSt5e/lBhi79/yDpTQpmKHdiZip2pRXaD2ytJomDSRwpjxgb4zjMgqsSKJTyw+/Jx
	 prGhYSbtp2JZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/3] mmc: core: Adjust MDT beyond 2025
Date: Tue,  5 May 2026 06:02:48 -0400
Message-ID: <20260505100250.522459-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050303-jingle-ambitious-5f11@gregkh>
References: <2026050303-jingle-ambitious-5f11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4270F4CA5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244071-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,sandisk.com:email,rock-chips.com:email]

From: Avri Altman <avri.altman@sandisk.com>

[ Upstream commit 3e487a634bc019166e452ea276f7522710eda9f4 ]

JEDEC JESD84-B51B which was released in September 2025, increases the
manufacturing year limit for eMMC devices. The eMMC manufacturing year
is stored in a 4-bit field in the CID register. Originally, it covered
1997–2012. Later, with EXT_CSD_REV=8, it was extended up to 2025. Now,
with EXT_CSD_REV=9, the range is rolled over by another 16 years, up to
2038.

The mapping is as follows:
cid[8..11] | rev ≤ 4 | 8 ≥ rev > 4 | rev > 8
---------------------------------------------
0          | 1997    | 2013        | 2029
1          | 1998    | 2014        | 2030
2          | 1999    | 2015        | 2031
3          | 2000    | 2016        | 2032
4          | 2001    | 2017        | 2033
5          | 2002    | 2018        | 2034
6          | 2003    | 2019        | 2035
7          | 2004    | 2020        | 2036
8          | 2005    | 2021        | 2037
9          | 2006    | 2022        | 2038
10         | 2007    | 2023        |
11         | 2008    | 2024        |
12         | 2009    | 2025        |
13         | 2010    |             | 2026
14         | 2011    |             | 2027
15         | 2012    |             | 2028

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: d6bf2e64dec8 ("mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a3..f744dd5018428 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -671,7 +671,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.enhanced_rpmb_supported =
 					(card->ext_csd.rel_param &
 					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
+
+		if (card->ext_csd.rev >= 9) {
+			/* Adjust production date as per JEDEC JESD84-B51B September 2025 */
+			if (card->cid.year < 2023)
+				card->cid.year += 16;
+		}
 	}
+
 out:
 	return err;
 }
-- 
2.53.0


