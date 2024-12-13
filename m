Return-Path: <stable+bounces-104119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71629F1091
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA118160E98
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA21E04BF;
	Fri, 13 Dec 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+SNreLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FD1E1C1A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102803; cv=none; b=uMEwf/o5qcy6b1SmTvxQBkWy0tPZkTiCvx70F7aWWnbFihlu31M9K0NE6uB595mg4VJhfwF+y+aZFKeXUxj6QQJsSeUZDUJIkLA+WcfSbivWOwJoekb4yhN9ojmenOXy3AbYpLslL/USQKoo/Zd5XK7eN+3WPMmylLOB589c83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102803; c=relaxed/simple;
	bh=W3XVsdLEAtMiCmSViMel4tR/ci7j9CdC819oY2LpirU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g96uLvKaq5HOTYCNZkAXgijRUHvVeqnskf+Ne6MeqlWfJpE51Up4SvPVoiFf1fA8wSsEuxqu1qY87d0we5c+/kde28UOJTwDGmsCf7T/D3zlKRwKMMDe5Hrv7CoMGQznVdh/0hI8Z1RBKOtIkZ/IAZjg8LmIAFgxG5x3fcZxBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+SNreLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E131C4CED0;
	Fri, 13 Dec 2024 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102803;
	bh=W3XVsdLEAtMiCmSViMel4tR/ci7j9CdC819oY2LpirU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+SNreLELKZiwXipJzreTlh13HUdxcYV1cxkzhqGrbKASp6x2Ql6B8oRGObEuXp/v
	 D3VZ3rfs2PGswgtB8+0Oi1eBB/I/WHo4cnA3QDV6WFw35rnSVTqn1kY72gJA0e8Vcw
	 8zU7CGRtZrCR0FoGBxsEG5zFEN9ai6SV4KtQXnp70pbKlN9ZFJyyT5Df3C6sZXBIU4
	 GeZ4SyXT0tXsEPD9AhMj0nKZwFsLesCXu8ZtgG36yIXuBpBha987ZbWohvB9hmJXNr
	 mPLphy5EPmrXbFAtWmDPr0+4QDZOs3LhTwd0CXcxpBHHFat4YH6svvMM4C2l7rG5e2
	 95H5D3BSNkvCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] leds: an30259a: Use devm_mutex_init() for mutex initialization
Date: Fri, 13 Dec 2024 10:13:21 -0500
Message-ID: <20241213092600-73e71f5a8637be06@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213035206.3518851-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: c382e2e3eccb6b7ca8c7aff5092c1668428e7de6

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: George Stark <gnstark@salutedevices.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3ead19aa341d)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c382e2e3eccb6 ! 1:  c7a5b2d87541f leds: an30259a: Use devm_mutex_init() for mutex initialization
    @@ Metadata
      ## Commit message ##
         leds: an30259a: Use devm_mutex_init() for mutex initialization
     
    +    [ Upstream commit c382e2e3eccb6b7ca8c7aff5092c1668428e7de6 ]
    +
         In this driver LEDs are registered using devm_led_classdev_register()
         so they are automatically unregistered after module's remove() is done.
         led_classdev_unregister() calls module's led_set_brightness() to turn off
    @@ Commit message
         Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
         Link: https://lore.kernel.org/r/20240411161032.609544-9-gnstark@salutedevices.com
         Signed-off-by: Lee Jones <lee@kernel.org>
    +    [ Resolve merge conflict in drivers/leds/leds-an30259a.c ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/leds/leds-an30259a.c ##
     @@ drivers/leds/leds-an30259a.c: static int an30259a_probe(struct i2c_client *client)
    @@ drivers/leds/leds-an30259a.c: static int an30259a_probe(struct i2c_client *clien
      	{ .compatible = "panasonic,an30259a", },
      	{ /* sentinel */ },
     @@ drivers/leds/leds-an30259a.c: static struct i2c_driver an30259a_driver = {
    - 		.of_match_table = an30259a_match_table,
    + 		.of_match_table = of_match_ptr(an30259a_match_table),
      	},
    - 	.probe = an30259a_probe,
    + 	.probe_new = an30259a_probe,
     -	.remove = an30259a_remove,
      	.id_table = an30259a_id,
      };
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

