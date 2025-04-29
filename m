Return-Path: <stable+bounces-138960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC335AA3D09
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CE4A5D2F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16156231857;
	Tue, 29 Apr 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyHG4T7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49862550D5;
	Tue, 29 Apr 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970617; cv=none; b=NpiUNR4NAOAucEd8kLpvKi9VwwRfX30FoDR2LFwkNzrbPFYCczdF3sYnRVhQL9cBBlT5ryiGywEp136nCou2U9ap07GtneM+bg7CXueTXQsVpQP21sYbzrDK3olCNAdzNC05/3XD3aVkSFGXmQbmObN0cfJ3Ql70vYlwJUqNr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970617; c=relaxed/simple;
	bh=S+qjLFpypedjRlfFDLU0gx3XiFaz5VfaUVIta+Tw074=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+I77iwnQNpmPhL3ztz6sm5lSGw+CZTQstaSe91Wqu7suV39CAu6T6dErU5sIzvtiuopOnUttCd8UhdMIBEeHcAfdD/3Vj07P1UxEq6FGW/2QMhWXJk3UJW8HIQnR2eNiE661GkH8GoSsO4bllr4NnyUkSd8W36NIdT4wMrDLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyHG4T7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E5BC4CEE3;
	Tue, 29 Apr 2025 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970617;
	bh=S+qjLFpypedjRlfFDLU0gx3XiFaz5VfaUVIta+Tw074=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyHG4T7ZyxN2IoJTvrOiPdoUKE1S2wF/hnx1Is5fzWzDFzkgAoJ93jRfb0SSJNoSl
	 G5cJUb9Mq2Mq/gMYTQD2WjpZDKEn17Bszi2foZMTBbRUMBIUoGR3tNHjS7frWr2CfG
	 8+25w5yQ0ZJkZa3Tl+oFohSwGjV8+vwlvcHGxxZVcrOr9elzSqUtkdyfQuzS5wKglb
	 IIowkN6sOen0oaRc4fg02kHF6EydF7LtnJlBrou9wbkcxdsbzOYh9LzXB2vOrCFNyg
	 XeJcl28BudjDlP1CyTNFU9W2J8An9WYtdsRgRKC9s9Zn6Ktn1/cP36a/X0UzisW6w0
	 e5QlSig6SvuJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.14 05/39] nvmem: core: fix bit offsets of more than one byte
Date: Tue, 29 Apr 2025 19:49:32 -0400
Message-Id: <20250429235006.536648-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 7a06ef75107799675ea6e4d73b9df37e18e352a8 ]

If the NVMEM specifies a stride to access data, reading particular cell
might require bit offset that is bigger than one byte. Rework NVMEM core
code to support bit offsets of more than 8 bits.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-9-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fff85bbf0ecd0..7872903c08a11 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -837,7 +837,9 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		if (addr && len == (2 * sizeof(u32))) {
 			info.bit_offset = be32_to_cpup(addr++);
 			info.nbits = be32_to_cpup(addr);
-			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
+			if (info.bit_offset >= BITS_PER_BYTE * info.bytes ||
+			    info.nbits < 1 ||
+			    info.bit_offset + info.nbits > BITS_PER_BYTE * info.bytes) {
 				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
 				of_node_put(child);
 				return -EINVAL;
@@ -1630,21 +1632,29 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, extra, bit_offset = cell->bit_offset;
+	int i, extra, bytes_offset;
+	int bit_offset = cell->bit_offset;
 
 	p = b = buf;
-	if (bit_offset) {
+
+	bytes_offset = bit_offset / BITS_PER_BYTE;
+	b += bytes_offset;
+	bit_offset %= BITS_PER_BYTE;
+
+	if (bit_offset % BITS_PER_BYTE) {
 		/* First shift */
-		*b++ >>= bit_offset;
+		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
 		for (i = 1; i < cell->bytes; i++) {
 			/* Get bits from next byte and shift them towards msb */
-			*p |= *b << (BITS_PER_BYTE - bit_offset);
+			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
 
-			p = b;
-			*b++ >>= bit_offset;
+			*p = *b++ >> bit_offset;
 		}
+	} else if (p != b) {
+		memmove(p, b, cell->bytes - bytes_offset);
+		p += cell->bytes - 1;
 	} else {
 		/* point to the msb */
 		p += cell->bytes - 1;
-- 
2.39.5


