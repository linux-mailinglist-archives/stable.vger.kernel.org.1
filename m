Return-Path: <stable+bounces-49050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A498FEBA7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9577B2407C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E71AB913;
	Thu,  6 Jun 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Od6H3bzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5981AB91F;
	Thu,  6 Jun 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683277; cv=none; b=UKfPAPer0AveEBbyLKKFxZG0T3yFiiz9gxKl2iHCBOSzcBxGyomTc/dJGhZKJ/Uj4ml3HRE5AzilyeSs0Ist8D+QHqxSIU9SNe2Sv2+8lqC6s9pgrrPE07ebt1dZL70dIy+gCiNFdmo77/4vuXOSdxkrQ5OoI8BoL5AeSpHuU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683277; c=relaxed/simple;
	bh=MwMbeg+2yDG4QWOn6hhi1AG/2NnfrA0tBAA0IGGwfRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azJP5G7IfxB4btsJqD3WRk5GRDm03DH8PO9Lvj0aYQ90GE8X+4zo/rZWHskaB8xOUiWOdYRwVGUlIPJrjEo4UBgUt9aJJQITFxloqpXps0XEPP5f64nSmhs/zDQlri4iAK7CLJD+uQ+kmzB7EPIN0TpZ1+w3h3uWmmaXrLvZw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Od6H3bzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D9C2BD10;
	Thu,  6 Jun 2024 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683277;
	bh=MwMbeg+2yDG4QWOn6hhi1AG/2NnfrA0tBAA0IGGwfRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Od6H3bzcrVvkFfj8D4xmfd4G71oerGNlXcqrB32Mr7MLY3YuQVyZNgVCM0xP6ZMzg
	 Tzj1JiqBVl0ZpEMcsdIQC+AXV46vOrAnOgknzVl85QcwuaTS63mZkReH0BDCuN1kkX
	 wGycYOkDWIIXrleAdlhN0tZ8PaCtG1W9Pz9mze3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 219/744] wifi: nl80211: Avoid address calculations via out of bounds array indexing
Date: Thu,  6 Jun 2024 15:58:11 +0200
Message-ID: <20240606131739.415584681@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 838c7b8f1f278404d9d684c34a8cb26dc41aaaa1 ]

Before request->channels[] can be used, request->n_channels must be set.
Additionally, address calculations for memory after the "channels" array
need to be calculated from the allocation base ("request") rather than
via the first "out of bounds" index of "channels", otherwise run-time
bounds checking will throw a warning.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://msgid.link/20240424220057.work.819-kees@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c4f08f7eb741d..8f8f077e6cd40 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9153,6 +9153,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
 	size_t ie_len, size;
+	size_t ssids_offset, ie_offset;
 
 	wiphy = &rdev->wiphy;
 
@@ -9198,21 +9199,20 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	size = struct_size(request, channels, n_channels);
+	ssids_offset = size;
 	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	ie_offset = size;
 	size = size_add(size, ie_len);
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
+	request->n_channels = n_channels;
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request + ssids_offset;
 	request->n_ssids = n_ssids;
-	if (ie_len) {
-		if (n_ssids)
-			request->ie = (void *)(request->ssids + n_ssids);
-		else
-			request->ie = (void *)(request->channels + n_channels);
-	}
+	if (ie_len)
+		request->ie = (void *)request + ie_offset;
 
 	i = 0;
 	if (scan_freqs) {
-- 
2.43.0




