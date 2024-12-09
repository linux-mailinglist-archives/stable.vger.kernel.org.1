Return-Path: <stable+bounces-100251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5D9EA0AA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6A11886267
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DC199EB2;
	Mon,  9 Dec 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnfm/eJU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF21E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777744; cv=none; b=MBFfAihEh3m/XgZNOLB0OEP2vBf4OCvEBtpFiz9405zjK9okDte4xGMU6nafEly2Mn0/3LN+t0r5EpWSqnieOZz4CBq//xlZ+a7j3UYfjXvMIdq2dJ1f46dTE6KrgG/z6I5rr89D8Pf9ApP7ifW/oymPIm9Hhp22C5H1u2hIXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777744; c=relaxed/simple;
	bh=e8wUWjX7DX+o2Vdp8yIr6YN/rUoSgwQiyxGpqJvz4SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9vvJAsgIrKH97NuRwhCrMBYCux7k9Ztyk0igXDEYK4P3g3YN5iwDXfPbMI/4yvvD84X60lbMjoSPGOnqrcD/CqQf4DZMeO1AUk2GpZK1HscFi59jf5Hap9sERe/dZusSGjieow5Yl9l5eHXaQqzer4XHg79u9xqfF4+UdYPub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnfm/eJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA7CC4CED1;
	Mon,  9 Dec 2024 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777744;
	bh=e8wUWjX7DX+o2Vdp8yIr6YN/rUoSgwQiyxGpqJvz4SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bnfm/eJUph8FVgbCZ2N5M063PD41p41AibGWGCc8EIzAgCv5b1Arl02lKwrXgNqB1
	 FpvQHnvzL29jJmp+Bbd8jVtJRvZXTuKdytgd8uFWvktMxGb9LtGt5ydCFdfGPkSrbt
	 0rfhsRtO5/rJVTxyRVqa/1zXE4iQbI/w9qgFYvJJOrpBY/aEhPoYu8Et++CsH58btR
	 3uHXwBJjIe7c4dPp7rWKa3z6z8zU11MJUSF8VIcJ6W+n/whlz7Cer16pmWeo+pjyV9
	 LQa3/W4/ttFJ0LkPRpAe/yLP5lvPiHioY0pC6svhKruV8j4cieXYNZ8dh4AZyVEz9j
	 IQQlQGHk62SiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/3] scsi: sd: Fix sd_do_mode_sense() buffer length handling
Date: Mon,  9 Dec 2024 15:55:41 -0500
Message-ID: <20241209152530-c6925bd714abdab5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209170330.113179-4-kovalev@altlinux.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c749301ebee82eb5e97dec14b6ab31a4aabe37a6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Damien Le Moal <damien.lemoal@wdc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: c82cd4eed128)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c749301ebee82 ! 1:  f6b467ad3c189 scsi: sd: Fix sd_do_mode_sense() buffer length handling
    @@ Metadata
      ## Commit message ##
         scsi: sd: Fix sd_do_mode_sense() buffer length handling
     
    +    commit c749301ebee82eb5e97dec14b6ab31a4aabe37a6 upstream.
    +
         For devices that explicitly asked for MODE SENSE(10) use, make sure that
         scsi_mode_sense() is called with a buffer of at least 8 bytes so that the
         sense header fits.
    @@ Commit message
         Link: https://lore.kernel.org/r/20210820070255.682775-4-damien.lemoal@wdc.com
         Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## drivers/scsi/sd.c ##
     @@ drivers/scsi/sd.c: sd_do_mode_sense(struct scsi_disk *sdkp, int dbd, int modepage,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

