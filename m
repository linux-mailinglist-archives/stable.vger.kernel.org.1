Return-Path: <stable+bounces-112775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB67A28E58
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF3168AA1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9CC1553AB;
	Wed,  5 Feb 2025 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5g2KXWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3C1519AA;
	Wed,  5 Feb 2025 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764710; cv=none; b=FA3PM2HA0drWfMo4Y2jUjBCyaqH2FUacfjoYB5lueAngdUWeYmA8J9/GCDMsbzKJ6Lf26qMk6UQnuUQrmhBMZynYVg2wkgBif6uTKSBDEdOobASRmvgeqOAAo5xlG+lOlDoiQKyOKp4I7oNu0AMoVsG0uhY+7x80ubD9vY3vLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764710; c=relaxed/simple;
	bh=IX+56iVeUssAT9d0ytNJ5cA85HRxWn+5p9B9iX3egVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnFASp482h3xGMK3+LT61vApAZNjatbpXhzmp5dBffhLJONVWBd/kywj0+sI4qEJmhtQ6aJ/syZeaO2bLqhJLrPpWf+z9dVetlZRy9ke695RnOs04H82T54LQa2b1XDbNht0OKK85E2LJqFvHpR5SBCQES5JqRhf6+S9pe4zVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5g2KXWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9E6C4CED1;
	Wed,  5 Feb 2025 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764710;
	bh=IX+56iVeUssAT9d0ytNJ5cA85HRxWn+5p9B9iX3egVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5g2KXWcluI/xZJML38pZi3bbojjX1QZKhX8FGVmxmP19k6zhna6GNwoRWlfR33If
	 TJEoIS84D0fDMDQapkzNWTlZTdKe63g9NBmDGxNGDGHKf6aVnrBtnElD4VQj46E7P3
	 G+hOeAmy7iGX509QaLrLWRp3t+rkHOlHlGV83ArE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 151/590] wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
Date: Wed,  5 Feb 2025 14:38:26 +0100
Message-ID: <20250205134501.054840228@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit e4790b3e314a4814f1680a5dc552031fb199b878 ]

During rtw89_entity_recalc_mgnt_roles(), there is a normalizing process
which will re-order the list if an entry with target pattern is found.
And once one is found, should have aborted the list_for_each_entry. But,
`break` just aborted the inner for-loop. The outer list_for_each_entry
still continues. Normally, only the first entry will match the target
pattern, and the re-ordering will change nothing, so there won't be
soft lockup. However, in some special cases, soft lockup would happen.

Fix it by `goto fill` to break from the list_for_each_entry.

The following is a sample of kernel log for this problem.

watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [wpa_supplicant:2055]
[...]
RIP: 0010:rtw89_entity_recalc ([...] chan.c:392 chan.c:479) rtw89_core
[...]

Fixes: 68ec751b2881 ("wifi: rtw89: chan: manage active interfaces")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241231004811.8646-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index abc78716596d0..c06d305519df4 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -391,11 +391,12 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 
 				list_del(&role->mgnt_entry);
 				list_add(&role->mgnt_entry, &mgnt->active_list);
-				break;
+				goto fill;
 			}
 		}
 	}
 
+fill:
 	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
 		if (unlikely(pos >= RTW89_MAX_INTERFACE_NUM)) {
 			rtw89_warn(rtwdev,
-- 
2.39.5




