Return-Path: <stable+bounces-137678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0AAA1489
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A52318903B1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AA521883E;
	Tue, 29 Apr 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPeUw00m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B962459FA;
	Tue, 29 Apr 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946792; cv=none; b=rA47thJkjaOtaA3Jj1IwquZnLQ3TNkghLZwSSridoU2IAWhw0q9Ut5xwAKRoLKtVsf57y7rxM+Rt/kR4By2D32MBuyKL7R5FKP25fUTcWAgt6XqMGB1IYV03ViMCmpeJWqivfKrQL/E6F+Vip7qGDWxvNg9tOwFFX3HGRwyuYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946792; c=relaxed/simple;
	bh=2FwMskh0U6J25t+onMoGR2kNLh6FzZP4b6vFAz30AB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwaKkT8gtAlcRifY82/D7uwlSzM1vxDYQdECdsqWgj7YuA68GajeZX1zcnzkmN+CSAIFJ/IU9p3VQ4RSxFjF9oHPVVwAeNeCbtJPcUQj6AKAeIxzKjcUv64wDEzerXxLCx2HBxWTUTZbTXEx2mqBPXYBB9v6wZMsjZ0OXHG4pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wPeUw00m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF53C4CEE3;
	Tue, 29 Apr 2025 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946792;
	bh=2FwMskh0U6J25t+onMoGR2kNLh6FzZP4b6vFAz30AB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wPeUw00mK3pGSsSLoyiS1anchTN0oUsxpQsIhjBoR0IUeyO4IXxsKuz+diqUZOVjq
	 hhJTOFRVUpr2dBmzPdzDtZFI8+Wz/3xuqZYcaEb7eleoIbQu6lf/o76MUhFidZqOoM
	 njk+MeM1ocHenOH/N94hJ+qC+A+OwShb3P7REr30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karina Yankevich <k.yankevich@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10 064/286] media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()
Date: Tue, 29 Apr 2025 18:39:28 +0200
Message-ID: <20250429161110.479232054@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karina Yankevich <k.yankevich@omp.ru>

commit 3edd1fc48d2c045e8259561797c89fe78f01717e upstream.

In v4l2_detect_gtf(), it seems safer to cast the 32-bit image_width
variable to the 64-bit type u64 before multiplying to avoid
a possible overflow. The resulting object code even seems to
look better, at least on x86_64.

Found by Linux Verification Center (linuxtesting.org) with Svace.

[Sergey: rewrote the patch subject/descripition]

Fixes: c9bc9f50753d ("[media] v4l2-dv-timings: fix overflow in gtf timings calculation")
Cc: stable@vger.kernel.org
Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-dv-timings.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -764,7 +764,7 @@ bool v4l2_detect_gtf(unsigned int frame_
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_D_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_D_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_D_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_D_C_PRIME) + GTF_D_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
@@ -774,7 +774,7 @@ bool v4l2_detect_gtf(unsigned int frame_
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_S_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_S_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_S_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_S_C_PRIME) + GTF_S_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);



