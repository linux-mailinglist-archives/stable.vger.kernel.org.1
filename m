Return-Path: <stable+bounces-59578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8C932AC5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9731F2304F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A011DA4D;
	Tue, 16 Jul 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TyBshEz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC17CA40;
	Tue, 16 Jul 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144271; cv=none; b=PGquXHUzum0jZNgRavzkTARPW+GVlbkPJszqxF4gqGnEu+4bK2/fDj9BRhbcgtPIvPoIaTFj0EGOkjl+yg/SzlpxiIxyiNYdU1isaMf9N8c2OQJNQlPFk7CWIeR/lLXQ2HjdF4ts7kkypQZJNbp99pmkjUqH1v4+OvtfHOuOcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144271; c=relaxed/simple;
	bh=UbI0e+w/JK76aSTXjE6lx6jgl5fR/2sI/bmk6rtXzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/WQ3S8zSzFYwCP7toXzIN+O8AjJXLrUiRXBwHb7uH+p2ojJJXVDv63SZz/mAHEZQReMxn4oAfsftjNrR4UV2Yd9aXJ4S7FvQEoCIq9zbBDfwXyjSJztxTMoTemqNt6wLWlkXmErDi+xa+6IFSdgqpTY9ET/lWrxnCcRhYChZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TyBshEz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430FDC116B1;
	Tue, 16 Jul 2024 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144271;
	bh=UbI0e+w/JK76aSTXjE6lx6jgl5fR/2sI/bmk6rtXzKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyBshEz58dyj6PQ2170UOy9ABzr7wkRTtOCAF1oKjqWuMkNqFPF4ZvfGvjAXi6Fr4
	 gp2xLLIBmsMf6+Ycwn1Iym9yL4peLF0Iqczyqae0GrcPQC2beEujq4V01aPMj1ehr8
	 PZQWY86Doqs13nqKE1zp5ja++z+mVjTO4kkIDK3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 02/78] media: dvb: as102-fe: Fix as10x_register_addr packing
Date: Tue, 16 Jul 2024 17:30:34 +0200
Message-ID: <20240716152740.725391205@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
References: <20240716152740.626160410@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 309422d280748c74f57f471559980268ac27732a ]

This structure is embedded in multiple other structures that are packed,
which conflicts with it being aligned.

drivers/media/usb/as102/as10x_cmd.h:379:30: warning: field reg_addr within 'struct as10x_dump_memory::(unnamed at drivers/media/usb/as102/as10x_cmd.h:373:2)' is less aligned than 'struct as10x_register_addr' and is usually due to 'struct as10x_dump_memory::(unnamed at drivers/media/usb/as102/as10x_cmd.h:373:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]

Mark it as being packed.

Marking the inner struct as 'packed' does not change the layout, since the
whole struct is already packed, it just silences the clang warning. See
also this llvm discussion:

https://github.com/llvm/llvm-project/issues/55520

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/as102_fe_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/as102_fe_types.h b/drivers/media/dvb-frontends/as102_fe_types.h
index 297f9520ebf9d..8a4e392c88965 100644
--- a/drivers/media/dvb-frontends/as102_fe_types.h
+++ b/drivers/media/dvb-frontends/as102_fe_types.h
@@ -174,6 +174,6 @@ struct as10x_register_addr {
 	uint32_t addr;
 	/* register mode access */
 	uint8_t mode;
-};
+} __packed;
 
 #endif
-- 
2.43.0




