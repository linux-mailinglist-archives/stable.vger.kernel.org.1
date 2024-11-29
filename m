Return-Path: <stable+bounces-95795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C549DC26E
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 11:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45160B21323
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290F19882F;
	Fri, 29 Nov 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="REh52goD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A419884C
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877947; cv=none; b=bfxgytZGFlN/TwBgEayCP9jYgKd71xsh06EKbgUeTs7jRUAWlJtSvuGUjidjppDrIXcw64UuYwG0GhlHjCB12nQN9Zend4ZwNbHYXh1KtdRB1UypHJX1Jdaw1zv/i+qrof8L59s9S2gRGstfSpVUz2DgZ0xRHeqn7WVA/KrD90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877947; c=relaxed/simple;
	bh=bW1FSCJFunRDrSqOM204bY5mld8sT3UEGJ++Vhd7K9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7t8azAJcAc/D3Slay4Xhk87ADJkd29K1rUryP2TX35i0mO7UiKLW9wIzOGglEqu1HzoP4NIQSzw//BzhOFPeMQCPRU4Bt2r6V25SaZMd8rGafA+eEBbFAZ/zVHKHrbrqv5dj5yihl9AF2ancHnU9ilRkZuby2PxGAfMHsPc1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=REh52goD; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732877946; x=1764413946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A1e42bI3C1cudgfG0Jju0iag8j3Ui9rF1GbEL/zZyXQ=;
  b=REh52goDGpnNj/HF/h/fNm11oJFELzbM8t7AwkxgTfq33HTpibmsIzah
   NFkD9wpgFU8Qse2yCqafSbIb4pJKHg/x8IRnK6ZhoNs32fcGgsHS7FNOD
   BsF8wEQrVmMFJs0Dqv/w0t/ToH2zq4UVixuDsSchhAAX821PKTP4AUXzx
   U=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="441787667"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:59:03 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:63322]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.207:2525] with esmtp (Farcaster)
 id 0ce592a2-94d9-471f-9120-9c67ed89cfed; Fri, 29 Nov 2024 10:59:02 +0000 (UTC)
X-Farcaster-Flow-ID: 0ce592a2-94d9-471f-9120-9c67ed89cfed
Received: from EX19D019EUB001.ant.amazon.com (10.252.51.32) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 10:59:00 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D019EUB001.ant.amazon.com (10.252.51.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 10:59:00 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.124.125.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 10:59:00 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com [172.19.75.107])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 7A3BEA0325;
	Fri, 29 Nov 2024 10:58:59 +0000 (UTC)
Received: by dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (Postfix, from userid 23348560)
	id 140D86C75; Fri, 29 Nov 2024 10:58:59 +0000 (UTC)
From: Jakub Acs <acsjakub@amazon.com>
To: Jan Kara <jack@suse.cz>, <stable@vger.kernel.org>
CC: Jakub Acs <acsjakub@amazon.com>, Jakub Acs <acsjakub@amazon.de>
Subject: [PATCH 6.1/5.15/5.10/5.4] udf: fix null-ptr-deref if sb_getblk() fails
Date: Fri, 29 Nov 2024 10:58:46 +0000
Message-ID: <20241129105846.4698-1-acsjakub@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 32f123a3f342 ("udf: Fold udf_getblk() into udf_bread()"), fixes a
null-ptr-deref bug as a side effect. Backport the null-ptr-deref fixing
aspect of the aforementioned commit.

Closes: https://syzkaller.appspot.com/bug?extid=a38e34ca637c224f4a79
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
---
 fs/udf/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d7d6ccd0af06..4f505a366da9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -380,6 +380,10 @@ static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
 	*err = udf_get_block(inode, block, &dummy, create);
 	if (!*err && buffer_mapped(&dummy)) {
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		if (!bh) {
+			*err = -ENOMEM;
+			return NULL;
+		}
 		if (buffer_new(&dummy)) {
 			lock_buffer(bh);
 			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);

base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
-- 
2.40.1


