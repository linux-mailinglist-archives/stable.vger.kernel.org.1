Return-Path: <stable+bounces-100257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340269EA0B5
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034651886209
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD019CC2A;
	Mon,  9 Dec 2024 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utVxAhrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC81E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777757; cv=none; b=gyN6lQ/1A8Det/SqEFPWStM4MRBY319m5yF3xdiH7N5ew8fpwhBmJ32u25ibskx5aWNO9COMVY0v1ibwsXWKzetKnC0Ss1j6XbF8AdDVSHNqEzQZVXH6/L7zfCY3V0rKNIILaM5RcvhHg5mxwG5TvN8dAokN0v8ra89HwVoE06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777757; c=relaxed/simple;
	bh=8qynSQVTIOsAtmTBwLQ1W6Qi80FQ7H0nrq4o3S67mHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ66r3/rkkPLccPy0xhJKgdwv1t8+mOxfST5kli6boiTr+2UOTCvGUyn6jrsnrOhwkbFPfwpeI994dUdgE93YetnKd2GYP1Xc9Y1WZnz4mlqKEVjLorZmVq4bp88FvDDSSXeZ9CgrSmkk+/QNI7hTreF+Ui4EwvU83mElZGFvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utVxAhrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF7AC4CED1;
	Mon,  9 Dec 2024 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777756;
	bh=8qynSQVTIOsAtmTBwLQ1W6Qi80FQ7H0nrq4o3S67mHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utVxAhrW00AMIBkNUng9GeSZJ/CM6OTQKxTnme3CQYBGiOHMokL4ew9h6AVRKzQLg
	 8WlHKbhXk7K8YVcC0+VEHFEH+bb1w1G1fl8AcNWiNamMZdXFpKxNgSGUvVVxLV8QRB
	 SGIbmbBN5sWo51xCJgyyurPiwDWzGzSvaa2XrzJntJ9WKrB87RdEd5vnrIkvCuYAMm
	 wc3kU4x84ThdwniVRWSUghCd7+CzW7wy/qDWaBZTyWSJb+D89pYx8Fy/ZrEk51StsH
	 2HJ0LSlQYuMz7J+HSxPdrI1C7OMbg0TWYdLUEig36ussReq/dWoeLxgw2yUfyOHV96
	 rvA2ZL39B5Lrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] scsi: core: Fix scsi_mode_select() buffer length handling
Date: Mon,  9 Dec 2024 15:55:55 -0500
Message-ID: <20241209132628-c75f8be7ddfda850@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209165340.112862-1-kovalev@altlinux.org>
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

Note: The patch differs from the upstream commit:
---
1:  a7d6840bed0c2 ! 1:  16b532ea81441 scsi: core: Fix scsi_mode_select() buffer length handling
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
| stable/linux-5.15.y       |  Success    |  Success   |

