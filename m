Return-Path: <stable+bounces-175429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51937B36810
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B4466939
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491A352FEE;
	Tue, 26 Aug 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RumOVi8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63322352FDB;
	Tue, 26 Aug 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217019; cv=none; b=owQzk4ijtisN1STnfcyzkS4pj3cQ6kBROqkyXn0jBXvL/xANbxYkWyXXziGivQfPa0yC5eu92cjdj6n6tXgd/IBqRLv/k7/MQ/nz1oh+WbhcTakfNL4v5mfdTqhSlSo0E4a9Rmz6Fz5RLw1muWpMKo8iATKZ1WpcPGQNg6n0+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217019; c=relaxed/simple;
	bh=bvTdrvMmvxphZoOtM1MafOqTNui/1aMn6n4TVCH/jGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbmiLr+M1IWXmQoIyfGZHFAs4v45Ls5S1yJfWwT+SPjM1YzrZEjKjRLoF2APJF9y2gfPDVrfVk8VNfkngTTg/FOskqGRJAxSxq4Bre7msywo6uFRcHqMGrjAC7qN+9Xg0C6q/sd2D9GPb9b788XjUa1yK2OQSrLwSR40iYHWVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RumOVi8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734C7C4CEF1;
	Tue, 26 Aug 2025 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217018;
	bh=bvTdrvMmvxphZoOtM1MafOqTNui/1aMn6n4TVCH/jGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RumOVi8wOxij4KuGO58gKWOv+KY3R76JyBMhvBtSuSZWYfeMcLyUZCjuzux+AS9Gd
	 8jS4f8ByqsQTFKarGl840F5wf/sN7SKhdizj+e0DZrveGQk314iGOlVGvSsqgpiJKU
	 8PusDEJ9KTxUXJmetF6lppBdhaRrgZwOTfZRG/kg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 628/644] ALSA: usb-audio: Fix size validation in convert_chmap_v3()
Date: Tue, 26 Aug 2025 13:11:59 +0200
Message-ID: <20250826111002.120008497@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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
index f5a6e990d07a..12a5e053ec54 100644
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




