Return-Path: <stable+bounces-164813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E05B12855
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E57AE23C
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316E3595B;
	Sat, 26 Jul 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1IUDHDs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0B2E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491694; cv=none; b=iKvFhGiQbtr6XN8vKOP62ymsxVHhLOg/Vq4BX6/0CMTx585i2XtEmKe3mcrJRz9igPnAInl9Io0rJjAmvS4OuTst6rKu4bH2pojWyEq032NDyg2r7agipr2ZKM2ir0PlAgFDG3WABwsQe9d0TSkJ4hCjuLIlS7vlG8coKyPoPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491694; c=relaxed/simple;
	bh=uxbjRuemwJojvqTcTlqtHnPCYfonQlm0+kOTQfWNcPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI3xHPVE1BoB/47d7kugMoAeysA+dUeJVThuKBsDUTMTD49fESJceo9MVqrdCgFpwebdmf5B7T7bF6hJCOKXOGvZ63w2SsvCQxdZluOxTBVyO4JrFmO9gxlCLS6Cd+drjSTeE2B3VORLj0tCFKpm5EQd18qSBHJKdJrwZPV+otU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1IUDHDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48DCC4CEE7;
	Sat, 26 Jul 2025 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491694;
	bh=uxbjRuemwJojvqTcTlqtHnPCYfonQlm0+kOTQfWNcPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1IUDHDsBgvBJe1+ONxWveATTp79BGCyyej4Xeb7/iTPf4VetWx3rQHzdBsvJEjVk
	 Koj22DER2d6z+cJkRVG/1g+Hfw3sXTY2moDvxqyDSC9A/96QGDEtGHxDFrmnsJ5TLH
	 FwZRliwlZlPIn7H2zqt3ybsRkqgCcTc9b2sHpCrc0JA/0JenUZY2agu3VlpJawa8PZ
	 pYlXlgr5KPmePwbi0+mY5Us2z2IbTeYj9uNtpfd5cAja0+ePyjz3nm4F+7LeRXCGal
	 2SA4dwzLxd3n10a/tdc8+nRu9yvEVzExWS+Un/WVRj/co1htlxqgGHt+wfTdIjoD3U
	 x4M1FpPqXh1Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Fri, 25 Jul 2025 21:01:32 -0400
Message-Id: <1753468353-9140c270@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-7-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: e9cb26291d009243a4478a7ffb37b3a9175bfce9

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e9cb26291d00 ! 1:  6fa2f936b734 comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
    @@ Metadata
      ## Commit message ##
         comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
     
    +    [ Upstream commit e9cb26291d009243a4478a7ffb37b3a9175bfce9 ]
    +
         For Comedi `INSN_READ` and `INSN_WRITE` instructions on "digital"
         subdevices (subdevice types `COMEDI_SUBD_DI`, `COMEDI_SUBD_DO`, and
         `COMEDI_SUBD_DIO`), it is common for the subdevice driver not to have
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707153355.82474-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers.c ##
    -@@ drivers/comedi/drivers.c: static int insn_rw_emulate_bits(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers.c ##
    +@@ drivers/staging/comedi/drivers.c: static int insn_rw_emulate_bits(struct comedi_device *dev,
      	unsigned int _data[2];
      	int ret;
      

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

