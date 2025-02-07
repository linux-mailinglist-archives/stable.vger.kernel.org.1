Return-Path: <stable+bounces-114322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E0A2D0F4
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACC47A3631
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF441C5F1D;
	Fri,  7 Feb 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umDXxsdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C21AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968653; cv=none; b=h2gzy2t5CIz1COb5AEK9gwi3aMjeUKebcLcHmdOdLDX58+9RyqKfwwTwpS0/0xtLCxtkYuSvVUwczxidf6862S0gSZkt7fY3aDAIGc7tyuVUE5WGBfLAkCXc770r8l4vh8Ic/qwkcCMEsww0Vq0cBmigRnx1nNmNBV+LC+LZGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968653; c=relaxed/simple;
	bh=u+kR5kHabuCseUNfwVSlguILuYLIwo1vjMkoyvEfFT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHJVCvjHPywHxS0VC7oLxt++l7ZtuLrJm9f0uJ1+wpGerivVMCKqRqZuBCs76CPeMiQD74zSMQfR/vh9zkKrR5Hk2TTkPrhZn2w2v+K+atI4osF5k5NJhn7hZ6N7XgaWiKpFFpOqYw2uw+w7+DqOTO90xsJsOzm8vK+xElyGmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umDXxsdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F89AC4CED1;
	Fri,  7 Feb 2025 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968652;
	bh=u+kR5kHabuCseUNfwVSlguILuYLIwo1vjMkoyvEfFT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umDXxsdi++4bOaUwJ7ecsV0tnuu8kcqrQpk/ZIKLA2MNYOHQxjfd8mUut6GGuHvf3
	 uOU1UerSlv+DR/qOak9R3cUpClF33pYp8CAukxNC42ZHSzmPW6akvP1yhJfRzl6z3C
	 IdFUEJPxVRklME03uzmyWdkbiuAwa9R4iH2/MjnehWrQu2d1R3x4wHAvAEyqRBMtih
	 g0ep8yKDq30GCZr0MP5Btmmaqo0m8aAQizYCch6JlW73nVuwVPvRK8vb+MQDtngUiX
	 XYSmrqUF2y+FYcnuTFH5dWkTThIechAVWvCTcYU+yfHSHPZGalSaH72D0yy4WwdmJJ
	 +9+qmjliKl/9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] pps: Fix a use-after-free
Date: Fri,  7 Feb 2025 17:50:50 -0500
Message-Id: <20250207165659-f523f1c87b626d82@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <3f1cad0c5516037fb35168b52dc8d8f16109ecd2.1738810952.git.calvin@wbinvd.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: c79a39dc8d060b9e64e8b0fa9d245d44befeefbe


Status in newer kernel trees:
6.13.y | Present (different SHA1: d487d68916ad)
6.12.y | Present (different SHA1: 2423d77f7ee9)
6.6.y | Present (different SHA1: 73f8d5a93c8f)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c79a39dc8d060 ! 1:  a6ade3f07d2ea pps: Fix a use-after-free
    @@ Commit message
         Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
         Link: https://lore.kernel.org/r/a17975fd5ae99385791929e563f72564ed=
bcf28f.1731383727.git.calvin@wbinvd.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit c79a39dc8d060b9e64e8b0fa9d245d44befeefb=
e)
    +    Signed-off-by: Calvin Owens <calvin@wbinvd.org>
=20=20=20=20=20
      ## drivers/pps/clients/pps-gpio.c ##
     @@ drivers/pps/clients/pps-gpio.c: static int pps_gpio_probe(struct pl=
atform_device *pdev)
    @@ drivers/pps/clients/pps-ktimer.c: static int __init pps_ktimer_init(=
void)
      }
=20=20=20=20=20
      ## drivers/pps/clients/pps-ldisc.c ##
    -@@ drivers/pps/clients/pps-ldisc.c: static void pps_tty_dcd_change(str=
uct tty_struct *tty, bool active)
    - 	pps_event(pps, &ts, active ? PPS_CAPTUREASSERT :
    +@@ drivers/pps/clients/pps-ldisc.c: static void pps_tty_dcd_change(str=
uct tty_struct *tty, unsigned int status)
    + 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
      			PPS_CAPTURECLEAR, NULL);
=20=20=20=20=20=20
     -	dev_dbg(pps->dev, "PPS %s at %lu\n",
     +	dev_dbg(&pps->dev, "PPS %s at %lu\n",
    - 			active ? "assert" : "clear", jiffies);
    + 			status ? "assert" : "clear", jiffies);
      }
=20=20=20=20=20=20
     @@ drivers/pps/clients/pps-ldisc.c: static int pps_tty_open(struct tty=
_struct *tty)
    @@ drivers/pps/pps.c: EXPORT_SYMBOL(pps_lookup_dev);
      {
     -	int err;
     -
    - 	pps_class =3D class_create("pps");
    + 	pps_class =3D class_create(THIS_MODULE, "pps");
      	if (IS_ERR(pps_class)) {
      		pr_err("failed to allocate class\n");
     @@ drivers/pps/pps.c: static int __init pps_init(void)
    @@ drivers/ptp/ptp_ocp.c: ptp_ocp_complete(struct ptp_ocp *bp)
     -		ptp_ocp_symlink(bp, pps->dev, "pps");
     +		ptp_ocp_symlink(bp, &pps->dev, "pps");
=20=20=20=20=20=20
    - 	ptp_ocp_debugfs_add_device(bp);
    -=20
    + 	if (device_add_groups(&bp->dev, timecard_groups))
    + 		pr_err("device add groups failed\n");
=20=20=20=20=20
      ## include/linux/pps_kernel.h ##
     @@ include/linux/pps_kernel.h: struct pps_device {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

