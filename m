Return-Path: <stable+bounces-113040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB915A28F98
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A89164D37
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC3155335;
	Wed,  5 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvUmDuC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB9522A;
	Wed,  5 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765617; cv=none; b=cvrKvUpHWSaPAmzG7L4fEQZVDLF/CeoRBuIzicbQcy7EapGOSwGeOqE+kr6gMHDTf+urfZSqcRgAUZmh0vcRimoNAA/58B1gHebYwhzhAIDnP41Ufa9mEKUdRTiqGRVvndbucg1K4X91RhRb0Q4mJ0okCNQPoJivVz+/rmq3yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765617; c=relaxed/simple;
	bh=KzYi5AlAL3+CJm/xBp3/csuTFwLkusp9olODe4Su2c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk1ju21piS6bhAejVXtGCF3OhPxp6gEehN3XPG2XDxSDC3hOJy9xWvko0ftWNP9wBKGKR0NFiiMAFRB1ltVBzH+aj48C5OcCcWhGe+PqTNvY/msqO+t3wamnFjIs/lFGJwI+NY26xi2/VKMlEAg88YeRBzMfDTMK1VCmjlCWm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvUmDuC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE08C4CED1;
	Wed,  5 Feb 2025 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765617;
	bh=KzYi5AlAL3+CJm/xBp3/csuTFwLkusp9olODe4Su2c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvUmDuC6CAA2laVqZc/KdRIJxokKq5VkAMrWS41gQHX+AlxPfxgbmTTA+xS23dHW5
	 SUo4kLgEtmdwWaDtwt8E3X+AoMJGhumbDSHm8LncADjVJxinzRRh61QJ5zNr1LcF8t
	 Q7DJAhy4NI+4l/cIYLWBR0RY68vPbLBm0Oi4Vws4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 237/590] libbpf: dont adjust USDT semaphore address if .stapsdt.base addr is missing
Date: Wed,  5 Feb 2025 14:39:52 +0100
Message-ID: <20250205134504.348418099@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 98ebe5ef6f5c4517ba92fb3e56f95827ebea83fd ]

USDT ELF note optionally can record an offset of .stapsdt.base, which is
used to make adjustments to USDT target attach address. Currently,
libbpf will do this address adjustment unconditionally if it finds
.stapsdt.base ELF section in target binary. But there is a corner case
where .stapsdt.base ELF section is present, but specific USDT note
doesn't reference it. In such case, libbpf will basically just add base
address and end up with absolutely incorrect USDT target address.

This adjustment has to be done only if both .stapsdt.sema section is
present and USDT note is recording a reference to it.

Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20241121224558.796110-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/usdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 93794f01bb67c..6ff28e7bf5e3d 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -659,7 +659,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 		 */
 		usdt_abs_ip = note.loc_addr;
-		if (base_addr)
+		if (base_addr && note.base_addr)
 			usdt_abs_ip += base_addr - note.base_addr;
 
 		/* When attaching uprobes (which is what USDTs basically are)
-- 
2.39.5




