Return-Path: <stable+bounces-161745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD825B02C5D
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 20:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4901AA3F29
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8F215179;
	Sat, 12 Jul 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBZjmgrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E37201276;
	Sat, 12 Jul 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344262; cv=none; b=s7WT/Y9emjmbIUOHjugwFKkXG+mOZjzgH6plho0p4lRHNgBptIm83o658nLPmzoI45iwOMSIzQR9ksouX1kZmMkxfUoPrk4V4auyff7qr+x6YB2aCL9+by4uFkT8VcBZye5mUi/n1rX/QOdLziieeAbE0G2NChG/mfMwkqplV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344262; c=relaxed/simple;
	bh=BE3+Mc/pI2mxEUpR5V2UrmHy317CKy34ZoYYunBC5yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPGquPG8wjIq84kPe7LlalGZcT+JOadkzzFtsJQ774M3AWgk9KTMvtYxeiPLujVRbXL+Q0Rzp/tLz4IUBLFD4+R413LB2bqK8lb6nNB+KZ4dFyhF0pIGwcIuUSeKFwCo23MKW732n6qfnpG67VgMOdd3hd7+HUjDpeX2tOy1Eak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBZjmgrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD028C4CEF6;
	Sat, 12 Jul 2025 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344261;
	bh=BE3+Mc/pI2mxEUpR5V2UrmHy317CKy34ZoYYunBC5yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBZjmgrQZDbTi4SlTvWsSu3l7XWpLJ+oAJ3nclM3nKvGowcBQJDzFQu3lTrTTH4cm
	 JmmwRMjeNqJobeamE/33DCRggnLprmGRHnNqlrqaelMBxZy+o/Xcr5EhEUmijYaUaQ
	 YJwQlq0nUg6FE+pNT5L7A6xsJCBrlFZKuMTE+mZITeZzHCTp4SafkEvLJoXwSkBhcW
	 hReZ/CCkh1NFm3ngMxX09FPQ+IfY5Gv0KALsJCnoUHnZ0wWUE7oI/9Bwal9a4WvJ9F
	 Uw66IjjRFcLJSEkKy96UkgJE1aKo3hoOjXTL7g9me0XtKTE3Ut2HGXMoB0Met8290q
	 PmKkY/T8srxFw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Michael C. Pratt" <mcpratt@pm.me>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
Date: Sat, 12 Jul 2025 19:17:26 +0100
Message-ID: <20250712181729.6495-2-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181729.6495-1-srini@kernel.org>
References: <20250712181729.6495-1-srini@kernel.org>
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
Cc: stable@vger.kernel.org # 6.12.x
Cc: stable@vger.kernel.org # 6.6.x: f4cf4e5: Revert "nvmem: add new config option"
Cc: stable@vger.kernel.org # 6.6.x: 7f38b70: of: device: Export of_device_make_bus_id()
Cc: stable@vger.kernel.org # 6.6.x: 4a1a402: nvmem: Move of_nvmem_layout_get_container() in another header
Cc: stable@vger.kernel.org # 6.6.x: fc29fd8: nvmem: core: Rework layouts to become regular devices
Cc: stable@vger.kernel.org # 6.6.x: 0331c61: nvmem: core: Expose cells through sysfs
Cc: stable@vger.kernel.org # 6.6.x: 401df0d: nvmem: layouts: refactor .add_cells() callback arguments
Cc: stable@vger.kernel.org # 6.6.x: 6d0ca4a: nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
Cc: stable@vger.kernel.org # 6.6.x: 5f15811: nvmem: layouts: add U-Boot env layout
Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
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


