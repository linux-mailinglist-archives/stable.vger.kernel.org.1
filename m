Return-Path: <stable+bounces-9312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F878231C7
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003BC1F24AF5
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29311C29F;
	Wed,  3 Jan 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3dEMYfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C871C2A3;
	Wed,  3 Jan 2024 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8AEC433C8;
	Wed,  3 Jan 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301115;
	bh=QJM5gSymo70VhMgufnARbheK0kS0FxHwWHMnnM72xj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3dEMYfSkATngDlzjvPHjKSNPAxrIs0hyAH5wIRvHubxve8i01CipK5LhOD0YOIGj
	 Jhoxokcd9tagvygTLV8Z1cCm/0naystcs76Bv6vDcf/yU+OB0xDF3w648Oxq4A6K2k
	 JUjsUu7hhuRE+Nx9THW1bsply8wp2dH8bVYX1cwc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/100] ksmbd: add missing calling smb2_set_err_rsp() on error
Date: Wed,  3 Jan 2024 17:54:28 +0100
Message-ID: <20240103164901.943577241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0e2378eaa2b3a663726cf740d4aaa8a801e2cb31 ]

If some error happen on smb2_sess_setup(), Need to call
smb2_set_err_rsp() to set error response.
This patch add missing calling smb2_set_err_rsp() on error.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0fed613956f7a..b81a38803b40d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1904,6 +1904,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				ksmbd_conn_set_need_negotiate(conn);
 			}
 		}
+		smb2_set_err_rsp(work);
 	} else {
 		unsigned int iov_len;
 
-- 
2.43.0




