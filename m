Return-Path: <stable+bounces-144622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC5ABA2BB
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6396D18971A0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39927A445;
	Fri, 16 May 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPbIXxgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22719938D
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420004; cv=none; b=RDQa12TclkeM+XszAgq/his2lSg5iy5TT63Vp6m6HvgrvIczUkBYCsPLCf7ftlJkyD/mpqqV/K7t6vuUi/jTHd7XUwP5h8sHh134a8dPKFdY27Z2RFS+EOhANgtEgjCR5JkR76lZFSZ2YA7hZ5OVLhxOm4Qfr6SfEbELLXlM3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420004; c=relaxed/simple;
	bh=qshacY9HbJ6dxn7QELoBo95Vg9+BgJ38/gw28x2LF9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9rnsv0AXh1E37PoeZ8OFJcwUU8Ikcdir+Dcez3MG5WxaqxVqT0cAjywDWCsCsVeElJGlkbQiYhSWNiuCL14OAGcQBobI8WgOEMJwIY5wj0CzgBvH2uAMByuIoXWOXNJG3fmzqnCxc0VyTo59y8gO1Ro46SoCbgWExB9HANCvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPbIXxgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBABAC4CEE4;
	Fri, 16 May 2025 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420003;
	bh=qshacY9HbJ6dxn7QELoBo95Vg9+BgJ38/gw28x2LF9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPbIXxgu2AF6jCu35Djz79s4BwIGUveFx1HuVP5nGeir97AUOQYuwzo6lZPi7Ltrz
	 7iHhn4FbRKHBxAeEUCkRBdeYLXKXCPIcB/Q27bHiVSVxROSmtL5rOMr8Dp6BXyhjjY
	 sj0zce+KcArPTgaVfAIqK4J6nyHxOdaafa9lRdua5ZPL66tKm1DqfiUIcqQgvBnvTD
	 MGuwyMfMYGcKCwSCM6902vc5hiFIkP7x0s3aA7rr29A53qfHgzkqOC3zpuUCfAxdhi
	 /JTq7MTdg+9XHc6hF4PxiRe6h/h6Y1658SXofK1o2eAo5tbHOE91itto7BorMsmW2b
	 FwdVIQ34D0b0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	luca.ceresoli@bootlin.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri, 16 May 2025 14:26:41 -0400
Message-Id: <20250516112545-f4b2ef15e27e8b30@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515202145.46813-1-luca.ceresoli@bootlin.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f063a28002e3350088b4577c5640882bf4ea17ea

Status in newer kernel trees:
6.14.y | Present (different SHA1: 3950887ff9a9)

Note: The patch differs from the upstream commit:
---
1:  f063a28002e33 ! 1:  e2c338535328d iio: light: opt3001: fix deadlock due to concurrent flag access
    @@ Commit message
         Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
         Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit f063a28002e3350088b4577c5640882bf4ea17ea)
    +    [Fixed conflict while applying on 6.12]
    +    Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
     
      ## drivers/iio/light/opt3001.c ##
     @@ drivers/iio/light/opt3001.c: static irqreturn_t opt3001_irq(int irq, void *_iio)
    + 	struct opt3001 *opt = iio_priv(iio);
      	int ret;
      	bool wake_result_ready_queue = false;
    - 	enum iio_chan_type chan_type = opt->chip_info->chan_type;
     +	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
      
     -	if (!opt->ok_to_ignore_lock)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

