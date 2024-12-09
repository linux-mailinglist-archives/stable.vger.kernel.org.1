Return-Path: <stable+bounces-100201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDAF9E9900
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CED167580
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87061B0427;
	Mon,  9 Dec 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1LWfVBB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F21B0403
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754928; cv=none; b=tA4bwwA350Ct1w1ekL08mdIuXjcs57bAJ8XbPBW6NzAmbPG2qjn2O107s4rnNlEz4bXqT81uROS+I7qyOaqzRIRoDe88Sj9BXjE+6jAAj/R99kGJAuZXQ+tcb0+Lt/2hTP8W6xUvFWTMfrFAvaDmaZWRJnwC1wNeIOx3O46U8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754928; c=relaxed/simple;
	bh=aYrTHxfQMR7VV9eirxb/ZRsq3TXhuElZ12X7ZnBK1LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyMHN/efrVgN2JSzrXHAsMmFZReuv7/EUoK2EDFKND1Q4orKkNFXrD6Zi4PPkNlKOb1PB3UHBVdjCxzc+5WqaONWmdP/+Qvhn5Jcbfvzlu8CgvzOdJ+q3j/V/gCxkVNN1qtK4gWo/vTHx0c4yajKNBPkiQ2C452x/OzhB0C50u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1LWfVBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD186C4CEE0;
	Mon,  9 Dec 2024 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754928;
	bh=aYrTHxfQMR7VV9eirxb/ZRsq3TXhuElZ12X7ZnBK1LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1LWfVBB0nD2DyQIzYwnmJvKz3MuvpCVdOqa395WLMyZ5D29ww1gsdha35CV021de
	 CWTZmjATotkbundogkPU/BjkibmCWzvwpddH8KACiGqWZGdSauKu3g0+ZPb+qC7hLa
	 s2wt/yBOWgT90HPr5JLhO84GU7FzX1qlauGbIrjKQE6OSUh/PLVpkPLUQfdeFV7ZdS
	 +VkhWrHMFKPJbZZRH7/X9tw2BOfZgRwMZclkBEgagYibLEnmiZZJx6rlXH3ne5xp6s
	 r52D6Wj/B36P48+S7+cxHrggl0gIonFZxRA0zHfIhC5EKGB7x+EpupI/RMN0JFwmvQ
	 KsKor4879fogA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Mon,  9 Dec 2024 09:35:26 -0500
Message-ID: <20241209082101-4c3eea7f2f82ddbb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209080541.3541969-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 652cfeb43d6b9aba5c7c4902bed7a7340df131fb

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8c77398c7261)
6.1.y | Present (different SHA1: be684526fad4)

Note: The patch differs from the upstream commit:
---
1:  652cfeb43d6b9 ! 1:  54afaabeb65a8 fs/ntfs3: Fixed overflow check in mi_enum_attr()
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Fixed overflow check in mi_enum_attr()
     
    +    [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]
    +
         Reported-by: Robert Morris <rtm@csail.mit.edu>
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## fs/ntfs3/record.c ##
     @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
    @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTR
     +		if (le32_to_cpu(attr->res.data_size) > asize - t16)
      			return NULL;
      
    - 		t32 = sizeof(short) * attr->name_len;
    + 		if (attr->name_len &&
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

