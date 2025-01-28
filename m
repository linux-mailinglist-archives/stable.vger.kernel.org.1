Return-Path: <stable+bounces-110960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F40A208D2
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1331681E5
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD519ADA6;
	Tue, 28 Jan 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwBRpuFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFC59B71;
	Tue, 28 Jan 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061244; cv=none; b=jv3e8UPcg9YaQWGQmw5EPiOWmdbH5sOq+jHflxORRAFfSB6rbYFUR0WNczdV3VQ0RnwkC4Ykp2gbsJ4yrDlu3u8rc8PONBy43UOOBF6bV386yj2aQ+C/BX3PtyyzBgTXjXq/rrjuCCNg+BfVhunwQ/yGNiX0tSevNoRRB7brv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061244; c=relaxed/simple;
	bh=EqfOhULGhRWjWwSuTyyrSnuUhXbA6YFXWSubLGy9muc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VrF/uJafTL25a2VlxqCcEWWTixhkUEBju9QWKscWWcdRtW2/RsWKljOQ1zK3uMXfh+UFjrhVV7LxwdvbPGKUE/m1i7iKLptCiTFsxxxYLJo+Nx0hNnkFCsmx1xRiP7q8aDnjU6o/bN7ZHNK98T9cfwaFe9NPjPtPDcL77Z81fYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwBRpuFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398BDC4CED3;
	Tue, 28 Jan 2025 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738061244;
	bh=EqfOhULGhRWjWwSuTyyrSnuUhXbA6YFXWSubLGy9muc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RwBRpuFUsXVvykc0E/kmZlJh6K/BiOKj9VDT3dRTPhnH/RZaVrng/xPxTLS2lBAD/
	 qN8XNgo1JPJti26hja3GovcVhLCIo8TXJdJem1PjgPuHfrDuJo6Ynn2s6Ijusfh3U5
	 dkxL2cGmDGx87ERiabSdfh4SHGOJKd0JPcGOv2I2/U+TJRGdKcq3DUh6Z8Y9pyKza5
	 EqJp1kvgQMiBSXgotADR8qtUV1/3vHkAId7EO52Sb1FvhULegvpVXXuLXcrrWSYfvv
	 Qo+S4wG6dRPZk+QYNIdzTHvASCjjQlpVCo8V9SYYOaPOSYmOvKfczwB9miQJckBJbD
	 qSNutitv5gS+A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org, 
 reveliofuzzing <reveliofuzzing@gmail.com>, linux-ide@vger.kernel.org
In-Reply-To: <20250127154303.15567-2-cassel@kernel.org>
References: <20250127154303.15567-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: libata-sff: Ensure that we cannot write
 outside the allocated buffer
Message-Id: <173806124194.7504.9074817431897226887.b4-ty@kernel.org>
Date: Tue, 28 Jan 2025 11:47:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 27 Jan 2025 16:43:04 +0100, Niklas Cassel wrote:
> reveliofuzzing reported that a SCSI_IOCTL_SEND_COMMAND ioctl with out_len
> set to 0xd42, SCSI command set to ATA_16 PASS-THROUGH, ATA command set to
> ATA_NOP, and protocol set to ATA_PROT_PIO, can cause ata_pio_sector() to
> write outside the allocated buffer, overwriting random memory.
> 
> While a ATA device is supposed to abort a ATA_NOP command, there does seem
> to be a bug either in libata-sff or QEMU, where either this status is not
> set, or the status is cleared before read by ata_sff_hsm_move().
> Anyway, that is most likely a separate bug.
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ata: libata-sff: Ensure that we cannot write outside the allocated buffer
      https://git.kernel.org/libata/linux/c/6e74e53b

Kind regards,
Niklas


