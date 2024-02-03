Return-Path: <stable+bounces-18500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C08482F8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AACB1C236E0
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE331C6B7;
	Sat,  3 Feb 2024 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqwoebiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD941642F;
	Sat,  3 Feb 2024 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933845; cv=none; b=nEOHs68PWPy7et9xCZ6HQk4EQBwQxEY5QFugpE5j3tHEfF8F/cYRqPUxmxdubCR/ggfUVTsjzCOhxZsJ0RBg9Js8nMJs6uuFY7HkggBiESOsa1U8P3PiC5UQx8KLOPFe0LEMJVxKNENCIwyKHYIIswICc7fBUKRxAMY0xjQpxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933845; c=relaxed/simple;
	bh=qijwYlNhqbFV4DbfWaLKm5kJpNoC92imJ41cZmBpyAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsHEbkPqULzpIOz5kgusLwbLMO4RiJ6iPc8wR+E0ZV3stWTUTSgyTMv+hYCzyOKpY+iuud1Qdh059f8SqdRikl5FSN84zFd5tPYGfLmt30qnVAAhxc8EGRrUFIwv6XmyDccv+HOhPqxQu8okJ5t8+vSkmXq0O0Qz3yIm2YZUihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqwoebiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC3C43399;
	Sat,  3 Feb 2024 04:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933845;
	bh=qijwYlNhqbFV4DbfWaLKm5kJpNoC92imJ41cZmBpyAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqwoebiEBdhfnPDmoj/mULGLZkifH2iuk2+ZDt0/WOi8f7tgEo0sszF7BQhtS+g2G
	 86x57KIevzbTDH1wHDF/XXdBrjXb+xzjPu7NKa8UkRwtT67/KbwTzhS0tFLdYYhzdo
	 RskRFvfv54vetX9z2mf8P4VhTuHaUKe7Zwt3FhjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 147/353] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Fri,  2 Feb 2024 20:04:25 -0800
Message-ID: <20240203035408.327221250@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 32af9a9e1069e55bc02741fb00ac9d0ca1a2eaef ]

This is a more of a cosmetic fix. The branch will only be taken if
proberesp_ies is set, which implies that beacon_ies is not set unless we
are connected to an AP that just did a channel switch. And, in that case
we should have found the BSS in the internal storage to begin with.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231220133549.b898e22dadff.Id8c4c10aedd176ef2e18a4cad747b299f150f9df@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0d6c3fc1238a..082f0bd4ebdd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1864,8 +1864,12 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_dereference(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
-- 
2.43.0




