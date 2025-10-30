Return-Path: <stable+bounces-191765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B6C21FA5
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 325E14E70E8
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86942EFD91;
	Thu, 30 Oct 2025 19:34:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257192EBBA8
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852860; cv=none; b=dMJwxWU2ZE/juSPs6tHIIvkxNnHrJynwRyynsxmJfqZ3e17+CxxXxSuu46v3FRXeYi97bszacG2G3HE57LfG9EAt8tiEVF1+b9rcTxGt2MyyNjqYBT/+XpK3VjvrMIAZB4lcMLYTJoGPYh+o0f3Z9gVbjDOs7WfIiBovtkExXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852860; c=relaxed/simple;
	bh=xxp91WyazdiFgE5rgTMGl2TEIu9OUF1xlUHOw1tWg9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eyr9xBeBfbem7tDZD8Wvnf9rcxrZJsdLiN/hybZxnylEiihIzckxCawxdTOpvpjneWwdkL4BEJvi2ErFryXl3Ldvab6dge/bXlzYJHkFegQxOa8ROLNJHbCCzLOnyZVMwSch5hwkU5087euohE1yjPqJnQ4dYl9KEV4ca3E4Z8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id B4A6523389;
	Thu, 30 Oct 2025 22:34:14 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15] wifi: mac80211: reject TDLS operations when station is not associated
Date: Thu, 30 Oct 2025 22:34:14 +0300
Message-Id: <20251030193414.406569-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moon Hee Lee <moonhee.lee.ca@gmail.com>

commit 16ecdab5446f15a61ec88eb0d23d25d009821db0 upstream.

syzbot triggered a WARN in ieee80211_tdls_oper() by sending
NL80211_TDLS_ENABLE_LINK immediately after NL80211_CMD_CONNECT,
before association completed and without prior TDLS setup.

This left internal state like sdata->u.mgd.tdls_peer uninitialized,
leading to a WARN_ON() in code paths that assumed it was valid.

Reject the operation early if not in station mode or not associated.

Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
Fixes: 81dd2b882241 ("mac80211: move TDLS data to mgd private part")
Tested-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Link: https://patch.msgid.link/20250715230904.661092-2-moonhee.lee.ca@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ kovalev: bp to fix CVE-2025-38644; adapted check from !sdata->vif.cfg.assoc
  to !sdata->vif.bss_conf.assoc due to the older kernel not having the mac80211
  configuration refactoring (see upstream commit f276e20b182d) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 137be9ec94af..69a67fcf1112 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1349,7 +1349,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
 		return -ENOTSUPP;
 
-	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+	if (sdata->vif.type != NL80211_IFTYPE_STATION || !sdata->vif.bss_conf.assoc)
 		return -EINVAL;
 
 	switch (oper) {
-- 
2.50.1


