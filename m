Return-Path: <stable+bounces-191749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24EC211B9
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 999E24EE9D6
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099133655E6;
	Thu, 30 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="L2FmaEUZ"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEE3655C4
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840656; cv=none; b=L794Tja0+w16Z38UtME5lw8BcB8NIrr2UQ4DN6EAtzT68x6yxczmz2WI0pEKKqiI5QrDwc2wyaa5USwbYWwBIcn9zhoi1hW6tFQB0q8pL6DWdFkn6pavbDfNwmztPHKeV1NsNapoErikQ3uZ0g1Mv7lp5cpuiKzEwxv8ChJauEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840656; c=relaxed/simple;
	bh=uc3fIl6LTH2kJBkgsbKqTk8or9vq7SuqmUvbtr3XmOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt9SsWNWyf/U2DdgSdyAhncvnsQcPtoN/F3z8y6LntIHCm7KPnZlnYJ1GT/kJtdAQsvClA0wsqFXtq1EYHONQ3CvYbjqjzaUd+Qp9njJxJnSPi0+Jc5L5OZJJ8bQprj3qsXRRknCAeWVXfm3UT2NhghKL0BSQDKWhd8dibSIMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=L2FmaEUZ; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
From: Amelia Crate <acrate@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761840654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTUSgzh9CPD6zujj7Dqp4HX3AdQQRxmoPKLvjWKrjxc=;
	b=L2FmaEUZSm4yUfcHoI2NiynASZH0B7MKJcon1YlvserElj5ZCkC5xkX7hC2CUhaVUuYVuL
	lfgJqS2Ycms0q9ZWFk7ei5mWnb34hbVtSt3BA27OK+mg+uvfk6jtDhnW/Z0AbmpFgDKMoI
	qXUGqLFKKa4+zDgcrzjumuelIW+HqQw=
To: gregkh@linuxfoundation.org
Cc: dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org,
	Amelia Crate <acrate@waldn.net>
Subject: [PATCH v2 0/4] Backport CVE fixes to 6.12.y
Date: Thu, 30 Oct 2025 11:08:30 -0500
Message-ID: <20251030160942.19490-1-acrate@waldn.net>
In-Reply-To: <2025103043-refinish-preformed-280e@gregkh>
References: <2025103043-refinish-preformed-280e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry about that, I was fighting with my email client to send plaintext but I guess I was unsuccessful. I had just included the full git format-patch output with default options.

Here's the series sent by git send-email, if I need to do something else let me know.

Resent after leaving the mailing list off CC, sorry for noise.

Aditya Kumar Singh (1):
  wifi: ath12k: fix read pointer after free in
    ath12k_mac_assign_vif_to_vdev()

Edward Cree (1):
  sfc: fix NULL dereferences in ef100_process_design_param()

Kees Bakker (1):
  iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Xiaogang Chen (1):
  udmabuf: fix a buf size overflow issue during udmabuf creation

 drivers/dma-buf/udmabuf.c               |  2 +-
 drivers/iommu/intel/iommu.c             |  7 ++--
 drivers/net/ethernet/sfc/ef100_netdev.c |  6 ++--
 drivers/net/ethernet/sfc/ef100_nic.c    | 47 +++++++++++--------------
 drivers/net/wireless/ath/ath12k/mac.c   |  6 ++--
 5 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.50.1


