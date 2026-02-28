Return-Path: <stable+bounces-220547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DMMK2NNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3E1C827E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F3D364BFE7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3303D47E8;
	Sat, 28 Feb 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3YoKf0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9323D47E0;
	Sat, 28 Feb 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300429; cv=none; b=SDng1VgSSmFAUYtpG4Dc+tFSjGN9qC1WOYcvFROojC2bHS6XwgZKKC454h9b/xCwIn3Oev35trDlh2m7DDbn0VrM4ADSW4t7v9TcSJ25V2VgzUKdKbfpxURntOIwdxpWjxUN2sDldxteyiDXlGQLwmxLSuCYtfAKwHdJiEAHow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300429; c=relaxed/simple;
	bh=V5zwxPQQmhoylxmdGBbyD7S0kz+77ermZOUg3JESav4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6g28zUls4C1dWMiqGU5AD/MeQwAHsW6w2IYD03NqyHTmgwXGZGrdVjwKHEAUAlyAqq33XhorGHMqz1AgnAlTQgdfQGh8cFtHPqSDWNOfDztoTbhsHRtCc2+F1Gm3Ya5RVX2105wcE0snHHXXBpUAUIWXbeJA3VXLXquoFRGRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3YoKf0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDCAC116D0;
	Sat, 28 Feb 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300429;
	bh=V5zwxPQQmhoylxmdGBbyD7S0kz+77ermZOUg3JESav4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3YoKf0+2DCR3MO3dRUiGvBM9aldd2rBFYH6WPIJxzQgEaJeZnQ2AMWbHhd55YOwi
	 IsuT4Vg3NLrrtnzPCRVJzQK4SPXCTtOdxYplwALU9WPN+2WOlLjpcoWC/gSm0XhIix
	 sGM1GUgc5HkRGT9l47wbJIIdh3FaWk1UyyatNAhS2yl6qTK7j3/cm4Iwvfhi7qwLNA
	 EQMYoO31HMstouJAbaOQ7c/6lkLLC4lyp6Ct5GiGE6vgbs1UzHjuOzynZdZVkiBhV6
	 tEj7beZo0MrK4vm1fdocBFa63EHHR73odnYafNG9aju3aZGNsY2gLLeY+jpqAWNutn
	 3TX53MZBnRDtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 468/844] wifi: brcmfmac: Fix potential kernel oops when probe fails
Date: Sat, 28 Feb 2026 12:26:21 -0500
Message-ID: <20260228173244.1509663-469-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220547-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,broadcom.com:email]
X-Rspamd-Queue-Id: 13A3E1C827E
X-Rspamd-Action: no action

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 243307a0d1b0d01538e202c00454c28b21d4432e ]

When probe of the sdio brcmfmac device fails for some reasons (i.e.
missing firmware), the sdiodev->bus is set to error instead of NULL, thus
the cleanup later in brcmf_sdio_remove() tries to free resources via
invalid bus pointer. This happens because sdiodev->bus is set 2 times:
first in brcmf_sdio_probe() and second time in brcmf_sdiod_probe(). Fix
this by chaning the brcmf_sdio_probe() function to return the error code
and set sdio->bus only there.

Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Arend van Spriel<arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260203102133.1478331-1-m.szyprowski@samsung.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 7 +++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 7 ++++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 6a3f187320fc4..13952dfeb3e30 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -951,11 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		goto out;
 
 	/* try to attach to the target device */
-	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (IS_ERR(sdiodev->bus)) {
-		ret = PTR_ERR(sdiodev->bus);
+	ret = brcmf_sdio_probe(sdiodev);
+	if (ret)
 		goto out;
-	}
+
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
 out:
 	if (ret)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8cf9d7e7c3f70..4e6ed02c15913 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4445,7 +4445,7 @@ brcmf_sdio_prepare_fw_request(struct brcmf_sdio *bus)
 	return fwreq;
 }
 
-struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
+int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 {
 	int ret;
 	struct brcmf_sdio *bus;
@@ -4551,11 +4551,12 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 		goto fail;
 	}
 
-	return bus;
+	return 0;
 
 fail:
 	brcmf_sdio_remove(bus);
-	return ERR_PTR(ret);
+	sdiodev->bus = NULL;
+	return ret;
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 0d18ed15b4032..80180d5c6c879 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -358,7 +358,7 @@ void brcmf_sdiod_freezer_uncount(struct brcmf_sdio_dev *sdiodev);
 int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev);
 int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
 
-struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
+int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
 
-- 
2.51.0


