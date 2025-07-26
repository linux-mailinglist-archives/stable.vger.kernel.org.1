Return-Path: <stable+bounces-164801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1203B127F6
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3E41CC32C5
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5339FF3;
	Sat, 26 Jul 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spUu4uLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D828FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489491; cv=none; b=inMIlfH348j3iGszwO1qvTzjt500mi9gQ7+XCmi0ihVDj+2GkGFHvVre64jdCYqwR5GquWSrvoQ3S+Bfc4FV49gSnV9uMakVXDNTOGXRcSMJWGSfXkFBoJuSfSKXS4bDQ2Tva/au1GEpAlxZ62wDd2sJ9JfWTY9YjYnsS0zbmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489491; c=relaxed/simple;
	bh=JJ1mKZYW+3OLjgBJuuUwF0TmCmearVBjUkOJnWDD/Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZqNkn5kGVeICaMVeIxTGxJub2/AfDcbL2GnXO0fWieTGrZU1odb2xyQ2wYsvZP1pm2cjvvRVPzI3fkdMLhZTfEaMSemqDQs1ZJnR0z1EoJrXxIeln+dRca+QnNFP03M4AwIUZY97G/DXddQOJR5acQbkwmUP1FD2Un5g47Ig8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spUu4uLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD53C4CEE7;
	Sat, 26 Jul 2025 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489491;
	bh=JJ1mKZYW+3OLjgBJuuUwF0TmCmearVBjUkOJnWDD/Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spUu4uLICCYsCZrsCpQRdVLZ/LmoIxGcIB6qAMG+tzALN7AvDTVHiBJqcgqVAX7/0
	 8HlehR6cBU0yAa/Uwwe/NgmzlA3tajCeEU5PltnCyrG5khuuJMOpPOGPbuXpzST3+S
	 mpK94w8eSQO8Og2M7fD3Rb8oJ/sQW4mMBIdlTzrrECGS+fzk8OydRRAhLdsHUTNR6w
	 BJC2zN5SFX9pj7dv1km+omsPAD/eCgGIX77aEJTQvt1jIi7OcKTGbTSu2YU/5h8qd6
	 KbhY2nkEgtoZ29RFBgGk2THz4lCDPQczP8ogEAQgDQ9m8kAZJolLMBJmWphn/+EwFm
	 jCU+E8Vaf4naQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix some signed shift left operations
Date: Fri, 25 Jul 2025 20:24:48 -0400
Message-Id: <1753467848-e48314ac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-2-abbotti@mev.co.uk>
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
1:  ab705c8c35e1 ! 1:  0d19deff7ec8 comedi: Fix some signed shift left operations
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

