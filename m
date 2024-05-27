Return-Path: <stable+bounces-47079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569868D0C7D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E811C20C80
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E315FD11;
	Mon, 27 May 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F97g12zU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F915FD01;
	Mon, 27 May 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837617; cv=none; b=EIcAgOV3UbgULSSkFzF8Q7J33PInJMriPJ3RtD7trXkEL2hB3qEuq/kTjQ07ba+NZYVEfXWxwW452klqZwLlpThYjVDBYfZBlBLO3EXt/fk42sE60iq9ljdpAimx6tX2zzButbN11C8+2dwWnnQGcidUmtTKPP6Wwty6MUJF6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837617; c=relaxed/simple;
	bh=pE/bwTUypNQxg39j8BgR/IKg/AAdxnuUrvIwHNZ2rD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+EwkXOrSSNudlr8y7dQCqzd+7DZa0jg6bNdYe6JXHI8hl0q9DNTqeMvcVTYUioKhk3t3UAR2vmybiG8+nHHst6pTZfKuDcAlnbif7xGZz2a2iIm/AnObzFOKYu2yklxbyCkAP91gAvYNeXPjV8SF9xvD8iAZPCtNffP824XiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F97g12zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D82C32782;
	Mon, 27 May 2024 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837617;
	bh=pE/bwTUypNQxg39j8BgR/IKg/AAdxnuUrvIwHNZ2rD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F97g12zUkE6wqQQZvUt8Vf2Wr0Tf76n8pJeWKvj/gwsQdp+7VBSqLXriwpCQVaiC+
	 XocjoMEiwtFI2KQME3kuH6a5UKrGoPYNvXbhm8YBNCjHgnYH4vejwqjX2hhjOYkD+D
	 uPihWB3cCWWsQe/FUd7InTizO5ipLxBKEbfwbKCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Yu <jack.yu@realtek.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 077/493] ASoC: rt715: add vendor clear control register
Date: Mon, 27 May 2024 20:51:19 +0200
Message-ID: <20240527185632.557996295@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit cebfbc89ae2552dbb58cd9b8206a5c8e0e6301e9 ]

Add vendor clear control register in readable register's
callback function. This prevents an access failure reported
in Intel CI tests.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Closes: https://github.com/thesofproject/linux/issues/4860
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/6a103ce9134d49d8b3941172c87a7bd4@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 21f37babd148a..376585f5a8dd8 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -111,6 +111,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
-- 
2.43.0




