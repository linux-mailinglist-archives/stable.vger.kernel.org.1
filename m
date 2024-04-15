Return-Path: <stable+bounces-39514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A58A51F1
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7731C2296F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E177580D;
	Mon, 15 Apr 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMX9Yweg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150478C6A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188356; cv=none; b=imeSBgAbT739ExIqBVAA2eqMURzbyl9Km2ap2yQATw+ad/uu+MO99KpTGgN3mEgOEFRbl4WW4kdV7ZgVcKBYSFrPxnRLL5bW2l5HdD7yP4niCkOmJZrgdotSMmVIrObQNp9K47vTzgcYCr7IGjHl2NxDYkZNGcpluutZKbl5YKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188356; c=relaxed/simple;
	bh=bKuuvE5v9pp4wSVBLsyVjlgsF+G53cyTicsZJCcF/JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGaB6Jy0lNpnz1R8mABR6nXTCCfwnDUJQp6z98HjfEt27DWigJwPqr2/Xcl7Ro2pJsAYfsR2ktuq3Z72eSfp8xYE16fZJmTr29j1VmYhRQGytiWFHCtB5LdowVwI1jCwVEDHNf7QqV3RfCUKi4tL1Z38PhVnqi99NNr1om77UHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMX9Yweg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F2C2BD11;
	Mon, 15 Apr 2024 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188356;
	bh=bKuuvE5v9pp4wSVBLsyVjlgsF+G53cyTicsZJCcF/JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMX9YwegWhWSuOSMcZp/WBDEOfCEaoyyvdmjIPEICT2Ad1OE4xToSoNhui5L0Muft
	 Jv4ql/j/Bo56HFTtdFU/W9hYTVLGJB7DNGahDJtgmA1B/HG0pX4V1r7BNtDuGB2k7M
	 CwbKJWOByuK9yee57s4xZELX9dtEncEoQ7VCNEQCLJ9XPKDYNdav+GH1st0M463BPS
	 6ac4pwhLyuiOE33cZ21CLRYbXtsteXTZI4dSOMTzJClSGJGuasI3mh65OQLYbH5o6M
	 /gD2XWSh+CMW5u19RFKV/nYHFJgElfHCjRCDWV23LOKFeDlo0nHul11iFawzDOpfGO
	 bfVKODdwCnVMg==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 046/190] ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE
Date: Mon, 15 Apr 2024 06:49:36 -0400
Message-ID: <20240415105208.3137874-47-sashal@kernel.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 13736654481198e519059d4a2e2e3b20fa9fdb3e ]

MS confirm that "AISi" name of SMB2_CREATE_ALLOCATION_SIZE in MS-SMB2
specification is a typo. cifs/ksmbd have been using this wrong name from
MS-SMB2. It should be "AlSi". Also It will cause problem when running
smb2.create.open test in smbtorture against ksmbd.

Cc: stable@vger.kernel.org
Fixes: 12197a7fdda9 ("Clarify SMB2/SMB3 create context and add missing ones")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 407425d31b2eb..9ba9412c392f1 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -485,7 +485,7 @@ struct smb2_tree_disconnect_rsp {
 #define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
 #define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
 #define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AISi"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
 #define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
 #define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
 #define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
-- 
2.43.0


