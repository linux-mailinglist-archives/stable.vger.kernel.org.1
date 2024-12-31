Return-Path: <stable+bounces-106603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C339FEC59
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C18162117
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F87346D;
	Tue, 31 Dec 2024 02:10:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD855897
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611027; cv=none; b=fBhFen1t+ITKtr6Kt6gjOlSflHgNkiM/U4JttznyHubg2jE50h8ogdO6CPzjZTlBEQf6s5R1GLeaOEDMyeajh3XSu9QrQ4WaeHJWf69E1EV3OKe8umYUadv8q08CncCrJTHfoyBy3gp65CsjrUpjJLWrEbBp4r5FKTW6QFYFnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611027; c=relaxed/simple;
	bh=T2Ju3Xn0OqcED+7SYAgXnF2ofmooqBoycjmSKxkaFEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2O8s8tt3np778pLHER0uMCMECZ/9yoJE1S1v4ffgHcJGfJu6xyxyo0KDpqDzd/ndZcw37H0ejrGW00HTl+FvI2VJgR+e2G6mZEKT9fmn464uJ0NzseWwjApX+1ng/lhmN/jhC6nToRvC3y+9jJiRB13rul71xyKMS3sOMPS6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.116.6.180])
	by smtp.qiye.163.com (Hmail) with ESMTP id 7451c0c4;
	Tue, 31 Dec 2024 10:10:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: amadeus@jmu.edu.cn,
	heiko@sntech.de,
	stable@vger.kernel.org
Subject: Re: Patch "phy: rockchip: naneng-combphy: fix phy reset" has been added to the 6.12-stable tree
Date: Tue, 31 Dec 2024 10:10:10 +0800
Message-Id: <20241231021010.17792-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024123058-emphases-eligibly-39f1@gregkh>
References: <2024123058-emphases-eligibly-39f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU4fVkNCQh4YSUlPHk9CGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkhVSkpNVU1VSkNLWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUhKVUpLS1VLWQ
	Y+
X-HM-Tid: 0a941a7a5a6b03a2kunm7451c0c4
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Qjo4QzIQVjcQExUqHRAV
	GjAwFA9VSlVKTEhOTUpKS0pPT01IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSk1VTVVKQ0tZV1kIAVlBTUlLNwY+

Hi,
> What "two patches"?
>
> This commit, fbcbffbac994 ("phy: rockchip: naneng-combphy: fix phy
> reset"), is in 6.13-rc5.  The one you reference here, is not in any
> released kernel yet, so how could they be in the same series?

Sorry, I didn't explain it clearly. Send in the same series:
Patch 1: https://lore.kernel.org/all/20241122073006.99309-1-amadeus@jmu.edu.cn/
Patch 2: https://lore.kernel.org/all/20241122073006.99309-2-amadeus@jmu.edu.cn/

They're in different trees so the merge time is different.
Without Patch 1, Patch 2 may break the combphy of rk3568.

Thanks,
Chukun

-- 
2.25.1


