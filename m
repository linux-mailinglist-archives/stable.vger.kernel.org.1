Return-Path: <stable+bounces-139646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B3AA8EF5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9663AA5EE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42091F2C56;
	Mon,  5 May 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lr2Jw/Gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A916D9C2;
	Mon,  5 May 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436101; cv=none; b=TAuNN7LASFwVU60W2idBtQB4FXEXq1dK1fdXb31tR3FpxT5Dyl03V96QLN6MDe0b4y73x8DlDyO//ZrkSsmzdOX7BOEDBi0ylCv4koo0L3IK+8cogcBhfHYQ2STWhLpj2Me5KXietQPbwnek/a5wMEyfPpVCWFA/1cMAamxOFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436101; c=relaxed/simple;
	bh=z387zGrWvW/H7PuLSVZWU6ftiLZtzOD53K/82vE+tl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rke4FIDe3GuEeQOnBj1gqj7jv8aMrBturfAE9HkmN5gY57MuhelNjSUN5Yvbt0nF9HtTfxcQrLwI/afjzJRm3OYmOsKDdiIk3hlqwtk5Vsu5ayiu5SIDozImINgHtA3fYrfG374X1b3oy4yDUPHSePy7NPofl2X9NdNcdyjghq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lr2Jw/Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09572C4CEE4;
	Mon,  5 May 2025 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746436101;
	bh=z387zGrWvW/H7PuLSVZWU6ftiLZtzOD53K/82vE+tl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lr2Jw/GqMyUjhtX8vbFUC26RZrAHH6dxW38VRECVu0bmNaI3zGUdqK3enO1CrzINX
	 wwpAi3wWpI9raLbe1VBQ9rKzbAweza75ma7noFnA+oPEinN9DUYcVcX7gIL4uRZDgA
	 CPFxrF3wuL8rawircdiQez5E9lDq0eVtllXhKJR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.27
Date: Mon,  5 May 2025 11:08:09 +0200
Message-ID: <2025050518-scuba-quotable-081c@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050518-humorous-tricycle-f8d9@gregkh>
References: <2025050518-humorous-tricycle-f8d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 467d820fa23f..77f5d180902c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 26
+SUBLEVEL = 27
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 56a81df7a9d7..fdad0eb308fe 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -89,5 +89,5 @@ static void __exit fini(void)
 }
 late_initcall(load);
 module_exit(fini);
-MODULE_IMPORT_NS("BPF_INTERNAL");
+MODULE_IMPORT_NS(BPF_INTERNAL);
 MODULE_LICENSE("GPL");

