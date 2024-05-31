Return-Path: <stable+bounces-47791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410B8D62C5
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B887D1F22515
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A681158DAD;
	Fri, 31 May 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPuBAoe+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7E1422C7;
	Fri, 31 May 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161445; cv=none; b=OJUDi4zNDKpN+n80j2DY+DoWI/ZoP7T/X7qWwdWLQG8yjqQA1V+fglc0IG/SR2txcZn8krPJgZ/0oysNyi+LXfgE3xZBuYMUKVzFABoSziVe8vIZs+8agZhgLi7vgtpyzVEN7qiw3q9K2wUlmlWRSwGv1GnzDYHT0euKVXM+JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161445; c=relaxed/simple;
	bh=sL6sXqS6GghXfzBSo92ynMAztG44AqdvhOnlzPMN+K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WccTcfIoAWNtXGmFDntLCJcbMBEBLzHpt5GMZTnKKtx47YsyeO3sBzOHwJdi80vqsYE3Ea4Ixn4UGjY49vI0B4JNjljPhxcZYdA1gC/QKDKxp17cgsDL42adkuxm3g3DhDvl4VXhsNUjSMM5WGWQ1yn7T36yg+AiPry2An/vBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPuBAoe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0775EC32781;
	Fri, 31 May 2024 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161444;
	bh=sL6sXqS6GghXfzBSo92ynMAztG44AqdvhOnlzPMN+K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mPuBAoe+uItvrap4UbfoxuquJP7oDcONULUC7Ab6V77SXGgHQPGIeU9TJGu7vDLtu
	 M6JD3He4X2lXGbX+Cav/5EuX1bPYBgeqW8tr0XhcuSa0fOP0hSJphNeINnL2KecpJ0
	 V/Vn7E4PxU+VZnBIfs5tU0VpBlrsKRwzeQ0Ei9emHgVIhCYv6Vvr8zvhQPU1clz6nt
	 X+bGFskZrIA+Su8diDvp1EmQNla1ivXpBgyOkaUBVUg8auPZHVsCTgSdruuZIAl4EM
	 k7RXMf5IQmX0lGx9NVB7+xf8y1BeXiuMzfZRp1FHfOKFDTvz/5gggNXE5n5CSrws37
	 W/ZzK7wF3mPPA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Jian-Hong Pan <jhp@endlessos.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Doru Iorgulescu <doru.iorgulescu1@gmail.com>, 
 linux-ide@vger.kernel.org
In-Reply-To: <20240530213244.562464-2-cassel@kernel.org>
References: <20240530213244.562464-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon
 S3 SSD
Message-Id: <171716144274.860385.926268923461750551.b4-ty@kernel.org>
Date: Fri, 31 May 2024 15:17:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 30 May 2024 23:32:44 +0200, Niklas Cassel wrote:
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

[1/1] ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3 SSD
      commit: 473880369304cfd4445720cdd8bae4c6f1e16e60

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


