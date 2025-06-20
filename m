Return-Path: <stable+bounces-154855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3F7AE111B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DC83B9C6C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82D13B788;
	Fri, 20 Jun 2025 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkA0oEk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC1137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386314; cv=none; b=tiMUBMMHOTNElscakmg50lAgkFlkcvMIb7NFB8s2NC5gCDsEVuX5mQOffQa47YHvhRiUJ0T6ZIIoJP5CSaAiETwRCSwz4jD8hJ6yHQUfA1soYSRzWD9eaZYWpbVjxesvDk5ql5ip15GRLy7XgltU0/HBV7Wz4VqtwBFksLUaiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386314; c=relaxed/simple;
	bh=e2R/iWLVqe0JwRIzo2DF3gK4evByHNPrNUpqHojIx6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6zx13RW+ETZkEqtzpxwFwEsbUWhsgOsKRhzFV3ZoQpLivqxhhrhfFZ+qxmkyXkmQr3qc0N6pJ85OiEfMi3ibA7uJfYY+ndswFK7kGhGt7jNlMPOkS9Sa51g/ODyd8uMqY/9E2v/eWsiPn1kK2Xla1ldkBW6+8UGORiU4nI0TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkA0oEk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F624C4CEEA;
	Fri, 20 Jun 2025 02:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386313;
	bh=e2R/iWLVqe0JwRIzo2DF3gK4evByHNPrNUpqHojIx6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkA0oEk/oTq9VnnoYB6aU18z/45m27Hls+Ma8Vz2wEbJNMyMvc+WPPPDehmP2oD+G
	 krQoPYrC+rFq5f4h34g+zzRX4MRbJNwDZAxAN402THMt7PaN68OBNY9qXV14ICGnAC
	 CiI7v8ZAoiwIs4VgObW6cSX7xYdsZ2RKRZNZHUuVlMN23tMA8VbeqmWRAORtBg7GXq
	 DvEYVG1S4rhCW9VtKAhh854M8EzzQQ5bhrxL1u0oR3voeYfHDuAHYT1+T1JL2/gW9q
	 0eOpMV+Ut+ToTDoMsyDi4sq9CNa4okAOwnK7ft99kU0kIu57T7WfvMlcZUysAn1NMr
	 M1sESincIjltQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys
Date: Thu, 19 Jun 2025 22:25:11 -0400
Message-Id: <20250619053339-55f86e6352052298@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <F7FB9E816BFCD1DE+20250619074704.56965-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 36e66be874a7ea9d28fb9757629899a8449b8748

WARNING: Author mismatch between patch and upstream commit:
Backport author: WangYuli<wangyuli@uniontech.com>
Commit author: Renato Caldas<renato@calgera.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  36e66be874a7e ! 1:  fab9d136c5d0f platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys
    @@ Metadata
      ## Commit message ##
         platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys
     
    +    [ Upstream commit 36e66be874a7ea9d28fb9757629899a8449b8748 ]
    +
         The scancodes for the Mic Mute and Airplane keys on the Ideapad Pro 5
         (14AHP9 at least, probably the other variants too) are different and
         were not being picked up by the driver. This adds them to the keymap.
    @@ Commit message
         Link: https://lore.kernel.org/r/20241102183116.30142-1-renato@calgera.com
         Reviewed-by: Hans de Goede <hdegoede@redhat.com>
         Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## drivers/platform/x86/ideapad-laptop.c ##
     @@ drivers/platform/x86/ideapad-laptop.c: static const struct key_entry ideapad_keymap[] = {
      	{ KE_KEY,	0x27 | IDEAPAD_WMI_KEY, { KEY_HELP } },
      	/* Refresh Rate Toggle */
    - 	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_REFRESH_RATE_TOGGLE } },
    + 	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
     +	/* Specific to some newer models */
     +	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
     +	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

