Return-Path: <stable+bounces-31968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26561889A12
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9411F2ECEB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4427282A84;
	Mon, 25 Mar 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMYdwaI9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88517C653;
	Sun, 24 Mar 2024 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323779; cv=none; b=GLDqvIZ/0xfEHNnFBFIRj6PCqvEDErmqryf2+P5KA+9WfO4b6d3DfLEnWrkKZaWnfFWiQpLVJEgGlMeDMJUnyH6wbM+2cLLWrEWevnYenC7FnLTqSXZN2LAU3Bk1OlmQtDL/gYREGFQccVAVXfy6zB08Kt+Hr26/t8iLEa3U4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323779; c=relaxed/simple;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsSJyXSlp1tbSZ5zSsnPeLIChn+R1KKyyqPlDcixvf89y/g4IoC4RydbJviM6KHRdANhMVti07OXK4SbDYfJnI5ozag+eYLbBKz1x4mKqDFaSxCOxOd1mX5MGqfsssbl0W4IZ/mUJV8gzerDtrHECPzrb6C+jrGQt3DzKHzvcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMYdwaI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF61C43399;
	Sun, 24 Mar 2024 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323779;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMYdwaI9LOMBNowz1d71bpQtqklYryH6SoeM5EgIz7/XlT4BKRLUJsZluIrOcAA83
	 J64/gR6w53VWxTWcp5vYxnfSAydUHCsOlHYoPY/8C2gXGt9ttUk6wLf4IeapXfqWQd
	 oKtUCFKFSUOeon/gyMZlzMMSWvh6lfQma/+8FkvWk9fFJJwI/e/42bSdH3qUwHcsKL
	 N7WvO+8cpBioSy7Kff1qmhO2W4p4l4QKbeuRIM9z3GZh+jJkTa8Mf6Pm4cSvxwW2Dg
	 JD5Bp9YCRaO3KPcHY2+F6zLIPCexcGlot9Zy2AN8iscA7IPHpgaYxfoBlMx/37XTW9
	 nO407c688Cs7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 155/238] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 19:39:03 -0400
Message-ID: <20240324234027.1354210-156-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 0b70530ee740861f4776ff724fcc25023df1799a ]

If go7007_read_addr() returns error channel is not assigned a value.
In this case go to allocfail.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 866b8695d67e ("Staging: add the go7007 video driver")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/go7007/go7007-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index eeb85981e02b6..762c13e49bfa5 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1201,7 +1201,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
 				u16 channel;
 
 				/* read channel number from GPIO[1:0] */
-				go7007_read_addr(go, 0x3c81, &channel);
+				if (go7007_read_addr(go, 0x3c81, &channel))
+					goto allocfail;
+
 				channel &= 0x3;
 				go->board_id = GO7007_BOARDID_ADLINK_MPG24;
 				usb->board = board = &board_adlink_mpg24;
-- 
2.43.0


