Return-Path: <stable+bounces-125658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF0BA6A7D3
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23883B66AC
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B75221D86;
	Thu, 20 Mar 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkE9pmWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E841CAA99
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479168; cv=none; b=lrPxmBzxODQTmoZ02XrxL3UGlwmVmyxqo+d86ckuNSguY6SGj/Wd2A/DmR6oGtRkBS7fY5BBSSSMQrFOqUYvB0UNqD1zuqnGbjvEGt9gBZjjPvTg+von+F6FTzeKR6CAn7/4R5xU8msMKReW0lIoWQdRGw08QljVwLaZdbfNqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479168; c=relaxed/simple;
	bh=Rn9O7QYqzi/mfX8xMXesMI5isRRlX2lEU8vHTWYLTVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3hW66ZA93yp9xuKjQsKnLuvI2sPkn0I2g2+wr1v70aasDbvdPsCPdnCiglPLIU4ivepzp9iR5ac1YNe6pd/8wAvfUdAzGGDXlrJfQ6O8v0eZs8HIce3fxrNwq32UTlMD0UPxNXBFlmX2ho7RMDOgcVxbuBh7CZpTT6Qsf8Uy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkE9pmWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819B6C4CEDD;
	Thu, 20 Mar 2025 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742479168;
	bh=Rn9O7QYqzi/mfX8xMXesMI5isRRlX2lEU8vHTWYLTVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkE9pmWOkTUP8a/GtPBtXvZz8Fe7QuxyuWgz97QS21d7Q4D3V9TGMrtDNKMqvBXsk
	 0K1ay6EhNx6oKM9OmW78Xym9a146LX9NSo32y6EloZKN1hq7mJuSwiBruBj2cQsHVG
	 713kUMDZan3SaRO35dzam60yBYZ2HnXI7TNUcdBfxFzVltN/Wjx5SZENNNLl9Hhh3l
	 eUYHbvE7nLygs7dWc6+MR34DsqvNCYrsfO1pT9Sp0L4ARP8Gylex9a6vA0E01JI75c
	 t9s43PA7IoRoWr0YUZbumMLGXuhjAlhMKoHBTsxnb1+CRgbdIxe9GIf6h0tQYAstmi
	 8YhZmOXIiiI9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	axboe@kernel.dk
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
Date: Thu, 20 Mar 2025 09:59:15 -0400
Message-Id: <20250319235024-4cd52346f17913d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833

Found fixes commits:
9bce6b5f8987 block: change blk_mq_add_to_batch() third argument type to bool
e5c2bcc0cd47 nvme: move error logging from nvme_end_req() to __nvme_end_req()

Note: The patch differs from the upstream commit:
---
1:  1f47ed294a2bd < -:  ------------- block: cleanup and fix batch completion adding conditions
-:  ------------- > 1:  648e04a805652 Linux 6.13.7
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

