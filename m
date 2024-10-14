Return-Path: <stable+bounces-84629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7B99D11F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA7F1C21621
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6E1AB536;
	Mon, 14 Oct 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJKGEz/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E161AA793;
	Mon, 14 Oct 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918670; cv=none; b=ccQV7ReUOOg2/7NfsKE7qi/iiCcjCZfBOKQxmm7Xnc17sQbQVyC3jPhxlnCizr+ynVJDLQR0cqTJ6+lXKR25Huj3AlSj/x/hwHEYT9KxSz6damLkNdQ+nKkdSPBcGEfonU9Q4Nv69CuFTYznB6kJKyl3ITIbta5sm53jHFw15YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918670; c=relaxed/simple;
	bh=LdxatDUsJ8imKVnONTLLBGsBYbiUdwrFQQ5hN+0W9jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOBDYKb08G0pBm2BNjJUP7o/ZSZKnbnLoG1x3m9JVmUQRSe2D8yHlPCCzAV+OOKh1QxgmWo787C+3AEHBYjldCBEGhxujLiXEcDYlSBjroTl3OmMUgCTCoknJXIH5I3YuLvgX/vdriNDZYGOgjbR86FgKjsHK8G9cx3jBUC7duQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJKGEz/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED8C4CEC3;
	Mon, 14 Oct 2024 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918669;
	bh=LdxatDUsJ8imKVnONTLLBGsBYbiUdwrFQQ5hN+0W9jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xJKGEz/MJ8iT+jN46MoIjcAe6HENo8Q3FCHyBdZ3I/5Ews+kgf1QyFKSjI122J04g
	 2Qv4s9S5LQ0/HftjlI9qL6iPJZdz2duD/3wUJNYSTxBfpujTOr1fr5MdkiM241bZBx
	 6u6JTYQ6Uld6pJnxZiPkopE1mvGUbqV3zE7RKCZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 6.1 361/798] icmp: Add counters for rate limits
Date: Mon, 14 Oct 2024 16:15:15 +0200
Message-ID: <20241014141232.129828812@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>

commit d0941130c93515411c8d66fc22bdae407b509a6d upstream.

There are multiple ICMP rate limiting mechanisms:

* Global limits: net.ipv4.icmp_msgs_burst/icmp_msgs_per_sec
* v4 per-host limits: net.ipv4.icmp_ratelimit/ratemask
* v6 per-host limits: net.ipv6.icmp_ratelimit/ratemask

However, when ICMP output is limited, there is no way to tell
which limit has been hit or even if the limits are responsible
for the lack of ICMP output.

Add counters for each of the cases above. As we are within
local_bh_disable(), use the __INC stats variant.

Example output:

 # nstat -sz "*RateLimit*"
 IcmpOutRateLimitGlobal          134                0.0
 IcmpOutRateLimitHost            770                0.0
 Icmp6OutRateLimitHost           84                 0.0

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Suggested-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
Link: https://lore.kernel.org/r/273b32241e6b7fdc5c609e6f5ebc68caf3994342.1674605770.git.jamie.bainbridge@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/snmp.h |    3 +++
 net/ipv4/icmp.c           |    3 +++
 net/ipv4/proc.c           |    8 +++++---
 net/ipv6/icmp.c           |    4 ++++
 net/ipv6/proc.c           |    1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -95,6 +95,8 @@ enum
 	ICMP_MIB_OUTADDRMASKS,			/* OutAddrMasks */
 	ICMP_MIB_OUTADDRMASKREPS,		/* OutAddrMaskReps */
 	ICMP_MIB_CSUMERRORS,			/* InCsumErrors */
+	ICMP_MIB_RATELIMITGLOBAL,		/* OutRateLimitGlobal */
+	ICMP_MIB_RATELIMITHOST,			/* OutRateLimitHost */
 	__ICMP_MIB_MAX
 };
 
@@ -112,6 +114,7 @@ enum
 	ICMP6_MIB_OUTMSGS,			/* OutMsgs */
 	ICMP6_MIB_OUTERRORS,			/* OutErrors */
 	ICMP6_MIB_CSUMERRORS,			/* InCsumErrors */
+	ICMP6_MIB_RATELIMITHOST,		/* OutRateLimitHost */
 	__ICMP6_MIB_MAX
 };
 
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -297,6 +297,7 @@ static bool icmpv4_global_allow(struct n
 	if (icmp_global_allow())
 		return true;
 
+	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
 
@@ -326,6 +327,8 @@ static bool icmpv4_xrlim_allow(struct ne
 	if (peer)
 		inet_putpeer(peer);
 out:
+	if (!rc)
+		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	return rc;
 }
 
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -352,7 +352,7 @@ static void icmp_put(struct seq_file *se
 	seq_puts(seq, "\nIcmp: InMsgs InErrors InCsumErrors");
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " In%s", icmpmibmap[i].name);
-	seq_puts(seq, " OutMsgs OutErrors");
+	seq_puts(seq, " OutMsgs OutErrors OutRateLimitGlobal OutRateLimitHost");
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " Out%s", icmpmibmap[i].name);
 	seq_printf(seq, "\nIcmp: %lu %lu %lu",
@@ -362,9 +362,11 @@ static void icmp_put(struct seq_file *se
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " %lu",
 			   atomic_long_read(ptr + icmpmibmap[i].index));
-	seq_printf(seq, " %lu %lu",
+	seq_printf(seq, " %lu %lu %lu %lu",
 		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTMSGS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS));
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS),
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITGLOBAL),
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITHOST));
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " %lu",
 			   atomic_long_read(ptr + (icmpmibmap[i].index | 0x100)));
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -183,6 +183,7 @@ static bool icmpv6_global_allow(struct n
 	if (icmp_global_allow())
 		return true;
 
+	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
 
@@ -224,6 +225,9 @@ static bool icmpv6_xrlim_allow(struct so
 		if (peer)
 			inet_putpeer(peer);
 	}
+	if (!res)
+		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
+				  ICMP6_MIB_RATELIMITHOST);
 	dst_release(dst);
 	return res;
 }
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -94,6 +94,7 @@ static const struct snmp_mib snmp6_icmp6
 	SNMP_MIB_ITEM("Icmp6OutMsgs", ICMP6_MIB_OUTMSGS),
 	SNMP_MIB_ITEM("Icmp6OutErrors", ICMP6_MIB_OUTERRORS),
 	SNMP_MIB_ITEM("Icmp6InCsumErrors", ICMP6_MIB_CSUMERRORS),
+	SNMP_MIB_ITEM("Icmp6OutRateLimitHost", ICMP6_MIB_RATELIMITHOST),
 	SNMP_MIB_SENTINEL
 };
 



