Return-Path: <stable+bounces-77642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B746985F6D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2179828A8A0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6B19005D;
	Wed, 25 Sep 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8BN8Yz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFB19005F;
	Wed, 25 Sep 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266560; cv=none; b=OgYSig1hhI1AwX8wnyiYa1U1pCG3Y6DXNKkM4VzSi3uAULMsH/nAsny0yRWTDvlPXIUk2gs2rVxLo/YETeB2EGGU+K04kJYzu8+cU2x14x9vuvqGEEr+zk48Fu51de8jvtuXyZ25rtao/1b8+n28M9RTpsAgilFKk3S2k1DvuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266560; c=relaxed/simple;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUDu1BLqd1t/Gav9x0hHAmqtmg+Q56/XwQ9HI6vf1DVoqPgiI7P32/jpG/m364aosYOsTfTuuJvhJ310Y7z8Tx2vM/wh26d87Rdczah3GeNZ1f/SgCLYpYSt+us/nkV56ff6KZ+5pINUCbHSGBuFe4zBTJV1cox9LFdts/K11Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8BN8Yz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2772C4CEC3;
	Wed, 25 Sep 2024 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266560;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8BN8Yz0IaENWMZ2NGQjMCOcANXdXWX03wqqym3ayqs95kNeGdU9KT3bMrptPvbUQ
	 9p0Ymrumh2tHBFVJ4RVGJpuRWytfH59suEudQcBmhhRVvwd8tRp5NiUJVxeJfeQeXF
	 bXwH85t65kiyUYbyspMhWSXE7NcWbf8kh8CW0yU/S4h87AbGac9sRRV70ueA/Uz4fL
	 ozsDfGiTOwXfRXZKtR9i2TavD7Myd1iIYrH9KM1HVsUi5K6+cc/SPAOVAUbtEf45HE
	 kH52e07b/hp/CmeNBtSpDUOPAQ5QMM5UVmVSapED39G4Mt1UrHAEQbGbJqdBnTfV6w
	 66Aezufigrz5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Remington Brasga <rbrasga@uci.edu>,
	syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	osmtendev@gmail.com,
	peili.dev@gmail.com,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 095/139] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Wed, 25 Sep 2024 08:08:35 -0400
Message-ID: <20240925121137.1307574-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Remington Brasga <rbrasga@uci.edu>

[ Upstream commit b0b2fc815e514221f01384f39fbfbff65d897e1c ]

Fix issue with UBSAN throwing shift-out-of-bounds warning.

Reported-by: syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com
Signed-off-by: Remington Brasga <rbrasga@uci.edu>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5713994328cbc..ccdfa38d7a682 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3022,7 +3022,7 @@ static int dbFindBits(u32 word, int l2nb)
 
 	/* scan the word for nb free bits at nb alignments.
 	 */
-	for (bitno = 0; mask != 0; bitno += nb, mask >>= nb) {
+	for (bitno = 0; mask != 0; bitno += nb, mask = (mask >> nb)) {
 		if ((mask & word) == mask)
 			break;
 	}
-- 
2.43.0


