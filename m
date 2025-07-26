Return-Path: <stable+bounces-164808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980AB127FD
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9ABFAC2ADA
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684D3B1AB;
	Sat, 26 Jul 2025 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyNq/34M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC752AE6A
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489512; cv=none; b=CA09Y8bHmcBqDw3VkIfhVb+5cD2MBrCZr63XJTNYCMYPKgbiUc/WwN95Mx07xcvsHoX8GffCMuYrcI0Ax1ZD0OjMZLl3dCqOBBZptHyyW3YslqQtc0eFTfEuKUXaSHw/7/nV6VHi1QTs8Na/manclS6P1QU35kuM+Fll8V2AdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489512; c=relaxed/simple;
	bh=k31CPHhsoMhK2qzSVODwQ+dDgM1DRNIvz04uS0U/aCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJT2ufMDr5BLgy85pqsnKZq1W3ufGdDhhaxP1iYBHzIxBuvFGWb/FTNWpNW3PNnn7POxkPqO8PXMfUWYK+amTWWs5giMJKku19HfP0/6Z5ew5QJMItSFE96FRocIxKPvnkMUgxxDPwl/voUi7L7IbeTNmyoEAJ4tjuSqQtSaeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyNq/34M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDB1C4CEE7;
	Sat, 26 Jul 2025 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489512;
	bh=k31CPHhsoMhK2qzSVODwQ+dDgM1DRNIvz04uS0U/aCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyNq/34MVSGrLcj+Saf1u6dEs8p933hAd8TLKarL7ysVb38Y1/Ui6brB4r6nEtf+Z
	 2Bg0FUSepAJDGp96n/Sy7Cb7BlpvPwpJdBBXpHC/p1/S3L4F+vS5VeQIs++c6CYGGn
	 36evcU3CN4d1MSgpjrnRtmU9t/8g8F5txJy8se2EY7kWgAJ8Vwapg2JL6DwAhahjYe
	 Jn+NHJmhDtwprB3h5JaknfIwbMN7+jeLSXp/83XFicqs1O2SeCDdQOJjhfx34LZlrw
	 ZQ9+FekN4+8pZKGLofe3GC8nBwnrEYo5cEWz9s+fB8qDqdGJYOpmd03Dc2031Qsb++
	 Xngf5pNAFGRBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 20:25:10 -0400
Message-Id: <1753468742-ed7cecd1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-5-abbotti@mev.co.uk>
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

Found matching upstream commit: 66acb1586737a22dd7b78abc63213b1bcaa100e4

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  66acb1586737 ! 1:  186240031021 comedi: aio_iiro_16: Fix bit shift out of bounds
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707134622.75403-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/aio_iiro_16.c ##
    -@@ drivers/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/aio_iiro_16.c ##
    +@@ drivers/staging/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
      	 * Digital input change of state interrupts are optionally supported
      	 * using IRQ 2-7, 10-12, 14, or 15.
      	 */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

