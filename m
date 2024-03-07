Return-Path: <stable+bounces-27101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A1875525
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B34A1C20F5E
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63305130AF3;
	Thu,  7 Mar 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b/IflWcv"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B346130ADF
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832530; cv=none; b=nmTm7oCzwni9Xa51N7iPjELwcOzi+L531i0HOX5apOWIw46AgHZSV0o06unZ2E5B9ldxGpPWGGNu7dKkuakA8u1h0xcA/Us7oW0/ZUdoSK+v9R81ecmH2xgWbGcl9V5YQDtPc3Qkywfw+8E6N2mnd3KiqoAnKUU+1Jvt0M7bihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832530; c=relaxed/simple;
	bh=1Nh3LjwUEpTCXcFNd3igNK7G8AUnhMQ9EPuvcLGlfbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzmGwjtHjJM0JL9WrxNdX401sBfSv90M3DoXTPWVbmNSqMhE05mn24ygTu3Vm+SAPVFAqhSXUHxR2BcK7O2IzwhrXDCwRiXOawVVzt4JK8fppjVSPEgLoHx4umhifl38QkaR0LmYHljP+N/ZQ0D3+0pQs9QPDGx0PS7SuY2bah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b/IflWcv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B51D40002;
	Thu,  7 Mar 2024 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709832526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2e3/6XO20oG2XDljssKzak32D0T1QE2mvDvHVnEscA0=;
	b=b/IflWcvh+HMQyPmPHjvGylFcoQfn8Vtu3ZBCrT9gPP6WB93KFdDbbjg7oVa5wrTqUhwie
	C2YHrC3S3TGkLV49Fe3av5FVcXY6Q5tDOfJ47CtkGrSYOXp7vEgC7Bd3KH9M5xBy8wUyh/
	bCO5jyi/gKxb2x55TklVZL559u3cveKArW9XMoydAPClUmB2IVnRUZ0lrsF8eHjJV10Wdo
	gETcegNlBykHSLB/7Z2RZpV50T/IklAFgX3wNyKAjRhZO/lSxfZQJY2CWZIHodGF03z+fH
	bjQnMOWfAkwpqlFOJOWMv9uALIF70/J7bRG0NSvbP5lE+XzRy8j2zPjDAFivgQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?utf-8?q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: rawnand: Ensure all continuous terms are always in sync
Date: Thu,  7 Mar 2024 18:28:41 +0100
Message-Id: <20240307172842.3454534-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223115545.354541-4-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4a18a8c8ad8a8921004e5c9e3b59223f95d6cb37'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 11:55:45 UTC, Miquel Raynal wrote:
> While crossing a LUN boundary, it is probably safer (and clearer) to
> keep all members of the continuous read structure aligned, including the
> pause page (which is the last page of the lun or the last page of the
> continuous read). Once these members properly in sync, we can use the
> rawnand_cap_cont_reads() helper everywhere to "prepare" the next
> continuous read if there is one.
> 
> Fixes: bbcd80f53a5e ("mtd: rawnand: Prevent crossing LUN boundaries during sequential reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel

