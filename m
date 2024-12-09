Return-Path: <stable+bounces-100255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2A9EA0AE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B69E1886269
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6719B3CB;
	Mon,  9 Dec 2024 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmCKf36W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831F1E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777753; cv=none; b=YJvOBVVhw9fBC4/sj3bJ9fE1lt1NJWAlvIZsVrJoFnMQZgz1Uvvbjwi+VMSQ82gM3TMwJV6E1o3Fkzjx1yWO61HVuaB7cUftkr7h+d1uaZs3dbDaJOCjKnmlZmq11yjvVG5/B3Mi+l7GMEqZDj409OskcT9+OffXjPd6JbvlHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777753; c=relaxed/simple;
	bh=CwTvzVnoP1ccU6S1LZL0yh4rX35R+L0GN+m0926sJCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+zC/nifkx8ysyj8KbRpHXN0qrUR04P/mo5NjzhCEzMSO++ixzj8/SdWEv9K2HtNwM8ZVT1gZ6ABl/aCizVx3M52eNgPQ5mKMlW612o6onh9Vuxdj1xEN7X2DpabayRPBF2gka5XRc2kqWao9bpBUkvlbxC0rgoZduDhdgu1F4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmCKf36W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1DAC4CED1;
	Mon,  9 Dec 2024 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777752;
	bh=CwTvzVnoP1ccU6S1LZL0yh4rX35R+L0GN+m0926sJCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmCKf36WgPOTImbxZvQZGHGS9eog3gj4oXBh2IE9K9ZS210EC/Qdh04Do/YZE6xGf
	 KrZZ76Goe4q/c7ggL7OW/txl/rGlT345oFRGKVWp8W8iPU0U/dftrhOKXvThempIdO
	 azKdAdOl5eU5ZzImSEdaB2GsYpKjaImlHrW//QVct6ZbUo8dxaJm2s4/neg1px2Vsz
	 GE5uuQFwLcbKF1PYDpC97zld9RceGvxskKemExUDbnZUqQw1ZYVOOJkI2L4KrDb8dH
	 yGl0PltTDp7fnQ/TK6UCn5sD3I8yGr6HtzcJ0zqy6yRBx86uK31nWQCHLCjPwjIvAX
	 5u3qs/O1LWLZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/3] scsi: core: Fix scsi_mode_select() buffer length handling
Date: Mon,  9 Dec 2024 15:55:50 -0500
Message-ID: <20241209152229-cda710329b523c00@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209170330.113179-3-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: a7d6840bed0c2b16ac3071b74b5fcf08fc488241

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Damien Le Moal <damien.lemoal@wdc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a7d6840bed0c2 ! 1:  4826a9616670c scsi: core: Fix scsi_mode_select() buffer length handling
    @@ Metadata
      ## Commit message ##
         scsi: core: Fix scsi_mode_select() buffer length handling
     
    +    commit a7d6840bed0c2b16ac3071b74b5fcf08fc488241 upstream.
    +
         The MODE SELECT(6) command allows handling mode page buffers that are up to
         255 bytes, including the 4 byte header needed in front of the page
         buffer. For requests larger than this limit, automatically use the MODE
    @@ Commit message
         Link: https://lore.kernel.org/r/20210820070255.682775-3-damien.lemoal@wdc.com
         Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## drivers/scsi/scsi_lib.c ##
     @@ drivers/scsi/scsi_lib.c: scsi_mode_select(struct scsi_device *sdev, int pf, int sp, int modepage,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

