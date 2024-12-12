Return-Path: <stable+bounces-103120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272859EF52E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFD928B81E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA3215762;
	Thu, 12 Dec 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3qxf/fC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928A176AA1;
	Thu, 12 Dec 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023607; cv=none; b=midsf0TKIaXLZteqG0fOgeT/TEl0GWZWQAnDgb1DW1v7ciAOQaukKgxSIzd19f5BuAcwYzfKYeLR7RLhY1HTYaGCeGr2UMd/Ac7VngSbke9CXl6+Cx/U29Ld7rJSPyeR0ycxI93C+RRh+U40Z4KBEkM0l9rrbhjFH0ao4doP0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023607; c=relaxed/simple;
	bh=mvqW1y9xN0Y8NrP3tBmnWsEzjZFN9mnac/18QGpDXa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLlCweJSMY3D963RN8TDyQ7eidYfe5eStf3EQlsso7wvF5dl8nIBQ4sEO6H3cVgUIUWT0tmfoukFnnOfI3jAyKWV7ariC+RFRj46c3+8cQop/3/K1g5ehK/q8aDrRJKyLr1f3edyKf2hZpTEHANbFja/RqZBBion1g6Hm+Q1P5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3qxf/fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE1C4CECE;
	Thu, 12 Dec 2024 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023607;
	bh=mvqW1y9xN0Y8NrP3tBmnWsEzjZFN9mnac/18QGpDXa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3qxf/fCrtoy0bLdwK7zLEEKkb9lqA+t9IueaHsAEaMNg3RbmnEErrapo8YsH7jWS
	 uo81RixCZZ6/pd9tsfZHZBSJorX5v3YJ7I/+tP9Fit3ORpp2VdjnOL+9zMrnonqtt5
	 pIpi7NHPxYY/bxqstjvPixcu1lSq1GSVM1ciItVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.10 006/459] media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()
Date: Thu, 12 Dec 2024 15:55:44 +0100
Message-ID: <20241212144253.777193878@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaosheng Cui <cuigaosheng1@huawei.com>

commit 0f514068fbc5d4d189c817adc7c4e32cffdc2e47 upstream.

The buffer in the loop should be released under the exception path,
otherwise there may be a memory leak here.

To mitigate this, free the buffer when allegro_alloc_buffer fails.

Fixes: f20387dfd065 ("media: allegro: add Allegro DVT video IP core driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/allegro-dvt/allegro-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -1208,8 +1208,10 @@ static int allocate_buffers_internal(str
 		INIT_LIST_HEAD(&buffer->head);
 
 		err = allegro_alloc_buffer(dev, buffer, size);
-		if (err)
+		if (err) {
+			kfree(buffer);
 			goto err;
+		}
 		list_add(&buffer->head, list);
 	}
 



