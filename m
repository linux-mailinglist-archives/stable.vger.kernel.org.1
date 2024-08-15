Return-Path: <stable+bounces-67838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC1952F54
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F03B1C20B61
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E018D627;
	Thu, 15 Aug 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOjnnE8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD87DA78;
	Thu, 15 Aug 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728677; cv=none; b=VAJfzeV6WzWu3/rmFXKbhNF8Orn3Kx6hPtg52dGiD+oyF8hCDaiv6SjbVwEkCeYuq9BkTVB85h1gz9VRsDt7S8mYHc6Czu5atvp0RgyMhry0FLx1XiggcE24rSlSxvu2XgD4xIttt76M2Vy3RLMMPgqq++jtxOdtBC4nzcYcmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728677; c=relaxed/simple;
	bh=usukGFcMiEHLaFfhD4Tg6RnGiwXlydHJGX6u9qwBWKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntor0yvGJXIJ4XkuMCPfCCp79XnTJCJc3rhAyMKkI5lz3Kqoze8hDgYk9cIoUPLWQ2rTMkXktWqDbjY0U0tL4V3duLfRG1VKJ8X+uH09wI38Y28CKsKtHIdd0tHnp13W37yPa+ixAz3fxDfobj6A4roDezBV3DicP21FP+7/UdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOjnnE8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D60C32786;
	Thu, 15 Aug 2024 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728677;
	bh=usukGFcMiEHLaFfhD4Tg6RnGiwXlydHJGX6u9qwBWKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOjnnE8YV9f9XzuEpotlq0fLluyRttXktaxBWXEQdlgiaLVJCPK2dYkFxJ42l0y3j
	 wAihjt6ZILp18z9MRh/K81bqhjIDb+BpovQtIYCZTNnjtFFQwQr34Cyz/eeI0Mb1HI
	 YxYhWtuKoCJ0b1pbs0+xLMKxaQQnDooIliDpfWTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rafael Beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 4.19 074/196] wifi: mwifiex: Fix interface type change
Date: Thu, 15 Aug 2024 15:23:11 +0200
Message-ID: <20240815131854.910206795@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael Beims <rafael.beims@toradex.com>

commit a17b9f590f6ec2b9f1b12b1db3bf1d181de6b272 upstream.

When changing the interface type we also need to update the bss_num, the
driver private data is searched based on a unique (bss_type, bss_num)
tuple, therefore every time bss_type changes, bss_num must also change.

This fixes for example an issue in which, after the mode changed, a
wireless scan on the changed interface would not finish, leading to
repeated -EBUSY messages to userspace when other scan requests were
sent.

Fixes: c606008b7062 ("mwifiex: Properly initialize private structure on interface type changes")
Cc: stable@vger.kernel.org
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240510110458.15475-1-francesco@dolcini.it
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -934,6 +934,8 @@ mwifiex_init_new_priv_params(struct mwif
 		return -EOPNOTSUPP;
 	}
 
+	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
+
 	spin_lock_irqsave(&adapter->main_proc_lock, flags);
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);



