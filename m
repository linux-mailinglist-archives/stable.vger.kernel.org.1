Return-Path: <stable+bounces-23915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43538691D4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E061F217D2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4313B2B8;
	Tue, 27 Feb 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UaGMRkmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581154FA5;
	Tue, 27 Feb 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040520; cv=none; b=ARGYVAVNVI268o7prRcyc+Xziqfl7Lh0g/+yWPLdwA9wHcaixVmM8kMFGIxs4k+rURq/a2P83Sl/j6I/U5UTXzmH0ha6yG4odXz0vLukuHqli3nVNNFt3qmqoGT6rhf3VJC9hLZhXJ9oUwE7z3DxSaeg9vST6cOLG24eReNzibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040520; c=relaxed/simple;
	bh=OEThjFOOV3/8joT3Eq1fwIZx8NubJjo6kBByAbfjJXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye3yLcDjr1lVKTihHmOw99T5Dk963xk54Fm8KAdnVEstJkZ63yUFDtT4KJz044Tc0DyvhYnaQVU30270iUEfzPcBJ2jS7nBiR+Ti90Chib14PhvlMVDcwxYlRIBEBu44i0fPWfNSHxo9Ho/vCp2zLEYTZcbGwtKbuZR4g6+TbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UaGMRkmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11633C433F1;
	Tue, 27 Feb 2024 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040519;
	bh=OEThjFOOV3/8joT3Eq1fwIZx8NubJjo6kBByAbfjJXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaGMRkmmQSEmOsgJyN2hTKtK9vA9XUc+UGgev5x8KQPutHiKcqhmkxgLJ2Pr5RJkF
	 A13p/8sABxkrSu6eT2Rv0LZ+KslzNIoIZwSIPB4CNUusPIbgeOMXh9CRD+iFlZ5iv2
	 gkaL9XVjDXvqqlligTA8mzMsqCm1WLoGFCUg4QDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Kazior <michal@plume.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 014/334] wifi: cfg80211: fix missing interfaces when dumping
Date: Tue, 27 Feb 2024 14:17:52 +0100
Message-ID: <20240227131631.082460356@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

From: Michal Kazior <michal@plume.com>

[ Upstream commit a6e4f85d3820d00694ed10f581f4c650445dbcda ]

The nl80211_dump_interface() supports resumption
in case nl80211_send_iface() doesn't have the
resources to complete its work.

The logic would store the progress as iteration
offsets for rdev and wdev loops.

However the logic did not properly handle
resumption for non-last rdev. Assuming a system
with 2 rdevs, with 2 wdevs each, this could
happen:

 dump(cb=[0, 0]):
  if_start=cb[1] (=0)
  send rdev0.wdev0 -> ok
  send rdev0.wdev1 -> yield
  cb[1] = 1

 dump(cb=[0, 1]):
  if_start=cb[1] (=1)
  send rdev0.wdev1 -> ok
  // since if_start=1 the rdev0.wdev0 got skipped
  // through if_idx < if_start
  send rdev1.wdev1 -> ok

The if_start needs to be reset back to 0 upon wdev
loop end.

The problem is actually hard to hit on a desktop,
and even on most routers. The prerequisites for
this manifesting was:
 - more than 1 wiphy
 - a few handful of interfaces
 - dump without rdev or wdev filter

I was seeing this with 4 wiphys 9 interfaces each.
It'd miss 6 interfaces from the last wiphy
reported to userspace.

Signed-off-by: Michal Kazior <michal@plume.com>
Link: https://msgid.link/20240116142340.89678-1-kazikcz@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1cbbb11ea5033..fbf95b7ff6b43 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4008,6 +4008,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 		}
 		wiphy_unlock(&rdev->wiphy);
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0




