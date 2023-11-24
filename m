Return-Path: <stable+bounces-1933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FC7F820B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD481C227DD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA23364A7;
	Fri, 24 Nov 2023 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKjUxq2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE62E84A;
	Fri, 24 Nov 2023 19:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC73C433C8;
	Fri, 24 Nov 2023 19:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852633;
	bh=JcCqqnrwyQFljZwXAAazvAHNpcG82fzyRSwwqAwTueQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKjUxq2LkRNeLHB9WJAyhl1SMki3z4tZwD1eGn80/eDdCfq2SDzjFeZoO/Jx3GUog
	 tajtbNCFeMA06xfcyvc4CioWUh0mJryqfrXXjo6xVNAIQhg9M6H82F1Af7CjGKQYvj
	 OTWQPtrtgNo0X0653z1pZESa0LvBpzKc8+Oep6SQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 036/193] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date: Fri, 24 Nov 2023 17:52:43 +0000
Message-ID: <20231124171948.664044897@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit f93dc90c2e8ed664985e366aa6459ac83cdab236 ]

While AudioDSP drivers assign streams exclusively of HOST or LINK type,
nothing blocks a user to attempt to assign a COUPLED stream. As
supplied substream instance may be a stub, what is the case when
code-loading, such scenario ends with null-ptr-deref.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20231006102857.749143-2-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 1e0f61affd979..5570722458caf 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -320,8 +320,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 	struct hdac_stream *res = NULL;
 
 	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
+	int key = (substream->number << 2) | (substream->stream + 1);
+
+	if (substream->pcm)
+		key |= (substream->pcm->device << 16);
 
 	spin_lock_irq(&bus->reg_lock);
 	list_for_each_entry(azx_dev, &bus->stream_list, list) {
-- 
2.42.0




