Return-Path: <stable+bounces-44763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3B8C544D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FC21F233AE
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55CB757E8;
	Tue, 14 May 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VN9U196C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCB6CDC0;
	Tue, 14 May 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687105; cv=none; b=MvhlSDCXoDk9DsBSpkjjo7GpPRF18svBbqLwJi19PjNlRnVwveNLxwThWlyp8JxCxrTyKgFQ0qzopv7Y0ZuRJvegnH1l8RbUSBhQDjVJZWKnWaw9XUlnG4RcKShL/MVcJIMkHojVl/Gp5rgw3iiJ+yJwS4altNGPeSiUWybCd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687105; c=relaxed/simple;
	bh=bm7NQaHYibjvxU3VHSS2RINg5ZRW3ejQdFRODIzfNeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skb8d+tiSIscMvtpuvq1SxUnUD/FeVhXy/zBG0ID/UvSROZjlpRwkLjG5CaYogPAJbzoidrCzUmLNLYQpzT+SIbm+365AYfwhWAVkaNtWRAeb1MXyEywYtEJhyfDYtVDaPFza1un8Hr9b1+YJNYQJsqHQBBDkwjXpJUqjIBWVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VN9U196C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2925DC2BD10;
	Tue, 14 May 2024 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687105;
	bh=bm7NQaHYibjvxU3VHSS2RINg5ZRW3ejQdFRODIzfNeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN9U196C+YGQTeIRP/53xIm9OVvD1BAm4Y8I17pu3dFMXb7qK8nFoJT0iWkEuYVhP
	 u4MdxDq4eE+Ckj4TEeC2mTfEgDmBGlKWYGlLZ8FY5FJiN0n9HvahcRGRRMcncfC1og
	 atJr9qgA0Rvxh2PKkiv0jY6+vAEVAvhg9MXF8Drs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 35/84] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Date: Tue, 14 May 2024 12:19:46 +0200
Message-ID: <20240514100953.014927401@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

From: Jeff Johnson <quic_jjohnson@quicinc.com>

[ Upstream commit 774f8841f55d7ac4044c79812691649da203584a ]

Running kernel-doc on ieee80211_i.h flagged the following:
net/mac80211/ieee80211_i.h:145: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
net/mac80211/ieee80211_i.h:162: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead

Fix these warnings.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://msgid.link/20240314-kdoc-ieee80211_i-v1-1-72b91b55b257@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3b7151501b3ed..e26368fab65d6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -110,7 +110,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -123,7 +123,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
-- 
2.43.0




