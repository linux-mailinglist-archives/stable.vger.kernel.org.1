Return-Path: <stable+bounces-222531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ7wJLk+pWm36gUAu9opvQ
	(envelope-from <stable+bounces-222531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:39:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E61D40B3
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A3CE3006B04
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 07:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E58383C8A;
	Mon,  2 Mar 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="XG4uOi4A"
X-Original-To: stable@vger.kernel.org
Received: from out30-87.freemail.mail.aliyun.com (out30-87.freemail.mail.aliyun.com [115.124.30.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0096325727;
	Mon,  2 Mar 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437037; cv=none; b=ah1zmDo1nyJJ9yGPrr9+5W7eGfKa3x4SO6oHDC6+dSAcLjPl1B7xYUe0zwdw9O4bFQNBLTlOXxdLeQZOWu+x6sLWc9vv1msGwNqmofJgj5l6mif0WUkYGI1avm7fdavTy5BbdQcR7Q7pN9HN/GgB83EkD04uq9pXHWVrA1GU+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437037; c=relaxed/simple;
	bh=brnExaj1oQAVF/5Y4p7zhMF9Yv6s4dCcgw4Fe3zYvIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i4oyxRO8+8RVx3hctLrsGJcEeAnJd3ybtrzt0U+Ml1jGs2Ymag7v1kUBQM0yt8qr19vpXn54PRk1cO/+xCq96Hb/occfzcXTsTnNM6aLeMXi5FXgNIEL2I/565EOoAw2Nm2ydEjcVows/jOIUpd4vRbZut4mpRBzS68O6o/Akic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=XG4uOi4A; arc=none smtp.client-ip=115.124.30.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772437032; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uSf6P0bDTSshvk8ZcHeWOFwTq1M7/DYqiYXjmlaPg6k=;
	b=XG4uOi4Ao+0p+5ssZlTM/I7u9X8wDexyIU8g+wc772sgr+3tzipNB17C3niq8iLA9ifUwHgk0trGCwG4kagS6q1et22KV4tjUY4HkFwUENB0m/KZXGm/bmH/fZGcU9Hh4CHaeBVfbtd5VPnv+1z5w1PmTpYU6odUr+ax2oB98ME=
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X-284.M_1772437031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 15:37:11 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y 0/3] Backport to fix CVE-2025-40170
Date: Mon,  2 Mar 2026 15:36:27 +0800
Message-Id: <20260302073630.988982-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222531-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,aliyun.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:mid,aliyun.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A1E61D40B3
X-Rspamd-Action: no action


Eric Dumazet (3):
  net: dst: add four helpers to annotate data-races around dst->dev
  net: dst: introduce dst->dev_rcu
  net: use dst_dev_rcu() in sk_setup_caps()

 include/net/dst.h       | 34 ++++++++++++++++++++++++++++++----
 include/net/ip.h        |  7 +++++--
 include/net/ip6_route.h |  2 +-
 include/net/route.h     |  2 +-
 net/core/dst.c          |  4 ++--
 net/core/sock.c         | 16 ++++++++++------
 net/ipv4/route.c        |  4 ++--
 7 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.43.0


