Return-Path: <stable+bounces-170698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA2B2A52D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C194E348C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C132274C;
	Mon, 18 Aug 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjKb1EkK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25128322540;
	Mon, 18 Aug 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523486; cv=none; b=Rdkh/4iVi1WTefohI/Eoraz8/orIDyjSM4QmjtA64PMRSNfnZz6PMk/Y3RHdqJ3CBkPjsIzvdPCcMQvjVTeMwArX1pQQMfDjD37jSvko6QrTJTRSEeuMu+Y6mUn/F28PeECzU69lEq31Nww/dnc0+PuvFKU0Fnf3NjBf4JxbevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523486; c=relaxed/simple;
	bh=XuBNHNqVBjQkY0GEs82frtF8YM2qGfphqR16/2wTM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9xW5AvK4Ftqnt17cnVlEClxw8cCkjkhx3ra5c5YiyH6atF3h5Q3UTZqy8Q+AudddJvNU2X37O6yg7bWmdZj/QPG/uYEeQfeSnbTjk8n14dL69btriPNfNk4RBNdLavKNCU8OtDhLLxCbel4Z3Cu8rfgVpQ0RTBqyPFG3mqt52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjKb1EkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4367FC4CEEB;
	Mon, 18 Aug 2025 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523485;
	bh=XuBNHNqVBjQkY0GEs82frtF8YM2qGfphqR16/2wTM4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xjKb1EkKhnmSw+OP2foeE3I85oY3TedAWKj6ChvlaN9zBmapct6MWPVAbH/Ofdtxh
	 afEATepm0/PkIed4nN1xUJOkUk2wKSxyyhp4QATc1yg7cxXclg11NFL4OadyDGxD6V
	 vnM4WsnnyeGOC2kh9DuXh8KmH4JLxdjoa/R9yXks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 184/515] ALSA: pcm: Rewrite recalculate_boundary() to avoid costly loop
Date: Mon, 18 Aug 2025 14:42:50 +0200
Message-ID: <20250818124505.460651698@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 92f59aeb13252265c20e7aef1379a8080c57e0a2 ]

At the time being recalculate_boundary() is implemented with a
loop which shows up as costly in a perf profile, as depicted by
the annotate below:

    0.00 :   c057e934:       3d 40 7f ff     lis     r10,32767
    0.03 :   c057e938:       61 4a ff ff     ori     r10,r10,65535
    0.21 :   c057e93c:       7d 49 50 50     subf    r10,r9,r10
    5.39 :   c057e940:       7d 3c 4b 78     mr      r28,r9
    2.11 :   c057e944:       55 29 08 3c     slwi    r9,r9,1
    3.04 :   c057e948:       7c 09 50 40     cmplw   r9,r10
    2.47 :   c057e94c:       40 81 ff f4     ble     c057e940 <snd_pcm_ioctl+0xee0>

Total: 13.2% on that simple loop.

But what the loop does is to multiply the boundary by 2 until it is
over the wanted border. This can be avoided by using fls() to get the
boundary value order and shift it by the appropriate number of bits at
once.

This change provides the following profile:

    0.04 :   c057f6e8:       3d 20 7f ff     lis     r9,32767
    0.02 :   c057f6ec:       61 29 ff ff     ori     r9,r9,65535
    0.34 :   c057f6f0:       7d 5a 48 50     subf    r10,r26,r9
    0.23 :   c057f6f4:       7c 1a 50 40     cmplw   r26,r10
    0.02 :   c057f6f8:       41 81 00 20     bgt     c057f718 <snd_pcm_ioctl+0xf08>
    0.26 :   c057f6fc:       7f 47 00 34     cntlzw  r7,r26
    0.09 :   c057f700:       7d 48 00 34     cntlzw  r8,r10
    0.22 :   c057f704:       7d 08 38 50     subf    r8,r8,r7
    0.04 :   c057f708:       7f 5a 40 30     slw     r26,r26,r8
    0.35 :   c057f70c:       7c 0a d0 40     cmplw   r10,r26
    0.13 :   c057f710:       40 80 05 f8     bge     c057fd08 <snd_pcm_ioctl+0x14f8>
    0.00 :   c057f714:       57 5a f8 7e     srwi    r26,r26,1

Total: 1.7% with that loopless alternative.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://patch.msgid.link/4836e2cde653eebaf2709ebe30eec736bb8c67fd.1749202237.git.christophe.leroy@csgroup.eu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 853ac5bb33ff..ecb71bf1859d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -24,6 +24,7 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 #include <linux/delay.h>
+#include <linux/bitops.h>
 
 #include "pcm_local.h"
 
@@ -3130,13 +3131,23 @@ struct snd_pcm_sync_ptr32 {
 static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
 {
 	snd_pcm_uframes_t boundary;
+	snd_pcm_uframes_t border;
+	int order;
 
 	if (! runtime->buffer_size)
 		return 0;
-	boundary = runtime->buffer_size;
-	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
-		boundary *= 2;
-	return boundary;
+
+	border = 0x7fffffffUL - runtime->buffer_size;
+	if (runtime->buffer_size > border)
+		return runtime->buffer_size;
+
+	order = __fls(border) - __fls(runtime->buffer_size);
+	boundary = runtime->buffer_size << order;
+
+	if (boundary <= border)
+		return boundary;
+	else
+		return boundary / 2;
 }
 
 static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
-- 
2.39.5




