Return-Path: <stable+bounces-148991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5AACAF9D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A31BA27E8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E17222596;
	Mon,  2 Jun 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbueSHGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129D221F11;
	Mon,  2 Jun 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872184; cv=none; b=k7+gB/1Ki/LCW7B2EEppzLF9L7j38U4lF1Ap8m31oEviTC8Oftns/ROeMEbT8+X80rSU9yPjPb9cdU1MS01kzgLkc5NiHSGCVA78iJdqpp4ob+yeA9jR8vlhfKLTSK66hmHUV53f3izDj/0tKsbP49KJBUrL0VRatrmf2X0czUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872184; c=relaxed/simple;
	bh=I2+pVva3sk3zU2O8FRyvLYvEwH/MRxMN674JnVGKw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkM2xPkRaf6HDE2SJ+ZMRM9lQ44u89nlvmEPOQ8ETn6Ezpg42DxC1MqILu9lzHmPow33beEP1nM5wY8cutOg5x877KWUNYiCaX1+vesQa8PcsT4Kzgk1m2rzwXxzzuqOnjCFSUq0tzWtHjI000A+u2W45+VUHhSHNMK0DEWSvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vbueSHGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2355C4CEEB;
	Mon,  2 Jun 2025 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872184;
	bh=I2+pVva3sk3zU2O8FRyvLYvEwH/MRxMN674JnVGKw5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vbueSHGox1I4Gmq97KTt3fYKaBOT/fGAp4UZKYNhZ0g8CIM1JWF6TkXTPL6ay+bPi
	 3XDJgyDeaejbGnlSzY/EmcRndyfT6Rh2BDmGSKCPYa4j7miidgC8ZPX2Gx5Jczvfj2
	 sA06LgoQhxPHOL4KgcvH7NR9KojPh/qsr6DrNUic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.15 45/49] pidfs: move O_RDWR into pidfs_alloc_file()
Date: Mon,  2 Jun 2025 15:47:37 +0200
Message-ID: <20250602134239.710508332@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
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

From: Christian Brauner <brauner@kernel.org>

commit c57f07b235871c9e5bffaccd458dca2d9a62b164 upstream.

Since all pidfds must be O_RDWR currently enfore that directly in the
file allocation function itself instead of letting callers specify it.

Link: https://lore.kernel.org/20250414-work-coredump-v2-1-685bf231f828@kernel.org
Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/pidfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -888,6 +888,7 @@ struct file *pidfs_alloc_file(struct pid
 		return ERR_PTR(-ESRCH);
 
 	flags &= ~PIDFD_CLONE;
+	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))



