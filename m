Return-Path: <stable+bounces-65458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6929484E9
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1298280BDF
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D417556B;
	Mon,  5 Aug 2024 21:34:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.lazyprogrammer.io (static.24.185.132.142.clients.your-server.de [142.132.185.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053916EB63;
	Mon,  5 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.185.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893644; cv=none; b=hb05ZDZ+OBK5jhXFPetYLvJAIZySnpFZY5xKKaIKcgtMQMckOTPbDQ9VhvoBfA3LUNqGkC8v5PYb/W+a5iogaB34ScpHv2/V9VhVIkN1hs/iR+UpmBj5hvRF6Ma9J8xWcOMwFEn9l95R28yNPYGTS8xJIybM4HuvY0roYXD60bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893644; c=relaxed/simple;
	bh=qB5xyf1l+FpI07WUoab81fhL+edOtLz62pTJcF4aMsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRKWSWDZDoW18EXA1W1JSn5NkoUrRiZ+vzaKSHXC1sOUh7DN6/vpx0dGlzMdzqlUhXSv0rA+gKtBLQ91nYAxM9RBMQKkmm0ZiA24vJrxFmgTOsOWPm9icJwN9ZFRV+OsARw2+ylyfntgZBSWHjOCURohSH2Fa9KzXzFxM4+/e6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=none smtp.mailfrom=mail.lazyprogrammer.io; arc=none smtp.client-ip=142.132.185.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.lazyprogrammer.io
Received: by mail.lazyprogrammer.io (Postfix, from userid 0)
	id 9F7BA81612; Mon,  5 Aug 2024 21:28:29 +0000 (UTC)
From: avladu@cloudbasesolutions.com
To: willemdebruijn.kernel@gmail.com
Cc: avladu@cloudbasesolutions.com,
	alexander.duyck@gmail.com,
	arefev@swemel.ru,
	davem@davemloft.net,
	edumazet@google.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	willemb@google.com
Subject: [PATCH net] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Mon,  5 Aug 2024 21:28:29 +0000
Message-Id: <20240805212829.527616-1-avladu@cloudbasesolutions.com>
In-Reply-To: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch needs to be backported to the stable 6.1.x and 6.64.x branches, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.1.103&id=3D5b1997487a3f3373b0f580c8a20b56c1b64b0775
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.6.44&id=3D90d41ebe0cd4635f6410471efc1dd71b33e894cf

Thanks, Adrian.




