Return-Path: <stable+bounces-47790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664F8D62C3
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0219028BA10
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD56158DCF;
	Fri, 31 May 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlbtCHcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA406158A36;
	Fri, 31 May 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161442; cv=none; b=cR3JjiZtLb7hhe54D4RBuIxVk0qzidH+gCSi8V4N8oOOY8zjiUqsd7mvu9OT+S5RN2exx9eYvkm5b2/hi9yukGEHzwkt5t5emwM5pWdptx9hnUslRsX36uj3YK82pTdV86W/9hha9XZbytHvea+aF4hAA9qrPo4mlwIy7Ev0anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161442; c=relaxed/simple;
	bh=hREQc+rKYbEtB62OO98jmE4aIfVDLgV6L+RVo0OPMOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FpOmZWGtHBT4BCS1TmSzqE1UmqDDFFjPRfGwqSO2Ru6RQ6VHJppj7XQhO4KrsfqxjlOkRNWSyegrbfBa67V6oy5mURKAhu3zbUytBwtnHGvf8eKPHPCtvCN/0AgdSBubSDKJWNyjQDbEzU5yiKKbG0mf6qN4QhJBgmeo/1mErQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlbtCHcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3727C116B1;
	Fri, 31 May 2024 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161442;
	bh=hREQc+rKYbEtB62OO98jmE4aIfVDLgV6L+RVo0OPMOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HlbtCHcx6WZFpZ3t3MtzlUYsiRnJ3Dif7ONfjPw+xjjb0/C0AO2e6kX+QkOsoMUbP
	 Q2Od+EbG4w5jLiIQ/qgAi8VNaH/73RqgH53m2O4ylS3RyrgFNgZBZxRlXWPBlQ0Ybt
	 qDNP7OG4rzxosrU03a+GSr5RKIHxc5r1raMG2AD+eTbcB5OqJ9++mYc29DQp2S7GyG
	 xCq0+VZBrr0hBT76PCOOUmbFKV7j7pJCv3I4V5u0pSl+RU6uALKHKOL4+mT6XsSy/1
	 c4Kv8tmu/2FoauM7iw1kdcjLyR8VdQWsj0eP/iM0Kv90QK6v+MifYWAHKoPCqNHozL
	 +EiOqThCsqAtw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Jian-Hong Pan <jhp@endlessos.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Aarrayy <lp610mh@gmail.com>, 
 linux-ide@vger.kernel.org
In-Reply-To: <20240530212816.561680-2-cassel@kernel.org>
References: <20240530212816.561680-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial
 CT240BX500SSD1
Message-Id: <171716144058.860385.17073103843417056061.b4-ty@kernel.org>
Date: Fri, 31 May 2024 15:17:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 30 May 2024 23:28:17 +0200, Niklas Cassel wrote:
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

[1/1] ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial CT240BX500SSD1
      commit: 86aaa7e9d641c1ad1035ed2df88b8d0b48c86b30

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


