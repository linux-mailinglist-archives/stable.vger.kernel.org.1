Return-Path: <stable+bounces-178094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87998B47D3A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D3D189C53A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB229B8E6;
	Sun,  7 Sep 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzoCr1jB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149331CDFAC;
	Sun,  7 Sep 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275745; cv=none; b=Dbte+KrdoFK1KZ1skcGGACQ14rjPc87CMHVt44ReLjQx048tcUoqw8H3YiM+TkfJ6L5+rt3HHYtAhiXxYVfhJu8en4sTYBdbKcvRSTF9pNqPPE0es4yC25g7GmrZrTjt223s6zSlqF+jfwEoTzlP4TvIVDTcA27rhWnpwrH8pAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275745; c=relaxed/simple;
	bh=56cu44JGjPA8duBtdXInYZ9hGBXa6ijyPqDH6U9HMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzAhnvLP06WiHcpxCLI3qNXtF+t2vetBVViKF9Bsll39CWE317ySTjFZlEaltw63Fe6bQQLsJ4On5tSy0RbDg8f4kffgIFWjjj3BSlY/lt1h1ewypXynaXFHTXNfjVwFCgeJdEq27DGOIllYlmOzDvmSAEdfRdGag45jK+JZODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzoCr1jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C3C4CEF0;
	Sun,  7 Sep 2025 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275744;
	bh=56cu44JGjPA8duBtdXInYZ9hGBXa6ijyPqDH6U9HMUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzoCr1jBPZUrRnrsIv4jx5z872ViPjMSFZXxmFAM/OY9I9+qGMAgP4qbWlMGSSSqg
	 b1gb/Z0OPHJUH2TsWCFhQhsvzZq/EF8xd/44H/11xlLb0/W1wRZi3P745gb09EwRSt
	 xSp2/7pBL8P+gRCF0gTCfeVA1Kfttx8VftgRyPeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Smirnov <r.smirnov@omp.ru>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 51/52] cifs: fix integer overflow in match_server()
Date: Sun,  7 Sep 2025 21:58:11 +0200
Message-ID: <20250907195603.434307860@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
References: <20250907195601.957051083@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 2510859475d7f46ed7940db0853f3342bf1b65ee ]

The echo_interval is not limited in any way during mounting,
which makes it possible to write a large number to it. This can
cause an overflow when multiplying ctx->echo_interval by HZ in
match_server().

Add constraints for echo_interval to smb3_fs_context_parse_param().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: adfeb3e00e8e1 ("cifs: Make echo interval tunable")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Adapted to older CIFS filesystem structure and mount option parsing ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/connect.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1915,6 +1915,11 @@ cifs_parse_mount_options(const char *mou
 					 __func__);
 				goto cifs_parse_mount_err;
 			}
+			if (option < SMB_ECHO_INTERVAL_MIN ||
+			    option > SMB_ECHO_INTERVAL_MAX) {
+				cifs_dbg(VFS, "echo interval is out of bounds\n");
+				goto cifs_parse_mount_err;
+			}
 			vol->echo_interval = option;
 			break;
 		case Opt_snapshot:



