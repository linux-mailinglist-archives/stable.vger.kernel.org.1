Return-Path: <stable+bounces-145021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF7ABD0F1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886263B8BAA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CD258CD9;
	Tue, 20 May 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3JYoy8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA021DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727546; cv=none; b=s475sgABQbkJgHdBMlhoTUyRZR4aCIk8WKwo9HxwQlwbSq9FjlwzJJch6HD+nbdupSr4oWvClDhcHKnnwj1BsFkF5fVPgcb82GmGxa9u1Yul9cAehK3zEt55c497WFYnp0nEhwGdT3soFQIBi93irYMFl4qoY237u1qd4jUygPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727546; c=relaxed/simple;
	bh=Df2+EOZ4DwsWx9P7WFe/jXKcHnagtXCXIJfOaUoyF1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqaSVtzmsCa0Labxsy3jPih8JCPvHmrrpr68Ow3OUbPiSKVPjqzPIPPUq4MSiocloVjTIOfdG8+16fflA2dT6/onYLtVMgU5o3xWpllcCMrWkr8aVJ9kCFdtS8uAY7v4g/ipjppbGBepK7MbS2byFH6pr6Ss2V6jXNRcHml6u8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3JYoy8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC26FC4CEE9;
	Tue, 20 May 2025 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727546;
	bh=Df2+EOZ4DwsWx9P7WFe/jXKcHnagtXCXIJfOaUoyF1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3JYoy8W2nP+GdJqnhrUb39xDj5kP/gv/xasiGTe6dsQuLY9QrWCmRPmrgrcN7Pp1
	 /CG+XdPo7YpvHhGbQYiF/1OqQUwv7b7wlxv+ofTYwLR1T4/Q4zmSl6FU3fvOP5a1P7
	 SkChRF2rA6/5gZG16C6au6E9VP+6AD9jFGVkw3NsBB7RTtOQv1yf1O4oamfDAA6WPB
	 jVKcvnq/w0dz2zwWLMJ1DjQ1Cwa2d3HIYZodqHR3B9shgUtb7wiWj88oYJA8Ug3S87
	 plc3wSJ+Ku5YlScZNqAFkkHZ+77jVPELw8IVR4joSxe1OE/4xz/mQVgs1/csWNCD1S
	 uktDNiZRYhN3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 20 May 2025 03:52:24 -0400
Message-Id: <20250519183512-5ea246a26ccdc1dc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519085759.2694434-1-akuchynski@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  595cf3436549a usb: typec: ucsi: displayport: Fix deadlock
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
| stable/linux-6.12.y       |  Success    |  Success   |

