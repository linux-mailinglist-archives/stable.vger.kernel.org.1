Return-Path: <stable+bounces-136000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24BA99181
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1686F5A6EE8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1E28CF4E;
	Wed, 23 Apr 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oo1/SXew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4227CCD7;
	Wed, 23 Apr 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421394; cv=none; b=d313QY+W66DJYyJAx2tmq5GQNFil4jPRQzyCcDPmzO8UwY68/LXXcI72X8xUj9+SFH8Z/CJqMMK8VMBhMW7vWHKr9lOl59rDtboq42yqzwZIKbL1VzQy4AwnL7Ll3/zE6PAdzu/zHFd+V58fRXMMkW4RMrUCOiYS4JUuYW1AALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421394; c=relaxed/simple;
	bh=b4drVkd+REZw4O3czmgVmvu4utSydbhw5ocNqcPx44c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqDnT3zYvoFHvi8zVPWbnHKwd4VOb/9YvUCnPW99+V+DOps8vikT7le1QrwgU4UsNYH1U7IYFj/nb7MOGN+wILFfJRwFLEN/mgKl97T0oKGxKXJqMPAwvvCI8SZ0sY8fwVgX2g1Fv+CCO09d244nsZRV19iIk42h7lf/VoRmAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oo1/SXew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B5DC4CEE2;
	Wed, 23 Apr 2025 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421394;
	bh=b4drVkd+REZw4O3czmgVmvu4utSydbhw5ocNqcPx44c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo1/SXew7/JKj74zLvU6edErAaobuqi/kIzLAF4yyDU923GNeeF7+inO/APOIzGYE
	 J1Do9zBwR1a3HOqbwGgpuafbkSHys3Dq/3dmymqj3q12rOh4jVqpCJgLM5xLDYQ4xW
	 2mRmiGlmySPXCc4oEap8xjpH6MvkhduupGe8TG/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH 6.12 202/223] efi/libstub: Bump up EFI_MMAP_NR_SLACK_SLOTS to 32
Date: Wed, 23 Apr 2025 16:44:34 +0200
Message-ID: <20250423142625.398477069@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

commit ec4696925da6b9baec38345184403ce9e29a2e48 upstream.

Recent platforms require more slack slots than the current value of
EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
workaround is to append `efi=disable_early_pci_dma` to the kernel's
cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
platforms to boot with the aforementioned workaround.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Allen Pais <apais@linux.microsoft.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/efistub.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo
  * the EFI memory map. Other related structures, e.g. x86 e820ext, need
  * to factor in this headroom requirement as well.
  */
-#define EFI_MMAP_NR_SLACK_SLOTS	8
+#define EFI_MMAP_NR_SLACK_SLOTS	32
 
 typedef struct efi_generic_dev_path efi_device_path_protocol_t;
 



