Return-Path: <stable+bounces-256592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INrbJNRqGWrGwQgAu9opvQ
	(envelope-from <stable+bounces-256592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E99600D41
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288F23028377
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EB3A9D9D;
	Fri, 29 May 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="viHM1oZO"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC83C3C00
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050257; cv=none; b=oNHGok4zoxOzxoC7RUAhmOejYBctfqv5nIKpymBXSlvLM2WePvY8kU4cL8I8NwPRvvAjSmn6b0mSUMNtdJkjpYdAnazrzfHKMKBe2OrKe1j7lEkQpUspK42S/2BLM3F4wcW2vH5ami+llkkxwmReur/iOONp6rzzcW+IF6KCksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050257; c=relaxed/simple;
	bh=/38z7ZV9zHaiNxNBWo7SPMIItdUDg3n7sxYzdV2WgaU=;
	h=From:To:Subject:Date:Message-Id; b=IjhJIBMmh6aZuq0Ua3ENx4hVmbuY/hymVN4IlSE25p3tyTXiJuuSDVi+a2STeV2PRMrDQypbj706DtNrzRdEWgbrclT7pZL01nRecFB1vApMsv1HurdJpVON6W0QAZzvHTGCVajOtJ7G7twhr4IdR/0q+2bx8wCikGYfOcrYz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=viHM1oZO; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=viHM1oZOOPhh4W1HaqApI3aq63e99yrPEP8c6Mon8VSZYNv/WonfsPn64SMggualtcnNHHOluj/t9
	 5a+daFAqzGcyg7Fzrst+6pdZWEo+CDfMV+QScSPHLSgV9uLknyhgxdo4OO1N2ull1lFcpuZLbK+j5y
	 NjFXwxBOEOUx3p54=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.249.24])
	by rmsmtp-lg-appmail-03-12081 (RichMail) with SMTP id 2f316a19694936d-1745a;
	Fri, 29 May 2026 18:24:10 +0800 (CST)
X-RM-TRANSID:2f316a19694936d-1745a
From: Rajani Kantha <681739313@139.com>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] Backport 2 commits to fix skbs flush pending
Date: Fri, 29 May 2026 18:24:07 +0800
Message-Id: <20260529102409.3042-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.846];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,139.com:mid]
X-Rspamd-Queue-Id: 58E99600D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit:006a5035b495 ("inet: frags: flush pending skbs in 
fqdir_pre_exit()") fixes a deadlocks issue.

It depends on commit:1231eec6994b ("inet: frags: add
inet_frag_queue_flush()").

In order to make a clean backport and line up with master branch,
backport those 2 commits to stable kernel.


Jakub Kicinski (2):
  inet: frags: add inet_frag_queue_flush()
  inet: frags: flush pending skbs in fqdir_pre_exit()

 include/net/inet_frag.h  | 18 +++-----------
 include/net/ipv6_frag.h  |  9 ++++---
 net/ipv4/inet_fragment.c | 51 +++++++++++++++++++++++++++++++++++++---
 net/ipv4/ip_fragment.c   | 18 +++++++-------
 4 files changed, 65 insertions(+), 31 deletions(-)

-- 
2.17.1



