Return-Path: <stable+bounces-46295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA718CFFBE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F88B23E6D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5EA15EFBA;
	Mon, 27 May 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NAtbkWQ4"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E615DBB7;
	Mon, 27 May 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812104; cv=none; b=p1YwlW4eZKdxWXA5j1cAHHk62EkvF5tbMlug8/Hux6mNAeL5Per9bC0JGu/RNXa7mQW4xOWbe+jedOIM2RKG/tdX1nMk6Ue0h7NGCjDfV4ynX7756cLxhKyGYt2xwiWAVpDSYdPK0hnlYGWIg4u4XzTfygXnolS/C9TdZMiuyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812104; c=relaxed/simple;
	bh=fo1OuNp8nv8MD5H3UFcyo/4ZdXWMGXiogOpS+3aMxJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adEcQHjFJS2L4NRU1GdRLk/o6t5pfZzKseCKWS86xe4YABBX4YHBg+ikIyAUCe+bry75OWukurQcvQtd9oN8Zw7IAoWh2PIhK/7Vj6QN3NTnAkpRrzbto2V25Z74pwIy0RqEHMyHijAiCRJWEFVfHx2oV3joaraNuFXRAc19iLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NAtbkWQ4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63BBEC000C;
	Mon, 27 May 2024 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrVdm/z2KvEg0yrOWu25wDX0USnHvBtchkP2Qgvi/GQ=;
	b=NAtbkWQ4kSk5tHLF/oQ6om0bg/WONKQXCF8eNDvX2hs2jjRjwRju1xTWDYYOSNnCV//GE8
	9r14Zar2835r35aPdW+jborI8AcU277ShICTaAoxXQRQUhrF16cOb5+KNM2S2fT9Wtgp5T
	XELWvf/LXocc96xrD1O6NbAVAfmoh2N2fWfcYV3Yehi6HJrytAn1GLW/xxzlRkrfh6tsC4
	M6/03LKLVzLGOmuCuOCZZ5XwUfxjYocgsdFh3MEzxXtvlWazpZY4YDRnyKA+MXQAAtpAOp
	CjT0tBWyOIVvuQZusP2d5Ee0MfFJjp4IQ4Q/O22w8ErTlMd6dJJkHQ03d3LLZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Val Packett <val@packett.cool>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: rockchip: ensure NVDDR timings are rejected
Date: Mon, 27 May 2024 14:14:51 +0200
Message-Id: <20240527121451.29710-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240519031409.26464-1-val@packett.cool>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b27d8946b5edd9827ee3c2f9ea1dd30022fb1ebe'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sun, 2024-05-19 at 03:13:39 UTC, Val Packett wrote:
> .setup_interface first gets called with a "target" value of
> NAND_DATA_IFACE_CHECK_ONLY, in which case an error is expected
> if the controller driver does not support the timing mode (NVDDR).
> 
> Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
> Signed-off-by: Val Packett <val@packett.cool>
> Cc: stable@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

