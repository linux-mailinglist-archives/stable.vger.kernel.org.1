Return-Path: <stable+bounces-131413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4300A809C9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3021722DF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16ED269D04;
	Tue,  8 Apr 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ahRoCmfl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D424269B0D;
	Tue,  8 Apr 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116329; cv=none; b=aXdf4OQMTb5AOi9nZTB+RR6zyNyzE0BbZ11USJ2rDq2fm5gIz+gMY4xM6nACrx1b8SKIFhI5MegSIrgiJHsWddntq403znoBQ9JAlZwaZ/QOuYtVY+BXEN1BwxiG1Xc+4RzkkIHsfGcivdi2hnCSvRwogfRRC3LmepEUTAVIsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116329; c=relaxed/simple;
	bh=dgJz5Cb8sBhLblj9Su8xPu2IQfcsMBG5iAB/0Yd/d50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFMu5Ib4fRzG+KRklAck/1nOkMccFrnePr/wK7Zlg81k1MrXLQhVdXRskBXgjmi7qaqY/IfSxxAQY/FAeAtgjmExBVfig+I9lGzGvqaAgT7lSTL40JdVMiW30W0qPryqrYLtnET1awfX61/wT5QOy45SS/0bA8iBFyqZ7YajSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ahRoCmfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C694C4CEE5;
	Tue,  8 Apr 2025 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116329;
	bh=dgJz5Cb8sBhLblj9Su8xPu2IQfcsMBG5iAB/0Yd/d50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahRoCmflSFK7GBoeg6x3ow6Gv7aTUOKRIAy5rj37cOWlvHg5MXNggY523ldiiUXq4
	 n0VElAFSUeQFTA9f97R+3Z+LZcWVmYQ7b3L22VyKrQYg3W8OHIvpDuKzM7XyAVzysH
	 aXRRj7NJdRwmWPz1ZiHL6ZKkIUklyjYPphkX8C2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 101/423] crypto: bpf - Add MODULE_DESCRIPTION for skcipher
Date: Tue,  8 Apr 2025 12:47:07 +0200
Message-ID: <20250408104848.087401907@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit f307c87ea06c64b87fcd3221a682cd713cde51e9 ]

All modules should have a description, building with extra warnings
enabled prints this outfor the for bpf_crypto_skcipher module:

WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/bpf_crypto_skcipher.o

Add a description line.

Fixes: fda4f71282b2 ("bpf: crypto: add skcipher to bpf crypto")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/bpf_crypto_skcipher.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
index b5e657415770a..a88798d3e8c87 100644
--- a/crypto/bpf_crypto_skcipher.c
+++ b/crypto/bpf_crypto_skcipher.c
@@ -80,3 +80,4 @@ static void __exit bpf_crypto_skcipher_exit(void)
 module_init(bpf_crypto_skcipher_init);
 module_exit(bpf_crypto_skcipher_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Symmetric key cipher support for BPF");
-- 
2.39.5




