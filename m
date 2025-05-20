Return-Path: <stable+bounces-145029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B55ABD1B4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FB13ACD5F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4D262FE3;
	Tue, 20 May 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipmVPExo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286E23BD0E
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729157; cv=none; b=od1Zuk/46zTBOtWTV+9zm7UJ9bMuzt3FC4NAsgIq5864pYU6ukVBm7zUdeXvIZThac5SQNvwPnD5c5PvEU/PnztwhOlKst9znYaJCyYMLTpU3BGe/V5lYz4C08kugfwVtypPn8v/szgyr5LCgDaTvTMAQWHqu2PQA0YWXcsSxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729157; c=relaxed/simple;
	bh=dVexfb5/KyabBCLGPrbJzF2WqhDyroV7UWy+aWX5kiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oScT1QGGB6E6pMi1LFxmYBREe2tWqIzRx3jV7/VYmI8BUh/XEImdsj2k2RLIAU/vqEV8ry4kUhcb6uYVe0RWrcrz5DRn8xkmnL931Ysdki4VWll0gvNEkKflFCoCaemt5N/BYg11NWbkz6P5lpdTvT3f3QtoRVhYG84EReU/608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipmVPExo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D2DC4CEE9;
	Tue, 20 May 2025 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729156;
	bh=dVexfb5/KyabBCLGPrbJzF2WqhDyroV7UWy+aWX5kiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipmVPExoe1i94VAtfXfWTjq30S+JohL9VVuwsBedtxV0qQePIsQtT+H3Xmv3hmcvA
	 n1iZV897ZLQvzCwkoUWfqIJcqd9u/xJxJGxim40S+S2LLLhN8PiBLWM+WmbNw6NXt8
	 tlk+uhKBz03uGMPum6GQT67QLfvDYnaGMTTCj/zZeSgYv7E/xsgoBtTYhOKGq6Q8gb
	 z4cyEPBkoRIAvcZZkicCYMG8VoRibaPKQ4mRqg5/Otc8lIUM4EHn9GNVETK2OjxegE
	 qR4wDCgSgGvIgw3FtRqlItC3DCpKQFT1dVZNPUxGbz44repPx6vL/qFbFHdDD5Fh3Y
	 ejVWjNSDDFxpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 20 May 2025 04:19:15 -0400
Message-Id: <20250519192152-1527bac20ec5595a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519091504.3041039-1-akuchynski@chromium.org>
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

Note: The patch differs from the upstream commit:
---
1:  364618c89d4c5 ! 1:  048c23f1c8262 usb: typec: ucsi: displayport: Fix deadlock
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
| stable/linux-6.1.y        |  Success    |  Success   |

