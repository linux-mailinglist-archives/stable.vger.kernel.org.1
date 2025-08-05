Return-Path: <stable+bounces-166519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA77B1ABE6
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CCF7AAA14
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41C17C21C;
	Tue,  5 Aug 2025 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umJJaODZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172E4086A
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356010; cv=none; b=SEYzxeUkfovqU6hny3b3zDUyw0+SftgA0T8N+2c9JZCfVBGt8CpyktkVvMBSbqm+F2iUtdqOhKYoOoOy/shUb7EXirhv5ij//5gfrPU6izBHUcoKUtmL5n3LdXXRvH8pkD0xW5wYkqFAbXdtSkmKorixH031iKl7zvy0MxfOUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356010; c=relaxed/simple;
	bh=ExqD0/qFP5EirWeJ2icPFB3/gy3ha9hC5O5ruuoamt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Men0D/3Doe5ztQQ+CRW6s8b7UtzyqvuBgvynxzo995ynGGRKwuji2zo2qRil+0sCd6vmBVbqt7RiVJwcbhcp1K4C+ffeV9w/UVoo6ClxKD+CnleS3L8wJhYGDaGNgkel1RwSU1LV75Zl4D6+al+4HfU/Sozx5DjLRV8IvSKWo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umJJaODZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57347C4CEE7;
	Tue,  5 Aug 2025 01:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754356009;
	bh=ExqD0/qFP5EirWeJ2icPFB3/gy3ha9hC5O5ruuoamt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umJJaODZCTlaR0bfNG1JghARgfrbXeERM1Xxgj9zMvPpbaCetA5GfXBKGU/L5faac
	 Lom/nuzAtaFoJjW3TUW4KvmjALcOcIzlVpYZC6z07o+Cc8JxUuAeKebqO0qek1w19a
	 9ihsckuU5sUcdekk/qCb88XwrEYsxHBg5X8ScJCxBraQ6uHceqOXGBWar9UrnqjUrK
	 q67bwWH15nQs/QswSNJbi6+OGpOmBZSERx3H0qo8VP4yUk1+5SmrYkrS1HdF+txL9O
	 2x4yXUm3woAzl0j/KVDYpMLOBgI4YFIN+VUpAbHrOy6Z83x9YLkEdPd0MdQIp8cKt9
	 COOQFblRqHB5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp, hdmi}_connector() return type
Date: Mon,  4 Aug 2025 21:06:47 -0400
Message-Id: <1754321341-a5195975@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
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

The upstream commit SHA1 provided is correct: e1980a977686d46dbf45687f7750f1c50d1d6cf8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sergey Senozhatsky <senozhatsky@chromium.org>
Commit author: Jani Nikula <jani.nikula@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  e1980a977686 ! 1:  c9dc9718ce79 drm/i915/ddi: change intel_ddi_init_{dp, hdmi}_connector() return type
    @@ Metadata
      ## Commit message ##
         drm/i915/ddi: change intel_ddi_init_{dp, hdmi}_connector() return type
     
    +    [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
    +
         The caller doesn't actually need the returned struct intel_connector;
         it's stored in the ->attached_connector of intel_dp and
         intel_hdmi. Switch to returning an int with 0 for success and negative

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

