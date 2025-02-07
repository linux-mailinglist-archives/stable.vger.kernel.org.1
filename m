Return-Path: <stable+bounces-114323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2FA2D0F3
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FFB3AA81A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94351C6FE6;
	Fri,  7 Feb 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erjRm+9y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769E1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968654; cv=none; b=IJpS2tcSWn6N2z8qNze0s+l1+OZPAsLsyheIyjmqF/nHNPsiUxJB7l7NkgNvDM/rzx0wI/gAB9v6hBjdK0j5+XHgcjiXlHFC6y19oSlL3bB2+RfMf8TuIykfNCtI//pn76KYZ3idC40xfUNJ2+mh2etOv2zhIFh37zVIEMPsrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968654; c=relaxed/simple;
	bh=1RwRe4kCdlt4ddvCMlpADgL25NK60t/Z5CgrwRn4XBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbJnXtOTZ1Boo/um3KnIMNv2xkZtedWkx1I338AfzMpziKxCDc2vPXGa/NHO13zZTT8/w2H7qkWsajM8/EJzjdaUS42qZYcNqH4dF7JUg4duDPNv/sT/YrdCddhqWk4vbZQqyTOaX0QkPy6tDneUq3UNXDTrBUHMdX9tjjuuiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erjRm+9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FDAC4CED1;
	Fri,  7 Feb 2025 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968654;
	bh=1RwRe4kCdlt4ddvCMlpADgL25NK60t/Z5CgrwRn4XBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erjRm+9yj3F/76+vCSp0UfwmgZhXYq8AA00bB6/tMrecf1hTgTgBA8Yh3zaHyLYUY
	 nd/5Ow/Tlfh/Z7TtqHFtX4Kbgu9PnLWx6jIlFSNlmmjRRZ3EXr92qNqupIWK2Hr4uA
	 FgrIC7LLmhT3eTwtkcjOT/H2daC1fqdZ1gVe2omQfShI+SBHxQj2olk7T/Wj3Kbyqi
	 ldIXuQUL8vxX8Wm91VPdO3yUzBEC+VCKYeRP0pqCzSs9+W5FBP9CznlC9Klvr+F05i
	 IhqDX0Ab6gRKq3mVi1Xp15XQbOV9Q/wkAcUenSWz/6NoVqYrt2Qt5SAFizFdQhRW/p
	 2zoj95ngvh59Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: vgiraud.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] net: Fix icmp host relookup triggering ip_rt_bug
Date: Fri,  7 Feb 2025 17:50:52 -0500
Message-Id: <20250207161555-b1a8749027831a1a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207151105.2513351-1-vgiraud.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c44daa7e3c73229f7ac74985acb8c=
7fb909c4e0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: vgiraud.opensource@witekio.com
Commit author: Dong Chenchen<dongchenchen2@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 9545011e7b2a)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c44daa7e3c732 < -:  ------------- net: Fix icmp host relookup triggerin=
g ip_rt_bug
-:  ------------- > 1:  78fc851b6ed29 net: Fix icmp host relookup triggerin=
g ip_rt_bug
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_p=
roperty): /soc/clock-controller@6400000: Missing property '#clock-cells' in=
 node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
    Timeout, server 192.168.1.58 not responding.=0D

