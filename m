Return-Path: <stable+bounces-220389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF4eCAw0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE4B1C5DBF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7FF633168B1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C93A716D;
	Sat, 28 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxGbF83T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2B3A865A;
	Sat, 28 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300282; cv=none; b=FGOCOC8x3JPy9tHuPR5bKCqIzyTNmVbcNbFeIJlyesLBMnbyThOpYRPtgnzQTP8YjVl7jvapGN9OufA5W0SmC+XeB1ThmhqCwQ0SQpmatnTAXWhMrIa/G4KfG9h1YOXjh6wXaJ09zlHvZ2LFsHbnnKRwjv9Jkt9R8gH/L7o37Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300282; c=relaxed/simple;
	bh=cCmpW99VXVHVkFwH3lnV6jCzgBk2MGwqqDOjBzoTaGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL/NbnMF7vLbmLWbqjFG2Odnkww4yA+fCbd9CO5Qj5r5+gr8ghA1RjWR9/NdT0Rrdd/RHc53I1v9F6wK1Uqyv68L26E/hDG1bCqO5sr5oAl2bMAXI+tvJqFHbVPaOkaGeUou8rs0L/Fa4BcUFuwb8eq9LiZhOtj7fHtXPcraxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxGbF83T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CC3C19425;
	Sat, 28 Feb 2026 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300282;
	bh=cCmpW99VXVHVkFwH3lnV6jCzgBk2MGwqqDOjBzoTaGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxGbF83TlGKWIazsyyWnytvMv9WYcmz/4NVAI1eXB0b5lfkUeKG2aY1he2RiLbtS3
	 /VnyUJeRrleoOzJrIg6D3OdR9r1/1ev7RmbpFphuxL2vqnFGb0+dX2bxGzFk8gQZSi
	 7pSdnhmBGVvZQQkU+cR7hLBC3W7qz7jY/FKz+Up6kQMYow9p2aheZtcWkHcz5AETwP
	 FOUNpWN9OyRG7t64CAdirwVvynJ2oBIuqW48WF9OVUsOtt1BCptdFiBHOmwTam0zlY
	 DzXODppNAwNt5EM+mHRDZKpGHgOVk6Ur1fe0mHsbi3l/uNb7GA0qg8iPP0uN+TJj/T
	 mcTV1ciAXlVwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 310/844] wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control value as LPI mode
Date: Sat, 28 Feb 2026 12:23:43 -0500
Message-ID: <20260228173244.1509663-311-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220389-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9BE4B1C5DBF
X-Rspamd-Action: no action

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit fd5bfcf430ea2fdbb3e78fd0b82ceb0ab02b72ee ]

Although value 4 (INDOOR_SP_AP_OLD) is deprecated in IEEE standards,
existing APs may still use this control value. Since this value is
based on the old specification, we cannot trust such APs implement
proper power controls.
Therefore, move IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD case
from SP_AP to LPI_AP power type handling to prevent potential
power limit violations.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111163601.6b5a36d3601e.I1704ee575fd25edb0d56f48a0a3169b44ef72ad0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2900202588a54..39a04776705eb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10147,9 +10147,9 @@ cfg80211_6ghz_power_type(u8 control, u32 client_flags)
 	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
-- 
2.51.0


