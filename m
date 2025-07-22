Return-Path: <stable+bounces-163710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF81B0DA83
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE28C3BA181
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B232D9EE2;
	Tue, 22 Jul 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWOfIZus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB813B280
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189673; cv=none; b=FbfFBpfJsHrYRGlBi6HuTCkNL9ktSXlGkpRcsjjM3Vmn7zEOroEkJJqF4aJDIRtkBUtp1Cupz3RlpFOOUlD8ModhC1KRD5zZAE1iNnFC0R85y6WlfLbB938/4ols9mS4IwKZLs3jQTVL5ozSc8WA7GjCUX8AjxvAbzCcuCHmejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189673; c=relaxed/simple;
	bh=b3MQNVBx9hos6aiGUDyujiM1g808rGdaOpI4uwwypOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBE8PyqOe+/4k2hziZpdOSqEdAq2Qu3DVOAnBKpGvLILUUz8eyeDCiGs7UaNUKRHc3G3OgT1Z1j9MIL7kOZ4s8VakpdNADR+N/EGd2BgDvkNWwsgT3B/+sZadxwnUMzh5EPhAnemeD5QeCyTYWBdI5wDAQ7/ZuZegzH3dWz4V6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWOfIZus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F95C4CEEB;
	Tue, 22 Jul 2025 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189672;
	bh=b3MQNVBx9hos6aiGUDyujiM1g808rGdaOpI4uwwypOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWOfIZusk8eJv8k6A0VjIryaW9B5XqZjOIkYMxOpcITyJuKhvaRksKVG2EKzv8LcP
	 InhmiFe3x702qLZFJeV1KLLdsSr2iqkBT+q9HxAtNy4qIdA83fjGFffO0U1yCu44Gd
	 9A5REiWemzInG5KrJl+NQY6NUbkPS+jbJa2s3VtaX6vUn2dGnAiUfEOvgA2tkQgZOP
	 QH91Cu1yrGI456KwcQbkrrJm/vWKvCnISWnwKUAMkUiRharJ3HCixLg67d/CDAkC8N
	 wjOJgegjI7yZX4lUEIYCsRZc9vbu9AT3E1fmir0vnEgJocSD6PqpQVzqi+gU7ca7fh
	 CaOFC6ZBwj6Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
Date: Tue, 22 Jul 2025 09:07:46 -0400
Message-Id: <20250722130746.942677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072115-gotten-sprout-e549@gregkh>
References: <2025072115-gotten-sprout-e549@gregkh>
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
 drivers/nvmem/u-boot-env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index adabbfdad6fb6..8712d3709a268 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -132,7 +132,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
-	__le32 *crc32_addr;
+	uint32_t *crc32_addr;
 	size_t data_offset;
 	size_t data_len;
 	size_t dev_size;
@@ -183,8 +183,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	crc32_addr = (__le32 *)(buf + crc32_offset);
-	crc32 = le32_to_cpu(*crc32_addr);
+	crc32_addr = (uint32_t *)(buf + crc32_offset);
+	crc32 = *crc32_addr;
 	crc32_data_len = dev_size - crc32_data_offset;
 	data_len = dev_size - data_offset;
 
-- 
2.39.5


