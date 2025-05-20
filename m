Return-Path: <stable+bounces-145019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716EABD0EF
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9703B6AAA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8825DAF0;
	Tue, 20 May 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7b8s5kE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BF1DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727542; cv=none; b=DSwJz+JcPSAgTV/ZZ01p94HIpElBGLuOFidHEoZVPi2KFXQJE3G1cVlB/yvojyCG5X221S1mN00IiObrL4j9o/UuB3VfolQexxpTMSmGmQ83CYZO14Zv0uEtsjfiOiA7IfmvsuFk2BF6GwBjvMQjW+z7cHGBw9IMeoOg2JD+uKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727542; c=relaxed/simple;
	bh=SaIbDNTo/LE3Pr7qTV8DJfacqB/pfjUuf4ieJN+ca6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk3GLcKzcK8PyDSJLE0Bfl50jfuNMUwQPaw7cBFvEKwJS02yCCy7hh26JJxjIQFN9aoGhYXLc9wt4t9/PTqXI/QmRW3EmvIbSMe3/9b5EiPqikSgoqvCLuGFQRaT3zZnlJru8KycZxqOrKRC0KVMIlDNZcga09XaBUFe7kHXoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7b8s5kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F5C4CEE9;
	Tue, 20 May 2025 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727542;
	bh=SaIbDNTo/LE3Pr7qTV8DJfacqB/pfjUuf4ieJN+ca6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7b8s5kE45SooIhwYZWe7ShzaHEwl1NqMCJrFcjK8+Z0v7awB6/fulrb8LRg27waS
	 n40Vs6KhtKuok6/Jlrbnw2p8n1WXyugqUMh4OvgyTUWaMtCeKUngMpisTEtHR3CzTF
	 NVlq2KtngvLihiPg7hbA5wr/pl31fXVbF5r51P0+qnd/Yanqzrlc/RGryj6RvTEEdx
	 9nucgMAW0xSAWyYNBR8K+Yj8KBUKI+7DK1C2mB3iXj4LVdnUUX4uNNZRjT2Km5jkxS
	 Pa1Xf8iVSOroyijEpXmVv+IaIpz17sjuVOicTyVvSuRzukiEQ93/+h4239q8nq1v37
	 9ruerbAIwWjDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 20 May 2025 03:52:20 -0400
Message-Id: <20250519182548-93e326d4d142d87a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519094330.3225918-1-akuchynski@chromium.org>
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
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  caf9dc6a5a533 usb: typec: ucsi: displayport: Fix deadlock
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

