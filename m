Return-Path: <stable+bounces-164778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA02B1274E
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B484717D843
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0A25F7A7;
	Fri, 25 Jul 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCZZ50RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571541A8F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485860; cv=none; b=QiORfJ1K8NVfFjHjzYzj7bARBT+Z1ZQ3pD+oBJvV1Oo0lNYY1ri6EGB04z0TGKK1UMHs0shylpilKc0Q1k2du/Es1QRwnkvmikymYAdLRfptCxjdZIEQF0srJt1U8yVYpOhFxqEOPteMsjzHPEIYNzQmgI+LIS7l2feDqWn8Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485860; c=relaxed/simple;
	bh=YON4WZ8znZwqxlQ4w9LNkB4CtCNjINCJy2sk+0hkJT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONiZVIe5Uw20TLqgzCILts5p301sjJAXdDa27RcCJWQGiWPc2DEK0owz4vzd7z09/Tjrw3vukruPjfY3IH7fBNSuQ3Ky/NN5ux6+YWumgUc3/iM5nyAkK6UmFQtu3qeRx432fyrv433HQPGVZVfDr2JvlmkEITakUipVNNXzViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCZZ50RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E8C4CEE7;
	Fri, 25 Jul 2025 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485858;
	bh=YON4WZ8znZwqxlQ4w9LNkB4CtCNjINCJy2sk+0hkJT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCZZ50RUm7wjC4P8pFm5MHhXMzqhnfjx3+yV+BMAKuBmkaM/Fb0mqWc3YjCXxP3Oh
	 3MwmORtR1zdcCTlluicww59yE0DUx3t7PyeIgVk4OFl6W9NF2k93QmZeHBz/hsZkaq
	 4d4VlSzN/KQXnFjHnTVl+1RilIcuLgoSwI/vOsWm8bmSPxjsx11f5N/wdZv/rHHxaG
	 wC2fhfz+aexhggnVJuW6dZ/dVL5+ACbVy0yPOk4uWKLq71uwYR1aEUndTCI22n88fz
	 1+VllfAxrwY7+U2u36SEYndQLBGFFA/e3R5n38js1zyEWnZJZQQFdGXGJZBUuzx40e
	 MxOtWTcD1inng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix some signed shift left operations
Date: Fri, 25 Jul 2025 19:24:15 -0400
Message-Id: <1753471433-65b91030@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-2-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: ab705c8c35e18652abc6239c07cf3441f03e2cda

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ab705c8c35e1 ! 1:  e5ccdaa83664 comedi: Fix some signed shift left operations
    @@ Metadata
      ## Commit message ##
         comedi: Fix some signed shift left operations
     
    +    [ Upstream commit ab705c8c35e18652abc6239c07cf3441f03e2cda ]
    +
         Correct some left shifts of the signed integer constant 1 by some
         unsigned number less than 32.  Change the constant to 1U to avoid
         shifting a 1 into the sign bit.
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707121555.65424-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers.c ##
    -@@ drivers/comedi/drivers.c: int comedi_dio_insn_config(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers.c ##
    +@@ drivers/staging/comedi/drivers.c: int comedi_dio_insn_config(struct comedi_device *dev,
      			   unsigned int *data,
      			   unsigned int mask)
      {
    @@ drivers/comedi/drivers.c: int comedi_dio_insn_config(struct comedi_device *dev,
      
      	switch (data[0]) {
      	case INSN_CONFIG_DIO_INPUT:
    -@@ drivers/comedi/drivers.c: EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
    +@@ drivers/staging/comedi/drivers.c: EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
      unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
      				     unsigned int *data)
      {
    @@ drivers/comedi/drivers.c: EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
      						 : 0xffffffff;
      	unsigned int mask = data[0] & chanmask;
      	unsigned int bits = data[1];
    -@@ drivers/comedi/drivers.c: static int insn_rw_emulate_bits(struct comedi_device *dev,
    +@@ drivers/staging/comedi/drivers.c: static int insn_rw_emulate_bits(struct comedi_device *dev,
      	if (insn->insn == INSN_WRITE) {
      		if (!(s->subdev_flags & SDF_WRITABLE))
      			return -EINVAL;
    @@ drivers/comedi/drivers.c: static int insn_rw_emulate_bits(struct comedi_device *
      	}
      
      	ret = s->insn_bits(dev, s, &_insn, _data);
    -@@ drivers/comedi/drivers.c: static int __comedi_device_postconfig(struct comedi_device *dev)
    +@@ drivers/staging/comedi/drivers.c: static int __comedi_device_postconfig(struct comedi_device *dev)
      
      		if (s->type == COMEDI_SUBD_DO) {
      			if (s->n_chan < 32)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

