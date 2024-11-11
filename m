Return-Path: <stable+bounces-92141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5B9C4125
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBF3282784
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054C1A073F;
	Mon, 11 Nov 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7hHkCCo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C81A08B2
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336047; cv=none; b=aFPhOFS0fy3P9kX4x5uCbPrDTuqeNUjiLuVZFz7DgbT72oyd0MF0J7bohrHqBCIE2+TTTw2DzdUrsilHfI6NMyWYGfwIwG5avBKFdgVfDD55dxyr7XH9dW32GtaGHPUpxzSV/6m8YTI5HmSzHkF+F0S9CqWZVJoAvojN/X8ogOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336047; c=relaxed/simple;
	bh=YRfx2RwrY/GC6eMboeKeX+qKO85k9ZGQ0LJty+vQBuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giaqklRG33psfB9cGIPo7lIxncJ8HmDQSyHZJCmTKlPnBF5ULCmHEXaAmvs3x8uji3xiWXzIEjX1fFU5OOSqxENzAq8FZzg5wWPAVlWz1UGyC5hqBlhMEaLHYt3VZY358bLyynkGYQRECv3aLWcCkEKSQ1D6KJazHeaytggLNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7hHkCCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB8C4CED5;
	Mon, 11 Nov 2024 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336046;
	bh=YRfx2RwrY/GC6eMboeKeX+qKO85k9ZGQ0LJty+vQBuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7hHkCCof2OBBCjWD3813BowggFzA6RpZnTuEigmj4Eroi8WHLdPCu5DDyTExTV3Y
	 KVc+fORDe42XS1VSOPYsJUVMsqkkWq/iyfTQpS0iTI8rlXZPqiEU4BUiQAeQWRrW+q
	 upHBKNud0qWd3II7I8bvTNC2MjsHkH4igCWtcsE2n9TClfVyN/0FrjtuzI6UIfbmNo
	 CjmcRa3vrsPEor1h3XVtqRf2LrJEzufib4eWZJzfT91usElW9uEw0+U9jDCvx9oew/
	 /SSKZKVdkrJIM4yuJfNIO05AV6RJo4e6m9KgTUh6anu9XBj8fqWyJ9GSb7ixV6zKWA
	 sCqmIeFJYvXKQ==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: nathan@kernel.org,
	naresh.kamboju@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15] ACPI: PRM: Clean up guid type in struct prm_handler_info
Date: Mon, 11 Nov 2024 07:37:32 -0700
Message-ID: <20241111143730.845068-3-nathan@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com>
References: <CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 3d1c651272cf1df8aac7d9b6d92d836d27bed50f upstream.

Clang 19 prints a warning when we pass &th->guid to efi_pa_va_lookup():

drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Werror,-Walign-mismatch]
  156 |                         (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
      |                                                  ^

The problem is that efi_pa_va_lookup() takes a efi_guid_t and &th->guid
is a regular guid_t.  The difference between the two types is the
alignment.  efi_guid_t is a typedef.

	typedef guid_t efi_guid_t __aligned(__alignof__(u32));

It's possible that this a bug in Clang 19.  Even though the alignment of
&th->guid is not explicitly specified, it will still end up being aligned
at 4 or 8 bytes.

Anyway, as Ard points out, it's cleaner to change guid to efi_guid_t type
and that also makes the warning go away.

Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[nathan: Fix conflicts due to lack of e38abdab441c]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This resolves the warning that Naresh reported, which breaks the build
with CONFIG_WERROR=y:

https://lore.kernel.org/CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com/
https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2ogNnyGv40aCb0Jqybv8RlPt3S7/build.log
---
 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 63ead3f1d294..890c74c52beb 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -52,7 +52,7 @@ struct prm_context_buffer {
 static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
-	guid_t guid;
+	efi_guid_t guid;
 	void *handler_addr;
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;

base-commit: 3c17fc4839052076b9f27f22551d0d0bd8557822
-- 
2.47.0


