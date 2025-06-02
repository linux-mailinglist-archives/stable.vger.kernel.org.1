Return-Path: <stable+bounces-150099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A8ACB5C1
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDD4A3042
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA0221FCC;
	Mon,  2 Jun 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xq5G/Z2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686017BBF;
	Mon,  2 Jun 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876031; cv=none; b=KvnFmKc/Drd7UHtWIyRWXmoI9vD2HAfTMyTCukyxyxiR0lyF2LzwI/duEyJwPfqUQJKJPn5VABf6Z7D1DvUosIYF8SihhWahF+TJhi5/ye57POtuGKtaBXnVl3IY57JMKVdrfPx5YcOpYATCG13lt1EaoNAUMYa4OMA9Imj66fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876031; c=relaxed/simple;
	bh=MyBp7SKpZATsDMb7wD4zHHSdaGIqlmZBwHQBZr/thR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZS9QgEj2n0ym2llPtD537+YfiAfNzuCMt9th1ITSNUVNWK/C7LoJh25ceQOXXh/SeQEQtWqSrcHFNvdtkDWiTys5UGdGAr0SeD8CrejY8QWaFf/8lryDYmvic7dwN3N8k9DEZ1XZpbCAc+BDTVmkgH45gnZ2sXrl80JCtX8A3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xq5G/Z2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771A0C4CEEB;
	Mon,  2 Jun 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876031;
	bh=MyBp7SKpZATsDMb7wD4zHHSdaGIqlmZBwHQBZr/thR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xq5G/Z2etMYPrrtm+iOyRoUeBYlIy/jRBbjocfP/FF97vpJId52KZbfLJxYhbSBoN
	 +ObNx1asRH1AE25BT9BE2LZdj8V/nvihbx9yu19+SGo+laYJ7jc56Jkuxw7Z3xP83x
	 qonqAM0TFcZ5BW78l+3eyGwbjVFWb1OepRhtrxwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 048/207] dm: restrict dm device size to 2^63-512 bytes
Date: Mon,  2 Jun 2025 15:47:00 +0200
Message-ID: <20250602134300.636923626@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 45fc728515c14f53f6205789de5bfd72a95af3b8 ]

The devices with size >= 2^63 bytes can't be used reliably by userspace
because the type off_t is a signed 64-bit integer.

Therefore, we limit the maximum size of a device mapper device to
2^63-512 bytes.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5a66be3b2a63f..0f815bcf751f1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -661,6 +661,10 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 		DMERR("%s: zero-length target", dm_device_name(t->md));
 		return -EINVAL;
 	}
+	if (start + len < start || start + len > LLONG_MAX >> SECTOR_SHIFT) {
+		DMERR("%s: too large device", dm_device_name(t->md));
+		return -EINVAL;
+	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
-- 
2.39.5




