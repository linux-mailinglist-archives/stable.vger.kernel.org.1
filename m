Return-Path: <stable+bounces-148353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F56AC9B6F
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F5B9E4235
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DE23D2A5;
	Sat, 31 May 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A20P97Hv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3523D298;
	Sat, 31 May 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704108; cv=none; b=V4yw5lBn4JCX07QW2yTaQVEPiOgISmrZY4ucUttUSHx941LDfqxmPp4NprMgQT7tjrS4j7CfJYa5hLNJ4p4bE+MfHFXtQbHU2EnphI6ThLbGPz5d7xjyPEBOdR5w9BsbfcCdOpy5sC88D3iqtnooGeEK8Tdq/vpgjxlZa6NmOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704108; c=relaxed/simple;
	bh=ziBZwwqyZQT5qEjnp8U1zRRFZPCFs+iLXjzMT4hxT2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDtdnJoTHoCdtmQhUoOSaU3Mu96T6jIbbNvZT6x75TtvbLVjJ+RRyleJHXW52+3ZwxOUexUfmPrUAprFT2fkd3Vx/NxyNX5+dU0EmW6Mlim0JVPriLDMp8FDLD72bwfG7P0pSBxJ4apAn7nhTIvUjVxES4nfjhFwy7ScVVnji00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A20P97Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4180C4CEE3;
	Sat, 31 May 2025 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704108;
	bh=ziBZwwqyZQT5qEjnp8U1zRRFZPCFs+iLXjzMT4hxT2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A20P97HvewqwS6oSqh1AcgsBzKx4B/EI0jILDNiaqyscvlIrQcdps2VY6+znKtluv
	 TKFoHkxWKzewnqvyi+sLZlLWSHyORl4Jr6NZb4PJ35wL648PcSTrG3ceb7loopObab
	 JuUAerlnQWiKPRbwvOmZsjCY8EkPZlQNomallrFT25c2EirMjthJLin6JxN7glvKWM
	 9skXpJhz0J0/jbHFXI31e2cozi2yQNDhs+iO+vgK8hLyzBjzeWfnptVQPpn4U9abc8
	 wMVdmmw2lvOnsVxaiHiBGVQXKFwn/3bacmSqHmzEvAEzWx1hu+AVAV5rqZMXT7sHur
	 jw4mNJ21c+rsA==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] apparmor: Fix 8-byte alignment for initial dfa blob streams
Date: Sat, 31 May 2025 17:08:21 +0200
Message-ID: <20250531150822.135803-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250531150822.135803-1-deller@kernel.org>
References: <20250531150822.135803-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

The dfa blob stream for the aa_dfa_unpack() function is expected to be aligned
on a 8 byte boundary.

The static nulldfa_src[] and stacksplitdfa_src[] arrays store the inital
apparmor dfa blob streams, but since they are declared as an array-of-chars
the compiler and linker will only ensure a "char" (1-byte) alignment.

Add an __aligned(8) annotation to the arrays to tell the linker to always
align them on a 8-byte boundary. This avoids runtime warnings at startup on
alignment-sensitive platforms like parisc such as:

 Kernel: unaligned access to 0x7f2a584a in aa_dfa_unpack+0x124/0x788 (iir 0xca0109f)
 Kernel: unaligned access to 0x7f2a584e in aa_dfa_unpack+0x210/0x788 (iir 0xca8109c)
 Kernel: unaligned access to 0x7f2a586a in aa_dfa_unpack+0x278/0x788 (iir 0xcb01090)

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
---
 security/apparmor/lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..531bde29cccb 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2149,12 +2149,12 @@ static int __init apparmor_nf_ip_init(void)
 __initcall(apparmor_nf_ip_init);
 #endif
 
-static char nulldfa_src[] = {
+static char nulldfa_src[] __aligned(8) = {
 	#include "nulldfa.in"
 };
 static struct aa_dfa *nulldfa;
 
-static char stacksplitdfa_src[] = {
+static char stacksplitdfa_src[] __aligned(8) = {
 	#include "stacksplitdfa.in"
 };
 struct aa_dfa *stacksplitdfa;
-- 
2.47.0


