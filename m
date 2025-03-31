Return-Path: <stable+bounces-127137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FDA768E9
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D2216607D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65B218AD1;
	Mon, 31 Mar 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie4r0Asl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB1217F5C
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432497; cv=none; b=J0Z0CzjzqldzjsCL40Gh/bHxMb56CZQx1K33i6iW3hrIHpjQgb8UBSqx6PXp2pOjo5H+iXVCBZBUK1pbG5HBWA4/2btHiJWZZh5hhfj10iVkjIqM7tpWBp233gZC+eFg+amr5TLWtFcvq/ATv7HgLoIct38j2ibRKS+kYtbQVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432497; c=relaxed/simple;
	bh=oRnAK0eeZgvDMbwjuRmU7nTXNewdZ7nXwgwNPyxuHFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gd/h5atvRFjJhXUv2AagRu+j/dNyIoHEhg43yBLKJujTv+78xdNVz5JuRlFr4jMUl462Boqv+phbuTrk/rLcLGobjrsFGcv9pQAhzcl5oV/8fLeYb5RtC/mscS5rvx2U5Recix600hkgU0E9+beTvOHt3pCUo3KeW3F2Wvd3KYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie4r0Asl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0843CC4CEE3;
	Mon, 31 Mar 2025 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432496;
	bh=oRnAK0eeZgvDMbwjuRmU7nTXNewdZ7nXwgwNPyxuHFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie4r0Aslce1wYKk6dgQA2bvOGCEYzP1mscTbyXpGu4UwS118FgX10qM4FkRk84kID
	 2VdKW9ks5kWLzgY8o7sADPQtEDNI9etpWTpSKCJiHekiaTjYJ6nZ128eCjFYqc23im
	 Aas6xtdA6W4io8eMAo0oQe9fpGL1GCQpnf4TXR8sy3iugm2NllDpM4Z6fP4EU0PmZh
	 uLvtTBSNTWFfUUf8ZamNq8f3bolgQsaLeq8XJTETxePiEjBLejvszAdiagMP71SsaL
	 3uvAjV0lIwTgHLLu1RTaJEYonxHRPTKfwxXrHP7CCLzrY2BJdxZcpBkLCNvT2cT9a5
	 d4zyS2KabRyDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 10:48:14 -0400
Message-Id: <20250331103442-bb666d7a344813c7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250331064640.3180481-1-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  545b215736c5c ! 1:  ce89440fbcece media: i2c: et8ek8: Don't strip remove function when driver is builtin
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
| stable/linux-5.15.y       |  Success    |  Success   |

