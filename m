Return-Path: <stable+bounces-238390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHx5D1ug4WkJvwAAu9opvQ
	(envelope-from <stable+bounces-238390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:52:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C64165C7
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1982D3015522
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71671341ACA;
	Fri, 17 Apr 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="l+gStobh"
X-Original-To: stable@vger.kernel.org
Received: from out30-85.freemail.mail.aliyun.com (out30-85.freemail.mail.aliyun.com [115.124.30.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC2332604;
	Fri, 17 Apr 2026 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394320; cv=none; b=QGpuo1MH+xFUdNJE/v1k4jL1iy71EuZU06Efu6iu42IYBwcG36i7P7HNRYthuFTNka4CW07fCeSHsYRXXbeEBHB5oE9/KycFqfG96Rs6KDMzwAK01pSLhueDmC8EchBDAjqBgUQJaU7JTET9f4G5XFxpHbGt/C+p03YR4rvzm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394320; c=relaxed/simple;
	bh=Fkzwm/5CLTNhZkiwc9qcU5nP5+27w1PU7QrZLfWzUh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgxdoCEheboQ0MBL9DbYMyFAFdUldoLtrtdhc9LMbCV3TZhPLBLUoQ7tXEYJocTGqTOm/TXZBAL/UEUwU66Lj7Ko0TQzi3BPXZhikNbw5KNZrklBmrf4h53aYPaCz1qmGzRITTHFL0fTT/imdP0OnErRxDSZ6LQnyiWW9PTtTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=l+gStobh; arc=none smtp.client-ip=115.124.30.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776394311; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H9uQJyjHfjoT7CKJxEHYFwc+WbOT+sVBBtzzESoHp+U=;
	b=l+gStobhncuxoM1nCG945TE4jZNnixBOjqriK44FsAIjpPAaHOWC5prGLym8RUM+/EmdINwzlQ6UsPCKvvlcECltxKtrXcY4jpfFwOteLK0aGvop9zQE5GPMtdoR9LF3zWVXyrIfjjYVdvIJT/aWggNtKEVY9NWV7QowLv18lDw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3820338|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0214311-0.000652078-0.977917;FP=5462798403030388459|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---0X19nFwn_1776394308;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X19nFwn_1776394308 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 10:51:50 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	naohiro.aota@wdc.com,
	wqu@suse.com,
	dsterba@suse.com,
	ruohanlan@aliyun.com,
	hch@lst.de,
	johannes.thumshirn@wdc.com
Subject: [PATCH 6.6.y 0/2] backport to fix error propagation of split bios
Date: Fri, 17 Apr 2026 10:51:14 +0800
Message-ID: <20260417025116.743-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-238390-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,wdc.com,suse.com,aliyun.com,lst.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:dkim,aliyun.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C0C64165C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Backport commit d48e1dea3931 ("btrfs: fix error propagation of split bios") 
to 6.6.y to fix error propagation of split bios.
It depends on commit 
9ca0e58cb752 ("btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()").

In order to make a clean backport on stable kernel, backport 2 commits.

Naohiro Aota (1):
  btrfs: fix error propagation of split bios

Qu Wenruo (1):
  btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()

 fs/btrfs/bio.c | 62 ++++++++++++++++++--------------------------------
 fs/btrfs/bio.h |  3 +++
 2 files changed, 25 insertions(+), 40 deletions(-)

-- 
2.43.0


