Return-Path: <stable+bounces-249503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCDXLLksDGq0XwUAu9opvQ
	(envelope-from <stable+bounces-249503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:26:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D757B3B1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 510303036BFE
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C523F86F4;
	Tue, 19 May 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia7EpTfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313913F7AAC;
	Tue, 19 May 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182731; cv=none; b=Uc4nEgvGadNX7vHOM7LDqtSf83jj5dJuXr7X1/NrDE9P9GtdlaxpTVqFvQQ1QSQD8f2VBqt3MGQRv8T2RbKxpKtV/P2QtmaFMgXKZrf8OTu9xYDId/3jCOWejvT30oRhG22WVNIMM03y5YFPrMuggnodJ6XL2o4U6E7uLZvQ9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182731; c=relaxed/simple;
	bh=mDPAZ/XV3MEkn1kMDb6rqG+yEFK3oh6hRvKs2rVaWI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e6nk/Vb0KYrn8X2mNS5RERRFDbynvYBhiQBgteE/giEUwwghOwthPwhj2xhCru7K4moO/aDhTcIPrW+14rBc+t7yd4P9KywNAwJigWWxBVLX5pOsSSQmmClvgwoogJHLp+j+cWC8Fp+76/uiu5YkvDh1HubMjR/11fRhPMlBCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia7EpTfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B9BC2BCC6;
	Tue, 19 May 2026 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182731;
	bh=mDPAZ/XV3MEkn1kMDb6rqG+yEFK3oh6hRvKs2rVaWI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ia7EpTfxVMBQIWXxZsLndTj4UvnDXRYBzO+DvzOKScirKTi297xVw7LHmEjt8O7tI
	 PiYdS3ypDc97hKUpsMVVnu+DPXYiDHk/83wpZn9/AKENhcfc0dxbyFlAyN3d12ej7Q
	 al225sMS9OP0+MAKQ8kN/KYyMTrjSxWNaJ7IOJGu2LpxjaGCNBPxjTv//lPhxoNL9K
	 0pktlf6o8beYbVK3303mut4+n0G/LByaMlidO8/35leTa4LQEL1ZbewW3i8IilW5MY
	 fAM3zQSxlP/jJmDVPU9kZWu2cxjJtn2RjLArEbt7DUmhCRu2X74VG4j0GYavHW2G15
	 6nB7gElZS9fmw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lanqing Liu <lanqing.liu@unisoc.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260512074733.915029-1-johan@kernel.org>
References: <20260512074733.915029-1-johan@kernel.org>
Subject: Re: [PATCH] spi: sprd: fix error pointer deref after DMA setup
 failure
Message-Id: <177912243529.352391.18042117560657453374.b4-ty@b4>
Date: Mon, 18 May 2026 17:40:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mDPAZ/XV3MEkn1kMDb6rqG+yEFK3oh6hRvKs2rVaWI0=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiwenY6qElEXAYt754zvhl+7rRkaz1XI8o2joTGvatc2x
 WcJL0U7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJtOSx/7NYwv1r+tL4Lt6I
 p7+ZF8w4J8I/w7z0skbzaimzjMcht5cssRBsLdNQ0NBf8cnphC93UbB2qoWi8uYLMv2xDy79vTf
 7+rStmrb5ilYXVv7Jkf4Rv/dAVcdm55+sTkefumekH9Zn/eCUHBzQaRem37Tthd2L0vb3iYwmKX
 c/ngsIDr92ZsuyLK+DdT839/C77NHJqPBk8M4SDJv/tcBh0fUEj72tixy0WubvP5Wdu6uvrnKbW
 YzLnX6OtJj/ew7+Ove300Et9WuP+hP/PVk50/MN1q75+YKh9pmwsOQD+eicx3w2Fuve8Jjvu/O4
 83XlAps5aVr2ArujfeOnPbZWPi1X9kfklenrJxmpUzQMAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,unisoc.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D6D757B3B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 12 May 2026 09:47:33 +0200, Johan Hovold wrote:
> spi: sprd: fix error pointer deref after DMA setup failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: sprd: fix error pointer deref after DMA setup failure
      https://git.kernel.org/broonie/spi/c/3d67fffb7426

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


