Return-Path: <stable+bounces-38714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCA8A0FFC
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58F81C20DCE
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5214600E;
	Thu, 11 Apr 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ymiE1cju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE481D558;
	Thu, 11 Apr 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831377; cv=none; b=Mf717vPUgKvED6cR9r0YCMtG/8fQt20g8gyYgabOQ+OblP27aiylGDogQiy4tuIkzlH/x0qwpOKcW4oFMYkDYGAQETBFKfbse9peqZyYOE9DPNDJ6JJhLcmVGMuJ8Bc+zBhHJfQ3PHgEbwqz+BFdDTr2kvi3YxkZpPIfoVrwThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831377; c=relaxed/simple;
	bh=K9G+nIozpY8DuR9GDTdB1Gqlrx5DDICthV/YDEGRK5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmD71pywfM4MHT/2sG5fJacCbMVbcFqBJu5BjVkrRV60/t48XI/8B/yGxdB+iNjVPggw5qrRtnZtfcCSXxbQw+NiMXh0d5fQr8I04RD9WFDplnVKe21K1S/7ABMBzzvUThVXnSscNLhPED34uRqVLNjDbh3SdV1BlwMtrlGaZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ymiE1cju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51624C433C7;
	Thu, 11 Apr 2024 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831377;
	bh=K9G+nIozpY8DuR9GDTdB1Gqlrx5DDICthV/YDEGRK5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ymiE1cjuxLveY0FGK9gVEdyR1/g5rH0XsD4JmyRMbV9yYbC9MbCTnYkU+h1uQc30z
	 dBt2dWu54fzP1LZD904KRZwmlvnkze4mNYo52vsZhWMvelJuxiaNr7U9vh5bm98h2A
	 H3S6F7P5ZEMqoWjsllLRcUVS0UajhZ3YNG+gGr70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koby Elbaz <kelbaz@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 065/114] accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings
Date: Thu, 11 Apr 2024 11:56:32 +0200
Message-ID: <20240411095418.848182389@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koby Elbaz <kelbaz@habana.ai>

[ Upstream commit 8c075401f2dbda43600c61f780a165abde77877a ]

Fix a warning of a buffer overflow:
‘snprintf’ output between 38 and 47 bytes into a destination of size 32

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 05febd5b14e9c..179e5e7013a12 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2508,7 +2508,7 @@ struct hl_state_dump_specs {
  * DEVICES
  */
 
-#define HL_STR_MAX	32
+#define HL_STR_MAX	64
 
 #define HL_DEV_STS_MAX (HL_DEVICE_STATUS_LAST + 1)
 
-- 
2.43.0




