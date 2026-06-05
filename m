Return-Path: <stable+bounces-260677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MfPfHoGsImribwEAu9opvQ
	(envelope-from <stable+bounces-260677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 13:01:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED9647947
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 13:01:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.it header.s=amazoncorp2 header.b=QowFLh3h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260677-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260677-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837D1301B906
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D52A4C8FF4;
	Fri,  5 Jun 2026 10:58:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89E30C629;
	Fri,  5 Jun 2026 10:58:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657116; cv=none; b=M7qTgqZqPb5VoC32bwSIodZbsGwOr4ET2CasxVWPDnJYXTh0bZiD29qzforbz9l6n0JTY79YfiHFRBwRukT/kFdJwLyfsLRhTJGmdP0lmCEzgJ9SUa6Lc0/5xX3l2HobpP4cqE7qEAEnMtzThMgHh8e6DXqgHvkIJOPBgaVRTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657116; c=relaxed/simple;
	bh=Gqi9R0eFicuWxjhq8ZwuJgsJhCL6FEZGhSG5H6xcELA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvJ/qbmo8Wi+4gnSXiVfMWAxQK1lloNaa2Y67RhcZJ8zBnCLPqblTOBrxexKtnyXv/GXKPBxLXHcomg9eTY3V/A8sH4HCPPzE7cYAp1q7Mf3vT2ZHFYu7NzqVGgASD1V0BYeMuSYX4PDruAmGEcElAYxh9w/lSmyTRN3pYUGKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it; spf=pass smtp.mailfrom=amazon.it; dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b=QowFLh3h; arc=none smtp.client-ip=44.246.77.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1780657115; x=1812193115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQWB1MRHO0Oh1cerb+7kF6+zS8TJPeY9gp4o8uPVemk=;
  b=QowFLh3hkoGDb+pjRZ4KGc4H4Q0W8Tooqc1FtHPxIWzWD8iWIMvF6LIl
   9b25HCzwSIt1/bpK+WH5Tl8luoPRUI0/Sho+GfsJHSYUQoavxTiSCElVm
   kVYN4G8XXJ7dBznzL8zOPfMlZg0nIGU+khuKRQTp5i+HWgzfoBl+KDwxn
   eauQ8zbd8vtplIWkALWynFImnT9y96TGmnszioJwK2+MsKCE0sgpefo/5
   EiQCEE4omls1FjxmWwzncwu9aaJfYz2imgENYj1hL4h5np6aIRUJ2CLbu
   Zn0Bdd4QZ7nk4X+eWj4oLG6QoH9H6Swm+nUdkUKrexN8gs1oYq4EWRMh0
   g==;
X-CSE-ConnectionGUID: otzO6A7JQ9m3VqZ7jJM4YA==
X-CSE-MsgGUID: YbolRiWaRlWuZk/E8m1fAw==
X-IronPort-AV: E=Sophos;i="6.24,188,1774310400"; 
   d="scan'208";a="21175211"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:58:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:23098]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.253:2525] with esmtp (Farcaster)
 id 78f04fa3-8d95-440e-8f7c-1128dfcf6f2a; Fri, 5 Jun 2026 10:58:31 +0000 (UTC)
X-Farcaster-Flow-ID: 78f04fa3-8d95-440e-8f7c-1128dfcf6f2a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 5 Jun 2026 10:58:30 +0000
Received: from cdd-dev.amazon.com (172.22.139.101) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 5 Jun 2026 10:58:30 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <kmanaouil.dev@gmail.com>
CC: <abuehaze@amazon.com>, <akpm@linux-foundation.org>, <alisaidi@amazon.com>,
	<blakgeof@amazon.com>, <brauner@kernel.org>, <dipietro.salvatore@gmail.com>,
	<dipiets@amazon.it>, <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <ritesh.list@gmail.com>,
	<stable@vger.kernel.org>, <vbabka@suse.com>, <willy@infradead.org>
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
Date: Fri, 5 Jun 2026 10:58:26 +0000
Message-ID: <20260605105826.3337-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531232929.mn6f76yrnc6e4cpf@wrangler>
References: <20260531232929.mn6f76yrnc6e4cpf@wrangler>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.it,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.it:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,linux-foundation.org,kernel.org,gmail.com,amazon.it,vger.kernel.org,kvack.org,suse.com,infradead.org];
	TAGGED_FROM(0.00)[bounces-260677-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kmanaouil.dev@gmail.com,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:dipietro.salvatore@gmail.com,m:dipiets@amazon.it,m:djwong@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:ritesh.list@gmail.com,m:stable@vger.kernel.org,m:vbabka@suse.com,m:willy@infradead.org,m:kmanaouildev@gmail.com,m:dipietrosalvatore@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amazon.it:mid,amazon.it:from_mime,amazon.it:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.it:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3ED9647947


On Sat, May 31, 2026 at 11:29:00PM +0000, Karim Manaouil wrote:
> I am not very familiar with THPs in the page cache, but for anonymous
> memory, we have /sys/kernel/mm/transparent_hugepages/defrag which
> decides what to do in the event of a THP allocation failure, whether to
> enter a synchronous compaction or wake up kcompactd.

Thanks Karim for the suggestions. To clarify, THPs are not used and do not 
have any performance change on this workload as reported in [1]. 
The failing allocations are for high order file-backed folios in the 
iomap buffered write path.

> I am just trying to think loudly here and address the root cause. The
> real problem here is fragmentation due to unmovable pages, probably in
> your case the page tables. We should work more on reducing pageblock
> type mixing. Also page tables can actually be made movable so that
> compaction can treat them as movable pages.

I agree that making PTEs movable could potentially resolve the
fragmentation at its root, since page table pages are indeed the primary
source of unmovable fragmentation in this workload. However, making page 
tables movable has much broader implications.


[1] https://lore.kernel.org/all/20260428150240.3009-1-dipiets@amazon.it/

--
Salvatore





AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico




