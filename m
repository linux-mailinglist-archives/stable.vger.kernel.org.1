Return-Path: <stable+bounces-45539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943688CB498
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BA3B23330
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9253149C4D;
	Tue, 21 May 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rqud1A2n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ir7RCShl"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46904149E09;
	Tue, 21 May 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322348; cv=none; b=kTInMvnbwr/tuh5n77HzpwIWyzKo6UNZwSO8kLzjppjXOavVfXjIn+58r/n6wEHLcuHBVE1l2t35VNQGi0g9krqzdWNgxPerLvvpU1ACkfbt8MJU8tIFeDOJkryyX6TgplLLT76MHVckZu7Y+pqb7Xi2mYFHfoflr9Y2MPglFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322348; c=relaxed/simple;
	bh=FjNRPnFXbgaDrJzH0dco7+80Dl+FmT6vR06xWJ6y13Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiYULizsEVWuUWjawiH5FUj4ZShG0q97KL69McvaCFHc4Lr4BQgfAnKtbmsODOcAR+xoOrHTIFPfLVAxbGwDBVnrz/QqrX2h1h4tNnrksXP3d13zpr4Hs/eJC7fdhUPHqmjVV10lPTskYHmMlQbS4TGm/yRiFhCvzwSIlGcYPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=rqud1A2n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ir7RCShl; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 750F118000E9;
	Tue, 21 May 2024 16:12:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 May 2024 16:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716322346;
	 x=1716408746; bh=xQxZPFfX2OVgytqkFfLnTy1ZbYhV4pTBmatqarQFr7k=; b=
	rqud1A2nWSH9uuDCNCmku1HFki18hETLjMeCI1dW34g5ZQSHD8j15jp8yxs3c6Aj
	FmsOtK0XvlN/zs15Ro77Vd7tzIRg7jFKTPj5GQA4acRw5UViTohDKNSgX5HmqDX0
	CK3jmiScRCSdd3DSi+taYTumFvGvg5LFGUuCh77ADD+G6onBFJKuS08JlgkUwzm8
	D0WRV5GnDp7ntaTeR+KEDvu6CTyHEisV+SisVB/tmjYYY4ao6xegha8kJ2eKN/fm
	M1jvN5lCu2P7v1ImlZIsLIPhO9r9RGzxJL+BN1UIqXWGNFmoh6J70YnIoSdm3yRr
	Ea6T9yAIPJiSG97t8fmFXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716322346; x=
	1716408746; bh=xQxZPFfX2OVgytqkFfLnTy1ZbYhV4pTBmatqarQFr7k=; b=i
	r7RCShlND6VEzAcQ7iNiNEmXYZQ0prAgVAjFjqf6M98PMJ+GmdLP0Rybr2dfvv8w
	VLjokAmd4YODrQzv0uXfnMwPqNN2Ur5tsClBSw55X5XpVUI2xUFtN1rKJpC8CNh3
	ftwWBN7aQh6b0CqEBK7oJLAnQ7GWay6OsbTO7WM0LhwnzNMYgldhQ6lvST/7ewfc
	LpP0ydefodivAfzP8REY1qnjtmUHuCJHJhDQOfw9Fe5L9+TDh9oghZSC46TfzRWj
	gwcavZuGiDoSh86k4+9DAL5/opyL0C7okHvk5n6bofPLCKQvkA8cnjQZxdgXl1TU
	KPm/ltRxsRS13pT34mRQw==
X-ME-Sender: <xms:KQBNZq5X8VwVbUuSRGfI9vBBEOYIfpFj4zElREL9HtaG3jpft-QO8Q>
    <xme:KQBNZj7F5mfYyV3BqnC31kT3mZz7vZJE79n8qu2rhDLUA-X7Y71jejELUbXnOTAXE
    vTB08xgzaGNV2lWO_0>
X-ME-Received: <xmr:KQBNZpcHACOTXa3ZpBZyzKI1XDq6eqWAUQP_XUG9N5IOExHnmrT6uUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:KQBNZnJR7CMjoVylyXqrqlIby5FzBMJf8NOuPJqN9AGmEeQFvpl1DQ>
    <xmx:KQBNZuLdJsrtPyM5UXFQ_HyLUPphUjHtGMOAxrfiZcWHqjKNU1Fgkg>
    <xmx:KQBNZowhJAeO2TkS8ZpSDt_9UK_OUfSNEjvqTC6rOX0sYKMqSY_0JQ>
    <xmx:KQBNZiKiM0h7agUCiEk-xIxmq9i0YxrutO-5sVzY3p4YVoYn3z0PWQ>
    <xmx:KgBNZm8EPCIJtlNP76q_yYYl456l6T0YC-W1c3Zb81jRcJeECnr61I4L>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 16:12:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 21 May 2024 21:12:15 +0100
Subject: [PATCH 4/4] LoongArch: Clear higher address bits in JUMP_VIRT_ADDR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-loongarch-booting-fixes-v1-4-659c201c0370@flygoat.com>
References: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
In-Reply-To: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=FjNRPnFXbgaDrJzH0dco7+80Dl+FmT6vR06xWJ6y13Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjRfBgUvdseI+vuPSpnrN2aeNWnTVn1wsHxxxYnM1dbzE
 1fnmt/uKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInUVTIyLFzQtodjisrCV38X
 XrLjm+U2bcGVzIKTJ6pTDxSbVxTH1jP8r5xq9GT3iZYL3mWzrkUlKFtniim3nk/peJohc/fdVP+
 jzAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

In JUMP_VIRT_ADDR we are performing an or calculation on
address value directly from pcaddi.

This will only work if we are currently running from direct
translation addresses or firmware's DMW is configured exactly
same as kernel. Still, we should not rely on such assumption.

Fix by clearing higher bits in address comes from pcaddi,
so we can get real physcal address before applying or
operator.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/stackframe.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 45b507a7b06f..a325d20a4503 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -42,8 +42,10 @@
 	.macro JUMP_VIRT_ADDR temp1 temp2
 	li.d	\temp1, CACHE_BASE
 	pcaddi	\temp2, 0
+	PTR_SLL \temp2, \temp2, (BITS_PER_LONG - DMW_PABITS)
+	PTR_SRL \temp2, \temp2, (BITS_PER_LONG - DMW_PABITS)
 	or	\temp1, \temp1, \temp2
-	jirl	zero, \temp1, 0xc
+	jirl	zero, \temp1, 0x14
 	.endm
 
 	.macro BACKUP_T0T1

-- 
2.43.0


