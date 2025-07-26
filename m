Return-Path: <stable+bounces-164817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E773B12859
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C97A3B72
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE83595B;
	Sat, 26 Jul 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTy0f1YM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BA2E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491706; cv=none; b=c/sis08/oWwzZr33iuBel+oNGTIZJUW++H6zCweGdvTskpTsAb+eOtcIWopWuz8J5Kg6PPyBucj2xh/rQE8MuNmu52IjHhHYNN5NKc0i3/9Bz8gL3p8MGiiReFKlje4hqI/igOxO94U3fEfR01JkyFpikf1fb1xf3yKCz5dDynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491706; c=relaxed/simple;
	bh=G6HKsFve18f1CHkOIG5cFJTupBGfmL14TWOxQlP/oGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih55/RYcU5mCmGP1Wtq/WuZ8uHu3WVZPuK5HZR8wnzNArTfkvaiZU/mbm+PR2aE+LAyEjUKW5AWckR7A02XuuBjoRrOhjb6QApWc4CgsZZ4t0sZKat6xkHwdHA1jB0IF95D9ffU+rjoGYqco4WUQcn/2lu3ncN55CxLJPhBGeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTy0f1YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E64C4CEE7;
	Sat, 26 Jul 2025 01:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491705;
	bh=G6HKsFve18f1CHkOIG5cFJTupBGfmL14TWOxQlP/oGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTy0f1YMuFJGNt8ZkC06bo7lWyI1CFxLlR3jCeUEV6PUHjBDxQlXQaKJENM++mGEd
	 daB3q2R9Aqw9B0xT8narcJobXK0KGGgMaj45SQQq9iTSEWHZU7b/DMLjKo8siS4Lnv
	 sVAdYDvXTCWFxb7OIQuNgadfabPQWzk2cOn2bECsK4YObp+ZQQ9mGu9RFl9ArZWXta
	 59AKVO4NzbZiQz1Aj9Hd5JvLInL24DZEEZF48G5gTSiqpnRd7bGhIufZVZK3v8VP1Y
	 pXt59tZjQ7UfJflidVUly89kHmMe0LLf/ubk6Nq+Z3sxoSONAhUfbKRb9ZLK+gjTe7
	 D3FAapFXXiD7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Fri, 25 Jul 2025 21:01:43 -0400
Message-Id: <1753469791-95dae1e5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-1-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 08ae4b20f5e82101d77326ecab9089e110f224cc

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08ae4b20f5e8 ! 1:  973ce1afed22 comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
    @@ Metadata
      ## Commit message ##
         comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
     
    +    [ Upstream commit 08ae4b20f5e82101d77326ecab9089e110f224cc ]
    +
         The handling of the `COMEDI_INSNLIST` ioctl allocates a kernel buffer to
         hold the array of `struct comedi_insn`, getting the length from the
         `n_insns` member of the `struct comedi_insnlist` supplied by the user.
    @@ Commit message
         Link: https://lore.kernel.org/r/20250704120405.83028-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/comedi_fops.c ##
    -@@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
    + ## drivers/staging/comedi/comedi_fops.c ##
    +@@ drivers/staging/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
      	return i;
      }
      
    @@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device
      /*
       * COMEDI_INSN ioctl
       * synchronous instruction
    -@@ drivers/comedi/comedi_fops.c: static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
    +@@ drivers/staging/comedi/comedi_fops.c: static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
      			rc = -EFAULT;
      			break;
      		}
    @@ drivers/comedi/comedi_fops.c: static long comedi_unlocked_ioctl(struct file *fil
      		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
      		if (!insns) {
      			rc = -ENOMEM;
    -@@ drivers/comedi/comedi_fops.c: static int compat_insnlist(struct file *file, unsigned long arg)
    +@@ drivers/staging/comedi/comedi_fops.c: static int compat_insnlist(struct file *file, unsigned long arg)
      	if (copy_from_user(&insnlist32, compat_ptr(arg), sizeof(insnlist32)))
      		return -EFAULT;
      

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

