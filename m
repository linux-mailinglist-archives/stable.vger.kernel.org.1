Return-Path: <stable+bounces-64481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7192941DFD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BE61C2362E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F61A76BA;
	Tue, 30 Jul 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUMNCNqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336191A76A1;
	Tue, 30 Jul 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360264; cv=none; b=aZhoBS4rc/0gnidK6okeAMk8xZwLxE6gtpsnTAQBHN1jUnjIuS7AfeZA+vPO/yljatMq5mfIi1RTZRrixaJTe8tjxZxRDKn9b8HyQHB9iHxXAQaY2fPeC30o2vgN9IG85GbpsLqPnVOF7M/UB2Mt89avmBHOF2Lvyhnjpiif2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360264; c=relaxed/simple;
	bh=k2/DFrTjZJ+9DevCsAUufBiEwrvV8pgUyx0fmrSzrjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9mMkZAdhTjXcozywFSBliCIB9mBDlPLtNkQhpt4gPZEiqophmuzgcv2k2GyLmP5utyZLlirba4ec0SBB4swnrzMd76KHlhusnLruOtdSUkxCxIhbk6EJutuXBIjriThJolatBkFQahmWqco6RrputfnmA/7Z6Ne7iR+KvuVTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUMNCNqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF44C4AF0E;
	Tue, 30 Jul 2024 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360264;
	bh=k2/DFrTjZJ+9DevCsAUufBiEwrvV8pgUyx0fmrSzrjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUMNCNqTj7Q+yOBwS3rQ7m0MmdoAom0pYf53N3cS6K1U/Y5g012cnbVwXrgzmjIt0
	 b4s+QaT4MLKTYWsVHIN6NmEG77uY1ob9Ohw/R5tJJvWwHTCqG15a0IcuWrJ17GX6kz
	 XQ2BnU0G0blqfuG+R8hdgRZG20daJY0VDsI4TiQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiang Ma <maqianga@uniontech.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.10 646/809] efi/libstub: Zero initialize heap allocated struct screen_info
Date: Tue, 30 Jul 2024 17:48:42 +0200
Message-ID: <20240730151750.385392390@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

commit ee8b8f5d83eb2c9caaebcf633310905ee76856e9 upstream.

After calling uefi interface allocate_pool to apply for memory, we
should clear 0 to prevent the possibility of using random values.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Cc: <stable@vger.kernel.org> # v6.6+
Fixes: 732ea9db9d8a ("efi: libstub: Move screen_info handling to common code")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/screen_info.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/firmware/efi/libstub/screen_info.c
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -32,6 +32,8 @@ struct screen_info *__alloc_screen_info(
 	if (status != EFI_SUCCESS)
 		return NULL;
 
+	memset(si, 0, sizeof(*si));
+
 	status = efi_bs_call(install_configuration_table,
 			     &screen_info_guid, si);
 	if (status == EFI_SUCCESS)



