Return-Path: <stable+bounces-100643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45E9ED1D4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877432812AC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD01B6CF3;
	Wed, 11 Dec 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7z+osjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164E38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934725; cv=none; b=TMOWN9XzBjLxyZRDkNlFD3S88YBCEZFRbNHBgYbRpGQId4rz/RnQgjky/RsajlmKjtUHFRuMTWA95yh8HKtSjTq7QOoCgV6V+CAaZZyJrrt27hdjl185z/I0wByprTmuxv9wx3ffSGzzWSE6z+7N9Zww1/YftdC5TcUhBM4R9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934725; c=relaxed/simple;
	bh=Q4N93Xbs5Luvn79tQCXm+LFS7UJwIQc4Tje99ucy5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+wPMl9J8JcmnnCiqAuCSKGtenOWt12QXVMvtBAN4ESKL5zEp1tLo57byzyGHLh3BdwckvB9Ig5qz62ePFUe0Tj1TlnAWzCKU9HG4FKITdKRXOFlr19xyuErp88bZup9pMLa7wqBRwbKeLmdmc8BXQXUhcW7ESf7Ut5YOC8ERqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7z+osjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE153C4CED2;
	Wed, 11 Dec 2024 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934725;
	bh=Q4N93Xbs5Luvn79tQCXm+LFS7UJwIQc4Tje99ucy5zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7z+osjMLgKNiSjnunS9YwqRDZCbKq0EGdGcYdslteLwke6yrVi8Z6gixd0qn6k9/
	 dB2lS4jwsR7/TouLnRX3+3K1NuD8xsXD6vnY472ZkqW3b5q0aln8lY+aL3P3oGz5Oq
	 QwP7wBtTRHeffs4IyaJqd8eqivHLfTgip+7HeEwAEymVmqNKEm9XOulxZAq9Be+1+c
	 oop1sWIk4AeSaWiIiNFr4KSLv0ROsFHwwMmA69yJZyHdRBhdsQk/73Rc1FmSB78e4A
	 Sa5ohoTN0DHgFdAjngW1FbsdUjuqIMF1YRXhi6aTdkzYV4KfZDIAMLdHTwWL7xBo1/
	 ls5KOJYjEVOUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Wed, 11 Dec 2024 11:32:03 -0500
Message-ID: <20241211101711-bdfda02f35e7ebac@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100811.2069894-1-jianqi.ren.cn@windriver.com>
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
6.1.y | Present (different SHA1: 41a5b35ed3d9)

Note: The patch differs from the upstream commit:
---
1:  652cfeb43d6b9 ! 1:  b719631ac9586 fs/ntfs3: Fixed overflow check in mi_enum_attr()
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

