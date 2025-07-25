Return-Path: <stable+bounces-164785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DDB12755
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B8F7B8867
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531C25B1EA;
	Fri, 25 Jul 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3HCdTad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716B238D52
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485877; cv=none; b=os7Nc8JCHC2NEzL13Fe2P7pkZFn+3YTdb/gilN8Vzb6nX3tprAMRnkYRLfqX3LBCXsMDMCoMW4TwyM6QW8ziZVS93A1PdWXx/nK69Vt1d6j5xs7jKexM4noO8krtihkpZIR6AsKFgBfGIvYctSqh12NSb+2wpJgeaOXsS93mb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485877; c=relaxed/simple;
	bh=1Raoq1IzetJBcjc5rmQ7PstKJKhCkw9+hAqM2KpZcWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz6mPibeCwlsVvnJUl8wXdn1Tr8JzydwsBke13KiQfMhF7HeNkweHdQ3WUjc0WHZV79tuoTdASNcJxUonVGtUi5d8VumcvqjUwwgDqoQ1pxeTPNy9V/nfcH3OZcNdbMUr9rmYCxLpdQQi062CQoXAedb1szy9CLnfC4uembaN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3HCdTad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58BC4CEE7;
	Fri, 25 Jul 2025 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485877;
	bh=1Raoq1IzetJBcjc5rmQ7PstKJKhCkw9+hAqM2KpZcWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3HCdTadlQf9E4Dqa8KRrp99p8vacgX0UIZb+4XNsmVpwFFQG8QE9YGbgqBEU+K1Q
	 ONFOn1/DGwpcdO8lJkO98s6T2HYl+OVIqcl82mTY7QlI2XJfx8x2XT3xYXAlbmrG+Y
	 9X808+511A7mayXW42WKuzYWo7hy1lpuLTwhDRUEcACs1CKxwvvqQlEK0Sj7urg1+X
	 JPlj03GLEH+5JeifSWBJPbXy638J/YMML0JevQKKiQM616ByXj2Q95JIW/RvoFttFI
	 AyMW4OiET0WKuDk/DcbYfVkiM3FMU6sEexJpbOvxkBObj0RYuNxdL8l7xEkECuDCOX
	 +NUNQyT60i8Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
Date: Fri, 25 Jul 2025 19:24:35 -0400
Message-Id: <1753471769-d9eed8d0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-7-abbotti@mev.co.uk>
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
1:  e9cb26291d00 ! 1:  8bad4aa45706 comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
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

