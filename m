Return-Path: <stable+bounces-102470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CA9EF2E8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A8A18907CB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B5239BC7;
	Thu, 12 Dec 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aBOaKg75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05D239BC1;
	Thu, 12 Dec 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021347; cv=none; b=ghZ57q1x0Dgvb3nld1RMtGNIHanwvf/Sr34q0LnVn2vCtVr+UgXrEvvrKu1ZmKpR7Yd9hPwm9tpokvK1/92odOx0AaJxlAce8vzvM0mOk+k6FJIJRddPxXRvR+i4BkX27uS7yvIxJTZMVeiYEhC1l/HXixR9ox/yVhO5esV0nCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021347; c=relaxed/simple;
	bh=HLC5tL2Ekts0FZOAYehvB5rBPoGEAXb5oQ97/LQwf7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKvxR2+3LBgcBz0XtEXSCq2DGQ5BFW4oN+pHGTn1uOyLdvHVQeeyChi0ZbYSowOQQL7znKgIz8jisiPV8AI8og20peUE72ShMYe8NuL5sx/FCvKdLDa22e7Yyv8hifmOgdcESXqMjJ4WZwB9ej2DHYghr8sVoo3uzIfLFnAQe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aBOaKg75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5581AC4CED0;
	Thu, 12 Dec 2024 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021346;
	bh=HLC5tL2Ekts0FZOAYehvB5rBPoGEAXb5oQ97/LQwf7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBOaKg75TEd8e8w/rY1FUxEfEJ759NRY9gAv99kEdA9ABxEXH9jbChKmlYb7nvlSv
	 tl4jzxuTGt3NPApijO5wtVBU0qKnFoek1klWbiYYKHztxCT5asa+KOqfo1xlWFSsK8
	 O3OIqTzAg3bdl4FgSFGlIHi1TEejjUT+jKMUez68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 711/772] smb: client: memcpy() with surrounding object base address
Date: Thu, 12 Dec 2024 16:00:56 +0100
Message-ID: <20241212144419.276816607@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Kees Cook <kees@kernel.org>

[ Upstream commit f69b0187f8745a7a9584f6b13f5e792594b88b2e ]

Like commit f1f047bd7ce0 ("smb: client: Fix -Wstringop-overflow issues"),
adjust the memcpy() destination address to be based off the surrounding
object rather than based off the 4-byte "Protocol" member. This avoids a
build-time warning when compiling under CONFIG_FORTIFY_SOURCE with GCC 15:

In function 'fortify_memcpy_chk',
    inlined from 'CIFSSMBSetPathInfo' at ../fs/smb/client/cifssmb.c:5358:2:
../include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  571 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 67c5fc2b2db94..6077fe1dcc9ce 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -5349,7 +5349,7 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
 				InformationLevel) - 4;
 	offset = param_offset + params;
-	data_offset = (char *) (&pSMB->hdr.Protocol) + offset;
+	data_offset = (char *)pSMB + offsetof(typeof(*pSMB), hdr.Protocol) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->SetupCount = 1;
-- 
2.43.0




