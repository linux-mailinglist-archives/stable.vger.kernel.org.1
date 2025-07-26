Return-Path: <stable+bounces-164807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F4B127FC
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC05AC1F3A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1923594C;
	Sat, 26 Jul 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDyKRhYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2C2AE6A
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489510; cv=none; b=pMZc9H11d4UCVzvvZ8OwJVJvi99CmALhz3chz0WTIHQxiSowkGM0vTc71uQ69sWzdAz9wQfaOUajpGxfHtOdSe9RlBTAK+DBbNn1v0n+NSj8x/dZxSM8x/WJA9UmoB1OGMLCrzN9+vjc3nef8u21CGaz7/dT2maaAsG+5fDzLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489510; c=relaxed/simple;
	bh=DAnmYY07UojJHlrKkZZg0bRIllvRwdq8BjUFh/wZr1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRS9LBV/p7za6ICjULfpPnSQG74hytTMgcZSaIOdnE3nDiG5S/UM1bQ6AuNfXES+L9GEy64b0rIWiyk5C+8zyX2BJfPLNjEkvD0zVdewwCWxlLdAifYo3Ifz6z5wxpAshv3CM4riUV1MOLQHd8VyoPmWc5gNbiWB4h4c8y9XILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDyKRhYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8162C4CEE7;
	Sat, 26 Jul 2025 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489509;
	bh=DAnmYY07UojJHlrKkZZg0bRIllvRwdq8BjUFh/wZr1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDyKRhYc+xfkuylnCy+u8bYlvXgZ0bMuzct5WeN+0zjogjUpF4T8qUXSUfj7D9vlr
	 RWh2AhtNAmZMidToT6+A7mVUxwjxmvrgsmvNCiNeZUCK9pkB171aQLs7ROd7BToq25
	 jylNPDs7vFRS7UI9WfL1mKFGLpXLOeGc2DqOnQoc61zvVNpqYBo0hfwaFaRWhU3nSc
	 Svu0pHEP3zWYjgs0BIMboeQBPqGrY8zyKZ2JStZ6hCivaM70QFJlkwAZDY0smBAV5v
	 hhLd2EuSmEa9YbPHaTV+YVUPGrRWjznax7nFK8bGJbfrXfd2cFW67fqZV1NUqU0uLE
	 3/0K1jCzWepvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Fri, 25 Jul 2025 20:25:06 -0400
Message-Id: <1753473081-fad3f879@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-7-abbotti@mev.co.uk>
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

Note: The patch differs from the upstream commit:
---
1:  e9cb26291d00 ! 1:  e45bff8c0acd comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
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
| origin/linux-5.10.y       | Success     | Success    |

