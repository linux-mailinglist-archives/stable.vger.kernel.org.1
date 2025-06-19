Return-Path: <stable+bounces-154771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A6AE0136
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3AC7AF484
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0727A906;
	Thu, 19 Jun 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn7rKfGJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A4254AF4
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323853; cv=none; b=k6BLQwyiWfJTLKuqVHAxgbpTauCuTTKMc3x+M8rB2KCu0vTPIecCU+LSQVybrEadu/EzhFqf9wxMTEYaZlceywdejC8lKGknfRqk8bs1s55Xvi7i4I2oTie8yzrz4+NBz+FoT9In2vqF+zm2bXEmP/9ndCKDfoA+vHVpnz6b+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323853; c=relaxed/simple;
	bh=cJ1MCNuPge3/HxfVgenAH0JOTjm0LCVImjRyhibvRZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEJxqHVpS9Dxjzg4dGJJEYPgwcRjwxhEkoAiceX1Zx4OmsjTwbOulU89zkB8xga4X5kVdHza1qV65myaMwdr42c8Lnp5t1StNFVLIwfpOdfRSSdx/DuJ1il+V/fem8f6LWlB0sBSPALNzauHROvfGEGYQHD4i7r8HgHSyXsOZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn7rKfGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60319C4CEEA;
	Thu, 19 Jun 2025 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323852;
	bh=cJ1MCNuPge3/HxfVgenAH0JOTjm0LCVImjRyhibvRZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nn7rKfGJ1+Jn5YzSU+0zKNNUuIXR2qgXY+cpOlkAj5Pz1NaigWpV7ryf+XX/hHvsP
	 MGvcoWkI3b80gZcuw1pbQpzJ4ypZEbkrc2dOMD6zNpa8eL2+W1LHczZ2ySO6FaaB1O
	 ODcAA3WA48znvyqVUPGi9PLf71kuzKMK2cpx5ccTtAzXikubAha5nN4ZFPehNHDn6e
	 JxY7Vev8fvh9edVTNJCLZejPaBSoJKOP51jrSfluU0qxZRcwuk30Qdk9f5TZWuhpGW
	 q22D9tHZy+W7Rk8FExVHdt1jjcfL2MDAqpJGrvBA0PwJ+O3C8Fgrg+4fHhc20xrqDn
	 x9/ChEwBHtISg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] scripts: clean up IA-64 code
Date: Thu, 19 Jun 2025 05:04:11 -0400
Message-Id: <20250618151502-ae9260ee880578fb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617193853.388270-2-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 0df8e97085946dd79c06720678a845778b6d6bf8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chuck Lever<cel@kernel.org>
Commit author: Masahiro Yamada<masahiroy@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  0df8e97085946 ! 1:  8f82f37000689 scripts: clean up IA-64 code
    @@ Metadata
      ## Commit message ##
         scripts: clean up IA-64 code
     
    +    [ Upstream commit 0df8e97085946dd79c06720678a845778b6d6bf8 ]
    +
         A little more janitorial work after commit cf8e8658100d ("arch: Remove
         Itanium (IA-64) architecture").
     
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
         Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
    +    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
     
      ## scripts/checkstack.pl ##
     @@ scripts/checkstack.pl: my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

