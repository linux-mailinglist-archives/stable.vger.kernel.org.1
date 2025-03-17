Return-Path: <stable+bounces-124714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2109A65901
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970BA1887FA4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB120A5F2;
	Mon, 17 Mar 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJrzLJCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC91A8F61
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229617; cv=none; b=P4L39jkT7ELeMr6YLoSqA6lve8iqFwogAScb1I5kOb1EDJ1vKkq4Gu0vwnw0zVkrkOs3q/Lh4XgmK9/6Ba9VVHd0gJMn6+eTH6LmViugABICBF9uaQ5xXYJy/2YRYJ+8k5ZHp84R455Ta9ekOAi0hODNY/dfSeHEk4LFf0ItwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229617; c=relaxed/simple;
	bh=q87sWJFL2N/gqbI3UgLeKNt/k8pymRp02A4twxgPG2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MU3xf/52LYnZ2KChg5mGRBJ8PgRHGCVVazuMLKYk1eyar8vHNESKxYntDm1DiWsfgSnA9ahwhtUSIKgWEZmWijZEUMpacTAirhgSnlJNyPadupbU1TViCaTIz6+35OhfQ+ecH7Q67xnVKhDikYZQLYA94fP8FYzQDEARgDnVRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJrzLJCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D0AC4CEEC;
	Mon, 17 Mar 2025 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229617;
	bh=q87sWJFL2N/gqbI3UgLeKNt/k8pymRp02A4twxgPG2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJrzLJCZQnx11Vo8L45Wf2Xn6dmMRsi7geyghfzTUKQNYAY4o8tDmXihiUlvJ9I77
	 hbnJQ2eic69IMQ/zbi3Wwpgs7Glrx/n9TtNiUe6exETvsFSnUVQHPM0rP6Mh4ZOVvk
	 YpFaZWVM6JvPHBp+7gUwTYRAc/t78DZqqo2iaZkFi7jy90HlvZq80jCF9JavsT0Poh
	 GrjB5w8zTh6HlX/j0wC6J94yipNBRFv6sIo/2wyMrZM26WWI4ip9eU6PjdOGFzjvv1
	 OR65BuBFQ5mX4zlMht/m0KNUif2JO38QUan6fHwHy/NRtpw98BzvAlRy+RQFcjcY3z
	 LXm5lbJ71WZwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] leds: mlxreg: Use devm_mutex_init() for mutex initialization
Date: Mon, 17 Mar 2025 12:40:15 -0400
Message-Id: <20250317091357-20ecaee5e20b7b45@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317050902.1151438-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: efc347b9efee1c2b081f5281d33be4559fa50a16

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: George Stark<gnstark@salutedevices.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 172ffd26a5af)

Note: The patch differs from the upstream commit:
---
1:  efc347b9efee1 ! 1:  86f4e68bf53db leds: mlxreg: Use devm_mutex_init() for mutex initialization
    @@ Metadata
      ## Commit message ##
         leds: mlxreg: Use devm_mutex_init() for mutex initialization
     
    +    [ Upstream commit efc347b9efee1c2b081f5281d33be4559fa50a16 ]
    +
         In this driver LEDs are registered using devm_led_classdev_register()
         so they are automatically unregistered after module's remove() is done.
         led_classdev_unregister() calls module's led_set_brightness() to turn off
    @@ Commit message
         Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
         Link: https://lore.kernel.org/r/20240411161032.609544-8-gnstark@salutedevices.com
         Signed-off-by: Lee Jones <lee@kernel.org>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/leds/leds-mlxreg.c ##
     @@ drivers/leds/leds-mlxreg.c: static int mlxreg_led_probe(struct platform_device *pdev)
    @@ drivers/leds/leds-mlxreg.c: static int mlxreg_led_probe(struct platform_device *
      	return mlxreg_led_config(priv);
      }
      
    --static void mlxreg_led_remove(struct platform_device *pdev)
    +-static int mlxreg_led_remove(struct platform_device *pdev)
     -{
     -	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
     -
     -	mutex_destroy(&priv->access_lock);
    +-
    +-	return 0;
     -}
     -
      static struct platform_driver mlxreg_led_driver = {
    @@ drivers/leds/leds-mlxreg.c: static int mlxreg_led_probe(struct platform_device *
      	    .name = "leds-mlxreg",
      	},
      	.probe = mlxreg_led_probe,
    --	.remove_new = mlxreg_led_remove,
    +-	.remove = mlxreg_led_remove,
      };
      
      module_platform_driver(mlxreg_led_driver);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

