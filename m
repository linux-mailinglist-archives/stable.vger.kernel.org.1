Return-Path: <stable+bounces-80056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BF98DB9B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F903B22B30
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776911D1F56;
	Wed,  2 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FIvBNSA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338041D0975;
	Wed,  2 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879256; cv=none; b=iuMjQsMR7HzgQJXAe7RGbEVa+L2Qg+hT9hkr0ykq7qz44tE6FpgTd1QxOHXm1iW6VczzIJafx7IPFiIZHWbBDy2byO8vpTDAdOU+H9yOCgZQRayE8IA6yTJS6FJDN0O4xAxrBK02/jfcZEyjFqknbe2jAzabv0SBdjHCJiwPEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879256; c=relaxed/simple;
	bh=eZWOWWnUE2EMih2UjYo5Q+v8XhSAplr+8E156s4ZQz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZJTJEauBNb/u3xa0xm75cKyA+A0rue0oPAVKEU8vkvWLRmgJ4e0ZmFp7lZoajJrBieA7MHqHHU1F7yIsJu1pMWMc3zi98737aGld5PaTV0hV0fTOPcpHnL9u3KBamv4ScrCtZ4JfwrTzrhluHT0o38nX4ZNENeQH9H4OVeZj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FIvBNSA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F82C4CED5;
	Wed,  2 Oct 2024 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879256;
	bh=eZWOWWnUE2EMih2UjYo5Q+v8XhSAplr+8E156s4ZQz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIvBNSA8MihsQbJLUcZtbU7H755Zy28lEGUroTijb39yVhgOe7xwM4D8H1iEsdiE4
	 wf7ipT2MmHGGm63AA5/XPJlXu4eDz8P69MWur4HdmMA6ju0gm4mao+6ZM9NWA3xZoS
	 r1TKL66NW50VekJBb8zQTLurRylfPz6GnwxTrExw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 055/538] wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
Date: Wed,  2 Oct 2024 14:54:54 +0200
Message-ID: <20241002125754.373721825@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit a26a5107bc52922cf5f67361e307ad66547b51c7 ]

Looking at https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
and running reproducer with CONFIG_UBSAN_BOUNDS, I've noticed the
following:

[ T4985] UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3479:25
[ T4985] index 164 is out of range for type 'struct ieee80211_channel *[]'
<...skipped...>
[ T4985] Call Trace:
[ T4985]  <TASK>
[ T4985]  dump_stack_lvl+0x1c2/0x2a0
[ T4985]  ? __pfx_dump_stack_lvl+0x10/0x10
[ T4985]  ? __pfx__printk+0x10/0x10
[ T4985]  __ubsan_handle_out_of_bounds+0x127/0x150
[ T4985]  cfg80211_wext_siwscan+0x11a4/0x1260
<...the rest is not too useful...>

Even if we do 'creq->n_channels = n_channels' before 'creq->ssids =
(void *)&creq->channels[n_channels]', UBSAN treats the latter as
off-by-one error. Fix this by using pointer arithmetic rather than
an expression with explicit array indexing and use convenient
'struct_size()' to simplify the math here and in 'kzalloc()' above.

Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://patch.msgid.link/20240905150400.126386-1-dmantipov@yandex.ru
[fix coding style for multi-line calculation]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4d88e797ae49f..4fc6279750ea1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3209,8 +3209,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
 	}
 
-	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
-		       n_channels * sizeof(void *),
+	creq = kzalloc(struct_size(creq, channels, n_channels) +
+		       sizeof(struct cfg80211_ssid),
 		       GFP_ATOMIC);
 	if (!creq)
 		return -ENOMEM;
@@ -3218,7 +3218,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	creq->wiphy = wiphy;
 	creq->wdev = dev->ieee80211_ptr;
 	/* SSIDs come after channels */
-	creq->ssids = (void *)&creq->channels[n_channels];
+	creq->ssids = (void *)creq + struct_size(creq, channels, n_channels);
 	creq->n_channels = n_channels;
 	creq->n_ssids = 1;
 	creq->scan_start = jiffies;
-- 
2.43.0




