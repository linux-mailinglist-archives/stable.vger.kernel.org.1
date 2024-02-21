Return-Path: <stable+bounces-22323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583985DB6D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91141F23AE5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981B76905;
	Wed, 21 Feb 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/Ti9MfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5469953;
	Wed, 21 Feb 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522872; cv=none; b=E3x1v6sT/glVZJWqxPxGNF8qLACmW3LqN8kIROw5TdrU7xKNgiM1pOg2r2yaE1EHmyb6bpCxXgcZEA7TWFiiix2qAJms+/at/DrSMZ/2lBAYL802YLJbZr19t4o4kCYXQiPJvlke3fE54fa+vdzrPUWpwF1thnz5ehwjH+lr2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522872; c=relaxed/simple;
	bh=Q5Dj9NhcSiFyUKnu6F56dSyWLFsjsp6l4lXh9ku30tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJoveUppncAvZ6tpp2Jx9VU1/gBgOV/lGr8nVB2d6O19x/9fn6yMpLs6hi9K9ZlRd0/KeFB9Vkgef6virL43UAng/B0LszhNuyJp6o0r0Htoza7bI8r2nRBHiCc3bK2tyVunDFIeYx4P7Ek7RiIOkStOGA4sr3WPPrr7mDz9Q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/Ti9MfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E26CC433C7;
	Wed, 21 Feb 2024 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522871;
	bh=Q5Dj9NhcSiFyUKnu6F56dSyWLFsjsp6l4lXh9ku30tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/Ti9MfBIE1ps0Ig9rUxwT7Z2w1/H/9A4X8sMEJ0bDqovoWf7CmgjxSJDIUF7cRWi
	 uZUNvqrmZ3+/i2oYU+nvRiunlmg7qZavORhS852wRz40AtABOum+4zFRQtjvsy5EyH
	 8PbU7M9jaoue62UlcxIwN/NTkygtEDsfyXMsv+WA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 280/476] ipv6: Ensure natural alignment of const ipv6 loopback and router addresses
Date: Wed, 21 Feb 2024 14:05:31 +0100
Message-ID: <20240221130018.335241204@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@kernel.org>

[ Upstream commit 60365049ccbacd101654a66ddcb299abfabd4fc5 ]

On a parisc64 kernel I sometimes notice this kernel warning:
Kernel unaligned access to 0x40ff8814 at ndisc_send_skb+0xc0/0x4d8

The address 0x40ff8814 points to the in6addr_linklocal_allrouters
variable and the warning simply means that some ipv6 function tries to
read a 64-bit word directly from the not-64-bit aligned
in6addr_linklocal_allrouters variable.

Unaligned accesses are non-critical as the architecture or exception
handlers usually will fix it up at runtime. Nevertheless it may trigger
a performance penality for some architectures. For details read the
"unaligned-memory-access" kernel documentation.

The patch below ensures that the ipv6 loopback and router addresses will
always be naturally aligned. This prevents the unaligned accesses for
all architectures.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 034dfc5df99eb ("ipv6: export in6addr_loopback to modules")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/ZbNuFM1bFqoH-UoY@p100
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf_core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index 1d4054bb345b..b2da2abfac82 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -220,19 +220,26 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
-const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
+const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LOOPBACK_INIT;
 EXPORT_SYMBOL(in6addr_loopback);
-const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_any __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_ANY_INIT;
 EXPORT_SYMBOL(in6addr_any);
-const struct in6_addr in6addr_linklocal_allnodes = IN6ADDR_LINKLOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
-const struct in6_addr in6addr_linklocal_allrouters = IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allrouters);
-const struct in6_addr in6addr_interfacelocal_allnodes = IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
-const struct in6_addr in6addr_interfacelocal_allrouters = IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
-const struct in6_addr in6addr_sitelocal_allrouters = IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)
-- 
2.43.0




