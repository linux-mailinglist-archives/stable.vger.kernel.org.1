Return-Path: <stable+bounces-66727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4380294F10D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A471F221B2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B514135417;
	Mon, 12 Aug 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E8498Olq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA539130AC8
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474818; cv=none; b=DtNu9fkHhK+jgh+IG9hslG4QWIH78ef58VQnL7keD/nKEHzGkJI6A4Uii3QVyZx1NP2H2dLqJoTSbf3ML3HmasNCZ09RniE5FZ5PtunHg0sh/FxSFfFIjip7YL+8dc+OYY+tv8nTdmFEhp7cBs+RYd1kqUwOxwDMwwMF33TmaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474818; c=relaxed/simple;
	bh=sVrXZXI7CBoQfRqFkJa8UtNQF3Cbc1SAfjv8VFMOQpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qB71zR4Z6+YoA4a7Ti5X5gvopOaxq2RZAgDwoG3fktpqQnGPN1z9xqE7p0osAMiCMB8qHqpVrJ3zLvbNUoV6Hhx3Mkb9Igxw1nZ2fEVuJ5D5CAJW+Dm4gkun7a6kiRHRQYYiJ6o4DrJhgTc1xG07n0pfIgwHrht32FNw8Pe/cYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E8498Olq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE4C4AF0F;
	Mon, 12 Aug 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474818;
	bh=sVrXZXI7CBoQfRqFkJa8UtNQF3Cbc1SAfjv8VFMOQpQ=;
	h=Date:From:To:Cc:Subject:From;
	b=E8498OlqKtVNaJ0f+8w1tApZyKC+Mu7m43HcMdC/TdJ+a4sivYJ1XmS2zx+xLRQOz
	 i03uBG7SkIzlpd69EA/SkbzbnZ/TvmGlF9lC/9V11DPQb4hcRRQt3249w2YzwDo+bM
	 wxWHQ44XLSWD2z4kGIM++wB16oA4jViVLOMR8Xdo=
Date: Mon, 12 Aug 2024 17:00:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081247-until-audacious-6383@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

As some of you have noticed, there's a TON of failure messages being
sent out for AMD gpu driver commits that are tagged for stable
backports.  In short, you all are doing something really wrong with how
you are tagging these.

Please fix it up to NOT have duplicates in multiple branches that end up
in Linus's tree at different times.  Or if you MUST do that, then give
us a chance to figure out that it IS a duplicate.  As-is, it's not
working at all, and I think I need to just drop all patches for this
driver that are tagged for stable going forward and rely on you all to
provide a proper set of backported fixes when you say they are needed.

Again, what you are doing today is NOT ok and is broken.  Please fix.

greg k-h

