Return-Path: <stable+bounces-144873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C709FABC163
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB03AB3F5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1927AC54;
	Mon, 19 May 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="wG64oYYh"
X-Original-To: stable@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DF1DE4FB
	for <stable@vger.kernel.org>; Mon, 19 May 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666510; cv=none; b=HqXARRY2L4QnasXBfCdSRr7KDnKxW3c2YMxqsMKr0pzN2eE7YlhkWL3nOn3b99GSmUl/ZK2rG4zMqllzMYudPB+O+jOTYHWP+j5c4bwikKif/mdTEl+Poj43NUbn2lI69F+sRylYCGR0QZwQbYIXlbu5jEhMa71qjdt39Y1eM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666510; c=relaxed/simple;
	bh=9R5a2W7x9CCMg8U2Oln6bEokyIT997EuJej9u2AdWqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hTpkNWg10DoVlPFZdA1yCaZTCnMXW1sw442uy22psnuayH04kjPcxbm8shrm2jGHtdE4d5r/WVPQDOLSSqrGAOz01DOoDkSQQ/qwl1aHmdtjxePUMoIHGG5bgc2B8M8QDZEM2FkGnMse2Un8erfY6Y0txMy69OKY1ub7+83pAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=wG64oYYh; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop (unknown [IPv6:2001:4646:fb05:0:b16e:79bb:ebde:f3fe])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 865E32234A3;
	Mon, 19 May 2025 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1747666041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOdRBWfK7HCTbPhOWXh60Dx4qp+WkOQSJ6EXpePkCPU=;
	b=wG64oYYh0altLQCkJzCGAiWDrs2wsXhHUstu9Pvwhun2pKU2FtbA2RUBohsKpDsZWcpgi0
	cIZQq4+U9nvaplyUh8IJP/4oHa5mBsxYTeCEnCIH7y3slbOtYnJ5QO0SF9KeYA2Q7e82e/
	7kdeMnj/U/dQFSTrAQ34zRU01oDnaRs=
Date: Mon, 19 May 2025 16:47:17 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Subject: regression in 6.6.91: arch/x86/kernel/alternative.c:1452:5: error:
 redefinition of 'its_static_thunk'
Message-ID: <20250519164717.18738b4e@ncopa-desktop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

When building 6.6.91 for Alpine Linux I got this error on 32 bit x86:



  CC      net/devlink/dpipe.o
/home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/kernel/alternative.c:1452:5: error: redefinition of 'its_static_thunk'
 1452 | u8 *its_static_thunk(int reg)
      |     ^~~~~~~~~~~~~~~~
In file included from /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/include/asm/barrier.h:5,
                 from /home/buildozer/aports/main/linux-lts/src/linux-6.6/include/linux/list.h:11,
                 from /home/buildozer/aports/main/linux-lts/src/linux-6.6/include/linux/module.h:12,
                 from /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/kernel/alternative.c:4:
/home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/include/asm/alternative.h:143:19: note: previous definition of 'its_static_thunk' with type 'u8 *(int)' {aka 'unsigned char *(int)'}
  143 | static inline u8 *its_static_thunk(int reg)
      |                   ^~~~~~~~~~~~~~~~
  CC [M]  net/sched/act_skbmod.o
make[4]: *** [/home/buildozer/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.build:243: arch/x86/kernel/alternative.o] Error 1
make[3]: *** [/home/buildozer/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.build:480: arch/x86/kernel] Error 2
make[3]: *** Waiting for unfinished jobs....


I believe this was introduce with

commit 772934d9062a0f7297ad4e5bffbd904208655660
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Apr 23 09:57:31 2025 +0200

    x86/its: FineIBT-paranoid vs ITS
    
    commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.

