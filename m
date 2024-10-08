Return-Path: <stable+bounces-82980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832B994FC5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C76E283FC4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2241DF997;
	Tue,  8 Oct 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVifqlZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B91DF27C;
	Tue,  8 Oct 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394077; cv=none; b=K1eNN6AomD+ldIddUly/oyFtDwg8Cgr+IBeYFhS/KO8KHh6Vh1x6LzgZyHYTfNXgGS7VMxxYugVsQbIYnSNU8m5NQWwAmiBI0Eequp/bqkDoYK5BsuSsx40ueE8WuNRd5nfYFmUni+lhKcXD6x67y7r6NKudjmKIBCE9C4ZIJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394077; c=relaxed/simple;
	bh=osPlSNr3ihAUOPbAnilwru6KtBsVL/cfqaOC407tzjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDGba540reZxDPP0Y6hAYJWnZjAokDniHIlazemboHMxssfkfTMsSbJdTGnnQnKNxiHfXtpH84G7smcqjifv2yH/XQv/EJHDW+5ELYQwhSh9uw/MyTRaQI5F7ewaHLH5l3XMIDrUm3mzKutlAlPBAC0RgI6xc9cUmPwxPspjtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVifqlZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5BFC4CEC7;
	Tue,  8 Oct 2024 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394077;
	bh=osPlSNr3ihAUOPbAnilwru6KtBsVL/cfqaOC407tzjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVifqlZDo5BOWjVdMgZob+KGQVWcfjRkm3+cy4gsePW5wBSymvi9vfsvyoUq8dZuq
	 dt1vSruZ8R4J0hDsE+7S9wSQYVP6lnyVOnLnpxxtqIed/MWurffT3fAdr51jQ+r5XC
	 3oPWBpslbbNrsvOkEMQUSO0xMqMIhkAyx22dQ9os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 341/386] build-id: require program headers to be right after ELF header
Date: Tue,  8 Oct 2024 14:09:46 +0200
Message-ID: <20241008115642.801899363@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 961a2851324561caed579764ffbee3db82b32829 ]

Neither ELF spec not ELF loader require program header to be placed right
after ELF header, but build-id code very much assumes such placement:

See

	find_get_page(vma->vm_file->f_mapping, 0);

line and checks against PAGE_SIZE.

Returns errors for now until someone rewrites build-id parser
to be more inline with load_elf_binary().

Link: https://lkml.kernel.org/r/d58bc281-6ca7-467a-9a64-40fa214bd63e@p183
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 905415ff3ffb ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/buildid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0ed..cdc0950f73843 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -73,6 +73,13 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	Elf32_Phdr *phdr;
 	int i;
 
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
+		return -EINVAL;
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
@@ -98,6 +105,13 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	Elf64_Phdr *phdr;
 	int i;
 
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
+		return -EINVAL;
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
-- 
2.43.0




