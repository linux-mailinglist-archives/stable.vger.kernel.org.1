Return-Path: <stable+bounces-145020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F3ABD0F0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858344A6714
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEA20E6E2;
	Tue, 20 May 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWnZZtL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA81DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727544; cv=none; b=IXB9iJ2/ICoXuwryq1jRKV6gDaOE3Mj+98NwpelmYjEykvPZ5Z+VDD6Ud1nA4GJB6dXajczAXodgQDzxWf8hIhVEcGREqSUfotU4SIz0beAMEP9IbQSOOlgSn6VVU7GHE/uGUu/doa4T3HUevPmtzG3qGJZyeMi7miFFa6Jgv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727544; c=relaxed/simple;
	bh=qgTt3yLun8ot7uMUpIB0l6UNRNE+RM5NFTdSUVcIdqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9gDcxBlg1iAFjW6KZ7gpUnroiEEHJqTQJsaDKJDS+ZMXX22NDUtbS6E5gy0BKjh13StOq0amubAsQc0whQcI2hk0+Lkx9ThIEQW0FS5uCLZswJfiZDt8N6savnQmkR9nA+kljdAY/Nz2fNSd/W/djBM3oY8dMLc6bBzjWaHE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWnZZtL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA1C4CEE9;
	Tue, 20 May 2025 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727544;
	bh=qgTt3yLun8ot7uMUpIB0l6UNRNE+RM5NFTdSUVcIdqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWnZZtL/7dYy4gJnb7iOqvixdK6GvdnCeyc8qR+3jkUVTgNslVQFNpyGjS4j6WMqY
	 iGFT7E7uAEtKBj9YS0vQDyLACbDAhOLE62QVzxWwhnnL4zskA/vkJC1Y4pkYTM1zZM
	 aby1rWmxdvU5Ueev+3pIhmbW7Qb8MghxAVC1uW3q32ugBagX+j7VfpUfYdcW3vrlmc
	 Ci2j6YsbTgDz/g9ak/zRuNB25oZ5gSTHjMxBZAnw0uG1wG7vUWSabTMqAZIU2KCSdt
	 u5q9x6FN6Lw2WKScEM4MIK0ZtN6G2etN9UxSg2uLNMq84GBdh5UFp3UMOvgarieSDo
	 ClZw/vnAs1yNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 20 May 2025 03:52:22 -0400
Message-Id: <20250519174334-57716b5cc915e227@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519083141.2406448-1-akuchynski@chromium.org>
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
6.14.y | Present (different SHA1: 61fc1a8e1e10)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  7cff0dd9a8d0e usb: typec: ucsi: displayport: Fix deadlock
    @@ Commit message
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

