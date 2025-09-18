Return-Path: <stable+bounces-178331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55FB47E38
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223E16C158
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F720D51C;
	Sun,  7 Sep 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KSMHQhfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82C1A9FAA;
	Sun,  7 Sep 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276497; cv=none; b=aiNTo2rtQM+jP08d2eu3RmUyC2KpXLgcVSklBg17r9TxsNBC2ETfkaHIAmtJdZeyZG0JAgzjWDSWD3jzWeC5NgapFhBIChiCPCD2FzRoJeUj9FXL79x2baPsEredjITgLFZ5fXVlzuI7c4WoJh4oy/4zFr7TmtQvO/TH5GM8YSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276497; c=relaxed/simple;
	bh=wm2wKG2GjtjImOZf9/qRyalOiarOZr5lk9nWwVO9geo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0ytOzNS568giYry5B5TP/DjwBYb8biY6a7ackTw2h9Z2A3K6ZyOTK13N+cP+a0aoaIll22a/kR56oPDn7mM8B2r1bA57isRLy88oZubXAfh4cjlhCI0opUpFNKs8584Gs4qRsuOnEBccL5DsFXkwdET8PyxB/7i0LnU3a65QYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KSMHQhfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1D9C4CEF0;
	Sun,  7 Sep 2025 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276497;
	bh=wm2wKG2GjtjImOZf9/qRyalOiarOZr5lk9nWwVO9geo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSMHQhfNFCOs4lEZH1omhN9OGh1BsVP2VUFJg+axwjMioZPLzG0eDH55hYp4AS2Wf
	 8Z3jQQXZcGuwww4+Snz6eWGnBXhJGEr994kxrudU6a1lLFXEAr39uvp4Jb7BpZnSHx
	 ILqWiIKDMiAc2n/3VTVJBWd6xAMZvrt13gtXS5LA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/121] wifi: cfg80211: fix use-after-free in cmp_bss()
Date: Sun,  7 Sep 2025 21:57:35 +0200
Message-ID: <20250907195610.309162116@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 26e84445f02ce6b2fe5f3e0e28ff7add77f35e08 ]

Following bss_free() quirk introduced in commit 776b3580178f
("cfg80211: track hidden SSID networks properly"), adjust
cfg80211_update_known_bss() to free the last beacon frame
elements only if they're not shared via the corresponding
'hidden_beacon_bss' pointer.

Reported-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
Fixes: 3ab8227d3e7d ("cfg80211: refactor cfg80211_bss_update")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20250813135236.799384-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 6db8c9a2a7a2b..c1d64e2504548 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1807,7 +1807,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
-- 
2.50.1




