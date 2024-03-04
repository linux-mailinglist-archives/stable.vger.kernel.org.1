Return-Path: <stable+bounces-25994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5A870C8B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B0B1C24498
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8761B1F95E;
	Mon,  4 Mar 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sL7kjW4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459131EB5A;
	Mon,  4 Mar 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587568; cv=none; b=erP52R8zQ4S5qwswfu3pdygBsB6aAB8ylPLFFn4sELSJ+Ym4NRAvO7zP9GXOLpnRftNAY9RRik8IxM0K32Ha9yIyotgTafD1Wnl0bpuviJsxcKQiIK2igy9jMuDxMd0XDPSI4slUl4aHgQ3/hg98QXx/3M5KSltyoxeI0/pQlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587568; c=relaxed/simple;
	bh=Rci4oVS/7YND/9TXr87Arohehk9mx4eD9D7vGQ8IdOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjOFX9voUT61VFH6cq5N7SqEheD4EyYTTj/bvmOuh2YssAohf4rAHKKFGY3bcfO+7Efd0EsIBiN4njjWYffqn9JImUpApCSu3sso1waXMY8n23G8FovRnqOUZ2MLLxaNPNyCRbpLKfsvishwqsPXs72hldNSWPAIhxKNlaeHtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sL7kjW4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EBFC433C7;
	Mon,  4 Mar 2024 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587567;
	bh=Rci4oVS/7YND/9TXr87Arohehk9mx4eD9D7vGQ8IdOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sL7kjW4YQGiDvBhS8RzxDpsLceQsG5pFvXKV7rJCagZrtDPd+uVu/dOUbNjPMxLXi
	 PPSyxG1MM+3kp6+qxSo35oTUT8scmcpP1MBMG7jQz1ohF3WPnzuZExzaEbS7ahV8sH
	 sonC7uaKKkcz71DNOrWQ/P8A4MmVLycYtZCqJ510=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/16] efi/capsule-loader: fix incorrect allocation size
Date: Mon,  4 Mar 2024 21:23:29 +0000
Message-ID: <20240304211534.642225749@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
References: <20240304211534.328737119@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fccfa646ef3628097d59f7d9c1a3e84d4b6bb45e ]

gcc-14 notices that the allocation with sizeof(void) on 32-bit architectures
is not enough for a 64-bit phys_addr_t:

drivers/firmware/efi/capsule-loader.c: In function 'efi_capsule_open':
drivers/firmware/efi/capsule-loader.c:295:24: error: allocation of insufficient size '4' for type 'phys_addr_t' {aka 'long long unsigned int'} with size '8' [-Werror=alloc-size]
  295 |         cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
      |                        ^

Use the correct type instead here.

Fixes: f24c4d478013 ("efi/capsule-loader: Reinstate virtual capsule mapping")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 94aae1e67c996..43fefab755242 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -293,7 +293,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
-- 
2.43.0




