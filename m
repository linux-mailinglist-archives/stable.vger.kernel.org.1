Return-Path: <stable+bounces-144460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5955AB7A93
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 02:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627FD4A7F8B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAF1DDE9;
	Thu, 15 May 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6T0tRjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C31DDD1
	for <stable@vger.kernel.org>; Thu, 15 May 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268906; cv=none; b=LPR79ff09vXxI6cAQz/OZ+Ewf4avHo6GaObf9M5mU8BfvjY1pOCSTcCjoEgJWVR9ZdWfrbwrX77lF55DXdePBH8vBNUOyNC6NgeOzxJHu7oaECg4qhozLjCMaXsTTDH++B+NYVTyXYcaTGZOs2Gdzo5angsushFzuZ9gqsgpRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268906; c=relaxed/simple;
	bh=R/RYqpRuwWL/ZMb+7tKqMtcmxwNCiS8QK+zfLqqxGcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZayswDkkKQGZNl6Vb/CvJj94wLXtAlpqjaILo0shQZSLHavSLDRVkXZ3rtbetwBHI92L3FZWdjPp5csJDWI0fsyF8Nbbk/Npjnt897mo5lGwFuitA5SPsoBlhsIcUFIeESppZgl65oASl+RRW9HQJpFjsMJTPRsPUlvxQEIm7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6T0tRjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D60C4CEE3;
	Thu, 15 May 2025 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747268905;
	bh=R/RYqpRuwWL/ZMb+7tKqMtcmxwNCiS8QK+zfLqqxGcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6T0tRjzMO/6mosbtRjpKO+217YgUvaSfx1WBkulWmMLN5EZy2lWaSV9Zzi9XwKUx
	 koJ8VZKKu08rT6swN4+omEJ2XMqKJaS5Ahq93bH3CFQbKjCw/BpwNSkc/ENF0f/xsx
	 wgWb/wq76pcXhBvxuooFzSWyWOssOwRitByCaWV2eTexeo6ihJa0jrVZJi6GMn/XPE
	 WQJjXBZxSQYREzNMc58vNUPFJ3S3IYI3tNP3O23usV1wEfgvYnIMumyN6zJcdjPVKi
	 CvdAXJnTdC+NYuEsaanpgDUKzc46epf7Nrhd0s7as2X89BOWSuLiG462PLv71BEFie
	 CMJwBmht7J7yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Wed, 14 May 2025 20:28:24 -0400
Message-Id: <20250514201011-6788540c93d71428@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514144931.2347498-1-akuchynski@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  9734f12d7d5a8 usb: typec: ucsi: displayport: Fix deadlock
    @@ Commit message
     
         Cc: stable <stable@kernel.org>
         Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
    +    Change-Id: Ib10b1ec42c210b49cf67155ed1df7b074a99405e
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
| stable/linux-6.12.y       |  Success    |  Success   |

