Return-Path: <stable+bounces-98828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA729E58BC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC052844B8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377F218AD3;
	Thu,  5 Dec 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0q2qFLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DBD47A73
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409922; cv=none; b=ig9cuz/x/qaoTK76oMyCqyUYXbEKHvX7ttwKXJObZKVPDw5d3TGyQk6AJMiKLjV6sBfEtfSff/2ZvK9QUwKl9A7c0Ky6MXo3qyVcQRpH8S+yBuQOT6GCZ6trszbASbYZKWJwGBdy6XeBVkDTjIbVLEj5zLvTtYIgFUdzITjBf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409922; c=relaxed/simple;
	bh=tORfaQ52cY9wYbP+2iYhkA14LM6vm6mf7akOb93qwCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgw42MiWffjLAiB2E6TJBbSx3iHYAcEM2lIT9OHFl6mvzft+BhQZ2NIAYZJjbX80Upv+lJE/4C4s1qm/kfpqoDhBM79H1hj/EO4OhcWL5m9A007ehBQjCCXnWws8zMDTRpWzsp9XC0V6OzhMzpFU4ISGcPKsKUTLC8ckmD1/8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0q2qFLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E93C4CEDD;
	Thu,  5 Dec 2024 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409921;
	bh=tORfaQ52cY9wYbP+2iYhkA14LM6vm6mf7akOb93qwCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0q2qFLONQdEVx25C2+OPChKxTx37eYDkjtMqHH+ZwifqW0s6fjpogtUnZmCQU1rw
	 1MqLFWWoU042fLYpXfDdPYZ0gbafgBW1HKpV9yavxvuRRlR4toy+wlP/cNhSEuVSk/
	 T4tmkK86Lfc1TyXvWV4VIvIG6mnUT/EZiZe5U2VT03zY9lLk6/j/NAAmgN4t7/uH38
	 J/EShkBMzeU2I+1cs/xzUc5YcpV4Ou/zmmHwWILZcpQnqmpf9Nu/gV0avhfTVTJOJX
	 pdtjo+//dDRr5AHnotFJBP70DXhuFDjNRr5Qso2IUK0kaDdhI5MRx/4neAmYCObKPT
	 qeGdg/+qsVL8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hardik Gohil <hgohil@mvista.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Thu,  5 Dec 2024 08:34:02 -0500
Message-ID: <20241205070135-0f425913e33c9d90@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <1729316200-15234-1-git-send-email-hgohil@mvista.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 2663d0462eb32ae7c9b035300ab6b1523886c718

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hardik Gohil <hgohil@mvista.com>
Commit author: Kenton Groombridge <concord@gentoo.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 26b177ecdd31)
6.1.y | Present (different SHA1: a2bb0c5d0086)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2663d0462eb32 ! 1:  102f30cc3d0ad wifi: mac80211: Avoid address calculations via out of bounds array indexing
    @@ Metadata
      ## Commit message ##
         wifi: mac80211: Avoid address calculations via out of bounds array indexing
     
    +    [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]
    +
         req->n_channels must be set before req->channels[] can be used.
     
         This patch fixes one of the issues encountered in [1].
    @@ Commit message
         Signed-off-by: Kenton Groombridge <concord@gentoo.org>
         Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    +    [Xiangyu: Modified to apply on 6.1.y and 6.6.y]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Hardik Gohil <hgohil@mvista.com>
     
      ## net/mac80211/scan.c ##
     @@ net/mac80211/scan.c: static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
    @@ net/mac80211/scan.c: static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_
      	}
      
     -	local->hw_scan_req->req.n_channels = n_chans;
    - 	ieee80211_prepare_scan_chandef(&chandef);
    + 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
      
      	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

