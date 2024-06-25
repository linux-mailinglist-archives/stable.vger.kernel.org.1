Return-Path: <stable+bounces-55472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1209163BD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E90B1C220AE
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF114A0A4;
	Tue, 25 Jun 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A5i6YoSz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F91487E9;
	Tue, 25 Jun 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309004; cv=none; b=ZjecwVGhBrArW6MzwTc9UJnCioMNCb525nMyyTYT9pfsfgYCkyK636+A1Xc36BrWX/ByfRiBzPWJjO+ceLZBtcz6TZq7+K23yLoQjBc1LHD2VJjRgL7wj1xyi8O3oMZANZpeCuKe2fViqYvqrJBpCAaYlZmOWGjtD8fXBHxMqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309004; c=relaxed/simple;
	bh=VMx1OQdwSjI34wLqjdODLSu9Ny1OOmU1H7MXmQNao8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPwkb1LHRugO168LKPp7I8lUwM4onrfMlu7WKkz//KQNoHk6Hh7m2CPo1sdw5k6SBA+rRWEI4Gj2r3RnwUCqL0yGsX+EdoYVyKBTkCgei1c2FduNUx8dNe31KJhSksC7PrVsAGcItFSmhxjPYHsNuXHrXVnz0kS6cEFXRtEBQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A5i6YoSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2679C32781;
	Tue, 25 Jun 2024 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309004;
	bh=VMx1OQdwSjI34wLqjdODLSu9Ny1OOmU1H7MXmQNao8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5i6YoSzAFOdlCJt7Ugnxyk48ewj7octrGYWIpChrwHgrBqXu3pWkF7pQ53F8+2wq
	 ROhsLgIQnvGT7Dmisd/FxjKLEifxWK4YmIirX/lHOjiAGkQjqVVD1gpYqrdrctSl7A
	 kTLlpSyg9VzCHdGaDRHnFrZS3bqpCryfMG0f4B9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/192] ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
Date: Tue, 25 Jun 2024 11:32:15 +0200
Message-ID: <20240625085539.592170043@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 6386682cdc8b41319c92fbbe421953e33a28840c ]

The cs35l41_hda_unbind() function clears the hda_component entry
matching it's index and then dereferences the codec pointer held in the
first element of the hda_component array, this is an issue when the
device index was 0.

Instead use the codec pointer stashed in the cs35l41_hda structure as it
will still be valid.

Fixes: 7cf5ce66dfda ("ALSA: hda: cs35l41: Add device_link between HDA and cs35l41_hda")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240531120820.35367-1-simont@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3c157b006a5a2..b437beae9b516 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1187,7 +1187,7 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l41->index].dev == dev) {
 		memset(&comps[cs35l41->index], 0, sizeof(*comps));
 		sleep_flags = lock_system_sleep();
-		device_link_remove(&comps->codec->core.dev, cs35l41->dev);
+		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 	}
 }
-- 
2.43.0




