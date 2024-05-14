Return-Path: <stable+bounces-44407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCC8C52BA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C7BB219BC
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417712FB3B;
	Tue, 14 May 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kc5eDNRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9384D3F;
	Tue, 14 May 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686073; cv=none; b=IfFoJ2WJcF4MC1332v+uQmz/PA/IpwtpjNsHzvU9GlWkB8aXHzR46jy+XIn8w7nx/2vMisfl91C4X2oIQ5lcqHyEGnsv7811aWEP7b1MYvn5caKLRh/eEXyJoIGKxEXI8YdXsOBsyYzdGx+hnWav1ixzCOD6mclqM9FXYnJkHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686073; c=relaxed/simple;
	bh=AnT3gfNH7iDwPqhMAykdrE4VrA+/Cx75Ejnu0nLzDko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L52tGSSSij30MYmhqXHJtnChk269QUkNqqOV/fbKFAML0JpYF+KJKxZuzmdfCcfaHD5Ug0QkCU9DitRM12+aYmwlOwsJBMqSrZqfOGJZ3CxwJIFnCDNuqKLGl0ZlgO7bv0C9cFHDk36LZfNyk3S9qxJUm9w4la4Qh6GOKr1gf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kc5eDNRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CE7C2BD10;
	Tue, 14 May 2024 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686073;
	bh=AnT3gfNH7iDwPqhMAykdrE4VrA+/Cx75Ejnu0nLzDko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kc5eDNRdtMKB0u5URNN5rOS1HlRsm0vzvOIKnxd1Bs78buz9KyXZ3NgH9Jb6LVrnH
	 p+1epnes3Drp8dqXGahySkhDj1ncY9Ilkrvh/+ePcxGwf6BLuaFyxhoa2UQLecpod5
	 pYKyOKD5XelLiDVJWRJlEYcbxJ7DNdQW1MEOe2g4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/236] wifi: nl80211: dont free NULL coalescing rule
Date: Tue, 14 May 2024 12:16:05 +0200
Message-ID: <20240514101020.456308559@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 801ea33ae82d6a9d954074fbcf8ea9d18f1543a7 ]

If the parsing fails, we can dereference a NULL pointer here.

Cc: stable@vger.kernel.org
Fixes: be29b99a9b51 ("cfg80211/nl80211: Add packet coalesce support")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240418105220.b328f80406e7.Id75d961050deb05b3e4e354e024866f350c68103@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a3bd554e2586..a00df7b89ca86 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13802,6 +13802,8 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 error:
 	for (i = 0; i < new_coalesce.n_rules; i++) {
 		tmp_rule = &new_coalesce.rules[i];
+		if (!tmp_rule)
+			continue;
 		for (j = 0; j < tmp_rule->n_patterns; j++)
 			kfree(tmp_rule->patterns[j].mask);
 		kfree(tmp_rule->patterns);
-- 
2.43.0




