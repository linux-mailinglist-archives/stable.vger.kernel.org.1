Return-Path: <stable+bounces-166517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF5B1ABE3
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE3717E7BD
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4551149C7B;
	Tue,  5 Aug 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1HzakaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65518A6DB
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356004; cv=none; b=cnczyfkF1hlaKXhoObIGxpqfukmYTlVBL0oqKvsj/0CS7etPqc3RTEB6OqaneMMbHVgbbjkp2A2vSQoJE2id9Kto2YJQY+zKvrRXle3h4e9jaW1VObC1lnUuDeu0wdNPQDtWnosVNbe8PdQ+QmDMawOYbrs55eElPsGHcOqGYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356004; c=relaxed/simple;
	bh=owNPkWXjsWAtft0OpEiQI/MGcyTPLiSRSdOjl/KHSZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiDzH58NtlSg4OrBOgKJ2aYNU3LKvK/SSVBmX70e3Ctsa5IrJdFfc8kepP3qQOIlI2DjD0y1TlJMXqN9JdEtrpqNLxFZA47b8UGAkq0hv6DLx8T+05jRptXJs0Rb+Uz/4D3TpJ4bH6MCSVHpsJov/NdRRhmTPMTmmUy6rRkChlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1HzakaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED46C4CEF0;
	Tue,  5 Aug 2025 01:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356004;
	bh=owNPkWXjsWAtft0OpEiQI/MGcyTPLiSRSdOjl/KHSZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1HzakaSN9qFAk/56IqeFct6xc5EkzRHAvrtS3LXfAf0bP9gR9WmzSTr9OsrL8HyC
	 iDS9zwh3pvzsizE6TICldKp/IeoFAhoXgFhDAu6Nh3Wozykeo4U9HPPmM9d6iklO5H
	 IgX5L0+iJcWjrpCOEZzccm3VGjcXVPW1oeHr1WJS9etEgyAEHXefSCBvIEhrkAfLc1
	 zD9pTflM9v/COIELchlkmO8nec/7yvJm0mc9zAlg45q3v8pziYkBwbQ6HPg23Cd4kE
	 GLgHFVZ0yNS9gZIUZw31cBdOe2MfEfFymCQU13DFKZo0BEuQHAUo7fSoloCzxCun5Y
	 BSRSr2v52u0eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 2/6] drm/i915/hdmi: propagate errors from intel_hdmi_init_connector()
Date: Mon,  4 Aug 2025 21:06:42 -0400
Message-Id: <1754321418-c7885570@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <938a984204146a4b6628030af87ff374cb41936c.1754302552.git.senozhatsky@chromium.org>
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

The upstream commit SHA1 provided is correct: 7fb56536fa37e23bc291d31c10e575d500f4fda7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7fb56536fa37 ! 1:  d8185aaf6ffa drm/i915/hdmi: propagate errors from intel_hdmi_init_connector()
    @@ Metadata
      ## Commit message ##
         drm/i915/hdmi: propagate errors from intel_hdmi_init_connector()
     
    +    [ Upstream commit 7fb56536fa37e23bc291d31c10e575d500f4fda7 ]
    +
         Propagate errors from intel_hdmi_init_connector() to be able to handle
         them at callers. This is similar to intel_dp_init_connector().
     

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

