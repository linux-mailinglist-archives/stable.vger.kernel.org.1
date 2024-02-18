Return-Path: <stable+bounces-20427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106B859465
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 04:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC431F21B20
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F115D0;
	Sun, 18 Feb 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NC1PWQQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNR8uT44"
X-Original-To: stable@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466215C0
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708227036; cv=none; b=K1p8FaItxBj5/gPEVNbqlqpzNWLhACIfDvW1mFxmn6smEDivtt0t+1lFoUa6/bNYBcKBgd4L4iSYMaOkn1tB2/BfrJpHB/2C2308/Zj0QsomcUBYQxNg0BmKbFqjfsosJUrUkNmpD2iSwoRuuwmm0DBhZfipdgyHTca0AzQcfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708227036; c=relaxed/simple;
	bh=2nRBV2fUpHaqb82N/C4deVSrnkTWASajFc9A8riQRbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZFWkGN8tAxyKY7wUsgzdHSzhnlqLze0Tc8AnI5u+RbYXHpZA9MapRErW8CSiJISysTlKJQDV30hwzWTYtuoxsF8/IKoKLJd8ltrqkPSbtKrDlO4k8mxK1N0X20u+wSlEl3aPr0J1X8tuJTdBV+gx+C4SaBXjuAdLhCC/CZZ84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NC1PWQQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNR8uT44; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id D68483200392;
	Sat, 17 Feb 2024 22:30:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 17 Feb 2024 22:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1708227032; x=1708313432; bh=A0j3SW1JHI
	a1O1Iw2bt8CT2eukJao0r8lGkD5zm4FEw=; b=NC1PWQQC3QlJPgKR1uFROzvhAc
	oDP7wMr4rYeLOXrAuReQfkJIFTwgtSrZTKwhVXQvOAhs3YAy/pKPLwNU21MpmfGI
	ZOgwompL+8NFQ8P/ks+nCaspbiaxhLEB2V9h5rg77fjcOAh/7BDIlprugM18AuHV
	yCWuPjv+tH4zVs+NKRYUvN0Z2TNEBev94v9SiKsqqHyQQq4ruCPhLzBDcIbqLYwX
	hIgQum0Erm+qkSFWlhlB2bMb4jYUFUERzYtL1YighQh3Z631FGEiB8nuxcRLQeDB
	A2HSz1G6NsLz1bJAu010qMVAF4WloJYQ8Cuer7SX1BTpcxrWD3Y78T53LZng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708227032; x=1708313432; bh=A0j3SW1JHIa1O1Iw2bt8CT2eukJa
	o0r8lGkD5zm4FEw=; b=QNR8uT44v54QUDHKppXCGufRJKDRWgpx35j/oAR/zNYt
	9guVq4ykQ0NFGE7Qy3s+HCC6QivcbOZ/Ej8ef3CebexegfKhnq+0BjzF0Pz31onf
	LyiO0YnCDZne8m/vn5h2PGd766FZGC/bKa9n6kbW3PyEUmNjgAgEfw7badxDkHgU
	wN+4SkyOG0cPYx0iW3sv9z1kpPMpo5MNQCnNj4cNfJYyr04T3Rr1bqHbmKNCK5i2
	K7OjpnSZwD9GHG7bZ2Ujt3Z13q7G+7/r1d4p6GJjpcBuiSJ0NyjriZAmQP23/EGA
	8OuOQOGLxqQDJ+tYr39qKhUOHRg39X3CXpVczpQ5VA==
X-ME-Sender: <xms:13nRZciqF6-Oi-dmWuPV1krd7E88xRblKOV0khwsiY7m5e3Mr1pgbA>
    <xme:13nRZVCD2fgBcw8HCNKqx5ivuTB6YRRP4uIsVBA05dj1gymQUbdw810YayJA_ot2r
    QGPr-2VNYwdHuhxS1A>
X-ME-Received: <xmr:13nRZUEht8X2T_N2bxG-EGQB1itrWzyeK-GlQiju1X8-IGAR4UNg3MbTGHTSl9cppnl3NKUWPIrzg0s7AZbQrfN9lBmqH2V7gMUtnAxs4geK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:13nRZdT6qAG4gJwovNDvasoJI7h2C8i-pWBfDFO8h8CdboxuGZi7TA>
    <xmx:13nRZZwIAdZv_Foka1WcAmCWW5jGtgOwVtxyz9LoSVm--owkAIWaJg>
    <xmx:13nRZb5u48QZS-sLDAfTiZFmIKh5f4w9bRT98oHadRiniOrwBxNXOg>
    <xmx:2HnRZaoMjTJFBYL1vMf23PSrhE_Y3N9JDY_Dw92QigsviB8rg8IM7g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Feb 2024 22:30:30 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: firewire-lib: fix to check cycle continuity
Date: Sun, 18 Feb 2024 12:30:26 +0900
Message-Id: <20240218033026.72577-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local helper function to compare the given pair of cycle count
evaluates them. If the left value is less than the right value, the
function returns negative value.

If the safe cycle is less than the current cycle, it is the case of
cycle lost. However, it is not currently handled properly.

This commit fixes the bug.

Cc: <stable@vger.kernel.org>
Fixes: 705794c53b00 ("ALSA: firewire-lib: check cycle continuity")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a13c0b408aad..7be17bca257f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -951,7 +951,7 @@ static int generate_tx_packet_descs(struct amdtp_stream *s, struct pkt_desc *des
 				// to the reason.
 				unsigned int safe_cycle = increment_ohci_cycle_count(next_cycle,
 								IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES);
-				lost = (compare_ohci_cycle_count(safe_cycle, cycle) > 0);
+				lost = (compare_ohci_cycle_count(safe_cycle, cycle) < 0);
 			}
 			if (lost) {
 				dev_err(&s->unit->device, "Detect discontinuity of cycle: %d %d\n",
-- 
2.40.1


