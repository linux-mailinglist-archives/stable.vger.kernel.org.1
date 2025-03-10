Return-Path: <stable+bounces-123022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65744A5A272
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A231C175491
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2601CAA6C;
	Mon, 10 Mar 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LiPMUMRx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB9374EA;
	Mon, 10 Mar 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630818; cv=none; b=oGUsKk02m22G8WsKF+SwLt1R9P5CQ76wTZD7lml3+FJmOyBpafR+yy6ZMJoaZduBG2gW5eL75qXoKxhzEzWiH62DBDcMi5ZusCIZrdEZAjWds1Uwg3l1M5Uv83EIEmYYCN7ob5GNMPxztbm/xOsnDhOOorX/6ap9pmbQX0PP2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630818; c=relaxed/simple;
	bh=5lpaH16CQRYKprFja1E8ddWt4nJhp1144YiwEN1OD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIxj3XGkwI7HKHGX2r9ph2vUVEQWxgsu4lIFKbUwrI+u2kuUr5tPlMfXGk2yghtbgfRR/wm6zekp1Q5B4whtzcbd5+qIul25AP4eah5ZQBPrSsq/N9/m3GQt1KcKpal3HP7VMNM9zJbBIdDdl7iAhaU2Cevp/BSx9MfZZrnr7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LiPMUMRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CE2C4CEE5;
	Mon, 10 Mar 2025 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630818;
	bh=5lpaH16CQRYKprFja1E8ddWt4nJhp1144YiwEN1OD00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiPMUMRxInFi7X9T3k0I068mucpVX+XQ03w7mmpS/odwDptdqSjrKRSd8naFsZ/f/
	 DdKPGQCBDY71+GxwEMTjImYgCwOFT5no6KwWOv6h6Kr5EnVsiiVsSHesuiyEvkKYpu
	 EcdlMnK7nqaJbnUqvBNqKNmham+8pamL8tY7eDHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com,
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 545/620] wifi: nl80211: reject cooked mode if it is set along with other flags
Date: Mon, 10 Mar 2025 18:06:31 +0100
Message-ID: <20250310170607.058365035@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>

commit 49f27f29446a5bfe633dd2cc0cfebd48a1a5e77f upstream.

It is possible to set both MONITOR_FLAG_COOK_FRAMES and MONITOR_FLAG_ACTIVE
flags simultaneously on the same monitor interface from the userspace. This
causes a sub-interface to be created with no IEEE80211_SDATA_IN_DRIVER bit
set because the monitor interface is in the cooked state and it takes
precedence over all other states. When the interface is then being deleted
the kernel calls WARN_ONCE() from check_sdata_in_driver() because of missing
that bit.

Fix this by rejecting MONITOR_FLAG_COOK_FRAMES if it is set along with
other flags.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66f7ac50ed7c ("nl80211: Add monitor interface configuration flags")
Cc: stable@vger.kernel.org
Reported-by: syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Link: https://patch.msgid.link/20250131152657.5606-1-v.shevtsov@mt-integration.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3800,6 +3800,11 @@ static int parse_monitor_flags(struct nl
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;



