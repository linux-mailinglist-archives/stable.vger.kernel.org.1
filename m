Return-Path: <stable+bounces-124904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6396A68A0B
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC7219C2680
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302825484D;
	Wed, 19 Mar 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxmWL4+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8E253B45
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381661; cv=none; b=qcV97E+q60eDUuT61WIEHgAU7XCRJc1hyaKkwdn1tgCniEJXjyfCk0aj6oV+8VdlMMI5B+HPySFffAZHVlGvPCSCBvHxV9BdXnC6a/sHULj8aYwqxyggxwMpB+iKIagKV4zn902GCKlorPzj2TIQxjckcKuFH8k9SYk8Z2bbw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381661; c=relaxed/simple;
	bh=NFiA6yEGD3qftDvsrmtL1DQV8BQD8vyMILLgFIZUCTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMiOmeWIcaIKsHH9qEC+ryWSTsG8wdUBoAq/EPzYKbPcnkr9FKA5WHX10N2TJbpDvmb84P6JKsdd7Ge2gb61kAAUwVbbEFi0FCpOkv7TGuyad8s4wb/sVqdBiu+JHDYPDOESZtgvGhc778B36H9uLfxTqIVTH1aQp3JI5xVeqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxmWL4+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CD0C4CEE9;
	Wed, 19 Mar 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381660;
	bh=NFiA6yEGD3qftDvsrmtL1DQV8BQD8vyMILLgFIZUCTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxmWL4+OOp5KOtluiGHgQzcB4HKgNVY/iNnu4Bi3fG8JgHg++/fg9Njy+te0Y315d
	 V50A9K/qYxUJEASg0Xsf2EDTr30XkqzD9dTK9X27FkeOJNjb5JiIhyNCcAFuiCp394
	 KoFRzc/vGwfikuDqEkNhEDtLbGpJYX3TG2zfdf+iyaVu/plebhj57HJUEoFybT5YiW
	 8qzkWZkhsBXgw6XFdDaMysFKYX/zLbDwKWqDd42F2jHwBnF50WLo3/jZDi9JY7NvQN
	 18HJUTlsy/EYAcP8JntgvJtLpcd27Cirtjv02ikU0ISL1iqeo2Cpf8mSQqb4VEXJIs
	 LzVnEdLsPNJvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V3 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Date: Wed, 19 Mar 2025 06:54:19 -0400
Message-Id: <20250319051903-1c9549413af290f2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319064031.2971073-2-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 300e6d4116f956b035281ec94297dc4dc8d4e1d3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  300e6d4116f95 ! 1:  feb32525515c2 sign-file,extract-cert: move common SSL helper functions to a header
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: move common SSL helper functions to a header
     
    +    commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.
    +
         Couple error handling helpers are repeated in both tools, so
         move them to a common header.
     
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: S:	Maintained
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| Current branch            |  Success    |  Success   |

