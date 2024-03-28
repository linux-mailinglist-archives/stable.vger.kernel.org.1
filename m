Return-Path: <stable+bounces-32631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0A88E0D5
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 13:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575D51C29B83
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8914F9E6;
	Wed, 27 Mar 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz+ksFeu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F214F9DE;
	Wed, 27 Mar 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541673; cv=none; b=r4hFXVAo23XtQEZh3s1QC0vYh3oN2d4/0c8QmFbzIdHmA8hosVnAocA1CWS5jFJ3MZtZvM4LPQk2Aqv3VE67qBEoqdc49MDgZSDhJfqOGK/0xtFS0DIyDHx9samiSSmySWWQqBjKj5FTh/gX8RNrCjawo+oUAr2oFxPEnW+yH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541673; c=relaxed/simple;
	bh=f52B1KkEW1j3+XwNpb+1tybAlCjy815tAAlHi5Fc9FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKcVBKVgo+9TcNMuVThQIUtAnvyz+WehQnTc29fTUQX+eydqA8UbxbZqITWwRNGd4fQhisnT2BZfjbbzk4l3dKno1KzivDEUcW+kv/7VCGUYH//zg4gNDdyl6q336Ed8DNcOo2HZQ72OtKIG1ZA5QoBi0tcmVXixJmvW4jd24f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz+ksFeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1230BC43330;
	Wed, 27 Mar 2024 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541673;
	bh=f52B1KkEW1j3+XwNpb+1tybAlCjy815tAAlHi5Fc9FI=;
	h=From:To:Cc:Subject:Date:From;
	b=pz+ksFeuIS5lHwIQQYTnlY419jysQfcMvRzphuETumwd8covGWvbaFIl8kZ2b2ZWm
	 HltkP1eqtoz7evk6Odkncido6hvnezzYmZpa/4jaEpDs9bAIENozDVERdGGsNBYr37
	 poNxSSKMOJ0PSg8DaI2eZJBUZ6P3VCkk2LQ2uXkYboQ6a308hWjh7AarnWW70yh+Ou
	 IZXMbbIQaVfyOhCMpLt6bcXrlhaSZrmWNfrjr/sQS/USdwYjPX1pwnFe/wJdu7yBa6
	 kRmfYvOIWXpPlIlHR/wQac1C6/riKYMTq4h+0ZgTF4qy0d18ZmpXAze2FU6QPIkDe5
	 tTlJyEr5VlxAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wangyuli@uniontech.com
Cc: WANG Xuerui <git@xen0n.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch/crypto: Clean up useless assignment operations" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:30 -0400
Message-ID: <20240327121431.2831149-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fea1c949f6ca5059e12de00d0483645debc5b206 Mon Sep 17 00:00:00 2001
From: Yuli Wang <wangyuli@uniontech.com>
Date: Tue, 19 Mar 2024 15:50:34 +0800
Subject: [PATCH] LoongArch/crypto: Clean up useless assignment operations

The LoongArch CRC32 hw acceleration is based on arch/mips/crypto/
crc32-mips.c. While the MIPS code supports both MIPS32 and MIPS64,
but LoongArch32 lacks the CRC instruction. As a result, the line
"len -= sizeof(u32)" is unnecessary.

Removing it can make context code style more unified and improve
code readability.

Cc: stable@vger.kernel.org
Reviewed-by: WANG Xuerui <git@xen0n.name>
Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/crypto/crc32-loongarch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
index a49e507af38c0..3eebea3a7b478 100644
--- a/arch/loongarch/crypto/crc32-loongarch.c
+++ b/arch/loongarch/crypto/crc32-loongarch.c
@@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
@@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32C(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
-- 
2.43.0





