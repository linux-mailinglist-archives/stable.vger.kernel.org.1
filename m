Return-Path: <stable+bounces-47792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B08D62C7
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1481C26735
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8D158DD6;
	Fri, 31 May 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE16L+he"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35405158A18;
	Fri, 31 May 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161447; cv=none; b=T0a/CAk+0A2QFEgPKQOuOJ4M3zHoj5mlQ23R+I4upPN0AfkFxUq9aOIGgml7wnrJDj9gJ78ZwYye4V1jd6dess+T8a8qFCKy+Jq7nMMQz8GvOFefeBNGknqK++mBmc015LBlkH8/N1UynOFDR8efMBqejeb4hiPEZotMx9CAeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161447; c=relaxed/simple;
	bh=gFC1l1cuepLndJfwbQhjy5RLRVn0vVdYXl4e+lDoOZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eICfiFLIC8Ofl/mg278P7m6fD85bCeFwSLmdPkmxWAFZYjdA3lP2WMPZcmr/FTOz7Cx5JZtNdRfzy7vnDVM2BWUkEa4RYh01rdL5V7RIUNNwg24XdI20pUZ0pEFMv0i340qxQHIWdlHjSRbHGB6bEDJUd4yv+PSc7t9aN6wnMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE16L+he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29304C116B1;
	Fri, 31 May 2024 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161446;
	bh=gFC1l1cuepLndJfwbQhjy5RLRVn0vVdYXl4e+lDoOZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kE16L+heEzZMwhZSFBDj07TOG6h0SH2hYH10k84CpHwpO3BNDk5cVVdJvyjBVW7Jk
	 I0Oy+d0E0HRcF8HBi/GIBYJSCp47J5JWJ8LZmd/RslujzCARCD+pMkf6v21iur0bqN
	 0gt/TN3Yn2AdKtIY+n5HI/BqoQCLuptZt3URPM8P5Cx3k65XXOTRG2zwP6P3ZR4RpH
	 NjzczFtuVlGINZb+NSUeNPotS+FC5c8g4Mc9Je1r1F2t//2s3EtQoDtydlTug/qF8g
	 2gBINcrfRo+linG7pk8tAUk0fO9Nd3LyIb+gXrT7Aqlnkdzf6cRi7rWZNJYfOjmsXr
	 TeL1jRzLc3s0A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Jian-Hong Pan <jhp@endlessos.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Tim Teichmann <teichmanntim@outlook.de>, 
 linux-ide@vger.kernel.org
In-Reply-To: <20240530212703.561517-2-cassel@kernel.org>
References: <20240530212703.561517-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer
 AS340
Message-Id: <171716144488.860385.18377345070341018457.b4-ty@kernel.org>
Date: Fri, 31 May 2024 15:17:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 30 May 2024 23:27:04 +0200, Niklas Cassel wrote:
> Commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> dropped the board_ahci_low_power board type, and instead enables LPM if:
> -The AHCI controller reports that it supports LPM (Partial/Slumber), and
> -CONFIG_SATA_MOBILE_LPM_POLICY != 0, and
> -The port is not defined as external in the per port PxCMD register, and
> -The port is not defined as hotplug capable in the per port PxCMD
>  register.
> 
> [...]

Applied, thanks!

[1/1] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
      commit: 3cb648c4dd3e8dde800fb3659250ed11f2d9efa5

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


