Return-Path: <stable+bounces-92371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAEB9C53B7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F1E1F227FB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1F20ADFD;
	Tue, 12 Nov 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V6zixlEs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAB214423;
	Tue, 12 Nov 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407440; cv=none; b=QKKH2THvg+LLuedxTZYyhd4roAjRHv3PEqHMsPI9l2Z2K8Pzjw3u5WmwwO2iClxNBorV1zCGLUKzZKII+/7pTq775YU4ma3ifw8jwxTjDBYlpM2cThblAL7kFrmBwuN6JqNFhrArszzfx1E2ciHRVN7TO0dSSVkFjBf+kcrxsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407440; c=relaxed/simple;
	bh=i5KXzmHy3Vs3dlq1TBMCPlO61zBZvKqkHn7zL0Dfje8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ09duNYVNsHXKKi+FA55IsboK28E2RJCyC3KOjvvpF4HnhO05ffnkwm9L6U3Cz+5n3EKZ+VQXMLD6t/8WXLIybgncci3QJ/Q8MraQ2fWh8MSQ37f6N2pDQcCy4kNya3cild0dNBikqj5nCNZ+Ff+OpeS4RiMB8boHz/O+tyiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V6zixlEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E6CC4CECD;
	Tue, 12 Nov 2024 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407440;
	bh=i5KXzmHy3Vs3dlq1TBMCPlO61zBZvKqkHn7zL0Dfje8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6zixlEsA2wgfCZKeqNwcjFm7FG4aYPTqUVxn/Qp4/VLEOK/NNLgQginYLD5Gx7KM
	 /vTnPcjwLimKmTv3REjjTisMWPZ1VA5IxLhXvHnHjKkBgXe8rY5INaTup3DrWEqYtt
	 dvF+bGS2J/QZ9sQSoNSaeLmVD7TU1TQnhFWtjBdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH 6.1 45/98] media: s5p-jpeg: prevent buffer overflows
Date: Tue, 12 Nov 2024 11:21:00 +0100
Message-ID: <20241112101845.985788238@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 14a22762c3daeac59a5a534e124acbb4d7a79b3a upstream.

The current logic allows word to be less than 2. If this happens,
there will be buffer overflows, as reported by smatch. Add extra
checks to prevent it.

While here, remove an unused word = 0 assignment.

Fixes: 6c96dbbc2aa9 ("[media] s5p-jpeg: add support for 5433")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
@@ -775,11 +775,14 @@ static void exynos4_jpeg_parse_decode_h_
 		(unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) + ctx->out_q.sos + 2;
 	jpeg_buffer.curr = 0;
 
-	word = 0;
-
 	if (get_word_be(&jpeg_buffer, &word))
 		return;
-	jpeg_buffer.size = (long)word - 2;
+
+	if (word < 2)
+		jpeg_buffer.size = 0;
+	else
+		jpeg_buffer.size = (long)word - 2;
+
 	jpeg_buffer.data += 2;
 	jpeg_buffer.curr = 0;
 
@@ -1058,6 +1061,7 @@ static int get_word_be(struct s5p_jpeg_b
 	if (byte == -1)
 		return -1;
 	*word = (unsigned int)byte | temp;
+
 	return 0;
 }
 
@@ -1145,7 +1149,7 @@ static bool s5p_jpeg_parse_hdr(struct s5
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			sof = jpeg_buffer.curr; /* after 0xffc0 */
 			sof_len = length;
@@ -1176,7 +1180,7 @@ static bool s5p_jpeg_parse_hdr(struct s5
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dqt >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1189,7 +1193,7 @@ static bool s5p_jpeg_parse_hdr(struct s5
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dht >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1214,6 +1218,7 @@ static bool s5p_jpeg_parse_hdr(struct s5
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
+			/* No need to check underflows as skip() does it  */
 			skip(&jpeg_buffer, length);
 			break;
 		}



