Return-Path: <stable+bounces-150757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3DACCD28
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC598175BF7
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9224BBEC;
	Tue,  3 Jun 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzZqN2xC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D1BA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975770; cv=none; b=k8ZHOEyaSMn61FWTVasJEhuW3mFwLOHhAmYphYd2MJaAufhfgSUZzD2V20B8Rggktz8624XULCQf3JXtTtoTBdOdl3QcRFwA83EpoErzwf0XqMOI8vR8T7850zTrs8lSPrsuevNvmVD/kajHemPxUGnCDDQ3NTSs4jjX9BXqBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975770; c=relaxed/simple;
	bh=jSfOp+6f0nIKW6XCwK3OADnmqgBmSws5N/+U/K85P/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoYp8npZ6/yD+CWJ/YATMt9H663IXx2pisQ8b+QP6NV3f8b18dxqqq4CuO6br8NV4hxFA+NtwEGqEdOoEgDvRLOgGqRskLu5ReW2p/tp3GfjZZYOGJaGpLg/PgeyKl9scydH9ZJCEanqtVveCB4miSq2nBIlkDt5t5rmupEWsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzZqN2xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64854C4CEEF;
	Tue,  3 Jun 2025 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975770;
	bh=jSfOp+6f0nIKW6XCwK3OADnmqgBmSws5N/+U/K85P/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzZqN2xCPrZWVoVyPj0tfUTV9b3cbUp5ZiSWY9V6q1hKeXA5B0Zuf13DQfIsrmmZb
	 ikjETjYjpoqpWYvQsyCOdq39h7tdHwwcOYkbbqH831VmYy0V0YiCJme5xhrPET04Zh
	 jyT1TpBRMKM3gE7ov4RkkPwrVJWjLAgP0uqzonVCN7Zt14eZ7hZSpdN0H/8sHPxcoN
	 CQS5O9wqpnNu5yehGCKKUY9QJwVr+vW/4lWAbFwkLasHNCB4CB6cuzAtx2hqFfnTTW
	 MuLoLWSdEi2H2MOyAlpdTVBmmwn5z23cPg0FfkAc2HA9REODJyUQtB8169ePjYrA+R
	 /IwcbH5oyHjOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Tue,  3 Jun 2025 14:36:09 -0400
Message-Id: <20250603143106-0705216c62eb86a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250603093701.3928327-5-claudiu.beznea.uj@bp.renesas.com>
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

The upstream commit SHA1 provided is correct: 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  651dee03696e1 ! 1:  523044130a840 serial: sh-sci: Increment the runtime usage counter for the earlycon device
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Increment the runtime usage counter for the earlycon device
     
    +    commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.
    +
         In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
         with earlycon mapped at index zero.
     
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static int sci_probe_single(struct platform_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

