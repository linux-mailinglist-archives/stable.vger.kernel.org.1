Return-Path: <stable+bounces-160006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0FAF7BE6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591D81701B9
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B92EFD81;
	Thu,  3 Jul 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nu/R3cTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5842EE993;
	Thu,  3 Jul 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556068; cv=none; b=dinBS0enrzgoPJuVFYd9J9Hi+qT4/5RXrKMMAb/ivPZh7Sjo1jnITNGgXlvP/KrxeYyoFxQ9C2mbYCq65AZYDrk6EIJsf9V/yKdFo0Hh0r6zX0ZUWWvbBCQIS2JtPKDq1kQ3jMuoIoQna43JxcouFbweNejS73OTu8f7lnC6uNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556068; c=relaxed/simple;
	bh=9ecowzH6C3eTACbA6R63ss677ZpwI683BFnv+UXo1bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHyYqg9/nSs+ItWYA7p9okOR2SCbDNf/nsxjL7Vj+ngh8l/9tEgW+mUNgu+dM1AWTAt5zbsi6+hBPEHWEVn5TTmansLmFD4guQcLHJ20tQld28Na3dzb6u6g1lLfVmTzMqOD9CyTSo0uBIGz5nBiwXkcKOm0L6MX7Wa6NWx6Rc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nu/R3cTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF388C4CEE3;
	Thu,  3 Jul 2025 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556068;
	bh=9ecowzH6C3eTACbA6R63ss677ZpwI683BFnv+UXo1bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nu/R3cTri7v2nntDOR/D0yFOhATZhwxdP2n51CMXMfwVjRU815DS7Yk4N356dp/ae
	 7h1xqiSvqkeXTnPIeliEphnnAwmzHWAcNl0emI84j1eS/8VBgRIIM2lbHZiflspfJR
	 YRR/3SejbAaTqlKPSl/pw+t1ELWC730ELago9FE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Kandybka <d.kandybka@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/132] ceph: fix possible integer overflow in ceph_zero_objects()
Date: Thu,  3 Jul 2025 16:42:03 +0200
Message-ID: <20250703143940.755397701@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 882eccfd67e84..3336647e64df3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2043,7 +2043,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
-- 
2.39.5




