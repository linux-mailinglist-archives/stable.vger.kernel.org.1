Return-Path: <stable+bounces-67649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D6951C44
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AADC1F21511
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521F1B1406;
	Wed, 14 Aug 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAOxceuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99301394;
	Wed, 14 Aug 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643581; cv=none; b=YTSK4rIOKvpjwMZcQGO6dHfRfLfmVxoA1ibvhfQIc27zt1F42qGGNHvzEA0ZlWUml8BKdaYmhxI/oYJK7oboTBFja6mSeNCDNKnCts5emvoyy98Owbvntmonx+9BevV9Re6zSQBxAYE0R/Rp2cbz6vHn6vnYveZPAN6gragFXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643581; c=relaxed/simple;
	bh=S6ETUwJhJjtOyU8fyiCYNEKaNec6h6IICgYODC0gkb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fOdo1Y4fuKtpKyXEJreKrQDm5YAOC2ZiBGscQApl2fbimjiGjTElgMurOKM4tRx0bpF24ZbNr7+D6KoVTQAorJX9ycoigOOExy6vhpzpUyRG6tNty0VjjxBV8GfoSg6kMyLcerAz1tHponR2DV7K89morXvGj8EHRNx8sFJlaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAOxceuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F0AC116B1;
	Wed, 14 Aug 2024 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643581;
	bh=S6ETUwJhJjtOyU8fyiCYNEKaNec6h6IICgYODC0gkb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iAOxceuXz2wLgjEhv9kDzU3q33Ye7VR2mcDFNLkwsnVHMmmIk4fOaKckwDT8xCGOZ
	 TPBf61R9fAbIW+t5Di6QG+wsP6dW75sGw1JKNmaTqMPriNV8tQN5x4dSY7FGzLpL0Q
	 j4ERYem+PR4oek0ZJyxisKY+C12j8vnCn3HpWN8bFlw6doctJTeUg3Cx4vVZe9V35b
	 XumNK/ONgBhEw4k8gl/Qc6++6jg+jlladjB9fTgkYxtNvkhuGO2nCZ3QnKNla1yBXy
	 92G2ioK4BM8xJi5k3tIbWfve3/pozmAC/MAz5iq5Ak4Px+0PEuHt9IFm7nnfBnlXW8
	 gRjTlUCOoa6fg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv <ipylypiv@google.com>, 
 Hannes Reinecke <hare@suse.de>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org, 
 Stephan Eisvogel <eisvogel@seitics.de>, 
 Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
In-Reply-To: <20240813131900.1285842-2-cassel@kernel.org>
References: <20240813131900.1285842-2-cassel@kernel.org>
Subject: Re: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error"
Message-Id: <172364357883.1303881.1790276895537620446.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 15:52:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Tue, 13 Aug 2024 15:19:01 +0200, Niklas Cassel wrote:
> This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.
> 
> Sense data can be in either fixed format or descriptor format.
> 
> SAT-6 revision 1, "10.4.6 Control mode page", defines the D_SENSE bit:
> "The SATL shall support this bit as defined in SPC-5 with the following
> exception: if the D_ SENSE bit is set to zero (i.e., fixed format sense
> data), then the SATL should return fixed format sense data for ATA
> PASS-THROUGH commands."
> 
> [...]

Applied to libata/linux.git (for-6.11-fixes), thanks!

[1/1] Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"
      https://git.kernel.org/libata/linux/c/fa0db8e5

Kind regards,
Niklas


