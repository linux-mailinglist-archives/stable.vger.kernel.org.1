Return-Path: <stable+bounces-114336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF1A2D101
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDB16D69A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A01C6FE6;
	Fri,  7 Feb 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcPu6V97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757A1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968681; cv=none; b=THrEK3yEYeOrtzCXS4z6nze/O53jgx7s0Qa59BKI7ufu+BRyl6GB5fRpA3AsWTtJLp+ThUc0OPxjuPMoEWFpI5SBmdIGpcYui4UXS3GcIXubhYJ/PiM+LLT0cVIs85bozvo8el5K/bkfoaHo+lhMR2mipAZ4VECRzTgopvrPNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968681; c=relaxed/simple;
	bh=Ek81WuJgNyiDBdcmZ+E8IewgHI9opBpLpRZuHunH98o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUEiUfUgIn57ccaH1OVkAqVBlZSwZlnLJO4v8knWEsOXER337VxR3czpSBCQpvvNQ3FToWxDFWw96p/Fwtb3yFt/H1cO5PJZ8gLghd3nK1wEfKLl/T7+2S9GuDIrVy9BBdjKSEGjJAPWYzVEx0052WtfDeEnsf1gOZ7L4G/Dii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcPu6V97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9DEC4CED1;
	Fri,  7 Feb 2025 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968681;
	bh=Ek81WuJgNyiDBdcmZ+E8IewgHI9opBpLpRZuHunH98o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcPu6V97eNPAsPzmt+jCphCHv7/eUqUNePU7S0eU18rH3nkQiOl1FIfOfp8iHBr2B
	 e0FJ9RnAyOIgD07uPJrlb1GdZCP9LLG97RJPaLM2M4QGbTMj3bBedsDns20iyWXAAa
	 rNebOrhbwPXN1TCChqQR9C7d7/OVpk9lUmdQkvcUCvDQbPxmUCVktWrVkaBDwAzrNU
	 6UFsIbWcwJghGWxEM3btnX6sUq4YHBmSygkP2Jx46yad9doCi019B7vjDLh2+4be7Q
	 3yfJXrvHSNkgWYCPZvBcCMqMcfTFMky5EB7pSt3BiHaBi++bcfQYnkyzYHBNHxYVoN
	 lGjQPhPYq+XbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] pps: Fix a use-after-free
Date: Fri,  7 Feb 2025 17:51:19 -0500
Message-Id: <20250207162737-d9a2c256316b6fd4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <c79f096dfae9f9f5167eb249066bd09de46f4b19.1738811137.git.calvin@wbinvd.org>
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
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c79a39dc8d060 ! 1:  6e21082a9955f pps: Fix a use-after-free
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
    @@ drivers/pps/pps.c: static int __init pps_init(void)
=20=20=20=20=20=20
      subsys_initcall(pps_init);
=20=20=20=20=20
    - ## drivers/ptp/ptp_ocp.c ##
    -@@ drivers/ptp/ptp_ocp.c: ptp_ocp_complete(struct ptp_ocp *bp)
    -=20
    - 	pps =3D pps_lookup_dev(bp->ptp);
    - 	if (pps)
    --		ptp_ocp_symlink(bp, pps->dev, "pps");
    -+		ptp_ocp_symlink(bp, &pps->dev, "pps");
    -=20
    - 	ptp_ocp_debugfs_add_device(bp);
    -=20
    -
      ## include/linux/pps_kernel.h ##
     @@ include/linux/pps_kernel.h: struct pps_device {
=20=20=20=20=20=20
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.4.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

