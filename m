Return-Path: <stable+bounces-39503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13D8A51E4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA501C22645
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651F74BE2;
	Mon, 15 Apr 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipJ31KkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA476044
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188321; cv=none; b=OFUtqJmqXqiZBha/TrUlQA4qB5HtjZWsxD/oBcELm/OhVJoAGM4iK/P5pu3/HqrdAg8Y/bBkqlL0VD9abHm9EMAVzESpHhJKRbTT9+7mLoWVLoylz15eMdDDPcHxbwo1kiSsSY2AA2FdOWJBMp+5QXOXMsU9X9I1P+7dhyqoKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188321; c=relaxed/simple;
	bh=H+ZQ6uKxbKtFPR1ybo2MEY5KeVPcwaSarNm9OpRdx7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYeNnJlKeUVviOFT6PH2B70fVi2cu0M4J+z5Wr3aNHwhz6Rd03VobJeq2dE0NoCM1nrCqJQ4/1VMKosNLwXXA9WsM2MMC5A0IKa4puOi+SOEmSbtNv4RUdfkCKsrDeuUWTZvCEpBygU27VwynBkWeJGl4qIsQD8MQcr/t9i1uXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipJ31KkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1286C2BD10;
	Mon, 15 Apr 2024 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188320;
	bh=H+ZQ6uKxbKtFPR1ybo2MEY5KeVPcwaSarNm9OpRdx7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipJ31KkCjEKXX8gx48O5eAgfXQD2HI40Yvvwo6eItYsNzZuGZLgYEEWhASPFJlZCZ
	 xqSEWNVK4Y7LC2i/OplOH1qHiu3mJSXrR+V5zX0iceNnuF5cbK1IvDJXpCK7+ZkMyk
	 KBkb1jRNS5tHshIxRaqBHHLNkO7sizAespoDPuJDX16SeUfPouACOmODOphdvb351I
	 eLQ/xUj7jV6qt+2tLskCjtHUME7bLoTfTOOXDmDtoF7NejHHU6p7EtMMgflswW+h60
	 eH8Jlr2YgsKvZ2G5Ud0F9B53NrPtBMYBiIr4vRaYCEtZVET+t4B/0qaLyeHYzs5eDO
	 eDfMz780GmUTA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Steve French <stfrench@microsoft.com>,
	David Howells <dhowells@redhat.com>,
	Micah Veilleux <micah.veilleux@iba-group.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 022/190] smb3: fix touch -h of symlink
Date: Mon, 15 Apr 2024 06:49:12 -0400
Message-ID: <20240415105208.3137874-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 475efd9808a3094944a56240b2711349e433fb66 ]

For example:
      touch -h -t 02011200 testfile
where testfile is a symlink would not change the timestamp, but
      touch -t 02011200 testfile
does work to change the timestamp of the target

Suggested-by: David Howells <dhowells@redhat.com>
Reported-by: Micah Veilleux <micah.veilleux@iba-group.com>
Closes: https://bugzilla.samba.org/show_bug.cgi?id=14476
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 1d3f98572068f..c676d916b4b6d 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -924,6 +924,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
-- 
2.43.0


