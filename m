Return-Path: <stable+bounces-163155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D306B07857
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7741F165BF1
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F27262FC5;
	Wed, 16 Jul 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8jJt2At"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEC26057A;
	Wed, 16 Jul 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676937; cv=none; b=OaCUDCiYc+O0pCxsoz9sGmsbjJDUbD7zMwncAZR8zTssBKb8Kf/zG66piEO+Azt9QEcjsBQe0y+lihhPCgptE5cqzk5PAbd8D4Gf7Y7di/dW5ApguD4k2XYllYNUlgNAJnYai+/HB1HB5EaU4dea1MHsI/Mk3Sbyd7Cr6+794Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676937; c=relaxed/simple;
	bh=F6z40T/vA8Ei0+4sNeywLtfPgjy3l6PcL0URr5IK4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlAYsv51WoKJu3VZIZy1vRWdj8Ch9zYmO2cG1pQrx+9nXj9ZWPOnFB4bmWl7oZia4JZbeURwHzn6la3YJTmiGe/5fJFnWLaUlVoafHTmcg5mJyRXBcWb3Xzhlng/uo21/k/RBFbuBkYitF2gEgohruGvKz+/qmUYtiXpkJQjFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8jJt2At; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF8C4CEF0;
	Wed, 16 Jul 2025 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676935;
	bh=F6z40T/vA8Ei0+4sNeywLtfPgjy3l6PcL0URr5IK4xc=;
	h=From:To:Cc:Subject:Date:From;
	b=O8jJt2At0i4PBZvisCUvJRjIrEeC3Vd8UUl/tLvreBieauXs0kiHMKbnB/y98DIoq
	 Ivv1bUqi4/Ep5ZqfdZWxAKe+pBbILEP6Ad3953Xe2LLn3vk8F4ZEYYBQBdWupm2yHy
	 r+iUdJC239xMctGos31QBdkAJJ+/Y+zhC24n053qDl/ogiAS0RKWh2OcDtyqYCImFn
	 TK7vMQCTRKAxOVf+cooIaYp2QlAM0Y9p6oBZP7bss82jO1bkvERO6ZkV59OW6Ym7g5
	 83nV8+ZvBpI2b7IWdAM6BlBM65aHahKabkxZQrV2h5VX7IAIJ8wmioTvvv3unJHRdZ
	 6CSEvV5K2Giaw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH v2] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
Date: Wed, 16 Jul 2025 15:42:10 +0100
Message-ID: <20250716144210.4804-1-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Michael C. Pratt" <mcpratt@pm.me>

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
Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
Changes since v1:
	- removed long list of short git ids as it was too much for
	  small patch.

 drivers/nvmem/layouts/u-boot-env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 436426d4e8f9..8571aac56295 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -92,7 +92,7 @@ int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
-	__le32 *crc32_addr;
+	uint32_t *crc32_addr;
 	size_t data_offset;
 	size_t data_len;
 	size_t dev_size;
@@ -143,8 +143,8 @@ int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
 		goto err_kfree;
 	}
 
-	crc32_addr = (__le32 *)(buf + crc32_offset);
-	crc32 = le32_to_cpu(*crc32_addr);
+	crc32_addr = (uint32_t *)(buf + crc32_offset);
+	crc32 = *crc32_addr;
 	crc32_data_len = dev_size - crc32_data_offset;
 	data_len = dev_size - data_offset;
 
-- 
2.43.0


