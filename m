Return-Path: <stable+bounces-196945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E262AC87EDC
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937593B417A
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E330DEBE;
	Wed, 26 Nov 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DRh5rBXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBB30C625
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127147; cv=none; b=L3qG62OLIakD0jFbD/1KKMomD0gAahP/94AaZekpRtsz1dCYlQs/lHfkqkJri5hT55cC1u11PviF2CFEof9oMynrWA468GFEqAQoJ9WRnsvID7n9oAhnMpMPUDqqefRcS82ZFp7Kx78cytA+m+6s7TUeectOg7co9lGIKub/boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127147; c=relaxed/simple;
	bh=J7o8+a1I25gyMr2nCGcTd+8YhviSg5xpSP1kY5jJpYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mx1lgUAt5yGtwfc0dWwklaSFu7nS4Hb9J6Y+nwHq9YnpEjk+zxHSkO8BZ8gUiArEPnXmEgq+B67SBPNSV2rzQ4ZU3GTCpFJOhcbmclKlHC0eFVtUDFvJmGh/NNz/TnqX072uUz/AlBckTXzQ6qe/DjTsxuPrONCQkUXqTOqoRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DRh5rBXf; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1764127134; x=1764386334;
	bh=J7o8+a1I25gyMr2nCGcTd+8YhviSg5xpSP1kY5jJpYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DRh5rBXfGFjvsGmNuNwefNFSRj0debIygHyCCwP8j8/TottpJs2+lxRgPJfQyzaX0
	 XdTOtqjzG/afpZWYvYb3U515HXvTiYkVU2w+yvZ2sGgN3cYdg/2PsHn4OC+UaK9TBE
	 dKR6Cr/92W4jsn+Z5d75c6kMtQQCSkH9JX2kW/dhAwJsgNHSerXXDBS8HiZY4KnCUR
	 uRBXEnli8GCWoKpeVp0hTfaBKCDs2WhxDOEaQfJytO8tI7nlJD4P8vD9gYLz8z5yfh
	 FYH2qhH8tZh+xgor54M4bqFJJ76GulDq9GuiyDpsYUTohK0le+1o0fnyTk3yDDfoHx
	 EhCR7VJB0iANQ==
Date: Wed, 26 Nov 2025 03:18:48 +0000
To: patchwork-bot+bluetooth@kernel.org
From: incogcyberpunk@proton.me
Cc: Doug Anderson <dianders@chromium.org>, marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, regressions@leemhuis.info, regressions@lists.linux.dev, johan.hedberg@gmail.com, sean.wang@mediatek.com, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Message-ID: <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me>
In-Reply-To: <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org>
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid> <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: f6d82a3f4af4a0c9485cbb7610dd235edea26b50
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

It's been almost a week since the regression was reported and an patch was =
provided to fix the issue, which has now been accepted in the linux-next tr=
ee; but I see that despite being a patch for regression, a merge/pull reque=
st was not made upstream for the latest -rc mainline release.=20

Is there any way that I can track the updates for this patch to be onto the=
 mainline release?=20

Sorry, if I am missing anything.=20

Regards,=20
IncogCyberpunk

