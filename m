Return-Path: <stable+bounces-134640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E763A93C60
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642C744039C
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22646219A91;
	Fri, 18 Apr 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qq1v1nBh"
X-Original-To: stable@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC1217F5C
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998857; cv=none; b=nslR7yrVUyjlr/RF0QtF1h6kAtvKh2NvqLIDd/JcXJUqC03KH3vpVwKqMkIQTVAPCC9oqPTWvGEF3YxqHsZ9gaxsAww3UW8PBa3WCZEFPmSUE28HoR0Q4JbVlrXcIQ+b83/e6YUJnWCIFZX3+jXcNFwqieyN5DglUfDY3VnF/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998857; c=relaxed/simple;
	bh=8wG7pW22Ye/C+WdJXY1z3OOXF0AmCW+VFUTn909RfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XetLDkzEaEf1plsgVv/g0IoS038DkArMrOUEg+iAuRA4iVOttfN/esMchaK/uOAYaQ7F56qINcC+EdSfwmmpAtKq3jWqnX2fEAVf8s2xQti+13wqf2oLcYLQtN6VGqL/OXxmDxpUoCCSW8lp/mgPAQ4UDxqu08zq8hGxhL+Y7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qq1v1nBh; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZfMpH1DtQzlgqVK;
	Fri, 18 Apr 2025 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1744998853; x=1747590854; bh=QCGJrh1zPcvTiEs0taTsLeWtERX/3JlUecn
	tswMpYvo=; b=Qq1v1nBhBNe+o+77NV3rSnykaM3xwHmZZWH+lfpRaHr3n95OV8N
	h6RIMSAdOHuZiALwy79MoefkCZBXlMNsggVRX05mQtR131HykBISC59mq7PIqC1V
	I2G6AOoiPTfCQQJne8L8ywsStCAZVdiIScZ9Qz1bMbZsXH4fR7XuwfwzRzOZwvCs
	IvFED3yNJWuyhlvbtiGZAsrXqdFsiWFE64lXVhVMZceKdsDr29Nn1jU+rrcRreCM
	5UnOdqorqmnsWXnIOzNDO7GiLyJ0aPsbmRZDN8c07JoVxFHbqWdZX163yHPcqzuz
	2m30Fwc+JyziYPud2EUZh2feJHSTrOrNvQw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ImH8HYqDZKoI; Fri, 18 Apr 2025 17:54:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZfMp901VpzlgqTr;
	Fri, 18 Apr 2025 17:54:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Preserve the request order in the block layer
Date: Fri, 18 Apr 2025 10:53:58 -0700
Message-ID: <20250418175401.1936152-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Greg,

In kernel v6.10 the zoned storage approach was changed from zoned write
locking to zone write plugging. Because of this change the block layer
must preserve the request order. Hence this backport of Christoph's
"don't reorder requests passed to ->queue_rqs" patch series. Please
consider this patch series for inclusion in the 6.12 stable kernel.

See also https://lore.kernel.org/linux-block/20241113152050.157179-1-hch@=
lst.de/.

Thanks,

Bart.

Christoph Hellwig (3):
  block: remove rq_list_move
  block: add a rq_list type
  block: don't reorder requests in blk_add_rq_to_plug

 block/blk-core.c              |  6 +--
 block/blk-merge.c             |  2 +-
 block/blk-mq.c                | 42 +++++++--------
 block/blk-mq.h                |  2 +-
 drivers/block/null_blk/main.c |  9 ++--
 drivers/block/virtio_blk.c    | 13 +++--
 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/pci.c       | 15 +++---
 include/linux/blk-mq.h        | 99 +++++++++++++++++------------------
 include/linux/blkdev.h        | 11 ++--
 io_uring/rw.c                 |  4 +-
 11 files changed, 102 insertions(+), 103 deletions(-)


