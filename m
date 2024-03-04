Return-Path: <stable+bounces-26062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168E870CD3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8251F21574
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7B47A5D;
	Mon,  4 Mar 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Apde/ePe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE61EB5A;
	Mon,  4 Mar 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587745; cv=none; b=K44vjQn39I9auqmO+mMW+5CPqitq5yCk0c9sIQHY6w02aYTR0lFfuBOhq5CDwCcdxkCFueC5ibSKge3P0wxGeqgroH9KK1vmYCq8cRbGXik8CGs9+uwWuShHt9lmagsEuM5Z+0zyLLhERkAMHdZ3JwyyhL/YFvUERXkRgzHxf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587745; c=relaxed/simple;
	bh=ejtkR5QQDvvNfdsGnOgGLNg7sfmPw+jWj/i8KaHX01Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrCSJ3emgcibG1LACSwRycE6OvUW6zwXNHAj+zJHrh5HcW8mqY/4PBEkulx9bbfBwEZ62wocgqv5zbzqV+7d8ThW5Wr7oceJzthCpcLPj9Ixy3Ld5RJeDi39uVlKajQ/9wzSKuq+yJhyYwuXmpggFi1hDL+CN6q/0NpAsKPp5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Apde/ePe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B23FC433F1;
	Mon,  4 Mar 2024 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587745;
	bh=ejtkR5QQDvvNfdsGnOgGLNg7sfmPw+jWj/i8KaHX01Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Apde/ePeUHrmVhp/hrfwhhcgv/4RS/KqRzzu8pczLLm/joDXVkJqygCbzcIp5zZGW
	 qCFQc3QpHBndnOS1KcPR7z6dXBsyAMDb1RRvmMtaTgZ7N3rou3dv0W7W5MKdAM+MOQ
	 ziqeAva7rd4jTzdrTxVtFSE2wnLxXRXPZCCyr0ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.7 074/162] ALSA: firewire-lib: fix to check cycle continuity
Date: Mon,  4 Mar 2024 21:22:19 +0000
Message-ID: <20240304211554.224351658@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 77ce96543b03f437c6b45f286d8110db2b6622a3 upstream.

The local helper function to compare the given pair of cycle count
evaluates them. If the left value is less than the right value, the
function returns negative value.

If the safe cycle is less than the current cycle, it is the case of
cycle lost. However, it is not currently handled properly.

This commit fixes the bug.

Cc: <stable@vger.kernel.org>
Fixes: 705794c53b00 ("ALSA: firewire-lib: check cycle continuity")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20240218033026.72577-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/amdtp-stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -951,7 +951,7 @@ static int generate_tx_packet_descs(stru
 				// to the reason.
 				unsigned int safe_cycle = increment_ohci_cycle_count(next_cycle,
 								IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES);
-				lost = (compare_ohci_cycle_count(safe_cycle, cycle) > 0);
+				lost = (compare_ohci_cycle_count(safe_cycle, cycle) < 0);
 			}
 			if (lost) {
 				dev_err(&s->unit->device, "Detect discontinuity of cycle: %d %d\n",



