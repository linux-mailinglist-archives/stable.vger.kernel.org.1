Return-Path: <stable+bounces-34360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB63893F04
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D443C1F210ED
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24D47A64;
	Mon,  1 Apr 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxoGt4H4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AC4778E;
	Mon,  1 Apr 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987858; cv=none; b=rzeW9QeZ7GokodXer1F6UOH8dEPFRjEeuL/5zGB2cTM7iE4KLEnW0ZSZdmpH3v6TuJrnBrca+/RbWJRHZrt870o0aqc8C/6dWbV9t7ik7bQDF/jG4dU96bXoQ8cT6tG5yYw4jx0PbIGbSPiih3mYOsSkPeX/ervmdSetVzHWHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987858; c=relaxed/simple;
	bh=H+dItW4h8PerBrABnTZol9C3WVXBexUUXzTl7TaHhUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmj0JUzrbw9tg3i0etRGedkoZRrXA+hGGaCdSNvsZLJC7Mv96LVCk/rrEt8IzWj3Iuys0KzOw6XjiI+jrIzrFpSc6Z9c6sxylyluw02oVGWaZgTJktKb84xJAaCrjckwJkMdxpVwg5Q2nfIVpw75ETk5+TDyh9S9aj/nbb+2+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxoGt4H4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D9C433C7;
	Mon,  1 Apr 2024 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987858;
	bh=H+dItW4h8PerBrABnTZol9C3WVXBexUUXzTl7TaHhUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxoGt4H4Fl6OAUfrXi9GrYrRmULbpsRbI35nmUs6EN64GyPDBeIZSmkvmJulRfOCa
	 2oym2IQZIFHLKdNmObfnhusQaX5h7p1xc1sRJRHzHGEmNiHW1zu93UZGU+rEW250h+
	 tKP7weaUE8j1SmMeb9K012d7xCJWwqkrYGjPP4aU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 005/432] wifi: brcmfmac: avoid invalid list operation when vendor attach fails
Date: Mon,  1 Apr 2024 17:39:52 +0200
Message-ID: <20240401152553.290773313@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arend van Spriel <arend.vanspriel@broadcom.com>

[ Upstream commit b822015a1f57268f5b2ff656736dc4004e7097da ]

When the brcmf_fwvid_attach() fails the driver instance is not added
to the vendor list. Hence we should not try to delete it from that
list when the brcmf_fwvid_detach() function is called in cleanup path.

Cc: stable@vger.kernel.org # 6.2.x
Fixes: d6a5c562214f ("wifi: brcmfmac: add support for vendor-specific firmware api")
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240106103835.269149-3-arend.vanspriel@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 86eafdb405419..f610818c2b059 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -187,9 +187,10 @@ void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
 
 	mutex_lock(&fwvid_list_lock);
 
-	drvr->vops = NULL;
-	list_del(&drvr->bus_if->list);
-
+	if (drvr->vops) {
+		drvr->vops = NULL;
+		list_del(&drvr->bus_if->list);
+	}
 	mutex_unlock(&fwvid_list_lock);
 }
 
-- 
2.43.0




