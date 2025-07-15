Return-Path: <stable+bounces-162779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D5B06018
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4D71C4619E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8A02E6D32;
	Tue, 15 Jul 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2YsNJq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A02D29C2;
	Tue, 15 Jul 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587455; cv=none; b=Jem5By21TxRjMVyRWEoug4hkeD8aQqSjCi3XmpSUWfjk7VheMB+joVb+W1p3bJZa8+X+cXMxysbigMPA/bTCnoYoKDgRr+jYa9QaiXmJCbIN3KrPv8CrC+U1bAl3a32DZ3MfdvuX1mTr8WBuNcxqLOnjd2/sh2Cy20dGoz7AvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587455; c=relaxed/simple;
	bh=pmwzrcfNMr8tv6E5PYz0y1J1tcbfud6Hrp4mdM/TomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzgYCDBBIWT5zMidWYDK5lEWWpQ40h9914CxkMmtueKNwokL7nirgWKERoyucRbuV5b9f2XqyxwQ7Sndnl885izWSRTSmM5flR9xSHB6/JvGZ3Vdtm5tdt0bSWiErDtJkxzgkXHOG1lXURSXbRno4CYfPo3uz7I52Ga74BOgq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2YsNJq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20421C4CEE3;
	Tue, 15 Jul 2025 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587455;
	bh=pmwzrcfNMr8tv6E5PYz0y1J1tcbfud6Hrp4mdM/TomM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2YsNJq0knN6mO4thSo/FRkgxPUEQ9cxqD7qOgkZ0xi2SOeLLtDr3PiITxoiioMt0
	 KrfWzggjlZmCyEQAQGEqw1EG4gKGSHLsKZuUhXkozYLiHP1atxlJcfcznVCU4Cn0yF
	 ZHPP2GOZP1JeWYzadxEuQ9cnuzgKdeTGrwSL8IDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Kandybka <d.kandybka@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 019/208] ceph: fix possible integer overflow in ceph_zero_objects()
Date: Tue, 15 Jul 2025 15:12:08 +0200
Message-ID: <20250715130811.602185075@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 0abd87942e0c93964e93224836944712feba1d91 ]

In 'ceph_zero_objects', promote 'object_size' to 'u64' to avoid possible
integer overflow.

Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d4974c652e8e4..c1eafff45b194 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2034,7 +2034,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
-- 
2.39.5




