Return-Path: <stable+bounces-158066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F5AE56CB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC907B3655
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455A2222B2;
	Mon, 23 Jun 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aQ8zCxzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D315ADB4;
	Mon, 23 Jun 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717399; cv=none; b=JEE2Ft912BcpTZpTGPM3smbdQ8CvIYxBmrrKmCrFTH/o7gmE7hTnLQUaxiTn+fTKtju0sscRqTNToau+7sNYi9sjsWvTPzMZCZn+Mv/+a8H7PsihDKSh3Fl++AUWJ+qWVytjGPL09XclqQ2xK9eCPjMWt+TNTbltydFiPl7bi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717399; c=relaxed/simple;
	bh=/F9okT/xZB+xz8/dtg6i0ndw6PYyXNjbMACf/einwxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBGwBZAqDueXvgQDCW5uCFtqdIcvkiyxBOanQzZFlafwBxIUJ6N1LfF46+dVjEO4Y9qMaOBNxRrDSeQMeZ58amZgf+W9j5b8Am4SrByjtAUkuJmEJsay89upga7kZzGqbEOjegAhnrnk7BkCIPsXUCShDnAm5KAwJarR9NvnKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aQ8zCxzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1778AC4CEEA;
	Mon, 23 Jun 2025 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717399;
	bh=/F9okT/xZB+xz8/dtg6i0ndw6PYyXNjbMACf/einwxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQ8zCxzTgA9CFvO0MIB1dsftN8MLAN11zElcwjQAt6I76Zd2NgPet4XgIAvDBgBD5
	 2GGCiZ4GNMrwDKvAivS+VwOjJX9KHHeov5QUp0SxwPT3bWcaDzovrmAiVpfEt241SP
	 bmrMXtZEXrZN1urH6Zovzi8r0xH4okzGD2iTGFtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 419/508] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Mon, 23 Jun 2025 15:07:44 +0200
Message-ID: <20250623130655.508871705@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit c575f5374be7a5c4be4acb9fe6be3a4669d94674 ]

Setting tsf is meaningless if beacon is disabled, so check that beacon
is enabled before setting tsf.

Reported-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=064815c6cd721082a52a
Tested-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Link: https://patch.msgid.link/tencent_3609AC2EFAAED68CA5A7E3C6D212D1C67806@qq.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index abcd165a62cfe..80a2a668cfb9e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1091,6 +1091,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	/* MLD not supported here */
 	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
+	struct ieee80211_bss_conf *conf;
+
+	conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
+	if (conf && !conf->enable_beacon)
+		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
 	if (tsf > now) {
-- 
2.39.5




