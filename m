Return-Path: <stable+bounces-164793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677FB12769
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965277BA178
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A22627EF;
	Fri, 25 Jul 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkBXQdIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F525A334
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485984; cv=none; b=GZrU/2wDz5A5FWVDUdfxJT/T8SVMRd+2sYeX9JQw6w/VDS4DQ0xS+cqZQZn1x2ECLecvMBXJg0KrDNzNtwW046lWvlWWiz8zQp2POg4wWoXtV0sgQxrGvnZ6cqdARbjtTH5DtZUSW7RdG2uDGTb/wL7cJgVGRtTD/n6YEW3KFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485984; c=relaxed/simple;
	bh=Ld84v5T8bbX0X39b/3qdXRt1TpAwZh3A4lfiTHWD7xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJIVQPjfDN+LIkFevLXaC+wNFeueIIExboZYyquqbzlNvXgsItuCH0Ui75EfbUDDFi/eAq31Q3RjS+MMNfHzTYiMElYG6x0Y8vrpqeZ3ubX2IcrAZDeKk4P3/3geNsm77tl8JgyCCoqTvRNwh3nINlylpMUnX31vgwwXH/eao1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkBXQdIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E7C4CEE7;
	Fri, 25 Jul 2025 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485984;
	bh=Ld84v5T8bbX0X39b/3qdXRt1TpAwZh3A4lfiTHWD7xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkBXQdIuU5gCUel/0c3QwMKGAGDW147t4zx9Mv9pxHiLQ3P28DH7/msfZ5RnGSZCT
	 P/NObV74FOpCJfZLwu/VP7D1SbDVGGicO91yl3ZvQITRYVC2uBRz2AsFVr3ckql/AT
	 746GdRQDC0/3IAigl1awCf7w6JBnyS9ioqyN1JjqTZxNn0ggiATYU5YBnI9H2+gqr3
	 RvXFjZSfcv+bvWt4IpnizgsYdsdzI1P8fP/gVQAj/EXkTz5DK6DLSItIj1x+s3/y3Q
	 IHbXkKwA6bMWamrbJ8BGaq43SrmEjNCqSc5VRtu1634JZVpwlGZt/BoyoXNBfrAawy
	 Wm4LgT6ARs0jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: Fix some signed shift left operations
Date: Fri, 25 Jul 2025 19:26:22 -0400
Message-Id: <1753464894-7fb32196@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-2-abbotti@mev.co.uk>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ab705c8c35e1 ! 1:  e6c1da157d18 comedi: Fix some signed shift left operations
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
| origin/linux-5.4.y        | Success     | Success    |

