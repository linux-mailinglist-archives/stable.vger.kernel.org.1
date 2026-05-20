Return-Path: <stable+bounces-250520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJdUIQTwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:31:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E91593DF6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A14F430819D8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9BB33A9CF;
	Wed, 20 May 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ur/ra8Rn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514201E7660;
	Wed, 20 May 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295625; cv=none; b=P3VY6Sn5z3ajh0RH1D1J7/8zru9hp394Fm88Qy7z0piZasuSLAYtkaT6mDxMLkHnr7Rfv0mztfK6psM9NSvxALBCPDK08t0L6cVCRX/BNnyZpDpRq6GstVk1gYxCWVEHtjZwUJr/gw512bh1SzFX6uinP+hTuNNzCEeKjA48zVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295625; c=relaxed/simple;
	bh=vR6hl7Re9Z7ZXamhwMt8w25rAOj9Fxe25wmjDmBl+mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDQhWvgFe578VOw65KD2yuTMpOhFW0GO+q3qGOyHWtEZONwqubDAqVy3jU5Mq8ZqPOTRilge/oedfK3/41oKRLWUQ0p8g8w2VcvX3NkXJau59fui6THBWG3Lj2xMzZsVRSUFsdeEzbDqF8zHIic54QPi3WbPRd3UCxerLSHKl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ur/ra8Rn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB8E1F000E9;
	Wed, 20 May 2026 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295624;
	bh=v+e4ey9ff/dh15F/So1W/9043L5z1XRvnxsTBmHYZYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ur/ra8RnrgNCR0w0/jSjAmrdacVXLjrf17tFkp0y1zip9OIt1TPA9ndVgOjR0N+A8
	 CU+/MdO22nldnfpPHjSU3DDnLdmmkDOOAUcypXxqtwJ8iYvkHqzsYk5UHcyLBZS5j/
	 ObTkfU5ZEW6qe9MZChdDpe4+vGxKLfDo9YKxoqb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Wunderlich <frank-w@public-files.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0473/1146] arm64: dts: mediatek: mt7988a-bpi-r4pro: fix model string
Date: Wed, 20 May 2026 18:12:03 +0200
Message-ID: <20260520162158.896863618@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250520-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,public-files.de,collabora.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89E91593DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Wunderlich <frank-w@public-files.de>

[ Upstream commit e4e6f0c5a4dc238684acef079e792c81d37e3226 ]

Fix incorrect model string in Devicetree for BPI-R4-Pro.

Fixes: f397471a6a8c ("arm64: dts: mediatek: mt7988: Add devicetree for BananaPi R4 Pro")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts
index c7ea6e88c4f48..621d01e3cd896 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts
@@ -9,7 +9,7 @@
 #include "mt7988a-bananapi-bpi-r4-pro.dtsi"
 
 / {
-	model = "Bananapi BPI-R4";
+	model = "Bananapi BPI-R4 Pro 4E";
 	compatible = "bananapi,bpi-r4-pro-4e",
 		     "bananapi,bpi-r4-pro",
 		     "mediatek,mt7988a";
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts
index c9a0e69e9dd51..bb15bfa5e6ae5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts
@@ -9,7 +9,7 @@
 #include "mt7988a-bananapi-bpi-r4-pro.dtsi"
 
 / {
-	model = "Bananapi BPI-R4";
+	model = "Bananapi BPI-R4 Pro 8X";
 	compatible = "bananapi,bpi-r4-pro-8x",
 		     "bananapi,bpi-r4-pro",
 		     "mediatek,mt7988a";
-- 
2.53.0




