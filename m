Return-Path: <stable+bounces-96130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846BE9E092C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A60C2822DE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091C1D9A5D;
	Mon,  2 Dec 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyrveSnJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EA13C8E8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158635; cv=none; b=gE/xcgRNlBNTUaf4WrNhH41RyRWBTND0V8AP3xsbKCdsejTRjWUrk+RH1kaNhJL/dTkLtHwYYHmSAPRpEuRey6fPMP9HOrzJnWxWmwndiOVFIbwfGhRyNh0hvcOtcee7p27wpnAYuBTC3TkgXypysVPjGgMtRYdCdIKwfPMOzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158635; c=relaxed/simple;
	bh=wofdtD6EoQ/MUxGXlfMytUC6A7VQmcWW0Va4yIwQ2lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pB+uuWxmPWd4JPCn2tJ1fKMySzYygFka5+534w0nyi62M+Ksa1XL89C2zsTR4F0Ptuk6ANFrd6YgDUcjngDFVx4Zc0UJSX1UMxzwFR76EceqU6E+t/JXDrdaJBcZEDBADdPROA5o+xgh0mbgPxJO5DG5l5e7SU+LJgUqEanWobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyrveSnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71985C4CED1;
	Mon,  2 Dec 2024 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158634;
	bh=wofdtD6EoQ/MUxGXlfMytUC6A7VQmcWW0Va4yIwQ2lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyrveSnJmZm9jLwK3Bhi1Liz0eocEXT2thLpPBcQN7WahqhEoTlxGPx/0oj1XbW0/
	 6G8RrqYeCAMnPU++y4a7xBcweK3wOtgaKdY5a9+bai9ZAvi6qrDDWZIKTjGdQZVgGz
	 yTpgU7AgnqUanhldajABUSsulVINZQQfI58zs8Rb0TwtMme9G9Tu7phnO8ZZSvn+2Q
	 xNxVLAITIbLfzcTOp1nF6MDRZSuP581uoJfd9ckIvkHYOgbWdJffZjVZKEr8BSIrbg
	 AjGa4eOir62ryvuup5L0bbfMOd80RvSmAoH7I5TWp3IsUIZPjHosnFW0q4E2QiDcE5
	 DMKYLu2ph/org==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v2 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 11:57:13 -0500
Message-ID: <20241202113223-26504e0cfaee0ef1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202131025.3465318-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  8dcad5070912f net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

