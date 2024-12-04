Return-Path: <stable+bounces-98574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D89E48A9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88853281873
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AD1F03DB;
	Wed,  4 Dec 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MACIljfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49619DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354578; cv=none; b=h8RbUJiTS2dE2m+nn1SiwO9aYTIHXhn4vhuXC4tz2nQ76peVVp5IONZoyoW788owdtyMLhJNWiSQsGm+2eN2xR/Qt2TsnmYcgYA5G7qP2GHjTCFEu/cZlUoypWFB9fbM2iXh2FaguzNCat31QYBpNA+/bT7rXQHKCNLdOgrxR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354578; c=relaxed/simple;
	bh=ZzrkxB4NsdcDdx4AFk9SK1tI2Gz9PJNHQFJSFWD0QuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwx4Ev8q4lZSTeS7MPaEM9l3kdbVQ24Ibs/31DK5gFc/I1ph8f8qB55PMbhRvNLrZAgqc3GT2KFSdmsnGfqsW6HlOrEgQMaevJth0vKCWA57QVMu5Ao6m4a9FqyfrawZXEG+hK5DLMTiqgfeLXb7psFxlZIz7gwg0KnySqCaSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MACIljfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213F0C4CECD;
	Wed,  4 Dec 2024 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354577;
	bh=ZzrkxB4NsdcDdx4AFk9SK1tI2Gz9PJNHQFJSFWD0QuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MACIljfSKFmJwA5UuvdQzFoS73y8uhJLFIaSYXQ55Gt5/UCjuxyUimjPth4NocSx4
	 iH49BeGSByjArg741dB9ZtWaPw6EJegoZfrbiDCIKpA9LMWn1FokU473rmT18b0Aue
	 HnInQmEQhu8OH+3DUIKpHJX51VuzLNT/ngMv29FF+kRogGFj8q0VLkeqsr3o0e60x7
	 jjyP3gEI4Ae8irQ3AV8wRpnjyK8WoJAKTRg/iC1pj0MvldtUDxqZc6YiUOMbeSwxCq
	 LX8qYmMmlbEnrw9A2In/TrPZRQXMmevTSNtOsGRVB/n6iKxvS468QS415ecxdwGE6T
	 PsDdHGD22Xkuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 17:11:38 -0500
Message-ID: <20241204065037-447ae17be805de83@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082231.129924-1-zhangzekun11@huawei.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-4.19.y       |  Success    |  Success   |

