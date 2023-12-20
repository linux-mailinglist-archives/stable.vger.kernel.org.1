Return-Path: <stable+bounces-8159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E82C81A4CD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE0328C5DF
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717E4C601;
	Wed, 20 Dec 2023 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KCbRrRnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475774C3D0;
	Wed, 20 Dec 2023 16:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84653C433C8;
	Wed, 20 Dec 2023 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703089077;
	bh=bSOO3K+NBeyMQe96wXlfmLjK0nnZAwbI6An90I26Bfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCbRrRnRHe0H+zzUuN4pWzKVS2PFuJJzy3rxvmQzWp+mYnp0JgqSKIRbgH+YbypDG
	 uuayyqx3Q34lfHcCNTUAVDvAy8OQoQ0Ks1v04dUIV8ZoZkkxyp7EVbnIq/wYPvdk6Q
	 /hqWZzB9mDtZWiunOAJ8whOl2M3vuP0RZH3rQBp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Li <yang.lee@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 123/159] ksmbd: Fix one kernel-doc comment
Date: Wed, 20 Dec 2023 17:09:48 +0100
Message-ID: <20231220160937.066374075@linuxfoundation.org>
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

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit bf26f1b4e0918f017775edfeacf6d867204b680b ]

Fix one kernel-doc comment to silence the warning:
fs/smb/server/smb2pdu.c:4160: warning: Excess function parameter 'infoclass_size' description in 'buffer_check_err'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4154,7 +4154,6 @@ err_out2:
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
  * @rsp_org:		base response buffer pointer in case of chained response
- * @infoclass_size:	query info class response buffer size
  *
  * Return:	0 on success, otherwise error
  */



