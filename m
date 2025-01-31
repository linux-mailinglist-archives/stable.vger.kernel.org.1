Return-Path: <stable+bounces-111774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20512A23A8F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F93A96A8
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1B16132F;
	Fri, 31 Jan 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="GkXwtZor"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B38632;
	Fri, 31 Jan 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312080; cv=none; b=XN4zT58r5MYJtyDIwrC/xPpi/OtYMr7NWZXVWZMwplcxYl/IT5yqliLcrPPaSF+5yzR3E/4MzGwHpUG1C4h9Q4yszhuZiNRU80IlC6+MhVSuG5S/q2ZzrVoZqNHRR/2qnDNQ2LMhDI9W9ozIA66cwiHr8D/JXCAt+n/zWmuA894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312080; c=relaxed/simple;
	bh=+lQ88HgYihnZe8QsK+4BdBsUiUilDPdJ3jiVQhGb30I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s990DB6nwZEhDIZZvx8/NCWegbdOnRdyJNZARMzRjw1+NvaoFOjkGz48NW88qMfzG+aYfYT98k6aY8Nn0X+gyT0V9xKtUHRMgov3PaqEPNzNkzpzeSb5GEEfZQdjPec6sYYY58QbyMcNqMG07njvSYtZLYjFCda12FzZX+wk1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=GkXwtZor; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1738312067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+lQ88HgYihnZe8QsK+4BdBsUiUilDPdJ3jiVQhGb30I=;
	b=GkXwtZorWGYMmFiZuQcW9e80jh4ByTO/BpgMtWWZZ3sRlTy+ibu6KAAdARJ95IhgdJnaoq
	VzQTcdSVTYVJlgfdRvOFQ2jTTr9MW3wzgemRwqIjA9/dCvBppeXRm7zIQ2/7bn7CoSRXog
	vcryloj5Bau0wVDYlRIfAOUIZX3OP+Q=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/5] net: Backport fix for CVE-2024-43817
Date: Fri, 31 Jan 2025 11:27:36 +0300
Message-ID: <20250131082747.4101-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://nvd.nist.gov/vuln/detail/cve-2024-43817

[PATCH 5.10 1/5] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
[PATCH 5.10 2/5] net: drop bad gso csum_start and offset in virtio_net_hdr
[PATCH 5.10 3/5] net: tighten bad gso csum offset check in virtio_net_hdr
[PATCH 5.10 4/5] net: add more sanity check in virtio_net_hdr_to_skb()
[PATCH 5.10 5/5] net: test for not too small csum_start in

The bug has been fixed "silently" in upstream with the following series
of 5 commits.

49d14b54a527 net: test for not too small csum_start in virtio_net_hdr_to_skb()
6513eb3d3191 net: tighten bad gso csum offset check in virtio_net_hdr
89add40066f9 net: drop bad gso csum_start and offset in virtio_net_hdr
9181d6f8a2bb net: add more sanity check in virtio_net_hdr_to_skb()
fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

