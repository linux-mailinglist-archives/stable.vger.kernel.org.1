Return-Path: <stable+bounces-164802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2BB127F7
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720A2AC1617
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDC3BBC9;
	Sat, 26 Jul 2025 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r36ISD+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08228FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489494; cv=none; b=eGSz80jNC+FQC6nO4zRJKvJ/cB5xqWptH9jP+peyWptOAJLDoLrhjtGP7HXF5a90P+KcSKKbqNHa0RPqqY4Yk9M5+oWPIonA58xmasqFeZEOpJutkdCt173e7N3kckh4WlwkiXfbZRX5PjzLt01vvKfwXnJCFIlgw6RfNMa3KU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489494; c=relaxed/simple;
	bh=uKOksxPXJm/tUnPGfk64RYEn+M/uWh6ahtTmhUk0Ur0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiS353cYFnBhkY86MFptRM0Pj4QvmqW+va1bs0+24n0+iS96jlQhPYTLCRYk/teHy7nmRrHfx6BlUN6VDuvEns4AMeC89/02O8WyVuySvhkai6HqX2ZAPWAJoyQmz1OnmCENED/s866fZCeoooCOW/ZCCGjgX2r/uBE7lA2e3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r36ISD+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56530C4CEE7;
	Sat, 26 Jul 2025 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489493;
	bh=uKOksxPXJm/tUnPGfk64RYEn+M/uWh6ahtTmhUk0Ur0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r36ISD+eX5JyLEGwDpgL3A2d7fUWywKfVbZXxuPevyZq/zbrqS8VrHLa7ucum7E4/
	 JWWbal1Xt2MYYYWkPXOj9SHdQ4s7g/kSOOLH8hMeZNUavZwFTPo5Rzb+pnaucIXLqA
	 olPPHod18gwpAX83EmVnPYwQnjvfeJTETLZumd0X99FMuwzGsGiWRHi7iSs0u8IuIg
	 +j1zxMV/D+OFPFYUwssg3LMxKJF2/5I1NM8wdIpDG63evNuOQTU31RSF5EGs1MB4Jt
	 VCILupx51Fk0qmGdi7o+822i1d5jWTVTWiZ0gICKBOKh6GtACIqZDQPWNUHL7XJg2e
	 yuBBtFqgVyz3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Fri, 25 Jul 2025 20:24:51 -0400
Message-Id: <1753466530-e173890b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-8-abbotti@mev.co.uk>
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

Note: The patch differs from the upstream commit:
---
1:  46d8c744136c ! 1:  b96c24925413 comedi: Fix initialization of data for instructions that write to subdevice
    @@ Metadata
      ## Commit message ##
         comedi: Fix initialization of data for instructions that write to subdevice
     
    +    [ Upstream commit 46d8c744136ce2454aa4c35c138cc06817f92b8e ]
    +
         Some Comedi subdevice instruction handlers are known to access
         instruction data elements beyond the first `insn->n` elements in some
         cases.  The `do_insn_ioctl()` and `do_insnlist_ioctl()` functions
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707161439.88385-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/comedi_fops.c ##
    -@@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
    + ## drivers/staging/comedi/comedi_fops.c ##
    +@@ drivers/staging/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device *dev,
      	}
      
      	for (i = 0; i < n_insns; ++i) {
    @@ drivers/comedi/comedi_fops.c: static int do_insnlist_ioctl(struct comedi_device
      				dev_dbg(dev->class_dev,
      					"copy_to_user failed\n");
      				ret = -EFAULT;
    -@@ drivers/comedi/comedi_fops.c: static int do_insn_ioctl(struct comedi_device *dev,
    +@@ drivers/staging/comedi/comedi_fops.c: static int do_insn_ioctl(struct comedi_device *dev,
      			ret = -EFAULT;
      			goto error;
      		}

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

