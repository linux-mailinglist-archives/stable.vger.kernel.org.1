Return-Path: <stable+bounces-144225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DBAB5CA8
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFB819E81D0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4322BF975;
	Tue, 13 May 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMQZsuT7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED392BF3FD
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162125; cv=none; b=WmoyxpxoJ3JRO8Xl10DDSzuLv7nUz0aV6zAzI53ZvvuK6QV1Mpypxl6A2cnPea/gC51qpV2SzXAZdhVbmKLjCLAzrzFE5lhbFfLKWwBfbkrBz6gMXHM3mV35LxNPoJ2eUJAaVNnxa28xUpbVkqzLn12PQ0mWHqzQa6zbzDRGbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162125; c=relaxed/simple;
	bh=s0MDBSzwI8LFZjTZUPUs2OT7w1hQya4lhA0H5tYi6HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpbvGQZBHk5HrTkdHJwTApYHLZnhxAjeQWTuuZE3otDuuusM7qamvuDk76g+YUJFElXo12TNo4NwVMdy3DWao8Cgd0AU+ola0EehcA/CDksrYgHY0aEqJbQTdemSH0V+A6rUK8hLcgQo4KjvEef8lAc7XCBjqA1+Pr25xyvTKHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMQZsuT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AF6C4CEE4;
	Tue, 13 May 2025 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162124;
	bh=s0MDBSzwI8LFZjTZUPUs2OT7w1hQya4lhA0H5tYi6HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMQZsuT7zUmR/CKxESZAoNU9+BbxmTCz4NViFxIuSH6Y6YLjkcNxy8XA4gpITF340
	 rZNHXojZLsL2hzVs0JVfZ43+UwF4CwJs1PiSwYxXZKIybojgpe/fY3Vx67eTP92WaH
	 tvAcx68XOiGuNb9mI7HorrQ86iGb0hjVgNQkePZPvE513yfIi9LUiPaKmYPEVVXLdi
	 l9V6FMMf2wBpegk0n4tx5c4TcgDPz3vY8RMdjSR4SNs91ne98f5kdMsLI5Abo5kMfA
	 pKbQlRdkkpX56ldC4DERAJhVocKFRQt2XebfXreueziSnH+1hw99yrjpOFquxUBEDs
	 4HsiAWMzcVIYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 13 May 2025 14:48:40 -0400
Message-Id: <20250513114436-b1b5a772cdb4350b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513073753.179129-1-akuchynski@chromium.org>
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
6.12.y | Present (different SHA1: 477e97e46b74)

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  2cefa12276275 usb: typec: ucsi: displayport: Fix deadlock
    @@ Commit message
     
         Cc: stable <stable@kernel.org>
         Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
    +    Change-Id: I0c09bb490e1170c13eaf0399cac9b84a9d51d8a3
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

