Return-Path: <stable+bounces-255274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKe1E+afGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A461B5F7C93
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7CCF31768B9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C0409636;
	Thu, 28 May 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wb7906jO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E73BD649;
	Thu, 28 May 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998449; cv=none; b=IL2EP0D5+34c7srCpxIriW0vFmyy49CvDbVSF2/1l95kNkzZ4pkfszgtzf51XIeyopTAfVgJoB+o3Iy2kCfGckzmXmDvWlLCxx4WkKhelFK2usRPiMc5YF7AXlDmBB3D6udwMjGY+FY78RbqXP0fJRIzhBo2X99PohPn7cuUarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998449; c=relaxed/simple;
	bh=fQLmOqXGNdYiFXhllSi+hwGu7WOJnD3CXSt5zlZ8Ohs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8XgEq8eyLg+yOpgpQAn7lGKQ8yOzNnsvrdIRgl8vtiXJVvUxn7fsC44n5gaua9gtbqoU8r0J6hzCRSobRmHwIidfUZfZ3Suo9+sN6a7L8mDq6ziQprvNAHZhYLN4bQggbQim5hLwVTkJsnJ2+AFFsGMvBUpL5goToZb3WjmrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wb7906jO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA701F000E9;
	Thu, 28 May 2026 20:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998448;
	bh=m1oiVgk/ayDckujWlHzwYXgXUngoncTyEfqVLdMzHrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wb7906jO+WXqHZCGCuszvTy1H7XAKyDTcr6pqcH/yqHHwY55nNLpOA5DQHYsOoJD3
	 57OWrV/7JHAk63iFFBcjQk/WJidV3u4WSBSIcPBnOvUhnGlPnzIl6aH6QedEMu2N4E
	 cvSL+gxa3oIPIWXhpg0RadzThs+gSCFHT+tgKam0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 177/461] ARM: dts: renesas: genmai: Drop superfluous cells
Date: Thu, 28 May 2026 21:45:06 +0200
Message-ID: <20260528194652.195520815@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,glider.be:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1.18.168.128:email,mailbox.org:email]
X-Rspamd-Queue-Id: A461B5F7C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 714e1d6bba0e0abe5c87c8e189a35fa690540df4 ]

Drop superfluous address-cells and size-cells to fix DTC W=1 warning:

    arch/arm/boot/dts/renesas/r7s72100-genmai.dts:28.17-55.4: Warning (avoid_unnecessary_addr_size): /flash@18000000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Fixes: 30e0a8cf886cb459 ("ARM: dts: renesas: genmai: Add FLASH nodes")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260327234244.91707-6-marek.vasut+renesas@mailbox.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/renesas/r7s72100-genmai.dts b/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
index 3c37565097145..da552a66615e0 100644
--- a/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
@@ -34,9 +34,6 @@ flash@18000000 {
 		clocks = <&mstp9_clks R7S72100_CLK_SPIBSC0>;
 		power-domains = <&cpg_clocks>;
 
-		#address-cells = <1>;
-		#size-cells = <1>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
-- 
2.53.0




