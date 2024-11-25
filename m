Return-Path: <stable+bounces-95383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE299D874D
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3093285191
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39151A7AC7;
	Mon, 25 Nov 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc42ExnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0093376E0;
	Mon, 25 Nov 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543510; cv=none; b=GoC0q6HG8O1e+ANce1ioowESKEWS5KDatQ2UgQ+SzsKJQAFSkVjDLgIDrufZ8DsSVX7Adg/R9F8jcOcutVo1uh+sVCHVmZwLHdtGmXVn1Ba5PRznAvH/4QDR+fK8qL5oKB4KcQHKysyd783cs66xStM6uaWX5w3ogoImWq/t7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543510; c=relaxed/simple;
	bh=ER6BK/74S4G1DUMCprZWg698DiwXO4Dr+rnOqRuNX1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cs9CM5yn1jTvl2wm6mnFd6y6Hj69fYBP0AGKRVeIZ+Rume4NqLAja7vQT1kpg6XzNiDELy1mn+xzRQ+vXmCKJGMFR8ZZTdbfHhSE5Lo0ZLnjjUho0WA5aJr4OMpHyx5ThBVNMLmiSsORhYT7dEpfVomznYir5iBLaRVRnb/rmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc42ExnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAA3C4CECE;
	Mon, 25 Nov 2024 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543510;
	bh=ER6BK/74S4G1DUMCprZWg698DiwXO4Dr+rnOqRuNX1M=;
	h=From:To:Cc:Subject:Date:From;
	b=Uc42ExnIQO0LRxiMs3xQ+F/NVW49ta39ByiW+AErf6oq/HDQrrik37kw20quaaIzI
	 CJy6mpdt+jqAK6e1YEReDjJ+v0Yt+xIIVGxKUetRMWBvvXGN3Z7dw/gq+umWbw/+18
	 xL3WmTiBVinbDorQfLoUt/N+9PAHXhqXsoaF0QUU+Pi7CLtpFBLqWt0qMhOTaZ8I+L
	 fD/4dld4pwyyHZ1JFZkRVm0y/FHa6/3Zub86fTM/+bZixzSKu2vvo3hPJ4FcZUjKyS
	 MUaZC1AG2Q5/FzNI/HDR54hhR1nwTX33o2r3f6Am5hucOdp/C4SJnwTLSUOP2pDCY/
	 Nt1rSAO/Zg72Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Dmitry Kandybka <d.kandybka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Mon, 25 Nov 2024 15:04:51 +0100
Message-ID: <20241125140450.3752859-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=matttbe@kernel.org; h=from:subject; bh=5FqTq52xl8VsAEX/Pg7TynecMuw7MwwqjB0J/nAGOWU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnRIQCzJj3UIdKq3Frn7JlFsA0HL8Eh9VJ+3bk3 YppBbRoOsaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ0SEAgAKCRD2t4JPQmmg cxbZD/4s4YB95wMV8MrObS9zd38Uetyk+WvKkRdL2u4ilqul5iOKvke60xVDjVzGw1cTV3PAWw/ fPMw6MU6FASTAI5r//697rpyZivsrBZfu9502JxwY8eWAOnUzYmSN3yXf5uCJ7TN2sEJgXy1/M3 Mnxr7ezQq22+8nukDO9YOlD4B1JQhx1HMbPWBjCQzw+6MAC6lzUr6esUFNZ4VjjZJlCzQR0vUmY J+c47EaU1Mw1s2wfdHNnC2m3ocrvYsnIhcxFa5oxZzPXR5u9bgTjRRtRCsrG9TOYZ2pcfBHxQfi uEAweFJ2AItuvTz/kYNbxo77vc7+TGoYwzPL50IbdeYwfWWagA94V0DS/aqi01KArmezr30qrqx paywH3OtAM3R+bIviEB0g92xlZKs4s9kRirEfA1kTUycLvIAQbWrXoOeBIdY280/4eu4+YFcsET TsW3PSOr5y6e3x1FNluo6d76LrvTFmVVH6Ddr06f7a0M9pK5coXjF/1Fwuo5XeOLadHtGtVV6gt nX55lSsxW20rDG24W6D/OTd5lTTh4c25ICaj2ovnD3bDgQKZMnobcUvB3yUTxi6myp34HndJSug BsAN0uW5aLSkcF0WQu13c4f7Jq06d8eul2zysQ5q+c86zNebYzV/w4lKMLXQOiwl38ev/0DswIf OHqEEfTATYWeqww==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

commit b169e76ebad22cbd055101ee5aa1a7bed0e66606 upstream.

In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Link: https://patch.msgid.link/20241107103657.1560536-1-d.kandybka@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in this version because commit d866ae9aaa43 ("mptcp: add a
  new sysctl for make after break timeout") is not in this version, and
  replaced TCP_TIMEWAIT_LEN in the expression. The fix can still be
  applied the same way: by forcing a cast to unsigned long for the first
  item. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b8357d7c6b3a..01f6ce970918 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2691,8 +2691,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			TCP_TIMEWAIT_LEN;
+	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
+			tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
-- 
2.45.2


