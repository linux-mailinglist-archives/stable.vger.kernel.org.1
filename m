Return-Path: <stable+bounces-173687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5725B35E91
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8B8364AEB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58BE288511;
	Tue, 26 Aug 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yp6KyEOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269121D3C0;
	Tue, 26 Aug 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208895; cv=none; b=ZUzdlhBBZ4VlBHjJ1F/UCg4LfHBJIk1PG0YT5kQi9adZBXpLyRHMqoftSxxy3fMf0gRLbyxF7OlKz4My89lVPx+PDKKj2rl5pt3RsdH5p+7XpKS3DuhK13cJUVtQY4TYwqQb0T4C+eY6gc3JuWA9pSRZuszIv1ct/nV0dOKdQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208895; c=relaxed/simple;
	bh=zkwYJgsP9eVvkmog9HQLiL3Oc/wZMouKho8CSMFW8Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qODlFbFEtfFfQFFC3ZfGJ8WZ7qoQBkxwDY273SlVwqQGD4uVNcLx8ZaYfs6Rd1+MuRsluFN3IzyZZ5ndnuMB5YCxX+OZ+mZUdvHgre3eiKPdg3yoLlwALY7O590WQhGQzjwT6PV6EAVx5qvUeE6FDWZNRRts3bS04pcRBw9N4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yp6KyEOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0448DC4CEF1;
	Tue, 26 Aug 2025 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208895;
	bh=zkwYJgsP9eVvkmog9HQLiL3Oc/wZMouKho8CSMFW8Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yp6KyEOeYyMcqkO+e54GhyIz3Z5fg8fazhGHn3R3/nRjAeAY7ZVAfOimqsGaQ9jH3
	 84vlxj0LjfUPbRHiSxndCuBHu8RVKPD1hZR6ySbb290mIS6ULOBIdWRQe+2zCzw5aC
	 xJlMjyF3JF48eSbo1W8piOpAxlA6Yo1UfCLBCbgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 287/322] ALSA: usb-audio: Fix size validation in convert_chmap_v3()
Date: Tue, 26 Aug 2025 13:11:42 +0200
Message-ID: <20250826110922.998713520@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 89f0addeee3cb2dc49837599330ed9c4612f05b0 ]

The "p" pointer is void so sizeof(*p) is 1.  The intent was to check
sizeof(*cs_desc), which is 3, instead.

Fixes: ecfd41166b72 ("ALSA: usb-audio: Validate UAC3 cluster segment descriptors")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/aKL5kftC1qGt6lpv@stanley.mountain
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 1cb52373e70f..db2c9bac00ad 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 		u16 cs_len;
 		u8 cs_type;
 
-		if (len < sizeof(*p))
+		if (len < sizeof(*cs_desc))
 			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
 		if (len < cs_len)
-- 
2.50.1




