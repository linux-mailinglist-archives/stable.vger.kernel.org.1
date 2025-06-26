Return-Path: <stable+bounces-158666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF16AE9831
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE53188877E
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15333285C8A;
	Thu, 26 Jun 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfM1ePHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490823B63A;
	Thu, 26 Jun 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926285; cv=none; b=qPwH0G5P5Np/b6k+njTAF9yExCJwKh42OxLCbFFv8sQFfcDoqpbXomhz+sQa65ei9D219jRJhi3PySjZZNhaHcE4aGrZ/5gkuoAED2CSVje5o30s2CWygiCKXvxAHJt1wbNZIm4d/Cr85YuE7KiDz/mB0xz9GryL1vVOapQBET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926285; c=relaxed/simple;
	bh=I9vZdEkAWXh73EN+tnd305QlTyFdASaPKKuepsi0GTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4MYMac+t0rQ+XKkRiGnSWFq9SPFnZGWTm6uKThd2+s1JUWWujQH/mgX02oWQApsUQhL7NtcefIPZOaCGbQ++oLESL6o49Z9P2MJ1zzZvkn/xGN2s3fligNw9BS/B2Ud9ZtDFgtQpHSClmL6Jxg5ey3BFWSAV9yMWm9Kb8AFTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfM1ePHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F89C4CEEB;
	Thu, 26 Jun 2025 08:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926285;
	bh=I9vZdEkAWXh73EN+tnd305QlTyFdASaPKKuepsi0GTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfM1ePHXmN+1ekJbJPITqLWNeBh0AWGrkuvHdW26YnIloQKVFaj2Q1iWFevNM1xcE
	 q6Fb9EsNxmiHGzH8XHTHQpT4cZMu7bTvwXb4mkdfmYhXq1Yf+sIfS/wId6AW8L6/zP
	 6/Ex1hA8qpR8HLrVh6s4ObpKMabCeBIRy4gUFR+Kl3Ts1VV69fA9DnoIrFPMbDYC00
	 dcXjF6j600ZIV4RVypNM630ORc0hezJJQas3GodjTFW7Cdde1zut5OzR6QziJvmK/3
	 NOgcF87lXZ+sH+oQvag35KINoEbldBFZB2xngbORZQZM4u3miVuQDJcTMm50Gr6sm5
	 c3m3aiWkEdysA==
Date: Thu, 26 Jun 2025 10:24:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Andy Yang <andyybtc79@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hans de Goede <hansg@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ata: ahci: Use correct DMI identifier for
 ASUSPRO-D840SA LPM quirk
Message-ID: <aF0DwglTSwicu/8C@x1-carbon>
References: <20250624074029.963028-2-cassel@kernel.org>
 <175085763212.1222616.11590478108629299286.b4-ty@kernel.org>
 <CAGEiHrDtfwKGN+veFjgODf_0W4yJfDP0f6kqp-dF9xsypoH_0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEiHrDtfwKGN+veFjgODf_0W4yJfDP0f6kqp-dF9xsypoH_0A@mail.gmail.com>

Hello Andy,

On Thu, Jun 26, 2025 at 12:39:26AM +0000, Andy Yang wrote:
> Thank you once again for your efforts on this patch. I also want to
> sincerely apologize for any inconvenience caused by the email reply
> incident.

Don't even think about it :)

We might have been able to avoid this extra fix,
but that's it. No biggie regardless.

Thank you for your help debugging this.


Kind regards,
Niklas

