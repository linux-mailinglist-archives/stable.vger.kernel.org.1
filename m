Return-Path: <stable+bounces-163711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F8B0DA8E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840C416AE1B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA012E9EBC;
	Tue, 22 Jul 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KARMN0rX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0113B280
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189895; cv=none; b=iUpsZFT9wyUH8zK3kyxZKkmEaqNqH6DLWKdTCxS27jSqVQqbyxSLarePTXTSj9ZeDneBlIQvnxKJ5mtcJ1XYcgoIqsVHuKLHeqzM2+DwFeX4NqIgdv0sExtHq4m+700r07O0qsET4EPKvEmcRYRWl87SRHvTmoEZexXd6gU2kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189895; c=relaxed/simple;
	bh=avI19llACOZE5MUqvdzi5SGYCnluHXFOtF5h/eFnKEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2uzowKALnsXcc0KfC53NiyABrST+IEYjZlU+1Kx9pi6cbkSYPGWNkhfboFG1tmz7KPwT/hZ/0/N+QMUJMV0uxBP5F+1OPvHKYCGaDUqHpS9OlbvFeZ4D0ubegI/3FVzryNNvmuO7qtb7Ij16x0nQJeVHVLVmh83WjfSuPaBGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KARMN0rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F6AC4CEEB;
	Tue, 22 Jul 2025 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189895;
	bh=avI19llACOZE5MUqvdzi5SGYCnluHXFOtF5h/eFnKEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KARMN0rXZ7cFTn7/qeOjnb0RsZGb7/apUW++7E2dvD/YjSXt+8ZKHmuTfVDADrcwT
	 wIxrQ9UhEa0ELLjIDKH+ho2bnuZQuKrP7LCUjdwjFh2tz8JUOxkl82B1jc41Hy0v0L
	 jAwH3Ll3JxEcxJCZhB0G1CNVfhNsebLGaQn+Xp/bF75k+iksB0XMmfTnnq/HmpE6WY
	 obInRQgAnDVIQkXTDyGRm/1AV4hUwFMgUPGFCZhYerYNGeUFH2kIPIlIVrAFX1FaJ8
	 exRnL2iKKxwi15u0AFwlilPvfqMo8p3QhUaOeZ2IooeI73k0aSsx8+QVbiR27vzoIX
	 r9abbX7v58QVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
Date: Tue, 22 Jul 2025 09:11:30 -0400
Message-Id: <20250722131130.943212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072117-afraid-cyclic-e53c@gregkh>
References: <2025072117-afraid-cyclic-e53c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Michael C. Pratt" <mcpratt@pm.me>

[ Upstream commit 2d7521aa26ec2dc8b877bb2d1f2611a2df49a3cf ]

On 11 Oct 2022, it was reported that the crc32 verification
of the u-boot environment failed only on big-endian systems
for the u-boot-env nvmem layout driver with the following error.

  Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)

This problem has been present since the driver was introduced,
and before it was made into a layout driver.

The suggested fix at the time was to use further endianness
conversion macros in order to have both the stored and calculated
crc32 values to compare always represented in the system's endianness.
This was not accepted due to sparse warnings
and some disagreement on how to handle the situation.
Later on in a newer revision of the patch, it was proposed to use
cpu_to_le32() for both values to compare instead of le32_to_cpu()
and store the values as __le32 type to remove compilation errors.

The necessity of this is based on the assumption that the use of crc32()
requires endianness conversion because the algorithm uses little-endian,
however, this does not prove to be the case and the issue is unrelated.

Upon inspecting the current kernel code,
there already is an existing use of le32_to_cpu() in this driver,
which suggests there already is special handling for big-endian systems,
however, it is big-endian systems that have the problem.

This, being the only functional difference between architectures
in the driver combined with the fact that the suggested fix
was to use the exact same endianness conversion for the values
brings up the possibility that it was not necessary to begin with,
as the same endianness conversion for two values expected to be the same
is expected to be equivalent to no conversion at all.

After inspecting the u-boot environment of devices of both endianness
and trying to remove the existing endianness conversion,
the problem is resolved in an equivalent way as the other suggested fixes.

Ultimately, it seems that u-boot is agnostic to endianness
at least for the purpose of environment variables.
In other words, u-boot reads and writes the stored crc32 value
with the same endianness that the crc32 value is calculated with
in whichever endianness a certain architecture runs on.

Therefore, the u-boot-env driver does not need to convert endianness.
Remove the usage of endianness macros in the u-boot-env driver,
and change the type of local variables to maintain the same return type.

If there is a special situation in the case of endianness,
it would be a corner case and should be handled by a unique "compatible".

Even though it is not necessary to use endianness conversion macros here,
it may be useful to use them in the future for consistent error printing.

Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Reported-by: INAGAKI Hiroshi <musashino.open@gmail.com>
Link: https://lore.kernel.org/all/20221011024928.1807-1-musashino.open@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: "Michael C. Pratt" <mcpratt@pm.me>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://lore.kernel.org/r/20250716144210.4804-1-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ applied changes to drivers/nvmem/u-boot-env.c after code was moved from drivers/nvmem/layouts/u-boot-env.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 4fdbdccebda16..3d86dcd01ecf1 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -139,7 +139,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32 = *(uint32_t *)(buf + crc32_offset);
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-- 
2.39.5


