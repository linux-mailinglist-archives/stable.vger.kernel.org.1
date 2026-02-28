Return-Path: <stable+bounces-220392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGbBK3s5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED51C659B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BB9331A6D0B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664603AAB86;
	Sat, 28 Feb 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD5GRwkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E5480955;
	Sat, 28 Feb 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300285; cv=none; b=ZPHLLOV/w29rx9u9Cqq5VprV81/n2Z2XE5xyLhs0JsCqdX6GNKrs4dl4EjqxL64w6VKCnpNs/I1Q9iR7P4Oc/97IVBXcksOEwN5SPd2EcSHBzVAHIWW3W0R/XkNPZ8uWEK1xwgj9dEGcuCcBxfYprIt79s/FsHYkDrCYj2uDQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300285; c=relaxed/simple;
	bh=WLc9+IuJ4Y6+DvZ7a5Qw5UhvfVOKCcCk+tw0ilC13LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg2FssfQ0dEw2nnnrludeZe0+xEA5BLMpFpmsHakPlDkDBsYElIzA/SaLxOItaIQHxi7lx6GOGUaFkcNbvAaOqLpWgci+G1xnyjzeaJXpC2d5vmFYtuQC7zpGcNcJZ93vxWX5N9cNzJIG3ooj9agEeC8XJv2ZIJq6dA/ySzTbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD5GRwkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8906CC116D0;
	Sat, 28 Feb 2026 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300285;
	bh=WLc9+IuJ4Y6+DvZ7a5Qw5UhvfVOKCcCk+tw0ilC13LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD5GRwkBi7TvozRmMTFz/By6L/aBmK7qe6RqSE/dwYKLxnAzuzLeDVltKV1JAZmvg
	 jO3GEh8NMHcNRzLxZP1yCOj+3nqek2pGGVDGQXaBN1PXzAVjzeoSuw1A91X2+W5Dmd
	 VsPRJ91dq2Y4dN+wyW54XY/I0KJV+NEbi6CFuD7+vzfuNfp0N6cDw9UInBhZXmoN2P
	 tx3awMVRVi37fBIjs2HILgaOVw98V/hoRAv+RQf+N1iCgiJBa9FmYtYoVuuMt4A6fo
	 GmjUEiowA9bTvV8XFEylJDN83Gbnagbr/PGz3n75YVXYkz+cdZ77JYRFCR0mDJCVTi
	 IMNyttwZe4+BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 313/844] wifi: rtw89: pci: validate release report content before using for RTL8922DE
Date: Sat, 28 Feb 2026 12:23:46 -0500
Message-ID: <20260228173244.1509663-314-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220392-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D8ED51C659B
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 5f93d611b33a05bd03d6843c8efe8cb6a1992620 ]

The commit 957eda596c76
("wifi: rtw89: pci: validate sequence number of TX release report")
does validation on existing chips, which somehow a release report of SKB
becomes malformed. As no clear cause found, add rules ahead for RTL8922DE
to avoid crash if it happens.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260123013957.16418-11-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 093960d7279f8..b8135cf15d13c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -604,8 +604,10 @@ static void rtw89_pci_release_rpp(struct rtw89_dev *rtwdev, void *rpp)
 
 	info->parse_rpp(rtwdev, rpp, &rpp_info);
 
-	if (unlikely(rpp_info.txch == RTW89_TXCH_CH12)) {
-		rtw89_warn(rtwdev, "should no fwcmd release report\n");
+	if (unlikely(rpp_info.txch >= RTW89_TXCH_NUM ||
+		     info->tx_dma_ch_mask & BIT(rpp_info.txch))) {
+		rtw89_warn(rtwdev, "should no release report on txch %d\n",
+			   rpp_info.txch);
 		return;
 	}
 
-- 
2.51.0


