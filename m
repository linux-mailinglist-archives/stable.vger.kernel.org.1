Return-Path: <stable+bounces-126956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83FA74ECE
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416FE172F12
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FA1CEE8D;
	Fri, 28 Mar 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Mlqa30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993084E1C
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181397; cv=none; b=ZNuMNxFpOBdxK26Bm5o2vqqbQJVbari6wFteZd/mLcChPbqxPLqM2nlCvHRXJ704YZmnE2fDLRBqaI8BagAnRXwtWTxTs8erL+OIpHqzrZUZnanu8WLfo9VCFMX9ftEjvi87z5shrMCTDYOsrA2iLrvADCdy7ysmYbn3RvYL27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181397; c=relaxed/simple;
	bh=gHsNs8qzJbXRezbbcnJWZ5Lk75IM/b9T8kSQQ1+Q8OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otDbLUGAp/s2mGLb5G7lpUsWwu/tM2wFWd6n2zEYdXQYuaglVIOz0sJXRzAHxwiASUdJr0b1PuIuMDywYcvmpuUL/asJ+NbqkvbqOiMEZ3OpfCxVMeWi1gq4D9ltX+wGSIAz4YtTLuoyTa8kGOuNN0FMUpXY6PRk0junegSbuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Mlqa30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFD0C4CEE8;
	Fri, 28 Mar 2025 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181397;
	bh=gHsNs8qzJbXRezbbcnJWZ5Lk75IM/b9T8kSQQ1+Q8OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1Mlqa30iIY3hasNm3c/G/HZhWGMhHBanBRqwswY1nE68GlDjMs56/+8BkO3nKJtZ
	 Bw+kLjsy/b+ayBlYJunwowA5Qhk5eus2aqWaiMuKR9X9ilEKBrh/Yz3gy9mHkwFZIB
	 r4NBegLqf//IWKfA0C82eevNRRKX8vMp4LQ/656Lqv4U2oKumCZRTxD0PHkcodon65
	 BukZaqn2LiFBGyZwPryUoJsc8svSQUMq8S3T4oHtWvAFd5Di0lIQTlpGY5wcC8Ztn/
	 MkPQgoMUSIPXGnxLEBEPlgFqN/O8ztsZSh4c0ZF6i8XjUWVi0Mth1swuKom2hX2XjR
	 KzSRQuPudEMLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akuchynski@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] usb: typec: ucsi: Fix NULL pointer access
Date: Fri, 28 Mar 2025 13:03:15 -0400
Message-Id: <20250328113712-065bb338f30d0a23@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250327133228.167773-1-akuchynski@chromium.org>
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

Found matching upstream commit: b13abcb7ddd8d38de769486db5bd917537b32ab1

Status in newer kernel trees:
6.13.y | Present (different SHA1: 592a0327d026)
6.12.y | Present (different SHA1: 079a3e52f3e7)
6.6.y | Present (different SHA1: 46fba7be161b)

Note: The patch differs from the upstream commit:
---
1:  b13abcb7ddd8d ! 1:  f2b614dccef6c usb: typec: ucsi: Fix NULL pointer access
    @@ Commit message
         Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
         Link: https://lore.kernel.org/r/20250305111739.1489003-2-akuchynski@chromium.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit b13abcb7ddd8d38de769486db5bd917537b32ab1)
     
      ## drivers/usb/typec/ucsi/ucsi.c ##
     @@ drivers/usb/typec/ucsi/ucsi.c: static int ucsi_init(struct ucsi *ucsi)
    @@ drivers/usb/typec/ucsi/ucsi.c: static int ucsi_init(struct ucsi *ucsi)
      		ucsi_unregister_port_psy(con);
     -		if (con->wq)
     -			destroy_workqueue(con->wq);
    - 
    - 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
    - 		con->port_sink_caps = NULL;
    + 		typec_unregister_port(con->port);
    + 		con->port = NULL;
    + 	}
     @@ drivers/usb/typec/ucsi/ucsi.c: void ucsi_unregister(struct ucsi *ucsi)
      
      	for (i = 0; i < ucsi->cap.num_connectors; i++) {
    @@ drivers/usb/typec/ucsi/ucsi.c: void ucsi_unregister(struct ucsi *ucsi)
      		if (ucsi->connector[i].wq) {
      			struct ucsi_work *uwork;
     @@ drivers/usb/typec/ucsi/ucsi.c: void ucsi_unregister(struct ucsi *ucsi)
    + 			mutex_unlock(&ucsi->connector[i].lock);
      			destroy_workqueue(ucsi->connector[i].wq);
      		}
    - 
    ++
     +		ucsi_unregister_partner(&ucsi->connector[i]);
     +		ucsi_unregister_altmodes(&ucsi->connector[i],
     +					 UCSI_RECIPIENT_CON);
     +		ucsi_unregister_port_psy(&ucsi->connector[i]);
    -+
    - 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
    - 		ucsi->connector[i].port_sink_caps = NULL;
    - 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
    + 		typec_unregister_port(ucsi->connector[i].port);
    + 	}
    + 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

