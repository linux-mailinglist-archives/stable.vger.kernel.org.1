Return-Path: <stable+bounces-106216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAEE9FD617
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B411625CC
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107C1F76C2;
	Fri, 27 Dec 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sScArNhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C31F754F
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735318280; cv=none; b=f5fyf/eEIksTKXGpRw06mybh5bBHdWIiZlh3GG3zlqQTDa9Wm5D2BJvr6dxXmgQ/+L9ikbXjeKFaUlPqhjGoQ0OE0Ei/kU2D58h7Zd7a5v8aGzQvJw4QCnK64nxwc4p6ONkGbn+K5NJvkV2ila+e+vnR+drGxYouqQ9+RuOcmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735318280; c=relaxed/simple;
	bh=zZiZuLlCCtme2aMwIry3D1QcdPrm1ejKl5jJhTk4+yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4s2BVCzBU4x2iKxJBtMPf5PYKQ7WMqZX2ccPVic1JBScOz1D+y8PnlLsjXouMLOkkn8CGGyNNpitnC++WVkiEzxaE8G1mGZKrKILn0svSj0+MAT1tkjxDvjYZ+hRUABJry+mJbUfz52p0qqyfdzJD+wWzh0GTcrrf46E9EDzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sScArNhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF345C4CED0;
	Fri, 27 Dec 2024 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735318278;
	bh=zZiZuLlCCtme2aMwIry3D1QcdPrm1ejKl5jJhTk4+yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sScArNhDUpT/AC4Gb3zl9HwZ8YPZvyDRoVsofDSbzdYxqQtK8EJOK1ZiKVDa2dSGc
	 sWhBxZzRuVRcGsCDflimQKPuvY8JP7BQM4ZzBcmmXaAoBnQeEK1Gf0tstvjZ3DU5cE
	 AKZePJtQpu4ts70ylirVNd94uIzW99+DJUv8n5M/3M6+/di3at3CZaeAikXFTy2W6D
	 1ju5lvpLU/M/aO2t+z16NCp3zvYTT9iOGsejmM1tkvvmnaat6FzbhbyVjvr24s4d6u
	 ONhqmvSmfav7n36WWEptrHbVbltEcwFAZs5bnXmAzk2+LGy7rgVaZXXbDDW+H+czGt
	 D3wpULBmVRQ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 5.15 5.10] bpf: Check validity of link->type in bpf_link_show_fdinfo()
Date: Fri, 27 Dec 2024 11:51:16 -0500
Message-Id: <20241227110722-af85231900bdc2a5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241227060437.76331-1-shung-hsi.yu@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 8421d4c8762bd022cb491f2f0f7019ef51b4f0a7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Hou Tao<houtao1@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Failed     |  N/A       |

