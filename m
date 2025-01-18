Return-Path: <stable+bounces-109459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C2A15E9F
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922531886F02
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BB1A725A;
	Sat, 18 Jan 2025 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+nnH931"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C21B7F4
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229256; cv=none; b=tnnlUDsRCO6nVnMR+Zz6Aa16MlYOZk6QuefYFKHsI9l1yF/4EiS7vqOJcRN3e2ni9F43Yo+Bo6clZ6v/3T9h/2yxn6eDbbofl6uhOIR51QlaJzS+DkICXINopm4BlvQ+l25GUBu9+pFr8zHqM8dNXscATY36mULMf1Gtr9Wtq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229256; c=relaxed/simple;
	bh=PevPXZV4Lj93GIdPg16GafU5lIeh4r9yJRLilKGPHGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QofTYOwJSaN+zv6pUa/M2Z43TrYrW8oq8PtbW+asAhXWTPozMOGEspBIWMUvww29slO7VhnpsbHXRznzplK/j1VU9rt9iQH97LHQe8JgUqdc9I1aGieCWQV5m9l1jMqohs3QRG4iBPDyHeU3C0wneAeXW6arFbXYUEkW4y/u1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+nnH931; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8583C4CED1;
	Sat, 18 Jan 2025 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229255;
	bh=PevPXZV4Lj93GIdPg16GafU5lIeh4r9yJRLilKGPHGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+nnH931QKfrVsckyaNJWD2B1UnYknPzQY7QID3/186P5vQP/8qt8bI/W+YnzvwEl
	 QK+b0fqkbh6bgcXZJLZiyEGsAMoecd2j9lLJvz5O45UpUWVlkZTS7loxg0BbK9BNaZ
	 3nQSYkzCORPzC2FtecvFFwI7PabajZo1fe2MFSk9h5sIz8LsZfctQAjOADAI+0B8/9
	 Y6bjNyZrIZgFKXu6/GjXlBmPkGK7gKxejTXIOXU7D1m6/evKbuDm/XuIPBAvdl14dr
	 wtzUm3SAOclyQorGZElKepuB6cmdjFiD4CMWbRVrQOxQntI+2WwtbVSU6Kb2Xn8zqg
	 Y1ErX8KC7UtKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1-v5.10] gpiolib: cdev: Fix use after free in lineinfo_changed_notify
Date: Sat, 18 Jan 2025 14:40:53 -0500
Message-Id: <20250118125617-99230a81a19a1d38@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117153017.7607-1-hsimeliere.opensource@witekio.com>
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

The upstream commit SHA1 provided is correct: 02f6b0e1ec7e0e7d059dddc893645816552039da

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Zhongqiu Han<quic_zhonhan@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 95ca7c90eaf5)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  02f6b0e1ec7e0 ! 1:  55e55db29a40e gpiolib: cdev: Fix use after free in lineinfo_changed_notify
    @@ Metadata
      ## Commit message ##
         gpiolib: cdev: Fix use after free in lineinfo_changed_notify
     
    +    [ Upstream commit 02f6b0e1ec7e0e7d059dddc893645816552039da ]
    +
         The use-after-free issue occurs as follows: when the GPIO chip device file
         is being closed by invoking gpio_chrdev_release(), watched_lines is freed
         by bitmap_free(), but the unregistration of lineinfo_changed_nb notifier
    @@ Commit message
         Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
         Link: https://lore.kernel.org/r/20240505141156.2944912-1-quic_zhonhan@quicinc.com
         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    +    Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## drivers/gpio/gpiolib-cdev.c ##
     @@ drivers/gpio/gpiolib-cdev.c: static int gpio_chrdev_release(struct inode *inode, struct file *file)
    @@ drivers/gpio/gpiolib-cdev.c: static int gpio_chrdev_release(struct inode *inode,
      	struct gpio_device *gdev = cdev->gdev;
      
     -	bitmap_free(cdev->watched_lines);
    - 	blocking_notifier_chain_unregister(&gdev->device_notifier,
    - 					   &cdev->device_unregistered_nb);
    - 	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
    + 	blocking_notifier_chain_unregister(&gdev->notifier,
      					   &cdev->lineinfo_changed_nb);
     +	bitmap_free(cdev->watched_lines);
    - 	gpio_device_put(gdev);
    + 	put_device(&gdev->dev);
      	kfree(cdev);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

