Return-Path: <stable+bounces-114338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77690A2D103
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910C63AA664
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADC1C5F1D;
	Fri,  7 Feb 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npDdNhdV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254231AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968685; cv=none; b=vAYclZ4wAiwF1Ydn/x4Me/ukKlROWxkEKtpPjxYvCCFbKYNGwB/eqkuFAT/A+E4mN0Qb16oC+RITkQ4Dz4vRhMutiSbLZSSeTykgDWrZ+3Q3sGyHJSFNngqmqKMgvdrUAY/5da1bPV3RUk2xHVSez6Mzw9PyOw/+7znPRPUTJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968685; c=relaxed/simple;
	bh=QPe8ZGRbT/0eRfCE5y+q6vdfw6xbWDiekZbgd0pgokU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAh3WrY0t8x4HT3DYgOGL0TmpUokN8o46qLq6tBuiG8sgKCTcVvHo17sfDvsXt4fP0dlE5ByXPhymjOySM/hVhZUoFwLgCKV4nQKeWLFGrgMEAg1Ik82DErwfe4Jf6r7VPg9ygAWwzpUZp6nb8KeGBMt2DQ5JM8JryymKp043Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npDdNhdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A48C4CED1;
	Fri,  7 Feb 2025 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968685;
	bh=QPe8ZGRbT/0eRfCE5y+q6vdfw6xbWDiekZbgd0pgokU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npDdNhdVQiJk8T2AzYFW9iYjXgel/0xILpqtwQWRvt+g1TVEXHZWQ2nDxDknous/U
	 krfspcvey+/+dtxtbESFqYFUcwPDzhMNu4coENpE/B1WWEf2u/H/q6HcSqgHGUjP5M
	 /aTG79np8OxRhELmYLGYAuJ2dpfcUp+bz7/cblWrDPGHxdQYWAp0IDwOVCX0DYxs/d
	 yd+xPpHqyEyghwX0XjehwDaf7zeYgiVL3klw+UKztUa/YdIFHuy67eRllBbyQdsaVn
	 5KGxb5re2tzOazhrcYmY00lR1fDWy9PTax8CYHVoCMJAmFUsq91PMvLWwnW6eQTCTv
	 08bYPAApe2iWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] pps: Fix a use-after-free
Date: Fri,  7 Feb 2025 17:51:23 -0500
Message-Id: <20250207163143-a3d4ccf7eee389f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <28dbfaf10f7be776b1185be3545b9a22ae71c130.1738810812.git.calvin@wbinvd.org>
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

Note: The patch differs from the upstream commit:
---
1:  c79a39dc8d060 ! 1:  23f60a23048e3 pps: Fix a use-after-free
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
    @@ drivers/pps/pps.c: EXPORT_SYMBOL(pps_lookup_dev);
      {
     -	int err;
     -
    - 	pps_class =3D class_create("pps");
    + 	pps_class =3D class_create(THIS_MODULE, "pps");
      	if (IS_ERR(pps_class)) {
      		pr_err("failed to allocate class\n");
     @@ drivers/pps/pps.c: static int __init pps_init(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

