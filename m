Return-Path: <stable+bounces-91461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1699BEE16
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7125A1C244DF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728D1F12FB;
	Wed,  6 Nov 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NEV82oYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEE1EF941;
	Wed,  6 Nov 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898799; cv=none; b=V5n/y9fVEB4iDZcSBXbx6HYE/Q9fcmGe0viWAo2gusBZXjiFj6r6hHkm3pMV2yZ+SZUGlCaReizn0sh3EdyEUTFxPjUEvC8CCaO6HQMnUd/vIQCKsc84tCNdI91lIIFht0HWzNEjclaVfEA4MaAsqFd7SFqPtjVVGLAtynyTyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898799; c=relaxed/simple;
	bh=71jrIEHRXuvAOqqWxRPDlmwb3MF9OGofd96iX0ko924=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJIf6efJbq4W70mrmlrK0iW6ufc81H3d9wmydvyOK5nK79Ad/C4eQU4ai4qNkaeSNaRP6uyfQ78wlL1FmxX43ZdHetAIWG+RHdbO13YUgN2Qwl2BKU2uGKUviam9sDm3+G+SbyywVrspX2b21VjnxIlGCT2+B+Nt0TlV2dj/WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NEV82oYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9AEC4CECD;
	Wed,  6 Nov 2024 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898799;
	bh=71jrIEHRXuvAOqqWxRPDlmwb3MF9OGofd96iX0ko924=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEV82oYf1layjNPYPgOuBJl16bQjKB/dJ73PMjc12HEEQnbu1odBCCbPhWAJ5vF32
	 mGguX6R7tf5JOS/itoJNIE1F9MYWqHkI4zwY3srMoqeczqZnf6ZdOoHasXPHHpohHS
	 wj8YL9p8GjJFHEfA3uF6t9vpArF2ArEdeN25SHG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Sherry Yang <sherry.yang@oracle.com>
Subject: [PATCH 5.4 360/462] wifi: mac80211: fix potential key use-after-free
Date: Wed,  6 Nov 2024 13:04:13 +0100
Message-ID: <20241106120340.422328766@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 31db78a4923ef5e2008f2eed321811ca79e7f71b upstream.

When ieee80211_key_link() is called by ieee80211_gtk_rekey_add()
but returns 0 due to KRACK protection (identical key reinstall),
ieee80211_gtk_rekey_add() will still return a pointer into the
key, in a potential use-after-free. This normally doesn't happen
since it's only called by iwlwifi in case of WoWLAN rekey offload
which has its own KRACK protection, but still better to fix, do
that by returning an error code and converting that to success on
the cfg80211 boundary only, leaving the error for bad callers of
ieee80211_gtk_rekey_add().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: fdf7cb4185b6 ("mac80211: accept key reinstall without changing anything")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Sherry: bp to fix CVE-2023-52530, resolved minor conflicts in
  net/mac80211/cfg.c because of context change due to missing commit
  23a5f0af6ff4 ("wifi: mac80211: remove cipher scheme support")
  ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/cfg.c |    3 +++
 net/mac80211/key.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -491,6 +491,9 @@ static int ieee80211_add_key(struct wiph
 		sta->cipher_scheme = cs;
 
 	err = ieee80211_key_link(key, sdata, sta);
+	/* KRACK protection, shouldn't happen but just silently accept key */
+	if (err == -EALREADY)
+		err = 0;
 
  out_unlock:
 	mutex_unlock(&local->sta_mtx);
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -808,7 +808,7 @@ int ieee80211_key_link(struct ieee80211_
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ieee80211_key_free_unused(key);
-		ret = 0;
+		ret = -EALREADY;
 		goto out;
 	}
 



