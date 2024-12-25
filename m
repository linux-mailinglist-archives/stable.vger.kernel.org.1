Return-Path: <stable+bounces-106091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A19FC35A
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 03:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3866D1881B38
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6417991;
	Wed, 25 Dec 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4LtHHf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCD632;
	Wed, 25 Dec 2024 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735094521; cv=none; b=TLLlkLTo8y3Pafn7nJ5w8MgxrM2hz22Ra3pGYcVBRKxI0MhMuogIldUIoiB0D0+Kiqi8u7/v3OgdXQf3mafeaXkTc6m2uuj3K9cjcQvwaEGTFH7KmKh2VlwGZb7LO4b5zcWN1txOsVH5VjR2GuLlZqTSf1HGt9SOlpVrU096hJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735094521; c=relaxed/simple;
	bh=fyLf3RASkCe2x0XKlRNqhZ0gTwHmNi/WjJCvj3hFC+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmiEmiaUUvHLSzwJJNPYT2OVOcmGBg7fY2nl0VxI9RGBKk5kUi0uz5sxicNllYcs1i2FM4eXX8tNFRPTOumY4Lkwf1m4kOlEYR09QzwKDX3xLHAB87FJWdAwBKExglxqi7w9ZTmo7lPookCh25qIYgSRfWlYSJmFsodnVwqlQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4LtHHf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28938C4CEDC;
	Wed, 25 Dec 2024 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735094520;
	bh=fyLf3RASkCe2x0XKlRNqhZ0gTwHmNi/WjJCvj3hFC+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4LtHHf/u6YAJ9HmGqERoIx5KcV7eX4dpjO4r7zd8JHJ4byecIxkS3kEEUU3w90k0
	 y7QzfWcjzDnyMZ4XES4q536tz+FKJa2KcZgbdAGvFFLuaFnnIAHVZ9y7km6I4znC1T
	 zv+RchV3pU1Ld0KBJyHvqMd61jsdsN/cwqgd33qruV/pdtUZNG642yMNTHO79THMPC
	 o2ottKNdiIgatxUBDwrXua6e1IagyQhAEE7cqnWiWYY9uKXEwXZJZDLu6B62AwDFuB
	 d368hM+rltZPwqyhLx6LOBbs55z6y1uLdtE5og+Muhuf51l4sQulzq34xmN2RcZELf
	 a7cEeAnBa5lqQ==
Date: Wed, 25 Dec 2024 02:41:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Dustin L. Howett" <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alexandru M Stan <ams@frame.work>, linux@frame.work,
	stable@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: fix product identity for
 early Framework Laptops
Message-ID: <Z2tw9REoq5rbpv6S@google.com>
References: <20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-v1-1-0d31d6e1d22c@howett.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-v1-1-0d31d6e1d22c@howett.net>

On Tue, Dec 24, 2024 at 12:55:58PM -0600, Dustin L. Howett wrote:
> The product names for the Framework Laptop (12th and 13th Generation
> Intel Core) are incorrect as of 62be134abf42.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_lpc: fix product identity for early Framework Laptops
      commit: dcd59d0d7d51b2a4b768fc132b0d74a97dfd6d6a

Thanks!

