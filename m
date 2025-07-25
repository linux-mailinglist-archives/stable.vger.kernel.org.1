Return-Path: <stable+bounces-164784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42CB12754
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136201CC3739
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD425F963;
	Fri, 25 Jul 2025 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwQtxUDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B7238D52
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485875; cv=none; b=ZX1f6ehXghNpToJhpblfyikpqH4mUojjwsPelkle59QdDAzdU8XW7eeQaZTcUl0u07eWAxr9BqgDviaPMW3huwoWFpsgKmjyuxsLAn0CHbUu+HXvF8yFYL7rhQDMvENpqFMi+QrgEvXRgkXi1S1lYbQf2ILRMx8es7/A87yMxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485875; c=relaxed/simple;
	bh=RYHTOU1Wu5kthmf2u/t3frwHOfwlUUsqL+tPrI1ozbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PatyGHAjWdJzayjhd2Itlb249jUFkZ8qKFBeog2qoAsREJ5LnKXiWTRabYt4nWQkOnCpOJzYchEN1AHJ1bndn6VuNAkY19nZ7GWDGzzPYakyY1HKUXfdYlP4+ZNpsf7t2lMs6jOBHkxxfSmAtotl0+PgZllb71HNwYdW3q2yhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwQtxUDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EB2C4CEE7;
	Fri, 25 Jul 2025 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485874;
	bh=RYHTOU1Wu5kthmf2u/t3frwHOfwlUUsqL+tPrI1ozbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwQtxUDxzvQkSoxiJXQSggmFRoT5kIx4hHVTXZP5aejf/zsrE1quoKHwQ3SRy8Jqn
	 bpPkPg9e+pJ6znAwHymj9kfrZFREnlIEmTBLMd00xxRrN2su4b1llSylM2BSetVKlp
	 Iy5NECkBXLII6eOVaW5yNcF5jlGMLlOhMoaKY7M3vxUZiRCwa0dMG8q8bt0hE1MkmY
	 pxvKqBxb40N7NK5i3V+8P8d9EvqbV3cn0k1xUqk1LwWibUHMhx+3DVORxOYXX82e0Z
	 X7IijP6WChNGuc9Hb+Gxtr0jZtSEOlman72Rvf971w71Bynq8UFOQteGAvxjLWHF2h
	 WiPBFxWyUto/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Fri, 25 Jul 2025 19:24:32 -0400
Message-Id: <1753464513-b037f6b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-1-abbotti@mev.co.uk>
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
1:  08ae4b20f5e8 ! 1:  4a8bada4e031 comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
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

