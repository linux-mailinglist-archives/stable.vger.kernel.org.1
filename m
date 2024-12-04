Return-Path: <stable+bounces-98589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDA9E48BC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A6F167311
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696F202C2C;
	Wed,  4 Dec 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxNNELAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDB19DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354607; cv=none; b=hhaHohIAWX/0tCGm2pOgT4w1bUqu3dWfN4VOhUradyAOvN62gfyw7kDJ7vd5Y144uPSTWZjuC2kDr9/DmGZ7xEjUgIDi40GH3KuAR4PQjapfJaaXUerlsrEWM0UuWvGdgMt4vQRIIu9rjgiuF0eoa5qreC/7esiAKve/Q3F4yYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354607; c=relaxed/simple;
	bh=eARdX5EniKgMNFs/5q4kpGH6Nr8txREzEhWRFKUeVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hpxjj6O4PqaaB+4JrXFUWz+P2kLb1WjcUcYGmIMu4q3tpQLa8ny9DkQ0pbetK48Nn4pJzs+yWDVIQqjt+mC23TliMNDD7khot7wcHgYq/C20M1RD3vzjUOgbME3b++2MCo9b8ZTD5fQ/9UjjUUBSQsjtZ0F0VACgNLg+eZRjjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxNNELAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A98C4CECD;
	Wed,  4 Dec 2024 23:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354607;
	bh=eARdX5EniKgMNFs/5q4kpGH6Nr8txREzEhWRFKUeVNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxNNELAupWLOFZrnVl8LkKuQQTybQB4BHToH+gyaHp3Hsbwotd+uRMqyMG3T5CIon
	 rWLYfpydnvs1hRCiV6/TmKyJMKfze+iq81AIgayjISg6X6/TrO1h+j5rFwt1EjguMO
	 Cowm0AURDzt2d2XUUHK4itCdphNJN9cvFSOgLlsW0Xw/sPiMqb9KbzENTRBRXh01cS
	 uNhB2vlAwzmqNdX0pZWgxM+jW+Ek1lyyJEeLq9/DQMwy88IqKsqbD38YxgDBbl8XbY
	 yP0Hko81KxqeajH1ZSM3DCKAl3wkINsp+Qsc/49lOKoaIkj3i9QItSptjr7ijNFRFa
	 Nz4PnuHQ8xjFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6] udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
Date: Wed,  4 Dec 2024 17:12:07 -0500
Message-ID: <20241204101729-2cb294efa7ff0160@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204151735.141277-2-kalachev@swemel.ru>
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

The upstream commit SHA1 provided is correct: 7d79cd784470395539bda91bf0b3505ff5b2ab6d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Andrey Kalachev <kalachev@swemel.ru>
Commit author: Vivek Kasireddy <vivek.kasireddy@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7d79cd7844703 ! 1:  edc6b0308d474 udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
    @@ Metadata
      ## Commit message ##
         udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
     
    +    [ Upstream commit 7d79cd784470395539bda91bf0b3505ff5b2ab6d ]
    +
         Add VM_PFNMAP to vm_flags in the mmap handler to ensure that the mappings
         would be managed without using struct page.
     
    @@ Commit message
         Cc: Oscar Salvador <osalvador@suse.de>
         Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Reported-by: syzbot+3d218f7b6c5511a83a79@syzkaller.appspotmail.com
     
      ## drivers/dma-buf/udmabuf.c ##
     @@ drivers/dma-buf/udmabuf.c: static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

