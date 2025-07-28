Return-Path: <stable+bounces-164966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC1B13CF4
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5631883479
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43D26D4CD;
	Mon, 28 Jul 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY1XzNZU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05226E17A
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712438; cv=none; b=T3N52lbMC9GtguAYUKkBeJPiJn5WOCSLG3S+lMF+1CLRwl36N0N6Zsh7Y6UhrPS4TdwWzlVxjcd6ytFq7Ekmzg2JGo7/6hAvxrJFNpj7qrOEEuFo3SlbuavxCKofFJOal/PYGtYuyNXVpIp1tilvRDuWYojW7aWJUjsdYh+bieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712438; c=relaxed/simple;
	bh=/p33v01QXS/z7h4rw7y9iciEqPtfLHi3Q8PB4Nh1Ekk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3oOwszNWQzOpPNZU1E5bRLG5iOh11Tw5bWk/73kKWNqrtHpFnbJdS6jfLV6eL7SUy9xowK0+t4GJKdvUoMHdswCV8oOVu1wkZwPfcKqgD3+EDpgKLmJi9rGq/bNzq4tygI6wfxx8xTizB4P/0J9esje2aSk9SVQ52KDNBGekG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY1XzNZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5756DC4CEE7;
	Mon, 28 Jul 2025 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712437;
	bh=/p33v01QXS/z7h4rw7y9iciEqPtfLHi3Q8PB4Nh1Ekk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY1XzNZUG7WtrdUkjgnm5dbRFBvs9b0MC5zCzf8EkFQcOzDKIoU7+qtz6/g3LM8tx
	 c101MHIg5QQzWK5Z/cnY8swnnzUQJOAowoC11QBYPxdBgH9FO+G87AFVynuR+sjmYe
	 tjneYkbxeXq5kPODK949/OgxiFR7841CJpaKt1BH4er3H5TWMklvwfDmOTMFH0Od1c
	 LDEwem3ul5/4bPqUqVpuwtb3st4/0QztI6tt13ptiVY/Ly98ly1g7mZhtnrKDCKvfj
	 HjVfrJpekdy2SCM+LbDxOE/hfWsNcQqB52S8xcUrJ3l4Qf/jTJ8GxQPeik0yaMFLCF
	 ufRfdb9rgqB+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.4] comedi: Fix initialization of data for instructions that write to subdevice
Date: Mon, 28 Jul 2025 10:20:35 -0400
Message-Id: <1753708584-0ca67310@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728122156.276222-1-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 46d8c744136ce2454aa4c35c138cc06817f92b8e

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  46d8c744136c ! 1:  8293aa18dbe9 comedi: Fix initialization of data for instructions that write to subdevice
    @@ Metadata
      ## Commit message ##
         comedi: Fix initialization of data for instructions that write to subdevice
     
    +    [ Upstream commit 46d8c744136ce2454aa4c35c138cc06817f92b8e ]
    +
         Some Comedi subdevice instruction handlers are known to access
         instruction data elements beyond the first `insn->n` elements in some
         cases.  The `do_insn_ioctl()` and `do_insnlist_ioctl()` functions
    @@ Commit message
         Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
         Link: https://lore.kernel.org/r/20250707161439.88385-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [ Reworked for before commit bac42fb21259 ("comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat") ]
    +    Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
     
    - ## drivers/comedi/comedi_fops.c ##
    -@@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
    + ## drivers/staging/comedi/comedi_fops.c ##
    +@@ drivers/staging/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
      	}
      
    - 	for (i = 0; i < n_insns; ++i) {
    + 	for (i = 0; i < insnlist.n_insns; ++i) {
     +		unsigned int n = insns[i].n;
     +
      		if (insns[i].insn & INSN_MASK_WRITE) {
    @@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device
      				dev_dbg(dev->class_dev,
      					"copy_to_user failed\n");
      				ret = -EFAULT;
    -@@ drivers/comedi/comedi_fops.c: static int do_insn_ioctl(struct comedi_device *dev,
    +@@ drivers/staging/comedi/comedi_fops.c: static int do_insn_ioctl(struct comedi_device *dev,
      			ret = -EFAULT;
      			goto error;
      		}
    -+		if (insn->n < MIN_SAMPLES) {
    -+			memset(&data[insn->n], 0,
    -+			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
    ++		if (insn.n < MIN_SAMPLES) {
    ++			memset(&data[insn.n], 0,
    ++			       (MIN_SAMPLES - insn.n) * sizeof(unsigned int));
     +		}
      	}
    - 	ret = parse_insn(dev, insn, data, file);
    + 	ret = parse_insn(dev, &insn, data, file);
      	if (ret < 0)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

