Return-Path: <stable+bounces-214200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACOAAtlng2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BBE9018
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F1043114DA7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DB41B358;
	Wed,  4 Feb 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CpGw2eio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1E40FD81;
	Wed,  4 Feb 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218898; cv=none; b=YQji5zGCIfKtaS6UvKs3+t9IeE5APRDavcbatTajGq6yDDZlX2tUPFKcSBaZx3KqjpIW/vqXgKv8jqEIpDwOTC+E2pTiqJF2ftI4iJKiqrjy3CFuGhfQ6CLQRI6fzxBW5nYl1hIHT/heDQoRqOFv00Vu92pr8bJw7c62xEjPePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218898; c=relaxed/simple;
	bh=5eJLNObIloBjI8rjHIphd9xQ29JcGenpLuGDcLRXN7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGwe3gEZ94tiy02Poe6yg7pDL8yvpb0UwXtPux8mQjfc3tdYZnAg4TQVTLcPq3tGYnntCWYakT1x7EGHarxPNZ3gPgjgtJEsfP5mzGZ6IoQXYz9nBdeXaemrGOnKCa0bn2RK/hy/XS0FXogpPgcVdxU/1H8jQXpuq6zKRZQJW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CpGw2eio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31CFC116C6;
	Wed,  4 Feb 2026 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218898;
	bh=5eJLNObIloBjI8rjHIphd9xQ29JcGenpLuGDcLRXN7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpGw2eioHvKY9oWju/28ruF7TRW5jNdKQ+VWhYq8lD3KTNdRS+Y2b57Oe+rObuRrQ
	 qRahVS579UhtixU6coH7vksNXIpTmLjEhnp7UZlNIZt4M9t+V/pmk8q5Rj3cbDdF2S
	 Parz8JpxAPoyLjjzlymk9ivgnSx1whpPmJS18uUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Alexis=20Lothor=C3=A9=20 ?= <alexis.lothore@bootlin.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.12 87/87] bpf/selftests: test_select_reuseport_kern: Remove unused header
Date: Wed,  4 Feb 2026 15:41:25 +0100
Message-ID: <20260204143850.061076726@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214200-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,msgid.link:url,suse.com:email]
X-Rspamd-Queue-Id: 729BBE9018
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

commit 93cf4e537ed0c5bd9ba6cbdb2c33864547c1442f upstream.

test_select_reuseport_kern.c is currently including <stdlib.h>, but it
does not use any definition from there.

Remove stdlib.h inclusion from test_select_reuseport_kern.c

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250227-remove_wrong_header-v1-1-bc94eb4e2f73@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: Fix compilation error mentioned in footer of Alexis'
patch with newer glibc header:

  [...]
    CLNG-BPF [test_progs-cpuv4] test_select_reuseport_kern.bpf.o
  In file included from progs/test_select_reuseport_kern.c:4:
  /usr/include/bits/floatn.h:83:52: error: unsupported machine mode
  '__TC__'
     83 | typedef _Complex float __cfloat128 __attribute__ ((__mode__
  (__TC__)));
        |                                                    ^
  /usr/include/bits/floatn.h:97:9: error: __float128 is not supported on
  this target
     97 | typedef __float128 _Float128;

I'm not certain when the problem starts to occur, but I'm quite sure
test_select_reuseport_kern.c were not meant to be using the C standard
library in the first place.]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018 Facebook */
 
-#include <stdlib.h>
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>



