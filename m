Return-Path: <stable+bounces-127141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DCAA76972
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA43B287A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC42222DD;
	Mon, 31 Mar 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaOeALJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107B221F34
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432505; cv=none; b=AqraNJCmz47FotSqy0z0pYtk6IGZWQaz+n10kAYo2Owse1+o+c7UtICSjsL2MaHp7VSkF679Ftbs4EYv8VAxuB8PgSKxh6zG2XksQ/5vLAngsz0t4QXCUkO4BoLiNuDovdoOK9B0R2QD+T1cN6W+6UuXDYYBJ/DcjTmqOZJ0i+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432505; c=relaxed/simple;
	bh=jWVMXqkjDvw+9b/CGWBmvFNHGuuNpsU9OjLBy/NZVWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWadM/W2cetYG1bGfWoYaFno8uKziF6Vm8DXMjJKiIKBVnmnai5JsnK7LV0CBqbqmIT70dIZ/C68BPy5Lk/0BP6+zdYzH5M7CYj+5BjTcZtY644U4i9ICCc1cV+hVihhtALUg07kZg4bE0Y+5tSaQsnZXQSdPWL5+Da+GbdX1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaOeALJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAD1C4CEE9;
	Mon, 31 Mar 2025 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432504;
	bh=jWVMXqkjDvw+9b/CGWBmvFNHGuuNpsU9OjLBy/NZVWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaOeALJwwY8369sjrAnenpSaXTMbmMBuIMNV8K5UzdpFV6n4bSOZjBWD0GmD8vfkl
	 SuynXcP+XE0S+6fzJWRrKSj9RXeYPv/LvGfxII+rSmJTcdTsgfmuiTx2WjDVTqMeZw
	 fS1chzIJdmTeZuj57pwr532FN/krWv1CYt+mDCWSIjZ1hsv0VRox8+RYFlKwRCsgN2
	 XzQMSc2Otk8p3RqaaLWQf4fqAAZf0TRcb+jQMyLon5q5ei1sFQ/+nL6OfenJ6ZXOfP
	 yxsnUBB7/mwyBBHMTUwvxDJs2tRi+7YH31yZwEN0wOQPaNNNcUftIFISD7QKimyWqd
	 dXcqZD6DddGCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 10:48:22 -0400
Message-Id: <20250331101245-3127e31ad643cfee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250331064733.3180764-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 545b215736c5c4b354e182d99c578a472ac9bfce

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Uwe Kleine-König<u.kleine-koenig@pengutronix.de>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c1a3803e5bb9)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  545b215736c5c ! 1:  7f327a373d739 media: i2c: et8ek8: Don't strip remove function when driver is builtin
    @@ Metadata
      ## Commit message ##
         media: i2c: et8ek8: Don't strip remove function when driver is builtin
     
    +    [ Upstream commit 545b215736c5c4b354e182d99c578a472ac9bfce ]
    +
         Using __exit for the remove function results in the remove callback
         being discarded with CONFIG_VIDEO_ET8EK8=y. When such a device gets
         unbound (e.g. using sysfs or hotplug), the driver is just removed
    @@ Commit message
         Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
         Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
         Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/media/i2c/et8ek8/et8ek8_driver.c ##
     @@ drivers/media/i2c/et8ek8/et8ek8_driver.c: static int et8ek8_probe(struct i2c_client *client)
      	return ret;
      }
      
    --static void __exit et8ek8_remove(struct i2c_client *client)
    -+static void et8ek8_remove(struct i2c_client *client)
    +-static int __exit et8ek8_remove(struct i2c_client *client)
    ++static int et8ek8_remove(struct i2c_client *client)
      {
      	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
      	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
     @@ drivers/media/i2c/et8ek8/et8ek8_driver.c: static struct i2c_driver et8ek8_i2c_driver = {
      		.of_match_table	= et8ek8_of_table,
      	},
    - 	.probe		= et8ek8_probe,
    + 	.probe_new	= et8ek8_probe,
     -	.remove		= __exit_p(et8ek8_remove),
     +	.remove		= et8ek8_remove,
      	.id_table	= et8ek8_id_table,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

