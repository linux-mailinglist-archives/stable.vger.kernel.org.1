Return-Path: <stable+bounces-212503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hs1N/8zeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DAA5141
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F9F31DB6F3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93C3043B2;
	Wed, 28 Jan 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RRC6rjrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACB302779;
	Wed, 28 Jan 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615736; cv=none; b=MlZ6SIrAAeOb7Xlk6wW8wT6xt8Lto3P/Bv0zCrQ410IwKd41RML2DwHXZCb9Q6Mmo7QtsAq1ZBR63OZa0MbLnVGp68rY+mjCo+Q2QMthskEus4x+6LoIth4q9PHASP7/Wocy4gyybGWK53KaFTCSguldZYV1UR+IHnih6UrrJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615736; c=relaxed/simple;
	bh=G/LiEKxlVem2Team7ajRzB6zVYt7V+K8mLu1WXU9qrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD+SPEMHvEBiDTRWn4WNJ4EZaLlAt0ao0OIRk64/5OcHNoLWlhXxCaSrTcLlIFw+HqwTRDSCs7zUNSuxga3tqvwgBNwFbtA5LfNW6IuBoBRAy+CqwXouLqCNuvqaqzCGJ5PtzPHVLVT98lZ/RSs5CazeN8Jcofzc3Dy9QM4/3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RRC6rjrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33A9C2BC86;
	Wed, 28 Jan 2026 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615736;
	bh=G/LiEKxlVem2Team7ajRzB6zVYt7V+K8mLu1WXU9qrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRC6rjrI7A1FiFWSjQqKbujutbMZpIz0/lSJkVZOneHMIc4MCGxk6ybpJb0Zuq8VN
	 dQpJKt8icivH9sTDv71VR0vXhZi5yMTAwvwNX4YDJ/SMVX62XzZFKNc2pmee7paQbO
	 UnBa66j1ahYvtvtzf2GJb2uAej991UwO5oLM+4Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Charkov <alchark@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.18 066/227] arm64: dts: rockchip: Fix headphones widget name on NanoPi M5
Date: Wed, 28 Jan 2026 16:21:51 +0100
Message-ID: <20260128145346.715756187@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212503-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,sntech.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sntech.de:email]
X-Rspamd-Queue-Id: 5C8DAA5141
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Charkov <alchark@gmail.com>

commit 5ab3dd9d0a63af66377f58633fec9dad650e6827 upstream.

Fix the mismatch between the simple-audio-card routing table vs. widget
names, which caused the following error at boot preventing the sound
card from getting added:

[    6.625634] asoc-simple-card sound: ASoC: DAPM unknown pin Headphones
[    6.627247] asoc-simple-card sound: ASoC: Failed to add route HPOL -> Headphones(*)
[    6.627988] asoc-simple-card sound: ASoC: Failed to add route HPOR -> Headphones(*)

Fixes: 96cbdfdd3ac2 ("arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20251229-rk3576-sound-v1-1-2f59ef0d19b1@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index cce34c541f7c..37184913f918 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -211,7 +211,7 @@ sound {
 			"Headphones", "HPOR",
 			"IN1P", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Headphone", "Headphone Jack",
+			"Headphone", "Headphones",
 			"Microphone", "Microphone Jack";
 
 		simple-audio-card,codec {
-- 
2.52.0




