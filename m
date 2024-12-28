Return-Path: <stable+bounces-106229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948859FD997
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 10:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171753A2998
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51024524B0;
	Sat, 28 Dec 2024 09:25:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E13594B
	for <stable@vger.kernel.org>; Sat, 28 Dec 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735377919; cv=none; b=i+FiHOjtTqe85Z/e5e7R2QtqMG6Gb/GJ1Z1sD1/kFocmzecHCaL+tmoEO/EuTkOseLZ8ltytRwQtY2xDoI0w8d9FpCyknspCd1t10sM2/fS2MSJq0wgDJcM6XLetaYabVcaZGMvyIeqiG/YcI90PGyMa3vicwgkXnrVeSZSZKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735377919; c=relaxed/simple;
	bh=gdF0+/IKFS1FB9wEhi6/Uax5ANVCaWMlDsPfmDyt+uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfbPCnyKX1lsJSdgbWrtPK5SehtaXNMHuDEiamJpshO2PIPbnLRANW2JFZzZLsYyiD2xopYYfWmJr0DP0CtQKXVzkdReQjB71lyeodzMV7iLDkr5ZZu7Cx2fa2mx2tLkEIFciw6JwgBIz960m/4LUuoD4hF8NQYK80ZfX3EQXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.116.6.180])
	by smtp.qiye.163.com (Hmail) with ESMTP id 711cda3b;
	Sat, 28 Dec 2024 17:25:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: heiko@sntech.de,
	stable@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re:Patch "phy: rockchip: naneng-combphy: fix phy reset" has been added to the 6.12-stable tree
Date: Sat, 28 Dec 2024 17:25:02 +0800
Message-Id: <20241228092502.544093-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUofVklOHU0eHR5MGUpISVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkhVSkpNVU1VSkNLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+
X-HM-Tid: 0a940c95682e03a2kunm711cda3b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6HBw*LTIcKT4sNSMrFjU1
	CzRPChJVSlVKTEhOSExMQktNSUhPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSk1VTVVKQ0tZV1kIAVlBQkhINwY+

Hi,
> This is a note to let you know that I've just added the patch titled
>
>    phy: rockchip: naneng-combphy: fix phy reset
>
> to the 6.12-stable tree which can be found at:
>    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>     phy-rockchip-naneng-combphy-fix-phy-reset.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please backport this commit together:
arm64: dts: rockchip: add reset-names for combphy on rk3568
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b9c12757f919157752646faf3821abf2b7d2a64

If apply fails, please change arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
to arch/arm64/boot/dts/rockchip/rk356x.dtsi.

Thanks,
Chukun

-- 
2.25.1


