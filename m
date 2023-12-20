Return-Path: <stable+bounces-8039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD5981A436
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4676128ADBD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A4A9B3;
	Wed, 20 Dec 2023 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/ks5Gze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D90495DA;
	Wed, 20 Dec 2023 16:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD455C433C9;
	Wed, 20 Dec 2023 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088741;
	bh=EB6NQOYifhVlfVYbekO27FRcrJRXF0g6ouPceFjrb/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/ks5GzeN5uWMO+jaQBHDWGpEGqw20jNvp0GT0W7liaWipxRsnzfdbRVORLKOpsPf
	 RxQTR6kOJsvLXnucwtuIlD0COd56ypZc9DRUzwWSWQlgfsVD0jm0HpINVOwC6q5L1j
	 MAwRwLoqqhBaO/hw/hgCnRgja+EwDQo+fdqyOjh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 042/159] ksmbd: smbd: Remove useless license text when SPDX-License-Identifier is already used
Date: Wed, 20 Dec 2023 17:08:27 +0100
Message-ID: <20231220160933.266206663@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 06ee1c0aebd5dfdf6bf237165b22415f64f38b7c ]

An SPDX-License-Identifier is already in place. There is no need to
duplicate part of the corresponding license.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/transport_rdma.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -5,16 +5,6 @@
  *
  *   Author(s): Long Li <longli@microsoft.com>,
  *		Hyunchul Lee <hyc.lee@gmail.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 
 #define SUBMOD_NAME	"smb_direct"



