Return-Path: <stable+bounces-156751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A18AE50FA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85596189D66E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59921B8F6;
	Mon, 23 Jun 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xkiKWH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5351E5B71;
	Mon, 23 Jun 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714178; cv=none; b=ajCtD/CFqPl6TfTihPcd35JMsVgoEtQ8ZrspAC4kxezA+zZ3f9IE2TDY51zWdwWD7+g802sWT5Rs9wUyZ2Ki7Kbgl9jbLN5jSY5eYz0mDh6zRsaBoTsjL/dVOGGQN5DqhSTARiuOTayQewoWmm1biRYsUsOkt6lNBmsCgrmZ9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714178; c=relaxed/simple;
	bh=livlVVHpbnNh2bGGt4U4/YJkApsMCQsE+BfGSts6r1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxJS7hgSg/Hx2PwJHXn9px5saRZP0sbkrziVwzDscqMl0fiNPV4nTIV+tduz+Pkb5ldpRGISKFiMRIKpsIukCeBKGUDSxHhfaYgrizPs54c6RsqxpZRWjokqn0jvRvibekax6ombq1N3tx3WxAm0WCg4KMPHZ7FS14jPBLEdZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xkiKWH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E6CC4CEEA;
	Mon, 23 Jun 2025 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714177;
	bh=livlVVHpbnNh2bGGt4U4/YJkApsMCQsE+BfGSts6r1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0xkiKWH1DdH/F5n1Ml99022uvXeQ9K078MmdObyLwz/XUtP5RFw9J5B0DMEzcWFzK
	 rE6QOY7ogIncsZY6750UIw5wk3gUbXjgENta9S+exNd9wiIjGGIm6Jqz+3OPXRma8v
	 3p/6dVkbjsLqiFduq50SMRKMIen0xbuzFDcx5yUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joel Becker <jlbec@evilplan.org>,
	Breno Leitao <leitao@debian.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 5.15 192/411] configfs: Do not override creating attribute file failure in populate_attrs()
Date: Mon, 23 Jun 2025 15:05:36 +0200
Message-ID: <20250623130638.511510215@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit f830edbae247b89228c3e09294151b21e0dc849c upstream.

populate_attrs() may override failure for creating attribute files
by success for creating subsequent bin attribute files, and have
wrong return value.

Fix by creating bin attribute files under successfully creating
attribute files.

Fixes: 03607ace807b ("configfs: implement binary attributes")
Cc: stable@vger.kernel.org
Reviewed-by: Joel Becker <jlbec@evilplan.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250507-fix_configfs-v3-2-fe2d96de8dc4@quicinc.com
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/configfs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -593,7 +593,7 @@ static int populate_attrs(struct config_
 				break;
 		}
 	}
-	if (t->ct_bin_attrs) {
+	if (!error && t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)



