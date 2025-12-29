Return-Path: <stable+bounces-203608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E36CE704E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C950F3013557
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAD31D379;
	Mon, 29 Dec 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0lLtkdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED231CA5B
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018347; cv=none; b=jSBAxB7eIUH/wy3FaIm3vECr/fEsIsWok+EM7a2YBRJQBNUMjE9ZLxbcw2FytKxqt0oWd+wLVBUYCYgLn6tC1PFKLv5mij5JccPVfXXN8lcZrsaUU0W0kNKb4EbRd/zNPAoS6oQEf9rvl3B6wC+MlbNwbbuKCXQqE6h4CasfF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018347; c=relaxed/simple;
	bh=5JyteSlyY6h/T1Aa4gXxGzil5Uon17g3Rm4mttyDFMQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eZUTQfu3uBsEcebQkGTMCJ5SAindzDKqzJyLnmOdNUrr/TI4xL794Qc9tzZyptxc/4k5NnO/MMrPWdJEI/Prh90k1xeKVFadr8HeYcWvbK+NARA3vdSO7F2GB0WVmZJlQR9siMewHgWicbsgMB5mD+Au285U3Cxd1+3p14VHk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0lLtkdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7EDC4CEF7;
	Mon, 29 Dec 2025 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018347;
	bh=5JyteSlyY6h/T1Aa4gXxGzil5Uon17g3Rm4mttyDFMQ=;
	h=Subject:To:Cc:From:Date:From;
	b=J0lLtkdUwZUT09n0sIDDyi2cOD/hcHEQpZcQaDG6y1QoWKCkc0iUSlpJf0JqWCR/h
	 Uuj8d5ltlB72EiYc3cfJreHmoDgXxQLznYeAX6u9m2dJO1gT8FlnNMzWNzVJbX1ttj
	 GFg0vrJnMMiG32KW6nyqp9n17GPXJzaxkiEq15ys=
Subject: FAILED: patch "[PATCH] lib/crypto: riscv/chacha: Avoid s0/fp register" failed to apply to 6.12-stable tree
To: wangruikang@iscas.ac.cn,ebiggers@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:25:45 +0100
Message-ID: <2025122944-stonewall-evoke-f7f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 43169328c7b4623b54b7713ec68479cebda5465f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122944-stonewall-evoke-f7f0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43169328c7b4623b54b7713ec68479cebda5465f Mon Sep 17 00:00:00 2001
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 2 Dec 2025 13:25:07 +0800
Subject: [PATCH] lib/crypto: riscv/chacha: Avoid s0/fp register

In chacha_zvkb, avoid using the s0 register, which is the frame pointer,
by reallocating KEY0 to t5. This makes stack traces available if e.g. a
crash happens in chacha_zvkb.

No frame pointer maintenance is otherwise required since this is a leaf
function.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Fixes: bb54668837a0 ("crypto: riscv - add vector crypto accelerated ChaCha20")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20251202-riscv-chacha_zvkb-fp-v2-1-7bd00098c9dc@iscas.ac.cn
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/riscv/chacha-riscv64-zvkb.S b/lib/crypto/riscv/chacha-riscv64-zvkb.S
index b777d0b4e379..3d183ec818f5 100644
--- a/lib/crypto/riscv/chacha-riscv64-zvkb.S
+++ b/lib/crypto/riscv/chacha-riscv64-zvkb.S
@@ -60,7 +60,8 @@
 #define VL		t2
 #define STRIDE		t3
 #define ROUND_CTR	t4
-#define KEY0		s0
+#define KEY0		t5
+// Avoid s0/fp to allow for unwinding
 #define KEY1		s1
 #define KEY2		s2
 #define KEY3		s3
@@ -143,7 +144,6 @@
 // The updated 32-bit counter is written back to state->x[12] before returning.
 SYM_FUNC_START(chacha_zvkb)
 	addi		sp, sp, -96
-	sd		s0, 0(sp)
 	sd		s1, 8(sp)
 	sd		s2, 16(sp)
 	sd		s3, 24(sp)
@@ -280,7 +280,6 @@ SYM_FUNC_START(chacha_zvkb)
 	bnez		NBLOCKS, .Lblock_loop
 
 	sw		COUNTER, 48(STATEP)
-	ld		s0, 0(sp)
 	ld		s1, 8(sp)
 	ld		s2, 16(sp)
 	ld		s3, 24(sp)


