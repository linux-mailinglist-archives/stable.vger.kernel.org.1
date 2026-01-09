Return-Path: <stable+bounces-207430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1462DD09DC0
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6EC31479BE
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528735A95C;
	Fri,  9 Jan 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AXu7J5b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851533C53A;
	Fri,  9 Jan 2026 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962032; cv=none; b=OFReC3Xjm+9EDRJ+HzBCXauXFTPMV84j1YMfz3ph+vkO/VP++dD16Z6LNw4O6QwCFp8R01SgIaYTgkjhSqNqi1UCNzQ6F33w2lPohGf3Njf2WqkKA7GlpJB1bCKnwboZ5P7gs9sDyn/nnkUIyU7PMoiVKGZna0UIAHsuQepRDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962032; c=relaxed/simple;
	bh=29tiMKEoBK66XWDgxaCNd6JACXwmoZo+JGNCvz/aIwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyVjht9EZVX29M92HNDq4iuBNdpeY17BA2uoGDB9Jprb/VvZxZ56XHc7C3m0DK/WZB/5AbVXDzHFd/jbVYNbiqH05K782UPyzBB/p64Z9D+PrzOFSbwZVhPSQex606zt5WXWkhIGFqt6ULKD7DQl/X4no2BC5XvLDXmu1vscpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AXu7J5b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D091C4CEF1;
	Fri,  9 Jan 2026 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962031;
	bh=29tiMKEoBK66XWDgxaCNd6JACXwmoZo+JGNCvz/aIwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXu7J5b0dFpxTff74aGvD/TTaC7uTyK00sp50dSB4oKRCu4jbI6BuqkMlJAL3RuxY
	 jNVxgrXhaQtgsxrbH9GjWtOKJ1YWaZ4AukaJnDZ0Ur0ImCz7fsAA/UT3a/Ir2B+JQ6
	 aRQAVpp8TvuGG4cyv+E7TAmm4mIIUYgMrw0JURkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 223/634] ALSA: dice: fix buffer overflow in detect_stream_formats()
Date: Fri,  9 Jan 2026 12:38:21 +0100
Message-ID: <20260109112125.824046719@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit 324f3e03e8a85931ce0880654e3c3eb38b0f0bba upstream.

The function detect_stream_formats() reads the stream_count value directly
from a FireWire device without validating it. This can lead to
out-of-bounds writes when a malicious device provides a stream_count value
greater than MAX_STREAMS.

Fix by applying the same validation to both TX and RX stream counts in
detect_stream_formats().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 58579c056c1c ("ALSA: dice: use extended protocol to detect available stream formats")
Cc: stable@vger.kernel.org
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881B043FC68B4C0DA40B73DAFDCA@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/dice/dice-extension.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/firewire/dice/dice-extension.c
+++ b/sound/firewire/dice/dice-extension.c
@@ -116,7 +116,7 @@ static int detect_stream_formats(struct
 			break;
 
 		base_offset += EXT_APP_STREAM_ENTRIES;
-		stream_count = be32_to_cpu(reg[0]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count, mode,
 					  dice->tx_pcm_chs,
@@ -125,7 +125,7 @@ static int detect_stream_formats(struct
 			break;
 
 		base_offset += stream_count * EXT_APP_STREAM_ENTRY_SIZE;
-		stream_count = be32_to_cpu(reg[1]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[1]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count,
 					  mode, dice->rx_pcm_chs,



