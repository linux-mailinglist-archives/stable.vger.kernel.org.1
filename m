Return-Path: <stable+bounces-88122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AF9AF84D
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1CB1F221F7
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9918BC23;
	Fri, 25 Oct 2024 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="shTyDLwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJPQT9pf"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237A12CD88;
	Fri, 25 Oct 2024 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827708; cv=none; b=snMwAN6pl02GjDGsz6hLm8v4M14iWhiFzSo4q4/N8t8L+YvI0wWbMfzogiFj6NvCT+NkpgX9ZQX8d82LYZE1T/g/WtZlOHXBsLzkuRcLfvBJo6uG59ujznx+lQznaHOA9PucjSNqK7aTxMs1cIGE+qaDHUnrjXYZa2uj4G1IDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827708; c=relaxed/simple;
	bh=QFFtBJzAZAp2FrLiSmCcVMgaZP7MAdsUChE27fQNMBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEbAHkRFSnjjJb/VIuP6dxem9AAb+Q4/XxCDGqt70+539YMbey/pSvt3NZABXaC0kXHV9LwyzaH4CFv/omRbRS34QHDK/NF1y2CvSMGu74aKe+4t9vmYeqTonw07p+f00B0CBm6UBwWhEI1PK0n9BKEAh+cIJCY2Linf6qyRxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=shTyDLwQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJPQT9pf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D025E114018B;
	Thu, 24 Oct 2024 23:41:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 23:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1729827703; x=1729914103; bh=hGbndDvPKU
	T6KhzJcrOUEZbPMjMh5KNkkA/oX8Q0dNU=; b=shTyDLwQnYFZKH4sdHIYlvjwH4
	ojGjW0FglhBwTRuaKDXosPwWrNqAjTTfKCL/do/Zwsctuco3082v5qr//iaLpU4k
	ww6S39304W++AH1cTgt+lpKX4tKGDykbpWBdQVLjSW5jrqT7EdHvofMW2m7sLem8
	YNGU+T/u+5vhswYOqHKKjlwgERNVlHoI4ezcdwcnrMDxfCbTlQsVvDEk0P8Kx0AU
	9t/C8TNpG7zrhqtWaDkyJ5EkBE9KvDpFTZGkqPFr4GRw3FBytUFvZeOsj3y+IO9p
	6MZRiGk0lqA79kY6ZiFYboHyJ/sQ0UjBRX73FZPLARbJLTyPtBF8rVdeECHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729827703; x=1729914103; bh=hGbndDvPKUT6KhzJcrOUEZbPMjMh
	5KNkkA/oX8Q0dNU=; b=XJPQT9pfH1uxMnbKR9Yi0/hufT1urt2HUSTjH1REm76Y
	p0KB+2Zd0ckmVFBs3z9VY4iCD/hy9/nd/OgrdbQk4qXVeu568MiI4agJsGAnhmHe
	0R/Q9bmH4EZC1OC/YLajU5ZHGRpioGsFq5UxenW/G1OHAjIIPB8rEU+Y9BzLYqnd
	Gn5CYtYsan640bIxt17nSrhw41yEPH5fZzR0KuZ57ybXCsIvfSn1GOAqlCqS0T3G
	XFWXMnMEutnZ2AMEZcXZibFHfoZYZevqgyN0muetAcYtvofmIWh3oeGB44n5K4vM
	6e7ONhF7OKlJjopU8cqp18zoaSXxZ16WcAYULfFHAA==
X-ME-Sender: <xms:dxMbZ7542-OO7h8ZeEqMEQxDiRe2hnJYXpsYgO9N7pukSDZWMKIDsw>
    <xme:dxMbZw45C45E80GqudxFIOG0SuLgExxqSBxN-Llmx1egXJqMSwY8FAr5esuCPdHK7
    ZfB8prmkBLD-6GIHUs>
X-ME-Received: <xmr:dxMbZyc3UkSJpZYUqlJC1A5J_Y5rVVrWrGf4DVTnHxDTTsdd53TkTYs5WPokv7MYJ33ejTUvASvqko7IOdqP-2_pkLnzkzesgW4W0S2tLqxHAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejieelheevfeek
    hfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghv
    vghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    rggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggumhhunhgurd
    hrrghilhgvsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:dxMbZ8LxZeNrmFsb-Lza1Jd4KcqiRx1W20RWBqCk0trVdTVyr7lt7g>
    <xmx:dxMbZ_L_t8AZhhBtCH3ZU44Pf5ABWjisgfemKvufSkLJ19jRYPI8Ig>
    <xmx:dxMbZ1wCSq7F8rj0K4vLrk3wVFio3M0GVrqocqFI7uaXVim24Y2g-g>
    <xmx:dxMbZ7I6DxvypIxLRKc4mfk1SruYrq-c_v55vuklWJVumC-Dgl37rA>
    <xmx:dxMbZ8GtFlHLjNkP5wRRrFyMh0kqWiRi-TxbZzmbCBJq8s5COXpLDEN8>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 23:41:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH] firewire: core: fix invalid port index for parent device
Date: Fri, 25 Oct 2024 12:41:37 +0900
Message-ID: <20241025034137.99317-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a commit 24b7f8e5cd65 ("firewire: core: use helper functions for self
ID sequence"), the enumeration over self ID sequence was refactored with
some helper functions with KUnit tests. These helper functions are
guaranteed to work expectedly by the KUnit tests, however their application
includes a mistake to assign invalid value to the index of port connected
to parent device.

This bug affects the case that any extra node devices which has three or
more ports are connected to 1394 OHCI controller. In the case, the path
to update the tree cache could hits WARN_ON(), and gets general protection
fault due to the access to invalid address computed by the invalid value.

This commit fixes the bug to assign correct port index.

Cc: stable@vger.kernel.org
Reported-by: Edmund Raile <edmund.raile@proton.me>
Closes: https://lore.kernel.org/lkml/8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.camel@proton.me/
Fixes: 24b7f8e5cd65 ("firewire: core: use helper functions for self ID sequence")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 6adadb11962e..892b94cfd626 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -204,7 +204,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 				// the node->ports array where the parent node should be.  Later,
 				// when we handle the parent node, we fix up the reference.
 				++parent_count;
-				node->color = i;
+				node->color = port_index;
 				break;
 
 			case PHY_PACKET_SELF_ID_PORT_STATUS_CHILD:
-- 
2.45.2


