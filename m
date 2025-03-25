Return-Path: <stable+bounces-126352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD04A6FFE8
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EE37A6D9A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01967254B1B;
	Tue, 25 Mar 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p6/y/un9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42751531C5;
	Tue, 25 Mar 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906064; cv=none; b=L74tCbz6bEQXq9qOZmu6+ZrOrFSskd06J2ab57ZWX49BvnRCENp/ABEs8lNkK7ql9IMrQzDHG/zn/5AxoVtVeXDTPgwOzrNhhsQmdnw43non9k58GQf16fHaUxLP86voraiALrDkKCalUFUWHtNB2WyBFfKjkz8wQRBeSEU7Yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906064; c=relaxed/simple;
	bh=WqLnjLf8k9kX4C9U9I700WPOmp2lWtYG2D/1eBIJA5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5iR0OxGm6z6HoWHlWzPvS34OG1LQ9QNS8s8bXz+d5zQkXoZrztzZhgpBYE1bqiK9TkbbN11D8TSoRiTXh9ibJIHDGr+y7ltRH/LNWfWhYj8tJYTzXRv3qUyTbIRtvrtRQUz9ueZXbU9patvzvVkpoBY9GyovoF75aSRBjuiRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6/y/un9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FD6C4CEE4;
	Tue, 25 Mar 2025 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906064;
	bh=WqLnjLf8k9kX4C9U9I700WPOmp2lWtYG2D/1eBIJA5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6/y/un9Mk9uyrKSM44QxHy9uTkX/7GeqU2H7W7lT6BWwkKBNMi7uhXBIBAHvYGbE
	 4Quv9a0vaL4uaCmTyVkpqTiMsuL/OIEjrH4VNfmDowuT6q0old9F7Js9vPVwxO32PK
	 97hR+bQ3CpghcrjwR3a0OOPsEflOkj4IJNyVo8Ys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Schneider <ben@bens.haus>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.13 088/119] efi/libstub: Avoid physical address 0x0 when doing random allocation
Date: Tue, 25 Mar 2025 08:22:26 -0400
Message-ID: <20250325122151.308241124@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit cb16dfed0093217a68c0faa9394fa5823927e04c upstream.

Ben reports spurious EFI zboot failures on a system where physical RAM
starts at 0x0. When doing random memory allocation from the EFI stub on
such a platform, a random seed of 0x0 (which means no entropy source is
available) will result in the allocation to be placed at address 0x0 if
sufficient space is available.

When this allocation is subsequently passed on to the decompression
code, the 0x0 address is mistaken for NULL and the code complains and
gives up.

So avoid address 0x0 when doing random allocation, and set the minimum
address to the minimum alignment.

Cc: <stable@vger.kernel.org>
Reported-by: Ben Schneider <ben@bens.haus>
Tested-by: Ben Schneider <ben@bens.haus>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/randomalloc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -75,6 +75,10 @@ efi_status_t efi_random_alloc(unsigned l
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	/* Avoid address 0x0, as it can be mistaken for NULL */
+	if (alloc_min == 0)
+		alloc_min = align;
+
 	size = round_up(size, EFI_ALLOC_ALIGN);
 
 	/* count the suitable slots in each memory map entry */



