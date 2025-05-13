Return-Path: <stable+bounces-144260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D23AB5CDB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD543A6FA1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB972BF994;
	Tue, 13 May 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvX2AI96"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4492BFC95
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162273; cv=none; b=gsFk5uZdPHzPkFdkXTsm2nVITU3xBu99/b6AAgngBCgIyMYOqG4nzan+ruQzxkDb+zI0vCR/uiWLPhV6c0dUGsCBQswZJzaVv0TlkCeLFHMvaS8HsnB2K0gXRV4A4DwL8sZtQ+T8K4GwH3N/Fu6kazWa4cY5/KflBzgoqI+Aj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162273; c=relaxed/simple;
	bh=M/g41VHMd1Z+Dtbqtxes1m6KYbHXDuxDIBD4FA34H4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFA2/UhvxXzmxCRDMw5RioWf1dQgEjxQfhWlx5UdKyWWXzqdlrdJDOHyAuusx9wg+EB9bB5bfO83KG21RhXJ3QmP3vfxO166bqoLVIl2wj/dpJyFxQPIFF2sNcfHcyvQnKTA2yEIqTtbekz8D21a17jmdyPbOB41BdMVEqZ4wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvX2AI96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA1BC4CEE4;
	Tue, 13 May 2025 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162272;
	bh=M/g41VHMd1Z+Dtbqtxes1m6KYbHXDuxDIBD4FA34H4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvX2AI96WNDUwRX8SNC6Xku3Zrk6Vr7ONQi0wYyYVF1mqTFoeJPWPsOJqh1kharHW
	 IHQ/FdxhgD4CwxCFxv1oJUbaNs2wiORuYlLTsXTo5AVirpF/3JuqSoW8/gf5L01FPY
	 CEoDm21blT/0DfBdZ4GZXNaT/rghSAIwS0CS5ER5yjCiI+KnQxZgMVIr+j2yDd8ojn
	 PpU3rKd1apBQiVTOczq1eZBIVQNSNeYoKD7FJgLuNKvZIXiE8ofVqSoeG2+MFUq+T5
	 b23RXIbUgWRq1NxWuVCr0fJkquiccF3qMPrq+s8vqqWwZVil85mGTW7AyBRBqlycMY
	 AdjsUEykKb8fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 13 May 2025 14:51:08 -0400
Message-Id: <20250513081225-a993cec5f65450fd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513081630.534069-1-akuchynski@chromium.org>
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
6.6.y | Present (different SHA1: 3dc48bb63649)

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  1e9e5ea8c6147 usb: typec: ucsi: displayport: Fix deadlock
    @@ Commit message
     
         Cc: stable <stable@kernel.org>
         Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
    +    Change-Id: I8b77692a60f77b8ddbb0503088f447fe1bb6a512
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
| stable/linux-6.1.y        |  Success    |  Success   |

