Return-Path: <stable+bounces-100254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D299C9EA0AD
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D787281D92
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E519AA63;
	Mon,  9 Dec 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF7fRn25"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49021E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777751; cv=none; b=bSGWKfQmhyNFEYvUKdxIARqarFyRja7KrqWErvzZmjC1MiStFk57m5H+sgOPMmXHhP7bMEKWqF5tO/hxPQHbO+T7GAv7ODgbZH1ULtPGkDbFblr0f3djCLC5GOhlJsh5PdbxGngUGlOxYCOaONy/q2kKjliUNMcC3VEwwsKZEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777751; c=relaxed/simple;
	bh=qQf37UNPRVn4g1n+RRj0abGcHt9XpFtgayguT7ulNik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+FCBYuIUIk2ZmuZpVcuZEmWF8Cc5CBBybp/YDgK1fJJYcPfMf4bBI9CErCaVbgAFDnNPPzdN34nP2hTDpufFyclHzmTi70h3chuiqEEK26Tuero4zD0yIMb/gA0EshrH+0A7tV2C0jsIyX2i47GfyKE4TKhpr+sQVdm0OJ41Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF7fRn25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB1CC4CED1;
	Mon,  9 Dec 2024 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777750;
	bh=qQf37UNPRVn4g1n+RRj0abGcHt9XpFtgayguT7ulNik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uF7fRn251d8ydX9Va0Yh+lkY5tkcQqmmDuFxaq/vnfc/SJs4mft41WS/FplYbYyVu
	 c0ICk8o+85UMlGjB2sxUpFKMQIepA9f1lFmZ3jShvuxHXcbFtdqzUnHfeSdN/Ep7/l
	 lqfldYPIV7bZj1FMS45x3RMUf6pzGJqO0fEr5mqIDsx9ENh4TPCNeFXP7nB7iSt6Qw
	 zSElWWLwDZGmRIhYON3RVD7tiTuF30umdT3gHroTPdGrlkPORajT4/XIzMkB6lRa99
	 MsPL6YbcnTFEvrjAfKP5xE7Vaji1zg7mkrLlj33/2qQ/ZzJR57Wnm8+54Ck8szUBSf
	 Hw9c0GaonSAlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/3] scsi: core: Fix scsi_mode_sense() buffer length handling
Date: Mon,  9 Dec 2024 15:55:48 -0500
Message-ID: <20241209151930-9aff3a2a164ca3d3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209170330.113179-2-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 17b49bcbf8351d3dbe57204468ac34f033ed60bc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Damien Le Moal <damien.lemoal@wdc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: e15de347faf4)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  17b49bcbf8351 ! 1:  5e9ba35e00eb9 scsi: core: Fix scsi_mode_sense() buffer length handling
    @@ Metadata
      ## Commit message ##
         scsi: core: Fix scsi_mode_sense() buffer length handling
     
    +    commit 17b49bcbf8351d3dbe57204468ac34f033ed60bc upstream.
    +
         Several problems exist with scsi_mode_sense() buffer length handling:
     
          1) The allocation length field of the MODE SENSE(10) command is 16-bits,
    @@ Commit message
         Link: https://lore.kernel.org/r/20210820070255.682775-2-damien.lemoal@wdc.com
         Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## drivers/scsi/scsi_lib.c ##
     @@ drivers/scsi/scsi_lib.c: EXPORT_SYMBOL_GPL(scsi_mode_select);
    @@ drivers/scsi/scsi_lib.c: scsi_mode_sense(struct scsi_device *sdev, int dbd, int
     +				 * too large for MODE SENSE single byte
     +				 * allocation length field.
      				 */
    - 				if (use_10_for_ms) {
    -+					if (len > 255)
    -+						return -EIO;
    - 					sdev->use_10_for_ms = 0;
    - 					goto retry;
    - 				}
    ++				if (len > 255)
    ++					return -EIO;
    + 				sdev->use_10_for_ms = 0;
    + 				goto retry;
    + 			}
     @@ drivers/scsi/scsi_lib.c: scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
    - 		data->longlba = 0;
    - 		data->block_descriptor_length = 0;
    - 	} else if (use_10_for_ms) {
    --		data->length = buffer[0]*256 + buffer[1] + 2;
    -+		data->length = get_unaligned_be16(&buffer[0]) + 2;
    - 		data->medium_type = buffer[2];
    - 		data->device_specific = buffer[3];
    - 		data->longlba = buffer[4] & 0x01;
    --		data->block_descriptor_length = buffer[6]*256
    --			+ buffer[7];
    -+		data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
    - 	} else {
    - 		data->length = buffer[0] + 1;
    - 		data->medium_type = buffer[1];
    + 			data->longlba = 0;
    + 			data->block_descriptor_length = 0;
    + 		} else if (use_10_for_ms) {
    +-			data->length = buffer[0]*256 + buffer[1] + 2;
    ++			data->length = get_unaligned_be16(&buffer[0]) + 2;
    + 			data->medium_type = buffer[2];
    + 			data->device_specific = buffer[3];
    + 			data->longlba = buffer[4] & 0x01;
    +-			data->block_descriptor_length = buffer[6]*256
    +-				+ buffer[7];
    ++			data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
    + 		} else {
    + 			data->length = buffer[0] + 1;
    + 			data->medium_type = buffer[1];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

