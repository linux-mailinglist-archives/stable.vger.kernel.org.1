Return-Path: <stable+bounces-164786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E31B12768
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34CB3A6F65
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D47261574;
	Fri, 25 Jul 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD/55Khx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2525FA10
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485966; cv=none; b=MT92TE7VMgZiytSPO3SooRakmD1YjtJOgOtfAvmx2vwU5z4gd6iZzIyhHe1fAxBYgYTDnNNUk12pJucXyuDepiXwmKmKhds5hBvDtJcQslZNxmxgSMe7d3S0psRN8R2IVFa3vtkLeqJEixAdqq35jI6cCiNicYLhdN7FCeVxMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485966; c=relaxed/simple;
	bh=0sHjGKPp5lPbzNL3zc83cbO03ZPaRP8iwOPQhkmRUjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbOBHk66saOz/nx3lKM9C9pGZDpZkc6E72tWfCHBW6mNr2PPjL9Q+nlqPI+JftEkh1YxN6ap4erpjt39U/CFrQZgHRnTPJLy3AAW40AoFOFXgdo68QINRX6Gveh/J5Lv+QDoy1nhfiPi5VzpSKhhdoW+05GY6fCldt9U8+MR8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD/55Khx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741C1C4CEE7;
	Fri, 25 Jul 2025 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485966;
	bh=0sHjGKPp5lPbzNL3zc83cbO03ZPaRP8iwOPQhkmRUjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WD/55KhxziA8oUS/xK0/3zGRll2M/eWyJtipXpufAIq69tLebRKX/qrEV3mQcchRx
	 RZCwNvKjeYjlisx1D3BluI+3UsiDOOYKhNp5a7GQ9j4emBiHmXfA/KNZ3maOr8P3JV
	 ECdhTp6A5A4e8pVIKkhYmr0HNggBZaLi0ug0Gule9wv0GGV6T35gX0G4bmGjnbe5Db
	 k+5XrWzhJ7pgumM0BgTz7FGq8E9Prmm2jGGtl9hel3O4L5n4qRdkuqTF8tE3rwoO3Q
	 jADYM9rkou0Ygumm9/3TG47nfp8NN9mOCtmFQYMaSiJIoaNj4ud2AaWtlrptvfSb0F
	 5KDhU1jO5wBkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Fri, 25 Jul 2025 19:26:03 -0400
Message-Id: <1753472753-eba6ea40@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-8-abbotti@mev.co.uk>
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
1:  46d8c744136c ! 1:  9ed5216f103b comedi: Fix initialization of data for instructions that write to subdevice
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

