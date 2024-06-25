Return-Path: <stable+bounces-55260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7879162D2
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2F32899D3
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9F14A091;
	Tue, 25 Jun 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tE/oF8SR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A114A087;
	Tue, 25 Jun 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308383; cv=none; b=jlrA3gdzaWRrm0Ry0OzfsDsf+5muLAaIS86DQFoMV+1RkhIfAJll0e+hwRP/OaASevc8/WkmpISV7RmgeNodp3nmatm0hlqskQoIvT/fbEZsCReoespiJyp59tv7m1yi64Mly1rP0kdhkBbAZXlhQDalypxyif4bMT0Ybb3vnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308383; c=relaxed/simple;
	bh=s+G1ErTp/sgw7RTANG9URSOtWSZ9p+wSjvqAEiSmT84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2m1LlUWrFWgCUNsI4EjAhD12L9vZzsasrAWeBRUDgR3wu+6JV/WpAZ58X/yH7rBrKxlGrq7VutVvXqPeuiF8oTw2Ve1j8QHZiwo548iLVB93YlQfdFWqJfQtnEsh2OTjitXdi4ika9Y5irRXaQLma6Y+FqdrWOyJ3pba0+hvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tE/oF8SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ECCC4AF09;
	Tue, 25 Jun 2024 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308382;
	bh=s+G1ErTp/sgw7RTANG9URSOtWSZ9p+wSjvqAEiSmT84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tE/oF8SRAP1LhFA8gUcIXA9dPjJ3dmfezMZcMvT7DT8b+ExVxtaxlcGQmb2CzLruJ
	 cHLdfyuXOEBg4Ttz/cBoAMA9VwyftO12MTCg68ZrwrTDH7gZphyJ+Jf6ni7gddeNin
	 hTmZxeWe+6EtOtm56C2D2uiE2qlbHHVjresJOvFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 095/250] ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
Date: Tue, 25 Jun 2024 11:30:53 +0200
Message-ID: <20240625085551.716356431@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index d3fa6e136744d..25cf072a2a10b 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1362,7 +1362,7 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
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




