Return-Path: <stable+bounces-21270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE4385C7F3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2D283DFF
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27C151CD6;
	Tue, 20 Feb 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XUfkdtv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB67612D7;
	Tue, 20 Feb 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463891; cv=none; b=KlCbsIWTm2n7SSc4fXRPrR5V58CSmBr0JvcsHzlXI+5O2aBYQ5Smqfk16vQfAwBm1QjyAx+wlMR/+QsPyN1MJ7n5SpKBdQrWCDfmw/VbUN2h6hOTeuF7bJUEVSCAttQeAWXAs9AeXzZpNB3GSgAvdu8aeKkdgOuD2MZe/9Pgy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463891; c=relaxed/simple;
	bh=ueYgEkhhpMyxfxczl/x6vZ4Na8J+k1jk0bj7l+uB/uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGI057uJQUYa6vzNrnLBpGZI/1bvM1i2WomzeefEB5dNn3s+dXbidjCvnkPG/gFIWFFw5eBy/2WUo3Lky2NLHwjNy7V2qfOTSiklhMtgDhBPHwBEHrO65P2e5Y0SskmtlAGAfRkk/E9dghH8Mg/gLwVePq1j8QzGO9VFDA4RrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XUfkdtv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CAFC433F1;
	Tue, 20 Feb 2024 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463890;
	bh=ueYgEkhhpMyxfxczl/x6vZ4Na8J+k1jk0bj7l+uB/uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUfkdtv06DQvPaVXbn+OpimNoqAHoxYdZkBq0j1vuspcAj9iWScilqMyuqdUHM/I9
	 G7Yzvh6ye/r3lC3zuoTvo0LZDZG3LcM3XCicdrcxLTRBc/VEzyhmCid60Z6Tr+4a+o
	 TYMsB+xOnIrgmJiTKqCf9N94bxbErxmMYEKZxBOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hui Zhou <hui.zhou@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 178/331] nfp: flower: fix hardware offload for the transfer layer port
Date: Tue, 20 Feb 2024 21:54:54 +0100
Message-ID: <20240220205643.106502427@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

From: Hui Zhou <hui.zhou@corigine.com>

commit 3a007b8009b5f8af021021b7a590a6da0dc4c6e0 upstream.

The nfp driver will merge the tp source port and tp destination port
into one dword which the offset must be zero to do hardware offload.
However, the mangle action for the tp source port and tp destination
port is separated for tc ct action. Modify the mangle action for the
FLOW_ACT_MANGLE_HDR_TYPE_TCP and FLOW_ACT_MANGLE_HDR_TYPE_UDP to
satisfy the nfp driver offload check for the tp port.

The mangle action provides a 4B value for source, and a 4B value for
the destination, but only 2B of each contains the useful information.
For offload the 2B of each is combined into a single 4B word. Since the
incoming mask for the source is '0xFFFF<mask>' the shift-left will
throw away the 0xFFFF part. When this gets combined together in the
offload it will clear the destination field. Fix this by setting the
lower bits back to 0xFFFF, effectively doing a rotate-left operation on
the mask.

Fixes: 5cee92c6f57a ("nfp: flower: support hw offload for ct nat action")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240124151909.31603-3-louis.peens@corigine.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c |   24 ++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1424,10 +1424,30 @@ static void nfp_nft_ct_translate_mangle_
 		mangle_action->mangle.mask = (__force u32)cpu_to_be32(mangle_action->mangle.mask);
 		return;
 
+	/* Both struct tcphdr and struct udphdr start with
+	 *	__be16 source;
+	 *	__be16 dest;
+	 * so we can use the same code for both.
+	 */
 	case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
 	case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
-		mangle_action->mangle.val = (__force u16)cpu_to_be16(mangle_action->mangle.val);
-		mangle_action->mangle.mask = (__force u16)cpu_to_be16(mangle_action->mangle.mask);
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, source)) {
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val << 16);
+			/* The mask of mangle action is inverse mask,
+			 * so clear the dest tp port with 0xFFFF to
+			 * instead of rotate-left operation.
+			 */
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask << 16 | 0xFFFF);
+		}
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, dest)) {
+			mangle_action->mangle.offset = 0;
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val);
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask);
+		}
 		return;
 
 	default:



