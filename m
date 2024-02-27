Return-Path: <stable+bounces-24393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6D86943C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5ED1F2211D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB714199C;
	Tue, 27 Feb 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGOTL9vh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600513B2B4;
	Tue, 27 Feb 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041876; cv=none; b=ODc3Pc6tT3v2C+FwPU0jBn2kamb12rxNlVr52JIdYrmPMFMSHP4gFAOFqRjm3qD7vyzz0njt57pbjZLzr7dE1kMakA2A+djqaYyjIXlNsTRJMp5/uduaj74hHiUgMmXATPEU7sE1C/wKWSZB0qes3WuUisdKlkDGV0d0aU4gV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041876; c=relaxed/simple;
	bh=1gFU9SmQvh5gMd7lXU+6LgoeHdOpf3wULL4YIa2aHk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMsk1pkMRUJMXpt84Gz+/sUa0jJ4nEzMVkFTETaH0Um20DQcAu5mw5PgJGUICy+OYb0n+x0m1b//wUHI0ahfO8u03TlNd9xvcroJw0qCF8TQOPasacATY/7VKPH7HuqV2lOKOp9yw+BC9Uxuzr3Ad3fZI0lN79UoudTcOEcywKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGOTL9vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F589C43390;
	Tue, 27 Feb 2024 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041876;
	bh=1gFU9SmQvh5gMd7lXU+6LgoeHdOpf3wULL4YIa2aHk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGOTL9vhycxPBuk0TD8ZUB2M6lJ/vp+Tm8jsf/Tl6mwR73HyDWd5hFqB+NA2yGWoG
	 d9OvIC0CxsGyO2mog6TeAHAu7UaIoLUaC3ZJMC/uUgdDgJ9N/BZHY+ijGqD1RQhv5P
	 q58Ircr2mqGvUBu4WCt6fbq5bZQTek5Z8dvhOJg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/299] wifi: mac80211: set station RX-NSS on reconfig
Date: Tue, 27 Feb 2024 14:23:23 +0100
Message-ID: <20240227131628.868132934@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit dd6c064cfc3fc18d871107c6f5db8837e88572e4 ]

When a station is added/reconfigured by userspace, e.g. a TDLS
peer or a SoftAP client STA, rx_nss is currently not always set,
so that it might be left zero. Set it up properly.

Link: https://msgid.link/20240129155354.98f148a3d654.I193a02155f557ea54dc9d0232da66cf96734119a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7cb50b0dd4ed..daf5212e283dd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1887,6 +1887,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
+	ieee80211_sta_set_rx_nss(link_sta);
+
 	return ret;
 }
 
-- 
2.43.0




