Return-Path: <stable+bounces-135186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76093A975D5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAF4178C8F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F62989BE;
	Tue, 22 Apr 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv71tA8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F12989BC
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351160; cv=none; b=G94GQgajRCjeA8rfslyuxMF+aT1/yU8V33JilYxFy/Dye5zR+OPEnvpng3IrMu3MUslzaojFw6psXDKwrzWk+qvVAGWHVOn2wspvNrhssfRbHeO6O0u8nEZOXTdeQ0Ez2hFKMaygCB20VadZrcvKKwHdRTX1BZKFAfbfyV3GGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351160; c=relaxed/simple;
	bh=12F7nIuE68HIxZhLHjUgP4/tuAAO/JJfpFMt3mJSDvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSU5+dE0j/fYI2wsGRQQ/tan4ikDQme1codGe75gR4oqETtaflhRR0OVMCjO7h+VgQJfiL72kH7nhrqYE2CNvb4QPb00LNh/0mN0p2TG1z91rBHPBs7yJVUVJfDOWvbghcilEnuLz9KhZYQOiqDXKc2vG70ddDJTCTYiWJdn0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv71tA8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622DBC4CEE9;
	Tue, 22 Apr 2025 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351160;
	bh=12F7nIuE68HIxZhLHjUgP4/tuAAO/JJfpFMt3mJSDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gv71tA8U81O2DbzcrM7wTZW29/8biyZNYYIC5IjzFRIftOZKZdwY1WHZD/eaiYCBw
	 I0KaTunUOWkoq5wviLWf3z7FXwgI/ORs5XpoGFMibSe2+2bSI/ecEW6lIJschVK7pg
	 lRpKB3bbrCwAa2uijTiHbM0ifMg4kET2xG4O0Vs+JsPbKCxIJ6nIbIuG9KUA//v81V
	 9MfEsZJH5aEDxojGQGAWtYv35/QDW4rpic4r7du5hMiXURXnrepocpS57jLqcOe3pJ
	 DTxrW9RfI22qSiVoOUt0LqHst3C8pyDKttokZMyEfjYf69f6N16iiwErtqKSerC5m0
	 Ixv8FsyaefQWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] s390/dasd: fix double module refcount decrement
Date: Tue, 22 Apr 2025 15:45:57 -0400
Message-Id: <20250422120957-37a1627939e13591@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422025832.3525312-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: c3116e62ddeff79cae342147753ce596f01fcf06

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Miroslav Franc<mfranc@suse.cz>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ec09bcab32fc)
6.1.y | Present (different SHA1: ad999aa18103)
5.15.y | Present (different SHA1: edbdb0d94143)

Note: The patch differs from the upstream commit:
---
1:  c3116e62ddeff ! 1:  aa5101aca4e99 s390/dasd: fix double module refcount decrement
    @@ Metadata
      ## Commit message ##
         s390/dasd: fix double module refcount decrement
     
    +    [ Upstream commit c3116e62ddeff79cae342147753ce596f01fcf06 ]
    +
         Once the discipline is associated with the device, deleting the device
         takes care of decrementing the module's refcount.  Doing it manually on
         this error path causes refcount to artificially decrease on each error
    @@ Commit message
         Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
         Link: https://lore.kernel.org/r/20240209124522.3697827-3-sth@linux.ibm.com
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## drivers/s390/block/dasd.c ##
     @@ drivers/s390/block/dasd.c: int dasd_generic_set_online(struct ccw_device *cdev,
    @@ drivers/s390/block/dasd.c: int dasd_generic_set_online(struct ccw_device *cdev,
      	/* check_device will allocate block device if necessary */
     @@ drivers/s390/block/dasd.c: int dasd_generic_set_online(struct ccw_device *cdev,
      	if (rc) {
    - 		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
    - 			 discipline->name, rc);
    + 		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
    + 			dev_name(&cdev->dev), discipline->name, rc);
     -		module_put(discipline->owner);
     -		module_put(base_discipline->owner);
      		dasd_delete_device(device);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

