Return-Path: <stable+bounces-77480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E0985DA5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBF5284B1C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6F1B3B3D;
	Wed, 25 Sep 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSdpJg2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDA18C344;
	Wed, 25 Sep 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265977; cv=none; b=j+XLBw39rmQTAEHfuHm1keIsg/9rKH5JobiZ0dKhrI2EV0NoCQRA1ZKRmfFcBYQJYXw35AZrz7eL38HDoDgblpcDLl/ziVwXQE7StQ6wu/LYLBEYWNAvTqwOXkecE5uJAiLV7wlJvsfIKMTj1ttqyV6fhVmp3FsrU7D79Azfp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265977; c=relaxed/simple;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlbSC8UQkJYuvTZEhjoKKGd6EKScf/S0G3OrZ+0Wead/YYCHb7L6PE1e4aXbs3Ge3CfusDqWen8Ba0wcUcly1wOMcJ/1KlAvvKSTiF3zqJN65RxFNr1VVm83E3K+r5SkUfcf/7WEjm2X+Rz6Zd37awQ+26kXPjoX0Z3XOM5Yzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSdpJg2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0142C4CEC3;
	Wed, 25 Sep 2024 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265977;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSdpJg2HVUDPSG2d3eHvJiwxzEjdQ5Ys6qT0AQlK7GV/TNLnheR08bBApSHqQWLuj
	 vuaht+K0GY6bgU4rl0bCsIuR/8rxxbSPYa6StdyktyELVKHlaaNXrFBt/+pwRJ3W6d
	 XbwebTwJSejCGkwPDrU6ePEr2mfUAcKV1MZMY9FlBCINE3h7p9pAwFH1KBVWHE+gsK
	 7iiGvem7ez+V8jiwFrFo1f3zP5SZSAWO1mMG8aihdcmMv0MyKQgWzVM/9A9MJn+v5w
	 pZj9lGuxwCaFi/05Hh3m9j7UTpSKPMmzXpi3YLAzo1/OnBBnBDi/9YloBzgIws9cAL
	 vA3a7Xss3Bo7Q==
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
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.10 135/197] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Wed, 25 Sep 2024 07:52:34 -0400
Message-ID: <20240925115823.1303019-135-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


