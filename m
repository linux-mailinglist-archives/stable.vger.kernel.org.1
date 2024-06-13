Return-Path: <stable+bounces-51473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927E907018
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164A71C23C18
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44AD145B10;
	Thu, 13 Jun 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0XzjF61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABB145A05;
	Thu, 13 Jun 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281401; cv=none; b=P71xKKdAXc5HH9K0AMMQ/78t87PQqIxoyOLzkVu5zLE3SsLXA4kNvX+vemNikgq7orNA3IZE6WGeNcru37FdT/zKQmebpNVhWzz4YBJWAW95EWczKXG+t1WhKcXEKeob10ZU79IcG/Bpc0zeT8sgW1jwdGFb17IY/etlc8RQ9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281401; c=relaxed/simple;
	bh=2vjBHCven7dE4bs/pY/nlqCOphCAhTqKrmWNAhVCfjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKmKqbRHcT7wzHoFf4Ucxz/usxlJiEYZNfBYWb3PzaQ+K7fgsByr9i/Fhp4a9qu6s6c5yCj2l5MetYgDOkXffchOBa/gz2QsdBInzwV81CeI/YcWtbLUGMnoMsW4k3JW6nri2B+dzT7lrFXRiuf2313RRM4cI0EVci+x4rS9cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0XzjF61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABADC2BBFC;
	Thu, 13 Jun 2024 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281401;
	bh=2vjBHCven7dE4bs/pY/nlqCOphCAhTqKrmWNAhVCfjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0XzjF61YL/LK0xMhx7eZMLGjlMp2CKtyPQ4+eo/QBX3fmpXwkCq98uODuhuoVOqv
	 fC01YxJOhS8KYPYbn5/e7w/SRMg1WJ9JEi/z5Tk3ef3w1YPMXZI2FQJ5q3ZBO/UgW0
	 Tuk2kVZoK1pY7QvdwTIA0XGnJvTfDfOXUtodoim4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 243/317] nfc: nci: Fix kcov check in nci_rx_work()
Date: Thu, 13 Jun 2024 13:34:21 +0200
Message-ID: <20240613113256.948156720@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 19e35f24750ddf860c51e51c68cf07ea181b4881 ]

Commit 7e8cdc97148c ("nfc: Add KCOV annotations") added
kcov_remote_start_common()/kcov_remote_stop() pair into nci_rx_work(),
with an assumption that kcov_remote_stop() is called upon continue of
the for loop. But commit d24b03535e5e ("nfc: nci: Fix uninit-value in
nci_dev_up and nci_ntf_packet") forgot to call kcov_remote_stop() before
break of the for loop.

Reported-by: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6671e352497c ("nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 7b3f3d6285004..ada7f32d03e48 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1517,6 +1517,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
+			kcov_remote_stop();
 			break;
 		}
 
-- 
2.43.0




