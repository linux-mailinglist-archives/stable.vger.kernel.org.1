Return-Path: <stable+bounces-163592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5501B0C5AE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846191AA3E95
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87A2BE059;
	Mon, 21 Jul 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibxWtaVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F919E826
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106338; cv=none; b=uBL2SghDXrxTjROLioQFYUUR0F6ND/0gGXE4Jkfad0IHcvgPBTy//kv4+zC3VY+nHXvMRdBoZni4UaVq1jZnwe4VJxKah/FDU9PqgjR6zLYIBLnFq7D9dtizxG19crqcMGtHkDYqs/CqCmrzxrrTElQk7oD2rjSS+JkuL9cxvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106338; c=relaxed/simple;
	bh=b4UQmVoRjPt7pY4UBGYpHbxH4w8pgfK5inTfWpV8rwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFPn+kWh6IhuSPjJ4A6o6hPAPOztfvQqmqNAZdIuH3Fz/HxDbC/GgQEOSTzCwL6XHXNB0VrhQsNWloNLTK3uKxQEHH/ZsOQqdLQ5kS1DLIfSPkHYtLL27Bty5WcLep/EWoFNTJHux3q4bl8N/+TVdRPEu3RJyCZLW4ehK/ChVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibxWtaVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C669C4CEED;
	Mon, 21 Jul 2025 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106338;
	bh=b4UQmVoRjPt7pY4UBGYpHbxH4w8pgfK5inTfWpV8rwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibxWtaVWgFHViceJFnSD7csX0T6Epc0+dbb7jadoe0LSECcLQ1DMUKDFHgDmtBsgL
	 /RW0+EL7PmhV7W2Fd4MmLwcEA0HHtpP1Q558WEYSoR4Afnbm5yigmWwo2IYQoK2Y05
	 CWvxpWD8/Q2QBeZaI6MMDwZn7dWWqkgm8R6151KwVlr/vl5cPO9zR4RjkjsgbgaHR+
	 lWy6pdtvQz4MhQRSGOxhQ55RxrvDo0bFmMlp+PdWhSN1RBB0fEk1dYxHQYyFPuqNLQ
	 OJl/8p9M7JXR628MT4VOsapuPFcf8zprdr6XPZeMDamp5JFTbtcOhtkjYTUTMuP3bO
	 UgXTEFGC6GVGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	eraykrdg1@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Fix SMB311 posix special file creation to servers which do not advertise reparse support
Date: Mon, 21 Jul 2025 09:58:55 -0400
Message-Id: <1753106036-b5fd2fc4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720203248.5702-1-eraykrdg1@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Patch application failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 8767cb3fbd514c4cf85b4f516ca30388e846f540

WARNING: Author mismatch between patch and found commit:
Backport author: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Commit author: Steve French <stfrench@microsoft.com>

Note: The patch differs from the upstream commit:
---
1:  8767cb3fbd51 ! 1:  db704f6b22b4 Fix SMB311 posix special file creation to servers which do not advertise reparse support
    @@ Commit message
         Acked-by: Ralph Boehme <slow@samba.org>
         Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
     
      ## fs/smb/client/smb2inode.c ##
     @@ fs/smb/client/smb2inode.c: struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.15.y       | Success     | Success    |
| origin/linux-6.12.y       | Failed      | N/A        |
| origin/linux-6.6.y        | Failed      | N/A        |
| origin/linux-6.1.y        | Failed      | N/A        |
| origin/linux-5.15.y       | Failed      | N/A        |
| origin/linux-5.10.y       | Failed      | N/A        |
| origin/linux-5.4.y        | Failed      | N/A        |

