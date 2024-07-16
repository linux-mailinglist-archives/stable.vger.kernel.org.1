Return-Path: <stable+bounces-59533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA0932A96
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE21B2307A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB71DA4D;
	Tue, 16 Jul 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aExP0tSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466DCA40;
	Tue, 16 Jul 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144136; cv=none; b=I7MOn2J+UwNhb5xow9m9KdSR1hm8s6LbpWl8TH3p8c3u8S38hvibSZhdvfsRRFD3xdaL6lLMShialWksZXJskWuIqvuMgw20TQDjnp4aeBr6Ba6kl7GaXR6bBqKFEMkxIajTevkTDBZAfEj80rQ5j+79GzmmK2L0D8eIAp/UQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144136; c=relaxed/simple;
	bh=A0+EfWxHC2+3gE9/p6Vitr3o1+0b5kDxywC5ysplWl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzcw9Faw9+4I7gae2VWSH9e0t3hWxDIN1hhjGXSwQw38SDnEprH57gaZ2cJntRelrLvb3JQ+umcWe6HEWHoR4fEpOGh8zSoyeFFAhf/E2iVpPJkubBNBWGQVkeMWhDLroY8iIPEXpN4QjKlgf4cPBJarowaPf0RaUJBhvBR6M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aExP0tSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80CC116B1;
	Tue, 16 Jul 2024 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144136;
	bh=A0+EfWxHC2+3gE9/p6Vitr3o1+0b5kDxywC5ysplWl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aExP0tSpnz4U6CywmG8Mt8n29qNc/0dbewnXFC6cIPSKnNVGS/sH7xMTZM2gg6ZEL
	 6AK5cIngm2HqJQtoVaHamgM1wnJh83/PN/7Wya45/v9tJZ/6q7YwS/b76NJptvHTiC
	 ylFJDdIHB1SJ7fw8qdutN9qGTMqT5rJq61sUrirw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4.19 39/66] media: dw2102: fix a potential buffer overflow
Date: Tue, 16 Jul 2024 17:31:14 +0200
Message-ID: <20240716152739.658465888@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@kernel.org>

commit 1c73d0b29d04bf4082e7beb6a508895e118ee30d upstream.

As pointed by smatch:
	 drivers/media/usb/dvb-usb/dw2102.c:802 su3000_i2c_transfer() error: __builtin_memcpy() '&state->data[4]' too small (64 vs 67)

That seemss to be due to a wrong copy-and-paste.

Fixes: 0e148a522b84 ("media: dw2102: Don't translate i2c read into write")

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/dvb-usb/dw2102.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -789,7 +789,7 @@ static int su3000_i2c_transfer(struct i2
 
 			if (msg[j].flags & I2C_M_RD) {
 				/* single read */
-				if (1 + msg[j].len > sizeof(state->data)) {
+				if (4 + msg[j].len > sizeof(state->data)) {
 					warn("i2c rd: len=%d is too big!\n", msg[j].len);
 					num = -EOPNOTSUPP;
 					break;



