Return-Path: <stable+bounces-489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31A7F7B4B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402691C20D23
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237F39FF4;
	Fri, 24 Nov 2023 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdIXq+CP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063D39FEA;
	Fri, 24 Nov 2023 18:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE38C433C8;
	Fri, 24 Nov 2023 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849024;
	bh=UHOt9vSwdzsPUO1QaH2i3FzqTyeNkwAQaItIbArbAQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zdIXq+CPy0aZ48VMgngIiBtpBuLYBBiESkDoEcQqj+SvTC2kz44NUuQtKl17t7Nl2
	 0RHiwxRRuljrmK54zHyNmzU3EorYCInnpHlBRM9uGgtb36YvWrr7iURSVaAG5bfLJT
	 eA0cFkTlrmBqNa2moqFuc00Md6ak31BGR4EruTTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/530] wifi: mac80211_hwsim: fix clang-specific fortify warning
Date: Fri, 24 Nov 2023 17:43:04 +0000
Message-ID: <20231124172028.639982737@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit cbaccdc42483c65016f1bae89128c08dc17cfb2a ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/virtual/mac80211_hwsim.c:18:
In file included from ./include/linux/slab.h:16:
In file included from ./include/linux/gfp.h:7:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:56:
In file included from ./include/linux/preempt.h:79:
In file included from ./arch/x86/include/asm/preempt.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
In file included from ./arch/x86/include/asm/processor.h:23:
In file included from ./arch/x86/include/asm/msr.h:11:
In file included from ./arch/x86/include/asm/cpumask.h:5:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:11:
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd
parameter); maybe use struct_group()? [-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

The compiler actually complains on 'mac80211_hwsim_get_et_strings()' where
fortification logic inteprets call to 'memcpy()' as an attempt to copy the
whole 'mac80211_hwsim_gstrings_stats' array from its first member and so
issues an overread warning. This warning may be silenced by passing
an address of the whole array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://lore.kernel.org/r/20230829094140.234636-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1f524030b186e..f5a0880da3fcc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3170,7 +3170,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
-- 
2.42.0




