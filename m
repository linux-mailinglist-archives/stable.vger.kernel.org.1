Return-Path: <stable+bounces-169229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D8B238E0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4304A1BC1B33
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F282D5A10;
	Tue, 12 Aug 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9ZJ7EFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E029BD9D;
	Tue, 12 Aug 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026813; cv=none; b=pHz4qWa3r71we8zdQLqo2dd7kYY0qxP4/h+C1YcjVl7et4XKqzjheoAz44C3V7apd3ZkIoMygoCjs8CoUc7u9/tgnhLWSvr7E1N08BplMBHUQ/Zl93pMWZ5+MQZYqSe4mMmI5Gqg6SbtqQLkOk5YA+DWeg7tIFwahPakqfVqdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026813; c=relaxed/simple;
	bh=f0YYuxN8kBxeAKAjDwfzG+Oj1HcGaj3bTaeLb8y00S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6qWVAUePAlYeilMgi4d7fR6UqRs/n9eLwvWJdhHhaYfsqYnVvcxIVU8DAXawkmR9qenEtp569Er0XOwzpkqEH7PduzgBkH44/4Iz4+NMbTn92t8tPMmPUFuAIViXKF1jS2UvpIEx2nE8qXY/48m1P4YcdHrKdIIs0UmLdf72d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9ZJ7EFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D86C4CEF0;
	Tue, 12 Aug 2025 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026813;
	bh=f0YYuxN8kBxeAKAjDwfzG+Oj1HcGaj3bTaeLb8y00S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9ZJ7EFFb0rG8QPagz29dg8J7ghHX7b6hxwBZ7BR9UVsxSeoLi3W8OdVVtr0YvNOu
	 lFx6hn//SU59QtuzaGm2MZ37k3pU3fp3SIF6ohfaaaH8+CnHKaEkO4IBDwoCWX99DV
	 sNmGRdljz11tb7tPnxefEg8P2NjxiX80mbomrxx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	Ralph Boehme <slow@samba.org>,
	David Howells <dhowells@redhat.com>,
	Matthew Richardson <m.richardson@ed.ac.uk>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 449/480] smb: client: default to nonativesocket under POSIX mounts
Date: Tue, 12 Aug 2025 19:50:57 +0200
Message-ID: <20250812174415.921690062@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.org>

commit 6b445309eec2bc0594f3e24c7777aeef891d386e upstream.

SMB3.1.1 POSIX mounts require sockets to be created with NFS reparse
points.

Cc: linux-cifs@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Reported-by: Matthew Richardson <m.richardson@ed.ac.uk>
Closes: https://marc.info/?i=1124e7cd-6a46-40a6-9f44-b7664a66654b@ed.ac.uk
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/fs_context.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1674,6 +1674,7 @@ static int smb3_fs_context_parse_param(s
 				pr_warn_once("conflicting posix mount options specified\n");
 			ctx->linux_ext = 1;
 			ctx->no_linux_ext = 0;
+			ctx->nonativesocket = 1; /* POSIX mounts use NFS style reparse points */
 		}
 		break;
 	case Opt_nocase:



