Return-Path: <stable+bounces-44123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663A8C515D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87251C2153F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C40135A59;
	Tue, 14 May 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IP2LdFu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7E134CDC;
	Tue, 14 May 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684363; cv=none; b=gbR4hagviPOb0HAboq8ImUhdt2bCtQ3pjOFXJnmS4UmMxQNJ1HQXoegjS9gYDmzEGjiRL95Zfcp/VnHHiIIPaLdFNachedqd1o74Bfnp0ouAc8BoOEKVOc0ONE+jEtZFISapYGXiIS8BmqkC0TcLbZckNdtw5QcZQAvOAiifqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684363; c=relaxed/simple;
	bh=0APbemlYbSMTI82P+wf7CCDDW+AP/UnQaLkQxGa/hj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkyR81aKVUS6dBhe9mp06GDJ+AZfzy1KS6jYWp4BuWgWZsXmZby0XUrxIsD5fxxaNYzGWRp9uZNIyrb4SBquQg52owlJ6iK+8obA6l9y/2ao3PDI+jbbP1XVCeoqZf1zyeSe1hCOGPNqBZbQOPWg4uVG/CrcwczjEs3OYXwQQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IP2LdFu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5ECC2BD10;
	Tue, 14 May 2024 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684363;
	bh=0APbemlYbSMTI82P+wf7CCDDW+AP/UnQaLkQxGa/hj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IP2LdFu+wG8xtNXETqYxQz6BdoNL0u5kWX2ATiGA7P6NEVTloNSpT4LMfknx4ewlg
	 2Jx0gp6454sqHqKyqMxUbSDwrALXShd4bTSt4cnKd05X0vQhfJOozQtVwXQwEcnHka
	 bRYnwVnI5GGcsF/FuqGKftfcSohLI3zXH80bjlks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/301] rust: kernel: require `Send` for `Module` implementations
Date: Tue, 14 May 2024 12:14:39 +0200
Message-ID: <20240514101032.545902428@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Wedson Almeida Filho <walmeida@microsoft.com>

[ Upstream commit 323617f649c0966ad5e741e47e27e06d3a680d8f ]

The thread that calls the module initialisation code when a module is
loaded is not guaranteed [in fact, it is unlikely] to be the same one
that calls the module cleanup code on module unload, therefore, `Module`
implementations must be `Send` to account for them moving from one
thread to another implicitly.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org # 6.8.x: df70d04d5697: rust: phy: implement `Send` for `Registration`
Cc: stable@vger.kernel.org
Fixes: 247b365dc8dc ("rust: add `kernel` crate")
Link: https://lore.kernel.org/r/20240328195457.225001-3-wedsonaf@gmail.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e8811700239aa..de54d5fede6f8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -60,7 +60,7 @@
 /// The top level entrypoint to implementing a kernel module.
 ///
 /// For any teardown or cleanup operations, your type may implement [`Drop`].
-pub trait Module: Sized + Sync {
+pub trait Module: Sized + Sync + Send {
     /// Called at module initialization time.
     ///
     /// Use this method to perform whatever setup or registration your module
-- 
2.43.0




