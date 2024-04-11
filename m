Return-Path: <stable+bounces-38287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4442F8A0DDA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F181C21A3F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7C145B14;
	Thu, 11 Apr 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iO5Bdz0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A0145B13;
	Thu, 11 Apr 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830112; cv=none; b=WudyglEt81f0I3oYO3mXxh60S3i0HdvORi3ryIogif023tr/GtXoqeDlQwd2ByfRVCQJdzc72VJtqELeIbUMeZMu18TlUFv2lpl/tlIQyq4CsxGnKBVJvA7D6T2GhYnQuBHu0MIeu8OCWq3zA5RZo8kz5C6S5ZEIZwzYT60bcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830112; c=relaxed/simple;
	bh=QDuoqgMY+wANJrUKGGjYM10UdVpXX7vcBVu0KFV9FOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzby2kWv5fJpXTYJhX1qGS2jjP5bOlNC5pPJ3FC5UmlOiCIybypltETRZJCj0qHe2L7FOOPEGe6sdiLbB6G0X7y51/+8NxrC+zkf9kUIH8Ll2T3ksLVGJoV8MTKQh4raYVYurxwpHONrAj/sxHCbE/qFAnJvDVz3Tv67ZZzgpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iO5Bdz0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AA5C433C7;
	Thu, 11 Apr 2024 10:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830110;
	bh=QDuoqgMY+wANJrUKGGjYM10UdVpXX7vcBVu0KFV9FOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iO5Bdz0P3P3qRHCvMgzjj/rKenRRViy9FXSsCsHNxxEKmB0IPVVC0ZBzv22QONJDA
	 6CraEqOGLtYsjtp4VAXOwsBIdTd1mUbLAAslkAQA13XqQAYgmb0hsABUYa+PihmZjz
	 /1p54FejPLVuYiF2aN+33z1gKBQjiNNGwIh3dcHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 038/143] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Thu, 11 Apr 2024 11:55:06 +0200
Message-ID: <20240411095422.059129278@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 98bc7e26e14fbb26a6abf97603d59532475e97f8 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118100206.213928-1-chentao@kylinos.cn
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa1..abca117725c81 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -973,6 +973,8 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
 		char *buf = kasprintf(GFP_KERNEL, "%s: Total %d times\n",
 				      kmsg_dump_reason_str(record->reason),
 				      record->count);
+		if (!buf)
+			return -ENOMEM;
 		hlen = strlen(buf);
 		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
-- 
2.43.0




