Return-Path: <stable+bounces-144459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D4AB7A95
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 02:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D757B006A
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE864B1E4C;
	Thu, 15 May 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDC1yX2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898901862A
	for <stable@vger.kernel.org>; Thu, 15 May 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268904; cv=none; b=VR4lPpBdcG+decHO5F7fJnKdjOAhR5O+sDtrwVVY31vZAkA6vM/UXOedQmhy1zXUWjwny94yZkK9kTVV4FsiLfMCRSqsZAWuICZEDT1e4MX1Wmc0pOge6Tm59eBNqjHn6ocD2h7KmLrPrrOmfpr01RF2aOb2V9CFQ2yKQsGf8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268904; c=relaxed/simple;
	bh=RnRQP1h9GPmuapJ3b7EWyhhxMT6GBR3AlBTFtJ/FVcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+gSkppgx91OO/XpJVwPg22UItRslzCaxmMBeSjpbSLq37b/WmIBlDTVMxJjqw1zdhESUNpXK+dKJiWf7QRy57rAPYiIKFxxT19Pkz5E15HxCT3iAPvxAJcAW/iNZKP7eO8zWF/ED01OrFXp3MKC1jL4rX6A6jxPCThrJh+tJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDC1yX2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DF4C4CEE3;
	Thu, 15 May 2025 00:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747268904;
	bh=RnRQP1h9GPmuapJ3b7EWyhhxMT6GBR3AlBTFtJ/FVcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDC1yX2IXfBE7jwZMYgA6zNpbpyu4nP9yfmDxF6mcHxHxFVSAaiij/bvTm2oroWbD
	 2JGqmtTAKgRCvOdBOIorK17QYIYea9ojZcHdpL6oMSOnDZlMpP86vd55UQigsAkOPJ
	 Rs+G+uTzwj4ecp9GB8zksHYrFNnGz+pKx7GdqDMrvOQwQel5QLIWoPhdF25SLBgnEQ
	 LjXWiPcqyQUTj2OtSXeKvhPq8StGLpTj9+QvdD4zzzW6/G/LhlZTMWjIsQTyDts4WD
	 BUW57tiVzH5RDmifeBTdOuuRjm8SeqRTB0csTB6ThYf4v8/Z6RbyyCYFRbnmAYFa8d
	 IwVSooY7siz+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Wed, 14 May 2025 20:28:22 -0400
Message-Id: <20250514200620-1df4fe059acf322a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514150157.2657456-1-akuchynski@chromium.org>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 364618c89d4c57c85e5fc51a2446cd939bf57802

Status in newer kernel trees:
6.14.y | Present (different SHA1: 64ae1063347e)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  d6f6410c4cc3c usb: typec: ucsi: displayport: Fix deadlock
    @@ Commit message
     
         Cc: stable <stable@kernel.org>
         Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
    +    Change-Id: I72e0a5893a259321df1f38e54af36e61cbdc60a2
         Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
         Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
         Link: https://lore.kernel.org/r/20250424084429.3220757-2-akuchynski@chromium.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit 364618c89d4c57c85e5fc51a2446cd939bf57802)
     
      ## drivers/usb/typec/ucsi/displayport.c ##
     @@ drivers/usb/typec/ucsi/displayport.c: static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
    @@ drivers/usb/typec/ucsi/ucsi.c: void ucsi_set_drvdata(struct ucsi *ucsi, void *da
     +
     +	while (connected && !mutex_locked) {
     +		mutex_locked = mutex_trylock(&con->lock) != 0;
    -+		connected = UCSI_CONSTAT(con, CONNECTED);
    ++		connected = con->status.flags & UCSI_CONSTAT_CONNECTED;
     +		if (connected && !mutex_locked)
     +			msleep(20);
     +	}
    @@ drivers/usb/typec/ucsi/ucsi.c: void ucsi_set_drvdata(struct ucsi *ucsi, void *da
       * @dev: Device interface to the PPM (Platform Policy Manager)
     
      ## drivers/usb/typec/ucsi/ucsi.h ##
    +@@
    + 
    + struct ucsi;
    + struct ucsi_altmode;
    ++struct ucsi_connector;
    + 
    + /* UCSI offsets (Bytes) */
    + #define UCSI_VERSION			0
     @@ drivers/usb/typec/ucsi/ucsi.h: int ucsi_register(struct ucsi *ucsi);
      void ucsi_unregister(struct ucsi *ucsi);
      void *ucsi_get_drvdata(struct ucsi *ucsi);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

