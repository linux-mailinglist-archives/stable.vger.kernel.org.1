Return-Path: <stable+bounces-157863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CAAE55FD
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7E4C6BEC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151C22A80D;
	Mon, 23 Jun 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WO6CkxVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01792236EF;
	Mon, 23 Jun 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716904; cv=none; b=cTkfJYTpWI0oRryI9mrC4pjSm0UcaLwG2fyEv6rDd5H9i/ncE54yHA+qqyS/Snq/iGmRrvSkE551KNzO7Iar5VJY9UoT8EXDlX0Ur0USIvd/9vSVOjl8z4D3QhXhrYD9HxAGkIK/qX9CgzlQdUrjx8/mq+Gd4x077jXTY7mp6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716904; c=relaxed/simple;
	bh=okGVvH/UnwSQggs31Pmj9KZF5YWaeWkITmpKZt4RCd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNRF8f5gkailwQpBM+YFySOYfJ4VO9tgW+qsxWqYa7j/6VyPkk+uGv+WdrygtgnFTNkZsLxskf7piAHdt1pjtgkkl0D5QXULpBWO7TeUbm6kkRw5m6biI2vvAhYxHbEtdw/RSLk10S8i2vlCsSAeYB3CoO1wQESVx0hXum8m7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WO6CkxVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865F6C4CEEA;
	Mon, 23 Jun 2025 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716903;
	bh=okGVvH/UnwSQggs31Pmj9KZF5YWaeWkITmpKZt4RCd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WO6CkxVhzmuTPoi6i+/NNrc5LXvJzrPLU4+3KguveoXGj55cm9AZ2hvq3TOb3TDMr
	 iHElquzGI1Kob8Qenpr/2MGuvYpDGv1+w6aakCCA+LfndnKF7u62aDF7E/IO9Ku8Uf
	 HlpHytzAIvD73TUngQlJ+LH7KCBWTE1NxlktxlUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.15 567/592] rust: devres: fix doctest build under `!CONFIG_PCI`
Date: Mon, 23 Jun 2025 15:08:45 +0200
Message-ID: <20250623130713.929070950@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 42055939a3a4cac8afbebff85a29571c2bd3238c upstream.

The doctest requires `CONFIG_PCI`:

    error[E0432]: unresolved import `kernel::pci`
        --> rust/doctests_kernel_generated.rs:2689:44
         |
    2689 | use kernel::{device::Core, devres::Devres, pci};
         |                                            ^^^ no `pci` in the root
         |
    note: found an item that was configured out
        --> rust/kernel/lib.rs:96:9
    note: the item is gated here
        --> rust/kernel/lib.rs:95:1

Thus conditionally compile it (which still checks the syntax).

Fixes: f301cb978c06 ("rust: devres: implement Devres::access()")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20250511182533.1016163-1-ojeda@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/devres.rs |    1 +
 1 file changed, 1 insertion(+)

--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -208,6 +208,7 @@ impl<T> Devres<T> {
     /// # Example
     ///
     /// ```no_run
+    /// # #![cfg(CONFIG_PCI)]
     /// # use kernel::{device::Core, devres::Devres, pci};
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {



