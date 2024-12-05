Return-Path: <stable+bounces-98779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06839E52CA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00A7284D20
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B171E3DF7;
	Thu,  5 Dec 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wi0ENRct"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA131DF997
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395424; cv=none; b=BTvEpfDhgOeiw0vKXwEI9d7q821vsYvUpwn18ZaX1P3Ls6NtOpO2dimpYc/7XfR5gWKtEVvstFg2hn3yM4QLWExmacobHDcafuqsOlKlB1iqpD3Ix41aUxIgss2m145ka7fA7pO3anDGcxh4W7x6jqMqhG49lGwHwSYRvEvMesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395424; c=relaxed/simple;
	bh=eW5XBHtEvX7yCQsLiYq5unZUl4xzXkSus5XYyTilXuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfof5XKz5V/x75HvzCHLCconaunsKqckkRdFXHuN/XvQmoOodMcruDw+nr29RIbr57MkD/VOocSjQSImlvhvV9iAPbnzSRV/wzMa66XRjfbCWEn5VsrWgAajUlqBhd0TdU2mydZZzmjVaGsoiePwrEU7ftQsio8WQs+RdqrZK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wi0ENRct; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97683FF81A;
	Thu,  5 Dec 2024 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu9sHg5vcrBeKKUlB5bJl4UwuotFEnp384Lb4gvhaW0=;
	b=Wi0ENRctm3qA3NsLpn8vukK7rs+4Px0my9U+4TG6MbHOXMnfIHTlC0eD09DHPM9pDnC5oa
	48cCOJusf4pLP8xx/trLgCqZoKgTtyI0+dihZHpjv+9EFHXnOQdt6S4E0U2vKj3x9V7qWF
	aczRLWDNWWT+hNCVqu3lCi/MninqmBqKWx4XKELdX/NQM6cCpwzPNDgBlUTvXyOS67Jl57
	hX5TnHPOMW+Cqgyjnw3/V6zEpH6TBmlLNlbylTJ0M7AKB/9Gt+iCnsQDcwmCjN/Iv0QlUF
	A2A4mp4EXIvd54+Qaqk1DXE40FyINVb3HoVFP595S+uH9OhGWgnPNbw7Pyrq8Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at,
	vigneshr@ti.com,
	arnd@arndb.de,
	dinghao.liu@zju.edu.cn,
	Gax-c <zichenxie0106@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mtd: diskonchip: Cast an operand to prevent potential overflow
Date: Thu,  5 Dec 2024 11:43:31 +0100
Message-ID: <173339519114.766262.17486555724920350115.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023211310.13015-1-zichenxie0106@gmail.com>
References: <20241023211310.13015-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 23 Oct 2024 16:13:10 -0500, Gax-c wrote:
> There may be a potential integer overflow issue in inftl_partscan().
> parts[0].size is defined as "uint64_t"  while mtd->erasesize and
> ip->firstUnit are defined as 32-bit unsigned integer. The result of
> the calculation will be limited to 32 bits without correct casting.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: diskonchip: Cast an operand to prevent potential overflow

Patche(s) will be available within hours on:
mtd/linux.git

Kind regards,
Miquèl

