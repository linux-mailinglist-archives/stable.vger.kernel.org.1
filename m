Return-Path: <stable+bounces-142890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00DAB0021
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD672505CB2
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C1281526;
	Thu,  8 May 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poQ0SKF/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8C281517
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721100; cv=none; b=jvw2eB7BLf/hD3IzHyz5K7IKRqhDwm3EwJum3l0E2T24yh0a3ZTZoW2P335BAProjqXP6k3snvy3fepivibeVk/+/hbC6czzZg26M4yDebXs0AEB2H/5QQZW74UGWi3dgGKNAlmRqDTVJrmWIaSTnQTTtuYmzDu7oZxDkEZ2RGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721100; c=relaxed/simple;
	bh=xlaJ08hkkwV2V8ndwKdLKDcE+8mDjNIoNbEoIidwk+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXxX0E1TdsWz4fC35P5vxqb6wbcfHkDbUlswDoEn8s3KZuGPAAU80nCPrEGwNXbc9xNMB/bEa/aq8ZwTClpjS+vCsElFAHzu5acreZqC9E8g7zrDm2xodODZryFCPwdcJ0bnUDDhlPSvah53B6y5A4cN4DebsY9FppbwUMXzq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poQ0SKF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9192C4CEE7;
	Thu,  8 May 2025 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721097;
	bh=xlaJ08hkkwV2V8ndwKdLKDcE+8mDjNIoNbEoIidwk+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poQ0SKF/sgDHzH2ywxCNGYiu/RLTBLcokEfiIPE0EdcFZMn9ElYhydnzvJPQjOuKD
	 eQmo6nADFHXhcFPvB3nTX1WqKMtuTHGO8XOfBtyvZAVNaeYnXIY9XP7Lk3tOK/dKva
	 0QEOKTO9BTs9pUzXcciZREl7DyE1ETrKFseNHsGimZFAcJo0r38SUoLS6in6LteKVd
	 XDkDPbWa+86uPYwS8RaUC5vQNdo5wRMnSsBtOvH41BefIHvjW9jfgWTL6DRAhJeJPZ
	 /SHgOqMoMLhfT9jZsTv83ogb3uxxTPGBIEaBn94A+NR6+8BN3ZfyNZamAX12dY/jhE
	 Uoe0Ghl/dSd8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 2/7] accel/ivpu: Use xa_alloc_cyclic() instead of custom function
Date: Thu,  8 May 2025 12:18:14 -0400
Message-Id: <20250507120012-18f90b49257fb637@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-3-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ae7af7d8dc2a13a427aa90d003fe4fb2c168342a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  ae7af7d8dc2a1 < -:  ------------- accel/ivpu: Use xa_alloc_cyclic() instead of custom function
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

