Return-Path: <stable+bounces-227906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOfzDCDywGnxOwQAu9opvQ
	(envelope-from <stable+bounces-227906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:56:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD482EDEFA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B833E3014774
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36E366DA4;
	Mon, 23 Mar 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ahs+/kMn"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5863659F1;
	Mon, 23 Mar 2026 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252552; cv=none; b=Z3fgVYM3ysjLQIfjtvD2PNK2Dp+Mi+ay3P41hNY1pMXWf3ij51iEnGKmjN1dEQqg7PT+kPWM+ETYgXDj5igCuNTeYLBzcvP2x6Uwpi4f5/l1yypcpbQ1PCYJIG/D3MsFqb3pIGZ5u37phinGh8gk3oTsWMZItVbEA+Q7Z6Sy0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252552; c=relaxed/simple;
	bh=TYKQKI2QaFDIMakzEAYl+Xh+rdI9GarPPVdk/kCcfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qkc+SldNpjq871/cC93gsRtOMnr/yYC4YiN/IOzNaflW+4xXuJW5QB0wGTkTgbc6g5Bz/IC5Y00Xp5pdppnrJyZjY4XhyBa2ElEwssbm/abix5Cg7KFGrF8RKSo062iAp5txhhGRsB9vsj+CJ9gNTPaGEayG258yCE3/fZL2Exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ahs+/kMn; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1774252089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mtIn7DP71PXd+663izgnCvu3LmpJDtlv1yNdOZnKHqg=;
	b=ahs+/kMnjPt9fEYJjQbd+5OH32ue4Jh+F8UcVlQYnqJ7psQEbCmyF8Ww5aPhMfRzh+6wQB
	JvxNkrS7kZvKERejGbtlIjsEVZjv8XYzkOTy1RBntBmRv8NS9JGINNP36JxiMuiHZnY2Ks
	XkcB7aqOY9NIYBZ0YmAgxNqndpvXQB0=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 0/1] erofs: Fix the slab-out-of-bounds in drop_buffers()
Date: Mon, 23 Mar 2026 10:48:05 +0300
Message-ID: <20260323074809.4542-1-arefev@swemel.ru>
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
	DMARC_POLICY_ALLOW(-0.50)[swemel.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[swemel.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227906-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[swemel.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arefev@swemel.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[swemel.ru:dkim,swemel.ru:mid,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADD482EDEFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in the drop_buffers()
function [1].

The root cause is that erofs_raw_access_aops does not define .release_folio and
.invalidate_folio. When using iomap-based operations, folio->private may contain
iomap-specific data rather than buffer_heads. Without special handlers, the kernel
may fall back to generic functions (e.g., drop_buffers), which incorrectly treat
folio->private as a list of buffer_head structures, leading to incorrect memory
interpretation and out-of-bounds access.

This can be fixed by explicitly setting .release_folio and .invalidate_folio to 
iomap_release_folio and iomap_invalidate_folio, respectively, but there is a 
commit ce529cc25b184e93397b94a8a322128fc0095cbb in upstream  that implicitly 
fixes this bug.

Please commit it to the stable branch v6.1.y .

[1] https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7

Jingbo Xu (1):
  erofs: enable large folios for iomap mode

 fs/erofs/data.c  | 2 ++
 fs/erofs/inode.c | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.43.0


