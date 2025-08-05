Return-Path: <stable+bounces-166520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C9B1ABE5
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7818A1D96
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948A149C7B;
	Tue,  5 Aug 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/ij74As"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB974086A
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356012; cv=none; b=HMRiGEmZDuUCCMJ00eNFNpnMqk3+jaL2FEcTwEMoX95CmYlhIJ1hA3lcBJSM2KQxSRK4UX0i9fHvbeZOLJTzRMsABoHB9VmlMTFXA5+StELn7LYKOYVNn+3kLgkjOshAOp8qVbx3UcNULLPrvSxxD8Q5DmnvHx4db/7q/HeVSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356012; c=relaxed/simple;
	bh=7o9AowWvoz1Lb9Eszidu5x8+VjKTNqy4JHtsxk0wF3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4k5rDHB1JJZYt+lTofkl1yuxxLPzejtOtl9/i4zdW2CzMyN01i5Ctvoam+f/Paw/t6F/TTMbGY5QKeTGkhlEcQ41FUYPSXviNyL4mfhxgDnLqIf8L3iEBS1ttsloUpQcqSXXOPQ0O6ir2LIgqX6aw+nhzW8KKRQmmG9wlNOvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/ij74As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1282C4CEE7;
	Tue,  5 Aug 2025 01:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356012;
	bh=7o9AowWvoz1Lb9Eszidu5x8+VjKTNqy4JHtsxk0wF3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/ij74AsUfkmaZ1FsVnPVcQO9Q/L9NCLN3W9Vlphg4KS0RSDUc2Pi56KLCjFMo/JR
	 rwguxTSVo46Npr3Fco4dZm/tGfT/ZFzN7tv/6kcfJD3VOS5x1/irsz7o//+dVjkEmr
	 SQ36vVZDI6wywfaJ/bVnIPHQnK2rRC9R+iAcxH2wgk0PkGroYWfdrWJl1NO5wmUfz8
	 /OZEfSf1G/AouBO/hQbTk5auHOdzKbQsoBacL5QtUdUCHlrR6fqAl9OgQciA3358lj
	 ekRs7IF6lQJtV8WErsHBshWIY6hCm72FG5U5ShMd1oVws3kMjzc0MFgM16lJeMHuSL
	 uae/n34R3Q3FA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 3/6] drm/i915/hdmi: add error handling in g4x_hdmi_init()
Date: Mon,  4 Aug 2025 21:06:50 -0400
Message-Id: <1754321505-88edfed8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ebf6995a6202f266badbec356c6b87a55cf478dc.1754302552.git.senozhatsky@chromium.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 7603ba81225c815d2ceb4ad52f13e8df4b9d03cc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7603ba81225c ! 1:  6e1bc5a45972 drm/i915/hdmi: add error handling in g4x_hdmi_init()
    @@ Metadata
      ## Commit message ##
         drm/i915/hdmi: add error handling in g4x_hdmi_init()
     
    +    [ Upstream commit 7603ba81225c815d2ceb4ad52f13e8df4b9d03cc ]
    +
         Handle encoder and connector init failures in g4x_hdmi_init(). This is
         similar to g4x_dp_init().
     

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

