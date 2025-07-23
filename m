Return-Path: <stable+bounces-164372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B0B0E99D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E5E5632A3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B282C1DFE0B;
	Wed, 23 Jul 2025 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldp1wYtH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CD2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245235; cv=none; b=UP6g6IvXzl+DrM6tRFb72Ubppu9RQdnJexfr5Itfiq/0LbqvIfKf9PMjHeKUbS8y/HQk6d8A5yOhI+lWOKHF7ggySL6L/in4+qz3y/pX7Zwg9VVqq8pur4rdzVh1oJET0PcpgXArhNpLktDkdbvqCfAze2/oOvESc9/soL6qU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245235; c=relaxed/simple;
	bh=VNUB7iMKPiz5wZD+jPvXUWB7mYzo1RzfCiAGfeHkqqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1U8JR5Md5caaKLgab3zrbzZoBGMg+FwgJ/acfcejb4ym/jebAbcV46D0NPdsUxjxlY21WHp/iPkxW7a86QJ3x5GUmjh1ktiNFqCOlzzDxKrpiHQfdhBwdUqoyzxK9C+SBrupxa0KXA1UB89l+AALXXYjSo6AFldFougXmkAuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldp1wYtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EEFC4CEE7;
	Wed, 23 Jul 2025 04:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245235;
	bh=VNUB7iMKPiz5wZD+jPvXUWB7mYzo1RzfCiAGfeHkqqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldp1wYtHvDuUbmAt965Coz33dkhj8fTdjYVR4V81ezUEbZE0UvSUT8GMwXXUdqv5k
	 8Zy+bul2F2k/zJIhXkRBpJpgW+1HILS+CSbuBYAA9nQdBIHSdzHNFKtQBQwOAMlD9b
	 +WbUYavIEGi9Qiqc6Ru7/4RkbGWBpEQWQFeBJABDq0xmkJXGNHckH+wmKtdbTq/S3X
	 uYPk+RFfitsYh9UQl3c2j0051FoXgCKNS7anD16kTrc2kFvMtmovj3kpo2obP4ULBs
	 NfNbLZsCyNhiS8NM7enW+6nXD/wKQqmCPGB5WT/dFnieSTm3egXBXqQjr8gyJ9JdcL
	 vHspDs2Cii52A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] net: libwx: fix multicast packets received count
Date: Wed, 23 Jul 2025 00:33:52 -0400
Message-Id: <1753234538-d2a2c5ea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DCAB16D0A9C714C3+20250722020037.3406-1-jiawenwu@trustnetic.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

Found matching upstream commit: 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2b30a3d1ec25 ! 1:  e778f2ab1e48 net: libwx: fix multicast packets received count
    @@ drivers/net/ethernet/wangxun/libwx/wx_hw.c: void wx_update_stats(struct wx *wx)
      
     +	/* qmprc is not cleared on read, manual reset it */
     +	hwstats->qmprc = 0;
    - 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
    - 	     i < wx->mac.max_rx_queues; i++)
    + 	for (i = 0; i < wx->mac.max_rx_queues; i++)
      		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
    + }

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

