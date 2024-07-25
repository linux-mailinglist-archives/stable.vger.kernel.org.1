Return-Path: <stable+bounces-61358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CA93BDAE
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 10:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C211C219FC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB4172BD8;
	Thu, 25 Jul 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VICrjWgl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B85249ED;
	Thu, 25 Jul 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894829; cv=none; b=knYGrcNY6r8SHxcjuJpokCZtOCkOCcTM5ochkPWxQGiWIWh4kQy/v5sL8Pk30R9unS6L73nA+ArKmjZz/BsRc3NUlp2b+U1OK5XZ3afCYPBoBpaF3NFdvp4aUGLgjTA5LLNhBvIvNo8ecDS+DZKXuPG9G0Sxa3FvJc7MIckE8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894829; c=relaxed/simple;
	bh=et8MeDpeM9VgJU3uJLRPA2b7BO3/WQzeSLIZTNsZP3Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5WjZqSCuQDYLscj0oh5y+o8eb8qQGnxcodPgpO/gmhLCGRF96b2ld70BmM3JA1hSnCoWjHLkxLH7CcFcaprahcO7A/ICrZnBAq/k5dRsw85njGgA8VFZfAJYXI8duD8sndmFgrJ0HfQWo0MsWKp10aI6qRnctXewF4KlbySUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VICrjWgl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ONvp71022308;
	Thu, 25 Jul 2024 01:06:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=voXGv9KufQht/hBsYwa1gfH1E
	e9PQIKr4zcoBTbC64o=; b=VICrjWglr/C9vTUWnRar0dBTtQThFv2Za8KUDQI3k
	MwvFvNNrET1czJ//Wd41pPOhzq6dLNe6x32+CwqN4siJ1ShA9mx5AvfV3jNX43vk
	hNB7qjuJNXQp8vvLJuRpGsd23JwjhIgqaUgkMTjoBcOf3IOHf5fq3cNH1vV0MxAW
	DgRRUiCtpKD38DusrtHgM34XYKNmNfzl5O6wEdQ0EWf5qikb09cbmTGJJY6/cgrY
	5VCqqJkarTCqAdrFWRNjS68YNt+N39bTMZg7BswTwhvc0vHxkxDHnbWgmv2Tlymk
	KOrIWpeCElUp7A8yURIf2r5QPgXPAjG3VdhAbhuPXvr0A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40kbr9s9ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 01:06:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Jul 2024 01:06:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Jul 2024 01:06:47 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 5F6CD3F706B;
	Thu, 25 Jul 2024 01:06:43 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:36:42 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Shigeru Yoshida <syoshida@redhat.com>
CC: <make24@iscas.ac.cn>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <liujunliang_ljl@163.com>,
        <andrew@lunn.ch>, <horms@kernel.org>, <linux-usb@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH net v4] net: usb: sr9700: fix uninitialized variable use
 in sr_mdio_read
Message-ID: <ZqIHkubX0KK8psPv@test-OptiPlex-Tower-Plus-7010>
References: <20240725022942.1720199-1-make24@iscas.ac.cn>
 <20240725.120100.2041590414991833213.syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725.120100.2041590414991833213.syoshida@redhat.com>
X-Proofpoint-ORIG-GUID: Cy5fQBZvMOQ1GOPt0UXNsc6IkZ_aefOF
X-Proofpoint-GUID: Cy5fQBZvMOQ1GOPt0UXNsc6IkZ_aefOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_08,2024-07-25_02,2024-05-17_01

On 2024-07-25 at 08:31:00, Shigeru Yoshida (syoshida@redhat.com) wrote:
> On Thu, 25 Jul 2024 10:29:42 +0800, Ma Ke wrote:
> > It could lead to error happen because the variable res is not updated if
> > the call to sr_share_read_word returns an error. In this particular case
> > error code was returned and res stayed uninitialized. Same issue also
> > applies to sr_read_reg.
> > 
> > This can be avoided by checking the return value of sr_share_read_word
> > and sr_read_reg, and propagating the error if the read operation failed.
> > 
> > Found by code review.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> 
> I did a quick check for sr9700.c and there seems to be other
> suspicious usage of sr_read_reg().  But, for sr_mdio_read(), I think
> the patch is sufficient.
> 
> Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>
> 
>  Agree with Shigeru, may be you can submit another patch addressing
>  "suspicious usage of sr_read_reg" this patch looks good

Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

