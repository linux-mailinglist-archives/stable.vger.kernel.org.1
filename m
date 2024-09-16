Return-Path: <stable+bounces-76169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056E979A33
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 05:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A002283596
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692081BDCF;
	Mon, 16 Sep 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NHg2Onyp"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C58EEDD;
	Mon, 16 Sep 2024 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458990; cv=none; b=hoPW1WMEklFzcIyXS45n2VoJmuJlnkRRWxairq9AeAGUc5McBo6EkCIBdaHed1TZyshdnYqSshyn2xEflnVI5NLq9yow8fwvJzfXaJdsQBs81YvAHusYk/uDPi1vThpIHCBH/6CZJJxaJAAZbPMXlzPP/CgU94wkhnjkOcQrTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458990; c=relaxed/simple;
	bh=uQeCiuqofbp7VBgWJBHIBiFbeaUu9Qm1y9Nz4rNP4v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AybFnbjNMjHD2azlJv0t6U2+lrI77QYJ0rZk6Ks2Q9YEMvNhEjyvgFehcvb9bunqAEB5SsYkxJsBQfw8JPLyU5dFK2ngyel+SWIXXZ5XqD6P6pwzz9yTUFsjI3B1UuOs9hwgeG3MJi7G3FR2wWWaBM9O+7/wt83EIaNwXYxhy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NHg2Onyp; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726458979;
	bh=uQeCiuqofbp7VBgWJBHIBiFbeaUu9Qm1y9Nz4rNP4v0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NHg2OnyplKoc7xXZNOiUMEJzcbsEPOJLA/PJqG9lqcXBGyxNXE3SmR7ZhH7fZOglv
	 QnPT/kHapnE5NEzaclkEswaYMnWcrryllvn/tOM1jqitmpxbLcU5QEHh9h8l/Sk98t
	 W7dPOzuRHSJlXhQyAiwq0/57UqGgeTVOjaLhZNqo=
X-QQ-mid: bizesmtpip2t1726458973t9xfue2
X-QQ-Originating-IP: 4+X9rNC0rfWCVm+jTaZrmC9K3XSZNEdwwr0L1XVgKWM=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 11:56:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14186944467596871158
From: WangYuli <wangyuli@uniontech.com>
To: christophe.jaillet@wanadoo.fr
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	devicetree@vger.kernel.org,
	emil.renner.berthing@canonical.com,
	gregkh@linuxfoundation.org,
	hal.feng@starfivetech.com,
	kernel@esmil.dk,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	walker.chen@starfivetech.com,
	wangyuli@uniontech.com,
	william.qiu@starfivetech.com,
	xingyu.wu@starfivetech.com
Subject: Re: [PATCH 6.6 v2 1/4] riscv: dts: starfive: add assigned-clock* to limit frquency
Date: Mon, 16 Sep 2024 11:56:10 +0800
Message-ID: <87764635B0614447+20240916035610.64002-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e2d7ed77-827b-4b7c-800c-9c8f3bcb6b5a@wanadoo.fr>
References: <e2d7ed77-827b-4b7c-800c-9c8f3bcb6b5a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Since this commit is already in 'linux/master', changing its title for the backport might just make things more confusing.

Thanks,
--
WangYuli

