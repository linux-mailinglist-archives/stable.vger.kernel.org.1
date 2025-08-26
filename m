Return-Path: <stable+bounces-173894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D5B3604A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3669E1BC006D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A431EEA49;
	Tue, 26 Aug 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERNcY5wu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5214883F;
	Tue, 26 Aug 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212946; cv=none; b=FsAw+SRr2EP31iuv3/yU+qjUyDI3pn9H1q9Qp1awPpFVoKdLGthxDs6XlchfBAGB4AoakvM/f1897CBJqANRZm80lh4D+bJ2rkMpSNdf7krtevJ/X37TJzmyKFCjZsAmiERK5/pObr+2S8bHYr4R1A9EeJZQfSrqlCN3JhM3cDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212946; c=relaxed/simple;
	bh=ZivF05qv0kSCQUL9ptJeUfJhQKBYkfqn0BTUfGpJLkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBCL9jqQt2hOMkxROh+KOc9KmJsHBnmvjk4fARfytSTURzFePFRdpV+tppKF1r0x1ahSFCFaEdT4Cj7Ki5RKXGdFDlTqZKnfl1XH/GuYYpqNv8AXMqdIN2ChwAbfVGfeRTChtZFXGHLqglBgAmOLIPjCZNdlllIM2m6lBZuGKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERNcY5wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1959C4CEF1;
	Tue, 26 Aug 2025 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756212946;
	bh=ZivF05qv0kSCQUL9ptJeUfJhQKBYkfqn0BTUfGpJLkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERNcY5wuj3ddae7qcPBf6W8GJN6ud16j8LXeDC3RNsKmRBOUt3yb603coMjyQbLYP
	 atWWL+zpefysRaZQIEjbHOymsBcBbfBEhwIzh+gE4RSKKRy9VCXYwve88XnZFxL+ku
	 vWI2cq2fyGcxPEop+PfFXYWcaY/RQcVaZSvrbMzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 155/587] wifi: cfg80211: Fix interface type validation
Date: Tue, 26 Aug 2025 13:05:04 +0200
Message-ID: <20250826110956.890862201@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 14450be2332a49445106403492a367412b8c23f4 ]

Fix a condition that verified valid values of interface types.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250709233537.7ad199ca5939.I0ac1ff74798bf59a87a57f2e18f2153c308b119b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2fb3151ea7c9..5b3a63c377d6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -559,7 +559,7 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 {
 	int i;
 
-	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
+	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
 		return NULL;
 
 	if (iftype == NL80211_IFTYPE_AP_VLAN)
-- 
2.39.5




