Return-Path: <stable+bounces-127138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61BA768F2
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442627A256D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641C21859F;
	Mon, 31 Mar 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdehB3CL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17768215773
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432499; cv=none; b=m/CZkQpCiz09Rik2BDJgBSi4ymNXWovbNCsAgjryuV1f9dtEQWmp8h2mAOLQaDHpdyrJWAuMrcAmslP5BMmXUdquwaxEz4FKqHIm5k1qALv4PkzvEg/+j7Mm3TnyF0UfjgBlu+RJeNocs+H5ir2CqmCQDHsQlv44HHwBu6bUE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432499; c=relaxed/simple;
	bh=jjC4wGqGenHBI2q53ZumWEkw47i4wT6NEu3Fh12ECxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHF4091LMV4C/Cc7HVOSDrOsAK7DKteTDYzAtdLZcoxrFVq7NrxHiP0wsXIcV1uaYLgpJjK45Df8Ralg9tCusD6DlHVWWIbKpK8peVvOmy1lIkL3WKkJpUC9cWfoNGq55e9MkwAmR6+b/k9ivIpKrwmfzpl4eXShgaZci9Cc8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdehB3CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120F7C4CEE3;
	Mon, 31 Mar 2025 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432498;
	bh=jjC4wGqGenHBI2q53ZumWEkw47i4wT6NEu3Fh12ECxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdehB3CL1pYuwhr+bBWUYOSyWlWIxaBf/In7i7R0Iu93sPCIQx4J8Oz8k6dKWcgbi
	 24DvHgN1sk6R0QzACLgJVjr6lAzLi9H1Pr8o2EnzT7CXOi9oh8TCQTaWucCtRjI84m
	 w6Ro5Nf40wPdgzkhvYZ4zve8l2BdDj4XLQ9gCSdowAfzqHgvGUx+8TGOekJLBc2hkw
	 CCjyD5BVHgzERD3UnP7OHWB4hqhUleWp3nlcUW446KOWh6NemyFktQjfAnYIpaVMgG
	 CjHyZ2PCsshgXdrSS/ICfVwkGgo+DgtJIQmzoo2Jg2o+jGfRZ5frwOaFBSLBugQLhZ
	 AUpOtYzJefsXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 10:48:16 -0400
Message-Id: <20250331102541-0bf68e6012a148c1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250331064549.3180155-1-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  545b215736c5c ! 1:  c13245918af57 media: i2c: et8ek8: Don't strip remove function when driver is builtin
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
    @@ drivers/media/i2c/et8ek8/et8ek8_driver.c: static int et8ek8_probe(struct i2c_cli
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
| stable/linux-6.1.y        |  Success    |  Success   |

