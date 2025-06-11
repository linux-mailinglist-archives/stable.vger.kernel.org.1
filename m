Return-Path: <stable+bounces-152413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7FAD5428
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49F3AC9E3
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08623ABBD;
	Wed, 11 Jun 2025 11:38:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C7239E72;
	Wed, 11 Jun 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641894; cv=none; b=VXSfBKtVmhYuPS1BZOJN4k288tfLppN6AdSyQlmLgzTYumjiWh+/wXaVt8ZGnOBGFrn0yuTfg5q9EX7J1Hk+7Ju6xS8gJTeA1y281MH5FnECzXQnRmnNldy8sdW2YctG/cNUOQOSsFUS3RIe8h2b8XlvmouL2yAaABMlQsnBseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641894; c=relaxed/simple;
	bh=jjTJVlRygJ+lZrV1UJpL8DR7Nwo+5KGKiceb+pjpmro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gedK2ybm1m3T0wdWhVBU/aoLB5EO98UmHEDzC7+f7uXXjAFjJRQKmzd+lBziZ/fbOowqgdofdhxBIWISN0q4z+No/3yhJy1vIrsfWphfCQ9Uz0EeNIot1JA8DUwRXjvSCiJEBPt97YK/xs1zFZdvVlzCR64NEnL2UGVTPscwj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=gladserv.com; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gladserv.com
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=45472 helo=localhost)
	by bregans-1.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <brett@gladserv.com>)
	id 1uPJFu-006nQJ-1k;
	Wed, 11 Jun 2025 11:04:30 +0000
Date: Wed, 11 Jun 2025 13:04:29 +0200
From: Brett Sheffield <bacs@librecast.net>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Subject: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <aElivdUXqd1OqgMY@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="40GOL/uwi4gwDFwN"
Content-Disposition: inline
Organisation: Gladserv Limited.  Registered in Scotland with company number SC318051. Registered Office 272 Bath Street, Glasgow, G2 4JR, Scotland. VAT Registration Number 902 6097 39.


--40GOL/uwi4gwDFwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Stable Maintainers,

Longterm kernel 6.12.y backports commit:

- a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in cork"

but does not backport these related commits:

- 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6 cookie initializer"
- 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init calls with ipcm6_init_sk"

This causes a regression when sending IPv6 UDP packets by preventing
fragmentation and instead returning EMSGSIZE. I have attached a program which
demonstrates the issue.

sendmsg() returns correctly (8192) on a working kernel, and returns -1
(EMSGSIZE) when the regression is present.

The regression is not present in the mainline kernel.

Applying the two missing commits to 6.12.y fixes the regression.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

--40GOL/uwi4gwDFwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="6.12.y-frag.c"

/*
 * 6.12.y backports commit:
 * - a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in cork"
 * but does not backport:
 * - 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6 cookie initializer"
 * - 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init calls with ipcm6_init_sk"
 *
 * This causes a regression when sending IPv6 UDP packets by preventing
 * fragmentation and instead returning EMSGSIZE. This program demonstrates the
 * issue. sendmsg returns correctly (8192) on a working kernel, and returns -1
 * (EMSGSIZE) when the regression is present.
 *
 * The regression is not present in the mainline kernel.
 *
 * Applying the missing commits to 6.12.y fixes the regression.
 */

#include <netinet/in.h>
#include <sys/socket.h>
#include <stdio.h>

#define LARGER_THAN_MTU 8192

int main(void)
{
	/* address doesn't matter, use an IPv6 multicast address for simplicity */
	struct in6_addr addr = {
		.s6_addr[0] = 0xff, /* multicast */
		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
	};
	struct sockaddr_in6 sa = {
		.sin6_family = AF_INET6,
		.sin6_addr = addr,
		.sin6_port = 4242
	};
	char buf[LARGER_THAN_MTU] = {0};
	struct iovec iov = { .iov_base = buf, .iov_len = sizeof buf};
	struct msghdr msg = {
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_name = (struct sockaddr *)&sa,
		.msg_namelen = sizeof sa,
	};
	ssize_t rc;
	int s = socket(AF_INET6, SOCK_DGRAM, 0);
	msg.msg_name = (struct sockaddr *)&sa;
	msg.msg_namelen = sizeof sa;
	rc = sendmsg(s, &msg, 0);
	if (rc == -1) {
		perror("send");
		return 1;
	}
	printf("send() returned %zi\n", rc);
	return 0;
}

--40GOL/uwi4gwDFwN--

