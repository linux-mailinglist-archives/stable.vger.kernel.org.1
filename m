Return-Path: <stable+bounces-82416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CAC994CB3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5698A1F238AB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378E1DE89D;
	Tue,  8 Oct 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWe978wt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF81DED7A;
	Tue,  8 Oct 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392187; cv=none; b=fYsdnUPc7vr0V0B59sPHz2WbPDlSZP9jrTdCOYTbKz2qKyiDS85HJLni7uBwXp6xvRCECBcl9A7RTgyTO1Y8YgiSpx5pBOgr53S5E/rFwtVvDC6OwigmzLLiQkLasFHsLHOyk13FyUj06Rq8FLf4DPH1oxYtGOEhSWr7RPuLWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392187; c=relaxed/simple;
	bh=7qaGBK3kHKmEcVbSwocqiVFAirXbMdSZMO8nJ/DGhhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajoJ4kz3KgNzFy/vVzYkoNogeKUpR0iOxUOsINbhrp+/7QFUt0jxezZpb62nsvApwxduckjLwSkAl5I/QOjvXVatu6XR2/2fE3Y1RiASuPzsKefwRHY5GZ9wCusQD349e9VOYi0L6J9dbXJHDuO1WsCnh2EsgEpIEeing9idflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWe978wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7015C4CEC7;
	Tue,  8 Oct 2024 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392187;
	bh=7qaGBK3kHKmEcVbSwocqiVFAirXbMdSZMO8nJ/DGhhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWe978wt145KKvS0/3+ftI68eMJ0eFj7UkN2AIHn9/zDf7OI9F8gD+qWiBEV/t94X
	 OkWomePBW8RxuzlEK5zcB3USszqhrNtqte6YWFgDbgWyEC6J65FSsOJYtfGMz+H64a
	 dKCow3AzbCkcVDW2PHI3MB6Yx4A98rpcHPH4cR6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 310/558] bpftool: Fix undefined behavior caused by shifting into the sign bit
Date: Tue,  8 Oct 2024 14:05:40 +0200
Message-ID: <20241008115714.512336139@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 4cdc0e4ce5e893bc92255f5f734d983012f2bc2e ]

Replace shifts of '1' with '1U' in bitwise operations within
__show_dev_tc_bpf() to prevent undefined behavior caused by shifting
into the sign bit of a signed integer. By using '1U', the operations
are explicitly performed on unsigned integers, avoiding potential
integer overflow or sign-related issues.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20240908140009.3149781-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d45..ad2ea6cf2db11 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -482,9 +482,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 		if (prog_flags[i] || json_output) {
 			NET_START_ARRAY("prog_flags", "%s ");
 			for (j = 0; prog_flags[i] && j < 32; j++) {
-				if (!(prog_flags[i] & (1 << j)))
+				if (!(prog_flags[i] & (1U << j)))
 					continue;
-				NET_DUMP_UINT_ONLY(1 << j);
+				NET_DUMP_UINT_ONLY(1U << j);
 			}
 			NET_END_ARRAY("");
 		}
@@ -493,9 +493,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 			if (link_flags[i] || json_output) {
 				NET_START_ARRAY("link_flags", "%s ");
 				for (j = 0; link_flags[i] && j < 32; j++) {
-					if (!(link_flags[i] & (1 << j)))
+					if (!(link_flags[i] & (1U << j)))
 						continue;
-					NET_DUMP_UINT_ONLY(1 << j);
+					NET_DUMP_UINT_ONLY(1U << j);
 				}
 				NET_END_ARRAY("");
 			}
-- 
2.43.0




