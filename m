Return-Path: <stable+bounces-81687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096E9948D3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442DD1F29122
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1F1DF272;
	Tue,  8 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nV/UMvqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CA1DDA15;
	Tue,  8 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389800; cv=none; b=qLSJNZGE4P86pxSkeI8M8IsxGa+eO6K03D+69bmNnVG32RVtGCexcFRTCoSRIQOJLAKBaBeIUZDDpPVdIEY2NnYqvNolgi7RnvWvAdSpCuVcX+JlQjDv2NVyNhG430cqGdlsFsdligglE/v5x0cxvlYtUKvKfCZny/72Nw6M78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389800; c=relaxed/simple;
	bh=8Q4gMPSN8CP7jP88a2X7sGVn+F4nc4fZ6QQPkVpX3eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw5mNb/BgBrXwTXKv2agy0OzgWVGtqGAi8qelPlt0uoBhFT0FOvDyx6ZODhnsu+sYboPTUAzG9IqxS/vtadgjphJ68QG64zDOSY6eoFiMV5A7I3QtuoNJUTDqfwCFPjysZJGMlQ1z24ihJR9Yk6ThDrXkAYuNQK9swKgtm1ToHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nV/UMvqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E59C4CEC7;
	Tue,  8 Oct 2024 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389800;
	bh=8Q4gMPSN8CP7jP88a2X7sGVn+F4nc4fZ6QQPkVpX3eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV/UMvqzzqK7wN44UEtEE5lnrGOCSVV7louBs6E99XZhw1orVfBculJQAqEpQjRWw
	 C4yV0CjEhWZq3tNvzLbX51jiXVB0szu7ayIAqK6vwr71mNw2sjRqzDPqo1tZ5vQILX
	 3avSFFsTM98TTFRHxN1+LnXGiW3Gvt9lrleUWIdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 100/482] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Tue,  8 Oct 2024 14:02:43 +0200
Message-ID: <20241008115652.244961964@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 7e989b0c1e33210c07340bf5228aa83ea52515b5 ]

We have invoked device coredump when fw crash.
Should select WANT_DEV_COREDUMP by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240718070616.42217-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 22838ede03cd8..02b0d698413be 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -12,6 +12,7 @@ if RTW88
 
 config RTW88_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW88_PCI
 	tristate
-- 
2.43.0




