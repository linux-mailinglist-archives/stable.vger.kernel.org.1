Return-Path: <stable+bounces-110121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DDA18DC3
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D36188B37F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350471CEE8D;
	Wed, 22 Jan 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfdHtXRU"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB4153824;
	Wed, 22 Jan 2025 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535673; cv=none; b=DTGsvgKOcJg4g1875af95aijFIQuivRK+/IxaWZ0O1Hbh9eVLjEvRLd8WJya0tYvFX+0gk32L/odU9s/w1w12tzbSK/u5qloAqH1rAFq7X4MmF8nFD7LlCJUy8QqhHO+6MIbVy+puY6LdvKhCUolXty3eh+Ygq5lGr9EyKzo4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535673; c=relaxed/simple;
	bh=KelfrUEDKn1STr/uyl6Wn/gXFShtj7LS2NXx40teaXU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pgUM2LFX3tcBk9YKAP+STU3RQ3LW9+3xNWwrKmou5y1o2IsLYvRUQTd3XnjTQoMpg20UiFFUBjN7/8E3MqjJ4rh01MImqpecv7JU6ecpN2cqrbBO8RBOMvQlGP4JLDsTi2bdvUQ5GjVCwAqYeUMg4/7E7Aavarb/913OlOhfsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfdHtXRU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37CF3114019B;
	Wed, 22 Jan 2025 03:47:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 03:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737535669; x=1737622069; bh=2pmDU7e3MlYtu8haZn4roILPX83I
	3ITd6BRmfCF1ljE=; b=YfdHtXRU+jyvX7GcTCQWf5LMspthLFNhMghZjDqBYaJm
	YvwkP3qzvwQ8ER1QfGkkSk+gf0uDs1Seqh5ALCwJeYMlUCpYg70bEPidRFmkOhPY
	LFYExlHWlVyKJ7wyyzYKpHOuTJk6e50jx4VF6L5yQVIllqtqi7DH3rFyu0jNx8Rc
	WvWeqQCwEYO27gGCnR2VcQiIkV7lB9D0z+s1p0wzVy81zYvF39/eozkWIijw7rt0
	1/nmCqTzWM+VL+r8Tl1xyGXceh7nBL0Punod+doxeEG96qfJfKpGORRFYBUkQ/zD
	NdBF/2A2460lhvPl0BEmfol0GzIZIW3PLanCd/W6+A==
X-ME-Sender: <xms:tLCQZ5hlNQRRu9x6rNXlZl6uPi5-HJbmfMnoB41pmVxrTTrTfneFSg>
    <xme:tLCQZ-DtGIRE4Mpc9pUyfvN7lx_3P8U8kiJd8-cGYgSbKC4eFEwzUu6vPy1fr3jH7
    7s5PLm-FSpF7gkUUzo>
X-ME-Received: <xmr:tLCQZ5HgNCaUZzYzcj8T8TlhjLnEaWvYeS3cxyO90BJrtrYD0gCUlY9K6DM5O5mjLn_v32kV-pZp6vQGRAGxV2SgyBK6wnIkFSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepiedugfduhffgheekjeekffduueejudevffehiedtledt
    tdekveekuefhvdfftedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhi
    nhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlih
    grmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    mheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tLCQZ-RP1c7KnAhjY3Lofn-Uq3W6g1r6tA7swNZc3si3giHxISrcjA>
    <xmx:tLCQZ2ygDVEKnJdMDkpKy6v4NpdGkXRe14NR3BWwyWbojjiAYiS9nw>
    <xmx:tLCQZ07yZM33NyldeKN5uwwVWKEmxQsMKWtVjZaQMjBJ_fPu9wUUrw>
    <xmx:tLCQZ7zQMpxE9NiKgfI6mCiQq8R6jKxBe6Iaw5pNfOLY8GTcNhz4UQ>
    <xmx:tbCQZws7T_YGAUiGnxDewSbPTLVXtDnHztONFL7nFdeeWXv5yRbPva0Z>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:47:44 -0500 (EST)
Date: Wed, 22 Jan 2025 19:47:35 +1100
Message-ID: <d0c39a02fd50c3ac2fc187d08b942c69@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Liam Howlett <liam.howlett@oracle.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] m68k: Add missing mmap_read_lock() to sys_cacheflush()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Liam Howlett <liam.howlett@oracle.com>

[ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]

When the superuser flushes the entire cache, the mmap_read_lock() is not
taken, but mmap_read_unlock() is called.  Add the missing
mmap_read_lock() call.

Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in sys_cacheflush()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[ mmap_read_lock() open-coded using down_read() as was done prior to v5.8 ]
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/sys_m68k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec83a290..38dcc1a2097d 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		down_read(&current->mm->mmap_sem);
 	} else {
 		struct vm_area_struct *vma;
 

