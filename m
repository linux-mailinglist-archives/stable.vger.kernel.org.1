Return-Path: <stable+bounces-195272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF1C74078
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 384FB2A86F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91F2222C0;
	Thu, 20 Nov 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5kQVw/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C21E766E;
	Thu, 20 Nov 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642761; cv=none; b=CMrhDkQUlkC5Ch9xkoin2E+4mw49K0YrESSYPRYdV0SF+Z3sr9yuqh5UIgzD55qgqMCHi/1pIZpvvgzxKx3GqCGJJiEum+H6qbWu/gwhh7IKgyJq5lUtF6LB3r64W25nwZ/PlyXAJQC+Rg+ly6gLVqEQUDenuVvqWKBG5NItggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642761; c=relaxed/simple;
	bh=rGS/XJMdl+I5LSrsc7S5CQODSW6RGFPxQQoPc1ctHlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I+ql8hOuedJyCCJXmzLDGDO2jXDHFAIUUUM8ipGstHsHVXg8kF/a/OHFVjh1t3p2Hs2QNFrnAcATfZZhkYxCczG/Zu+STOH7hSTOuULg7y0vV424/tRKobNRYCLTBmN8zxmBpAxGdiKN/qrOUESe4uqr8A9HPsd3DUtLMpVyyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5kQVw/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF95C116B1;
	Thu, 20 Nov 2025 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763642759;
	bh=rGS/XJMdl+I5LSrsc7S5CQODSW6RGFPxQQoPc1ctHlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o5kQVw/x6HRnWVDE3ImzTQDDLZYVSexS/zgNAHYIagSUevhRsKUVjAFYCcVIQz/Qa
	 xYDQMYYLdZxQvN6aylfPdzS0RmisybqoGdKlnMQT01vieRzi41Lb7mX1ELJ2ioSrQ+
	 1z7yKmlejAu+AdIXR8jlapPGbvABow/DiCHhWDh9ySVFSA4Jixl4UMlNQ6u2Z85dZr
	 qkezXe6lsxfop3KnDyklxGLZTJ0HLdy+/NjjczjelXxtHOGzSAr+EBtfuAuhuT8/Go
	 lSLButun+87wtBF6mMCuHbxQt6aGV+2sKcVrwRuyHcOtNVsEFUE8Ch4YSMIdycYaOg
	 Lg7yiB+4XGivQ==
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Ilia Baryshnikov <qwelias@gmail.com>, stable@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <20251119141313.2220084-3-cassel@kernel.org>
References: <20251119141313.2220084-3-cassel@kernel.org>
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix system suspend for a
 security locked drive
Message-Id: <176364275802.2432162.1835901906142925525.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 13:45:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 19 Nov 2025 15:13:14 +0100, Niklas Cassel wrote:
> Commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status
> handling") fixed ata_to_sense_error() to properly generate sense key
> ABORTED COMMAND (without any additional sense code), instead of the
> previous bogus sense key ILLEGAL REQUEST with the additional sense code
> UNALIGNED WRITE COMMAND, for a failed command.
> 
> However, this broke suspend for Security locked drives (drives that have
> Security enabled, and have not been Security unlocked by boot firmware).
> 
> [...]

Applied to libata/linux.git (for-6.18-fixes), thanks!

[1/2] ata: libata-scsi: Fix system suspend for a security locked drive
      https://git.kernel.org/libata/linux/c/b1189068
[2/2] ata: libata-core: Set capacity to zero for a security locked drive
      https://git.kernel.org/libata/linux/c/91842ed8

Kind regards,
Niklas


