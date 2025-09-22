Return-Path: <stable+bounces-181329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78CCB930DD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8683B24A1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117D2F3613;
	Mon, 22 Sep 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GCXE6pBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6232F0C5C;
	Mon, 22 Sep 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570268; cv=none; b=Buur76e77j+5190Hw+1+kyJonj2r+9Nnf98QPgl/FNAu6c++2O63zdFXEIoKbGg+94V2eF4qZ6YN1uJSmemmLLROkGWrZdFuDyjGkBiCr152BzemrMQrpXXG5E0pTYKrMsKGanZSJYV2ZZLZQQnvgH1efUFV5RpZFxnc2ZJOtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570268; c=relaxed/simple;
	bh=dqm8mTLKy0hHx396k0WhDMTnm09pfi5zSiRvN77ImN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/bIWa3TKjwdmgn+OLqOsippfC7xmFDzwoHpFldPdjw3amiKTPDMyMDBDyUsh/df+WgfjPH0TFKJ2+xpEj+RR9AkIM2sTlAprp+zJEBZIuifjyzrXwdtdgNjgkvODewrn93iSVEB/YtvbSKxeFMb9mLgI79E0SUT1fXDY2VL6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GCXE6pBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69D4C4CEF0;
	Mon, 22 Sep 2025 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570267;
	bh=dqm8mTLKy0hHx396k0WhDMTnm09pfi5zSiRvN77ImN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCXE6pBdXMkc86RwddAqNWnhB7rfodwXt9Rn05DX7A/vgfoqDM/OtVTyC5zZtawvk
	 yO0TPsNZ725Oq68KQF/SszgmotzO+IzeRIynHCFP56aXUMLLBIEUPpuvyEKyfzYiNY
	 upfH85QHXGqKBE3ue7zhpkNlk2EVuiEC9Zq/N7bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.16 070/149] LoongArch: Check the return value when creating kobj
Date: Mon, 22 Sep 2025 21:29:30 +0200
Message-ID: <20250922192414.655407150@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Cui <cuitao@kylinos.cn>

commit 51adb03e6b865c0c6790f29659ff52d56742de2e upstream.

Add a check for the return value of kobject_create_and_add(), to ensure
that the kobj allocation succeeds for later use.

Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/env.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -109,6 +109,8 @@ static int __init boardinfo_init(void)
 	struct kobject *loongson_kobj;
 
 	loongson_kobj = kobject_create_and_add("loongson", firmware_kobj);
+	if (!loongson_kobj)
+		return -ENOMEM;
 
 	return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
 }



