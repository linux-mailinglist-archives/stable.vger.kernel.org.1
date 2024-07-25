Return-Path: <stable+bounces-61767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E557C93C6DE
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230CF1C21D26
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726919D89E;
	Thu, 25 Jul 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="pVlAA6wP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1kr0kL6"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BC19CCE6
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923009; cv=none; b=ug8VLe6TOaCHf+jNYyzOxIh+Qf1WinU0PnzAlikkpdEBcVOrHUvcTt4T7THzDMImOzxHLZh1y/jxh4Msxs7LH9VFKAvZJPcTxKyVywZHxaWE0LzSXy/hyjed6yisG2VyXUIPwxvw0QFfYvkKXkNwQHnuktmCBQ2BjdoWWS8i0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923009; c=relaxed/simple;
	bh=9xEkzYw5KWElDrqKZEOI4qNhsr0Y8DPeqixrnai5rNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hatggQtFRy4hSEGWl00Skckuy9KWNeO2RY3B83nen1ivf4xvueKJFHYqlkHaKzmoDFsp2gtVc1LDOFZaf0M0D1xxkld94mLYmYB8SArFFYCYdYRrdK0YF7iDzPRkvgSkqdWJei4k6EECYuA059XNuha/grITBIMW4Xbn3bviYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=pVlAA6wP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1kr0kL6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E5F4F13801CF;
	Thu, 25 Jul 2024 11:56:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 Jul 2024 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1721923006; x=1722009406; bh=NNvHJBfACm
	Yh4SbsvylbbxExz4FRvpB2zjrNAzhuJHw=; b=pVlAA6wPmhWZD4qOSrfFWRlsju
	UjwGULguHgIA2HnXs+o9m4pe8KvB/IHtn0xKn+61kSP9bUv9VsELevqHb8aPP6Uy
	gKQ55olmWLebmz8LQIRZKhTBXNFUXqHwiSwGMuA0zHMxPoAX5gXdCXaND70LFSxy
	3H8NZtux+jwyxNjbBhiSUx+D5LTYaRCKiPn8tDLk0HnhMLG7Cvk4p6Lko9unoWKn
	JVbqR7YXdTET3zGx6jJe28EP7UJGo6AquFbBaQKKGAg7YtwF6VtUglBCpphsZJnm
	A1ZKUwaVDoTjmsbpF571zrx9vVyRocWnU/WuvN08O9JWFQdaqo/Dq9qQFkJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721923006; x=1722009406; bh=NNvHJBfACmYh4SbsvylbbxExz4FR
	vpB2zjrNAzhuJHw=; b=i1kr0kL6b+ZWiKTvEmo1cJ36YGyD2QplizrBd8V6OEdn
	G+vD7aK37A9GWeoKUjAhz5DECPPSlJ6giGLIOllEzcKdQTpeZcOnjK1UrR+A+OGH
	z6HLQsdyZRAZ2ja6/f737MFXhBC8rNy1xzWrEgmfE1aQAOqWtfWJxueUM1xD694S
	GwttrMfzXCJllp/pNyRnv/ga+kjPG08vW4LumQs9YOStqmiHFldb/8O5JhpRNpFR
	jCBqtjqBTEl7klf2p99nX52qdBFL3vvEdBzZEnxC+WfNkDAqWCBrlOnpPPQ64rRT
	uKJUR7nRKL2KIN9LSBFsx4YbPkX6JGGdJKCHbpddZA==
X-ME-Sender: <xms:vnWiZgIua8emGtYYMflVDs9799dsqgt6pdzr2bsHPEjZqmRjLE1BqQ>
    <xme:vnWiZgJ_xqEuAOzYXBNhO8BUQlX6qFChJQ9yXbjENKFD-s-CuQFeJwMtHx9W5-vnE
    TRve7q6ojWFfzu-7ns>
X-ME-Received: <xmr:vnWiZgs42AD5M0IKBRuMw4Cm92BcLL1iYcS9rwHuPP7E17bXElchuGEz7VVUW67uqttU_jqVVEMW0PtIaomYPNHMbXHeIo5QDwBU8cfzMMNfwNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhi
    ucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqe
    enucggtffrrghtthgvrhhnpeeggfehleehjeeileehveefkefhtdeffedtfeeghfekffet
    udevjeegkeevhfdvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:vnWiZtYqcRfRplKZiZmzD5ICFPd2Ts3kkas3T0YDrTauN5B7aQv0pQ>
    <xmx:vnWiZnZFN_Up90tZdbZ1fFoMN6wvmLllPCM_bgpyE3BSoFG-xV6aUA>
    <xmx:vnWiZpAzn-6qRxW4YE_Bi1lKH5WvamFpcUr6UMfHDiagpF0W31cSAQ>
    <xmx:vnWiZtbleX3UQqcPUvmsLNEgAtpoduT8N5B_411R3Bcoq-9tB63fKw>
    <xmx:vnWiZmUZVlkfe81M-Gj36K7K91Sk0yCjWeZCs7Kv4tPpZf0pWrvcyqQB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 11:56:44 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Cc: gustavo@embeddedor.com,
	stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH] ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case
Date: Fri, 26 Jul 2024 00:56:40 +0900
Message-ID: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
-Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
handle variable length of array for header field in struct fw_iso_packet
structure. The usage of macro has a side effect that the designated
initializer assigns the count of array to the given field. Therefore
CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
while the original designated initializer assigns zero to all fields.

With CIP_NO_HEADER flag, the change causes invalid length of header in
isochronous packet for 1394 OHCI IT context. This bug affects all of
devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
and 802.

This commit fixes the bug by replacing it with the alternative version of
macro which corresponds no initializer.

Cc: <stable@vger.kernel.org>
Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
Reported-by: Edmund Raile <edmund.raile@proton.me>
Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index d35d0a420ee0..1a163bbcabd7 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1180,8 +1180,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
 
 	for (i = 0; i < packets; ++i) {
-		DEFINE_FLEX(struct fw_iso_packet, template, header,
-			    header_length, CIP_HEADER_QUADLETS);
+		DEFINE_RAW_FLEX(struct fw_iso_packet, template, header, CIP_HEADER_QUADLETS);
 		bool sched_irq = false;
 
 		build_it_pkt_header(s, desc->cycle, template, pkt_header_length,
-- 
2.43.0


