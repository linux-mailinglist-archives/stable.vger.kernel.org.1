Return-Path: <stable+bounces-6796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB3814609
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758C6284096
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE21C2BD;
	Fri, 15 Dec 2023 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UsyWWptT"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DA18C2F
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 315EB1C0011;
	Fri, 15 Dec 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702637947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DpdWacBeVmA/hm3BZ9y4VmrrqsusBo4XPro7WpjvvY=;
	b=UsyWWptTAHwwGOCcNJ4fSN6Lrz3BPwQsCTfMAUA55rtU4qfVBRnAtOhGwuf1HVU0GI1yPg
	oQiXvTQTxoAW0QYNbshTaxwGwGcYPXgCoyltQx+Ks18slm0i1wcS8SXmwGaXvd14LK98fH
	OJ0U8qbLb8idRdApoAXdsJ9yEHP3I/QYkVIA4hdK78zrIeGwKsQBKye0pdATo6C40yPaBn
	pWgEckrfOz39xg8Wjulva1huA4XpkPRVbAgNzSLIyJU8LIKLdvrrLaJLqA5Jns3jthpxX3
	OB5LdEF1DBJ6fTKtU4X1Vjzp8ovmrwQsWFeR50KKs2Ujg6UoQut7MXjydpH0yw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
Date: Fri, 15 Dec 2023 11:59:03 +0100
Message-Id: <20231215105903.499114-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205075936.13831-1-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a7d84a2e7663bbe12394cc771107e04668ea313a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-12-05 at 07:59:36 UTC, Miquel Raynal wrote:
> While switching to ref counters for track mtd devices use, the vmu-flash
> driver was forgotten. The reason for reading the ref counter seems
> debatable, but let's just fix the build for now.
> 
> Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312022315.79twVRZw-lkp@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel

