Return-Path: <stable+bounces-125808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF3A6CA99
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121BD3B4D3B
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0D1F462C;
	Sat, 22 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="o73nr0dx"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC41C84D6
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654073; cv=none; b=Ax9a2NdPL0fAQ6XTUIDXrONtV7ni4wGQ5BASo1lFFr0lwgiwbQY7kNan/adq5Ol8xduS9bNjwHUD2qUlCPNXkpThACamH9r+oKnmk9y1Z68BZhSya9qAsBmklwasaX4SIMPBHvjGGTsmdrM7SIbSlMA1EQgIGRRP38Y02lpXmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654073; c=relaxed/simple;
	bh=WHdFTwPTUyJ+598p7a8fxDKAA6oIMZqFC8g/v9xmRh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmRhenFTW3bYvMQWhLivP1dOWwaJ6lv0pool79kb/0iYbiebi7h4CEuvwUh0N5t5H7iD5x5Yf840Obmt1J+rjm32gVjQbYybZyr58vhiBRKd2MhmrOJR5Sk83+k2FeocLWRn3cSMtMYkq0lbJKmkxb0SXqxP943RI4XHnNm/iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=o73nr0dx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id A368E4076183;
	Sat, 22 Mar 2025 14:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A368E4076183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742654069;
	bh=Eo/4H8iA7/FtfbL/c7OoJ7jeUnMFZs9q1JK9a+LRCUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o73nr0dxwe0Nvy5mBKFRc6T6Dr693WfYrFagvuSR48sRFNmQ/tQJ7U0JnEpbFyfB9
	 nghaPg2glH+ahfmEyS3k5jgskdBfa5hb1gg8i2n2hsRhdTmlG9GhJr4MW1zZy9VB5m
	 ueX7xAfmWpp3uFilGhpglGAgxtfOrbQmqq4gIkyU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6 2/4] xfs: dump the recovered xattri log item if corruption happens
Date: Sat, 22 Mar 2025 17:34:13 +0300
Message-ID: <20250322143418.216654-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322143418.216654-1-pchelkin@ispras.ru>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darrick J. Wong <djwong@kernel.org>

commit a51489e140d302c7afae763eacf882a23513f7e4 upstream.

If xfs_attri_item_recover receives a corruption error when it tries to
finish a recovered log intent item, it should dump the log item for
debugging, just like all the other log intent items.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/xfs/xfs_attr_item.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 2b73132fa607..8ed840c189cb 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -672,6 +672,10 @@ xfs_attri_item_recover(
 		xfs_irele(ip);
 		return 0;
 	}
+	if (error == -EFSCORRUPTED)
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&attrip->attri_format,
+				sizeof(attrip->attri_format));
 	if (error) {
 		xfs_trans_cancel(tp);
 		goto out_unlock;
-- 
2.49.0


