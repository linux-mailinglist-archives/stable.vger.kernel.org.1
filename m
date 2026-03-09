Return-Path: <stable+bounces-223489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NhSOltUrmlACQIAu9opvQ
	(envelope-from <stable+bounces-223489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:02:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A09233CDD
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA40B3022076
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 05:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BF2D5924;
	Mon,  9 Mar 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cdTWlkCU"
X-Original-To: stable@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A82327A3
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032525; cv=none; b=OfIsjrhF5maOfkgYCWVYkDn7nSQuanN0/m3IaBt0YBCqgG/7OORXQGyc+AdYYj0pF3ddxbKvQ0aCWCoWU5TUN7jfQrwMlTZ90wkAruTzd10e2ZFDo8DzNs8CQ9gmOf8RpDHDZD95Ox2+TES+BTbZmPu9MLcPkiRxXutCPXEtPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032525; c=relaxed/simple;
	bh=qJv5Up2o3YdVn/j3koQge8nHeyuIM2fK5PwDUiIsoUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMF1rhRCeHmUXDyJj9UtxZKxYE3nO4c8GKUo5QttdYvU/FU6Djw48rJ+0IQXtlWPmnmloJM/qxTK6+UEEIlCBeH/V+gTrJ3igA/bKICbUWCvXRPRgwi51l868mXonHdSUuNZm8oZaUPjtZxUEB4RFcrGYs/Zsd9CvoxwxDq9xLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cdTWlkCU; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773032522;
	bh=1xxhUOpsHPSl6uOb5KarU0bfLxgWhciM9FKxDBrNhBk=;
	h=From:Subject:Date:Message-Id;
	b=cdTWlkCUewgRfnRdP0Hg40PHsOm78SVvOzBvDip3jdiT85ZItAR4pxJ7AGkPrM+qT
	 zHW6eOkNtFJatx7jvQIxzt4W5uRr7uKP4lkscsJIW2qIhMQvOt+xc/BwS4Jtv411rQ
	 DBPj9luzPluj1e7dCfhqqcW+OYZPyvi8bsUl5cHw=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69AE542F00001DDF; Mon, 9 Mar 2026 13:01:52 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 3785807602709
X-SMAIL-UIID: 98C2C42334614354A275F0971B55E106-20260309-130152-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	willy@infradead.org,
	vishal.moola@gmail.com,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y 0/3] Fix patch backport review
Date: Mon,  9 Mar 2026 13:01:27 +0800
Message-Id: <20260309050130.912344-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91A09233CDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,dubeyko.com,infradead.org,gmail.com,sina.com];
	TAGGED_FROM(0.00)[bounces-223489-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sina.com:dkim,sina.com:mid]
X-Rspamd-Action: no action

This patch series is to backport the fix 736a0516a162
("hfs: fix general protection fault in hfs_find_init()")
to 6.1.y and the other 2 patches are its dependence.

Matthew Wilcox (Oracle) (1):
  highmem: add kernel-doc for memcpy_*_folio()

Viacheslav Dubeyko (1):
  hfs: fix general protection fault in hfs_find_init()

Vishal Moola (Oracle) (1):
  pagemap: add filemap_grab_folio()

 fs/hfs/bfind.c          |   3 +
 fs/hfs/btree.c          |  57 +++++++++++---
 fs/hfs/extent.c         |   2 +-
 fs/hfs/hfs_fs.h         |   1 +
 include/linux/highmem.h | 164 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pagemap.h |  20 +++++
 6 files changed, 235 insertions(+), 12 deletions(-)

-- 
2.34.1


