Return-Path: <stable+bounces-15758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A983B61A
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF922823B2
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39C062B;
	Thu, 25 Jan 2024 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="gBgoMBzy"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAC64B
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142898; cv=none; b=JdPQC+U60CgOMok6bdBFdQiOhIkFaHcoS6QiLTNbzw0nYKaj2Df3pXhUOFBYlznWT2BxtiHZPcmPSkQwBZnc5WejYvyhsIBrQf1asO6vTQRTAk3rR0fdAQXfFP2fUUO7s/L+R7Z1cYE60vXw5GF6nEoWtOmlQBQoUGH7HTz6hHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142898; c=relaxed/simple;
	bh=uK5d0QqKEQpjPUkioYL54rqGud9tpMYVeFJG+VmEPFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy/K67jPsn961VyCUqmu/lMR4TMRkSynttM+iaSmqum5eUvUn6hKBkGdfORLIU97s35he8Z3eqATDkLsNdDDa/Twnzr/O/RQbpKu+Jw9c/c2nCBRS3tlnrXPhchuoBu32Dnbm9UA+SjWIz30oI2FvH0NPum0mo/6Sqj3sgZC2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=gBgoMBzy; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1706142895; bh=uK5d0QqKEQpjPUkioYL54rqGud9tpMYVeFJG+VmEPFw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gBgoMBzy1pt6B7bl1GRs6MF/KzAMfIRHSU1CSZq94i6zi8K9xi4XH1aLbPHYG457n
	 XtIIxG2rFprCz5TykaydetEc+yt6M7hCSSEDBJY/NYeADS1q0jPgL4DZ1nY7TJ5uNs
	 SjNyBQzV72yqq7aUOqEfnZ0qbGYCwCNc2cA4GdLGOQFxfxQTeJA8AZo0Q7ZQPcHPnJ
	 IuZ86/QadwUAPcazhjxbu2RziZVoy54wX1tLfR9A+Utcm1XeX5cQx7pCdxSYTgrqgn
	 jueziF0a9REodLpI0TOYPCLDWOvIHzynnBMF3Ju1kZwsAygmcvouS7bsAGnfP6GNXd
	 N0ad59WHcKpsw==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id A4EFB2794200;
	Thu, 25 Jan 2024 00:34:54 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: gregkh@linuxfoundation.org
Cc: dan@danm.net,
	junxiao.bi@oracle.com,
	logang@deltatee.com,
	patches@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [PATCH 6.7 438/641] md: bypass block throttle for superblock update
Date: Wed, 24 Jan 2024 17:34:52 -0700
Message-ID: <20240125003452.30195-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012316-phonebook-shrewdly-31f2@gregkh>
References: <2024012316-phonebook-shrewdly-31f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M6BKiHeJDEAD7Y2ETKw267AeNMdiAauR
X-Proofpoint-GUID: M6BKiHeJDEAD7Y2ETKw267AeNMdiAauR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=573
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1030 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401250002

> For now, I'm going to keep both commits in the stable trees, as that
> matches what is in Linus's tree

Please consider reverting bed9e27baf52 in both Linus' tree and the
stable trees. That would keep them in sync while keeping this new
regression out of the kernel.

> as this seems to be hard to reproduce
> and I haven't seen any other reports of issues.

The change that caused the regression itself purports to fix a
two-year old regression. But since that alleged regression has been in
the kernel for two years, seemingly without much (if any) public
complaint, I'd say that the new regression caused by bed9e27baf52 is
definitely the easier one to reproduce (I hit it within hours after
upgrading to 6.7.1).

I've also reproduced this regression in a fresh Fedora 39 VM that I
just spun up to try to reproduce it in a different environment. I can
reproduce it both with the vanilla stable v6.6.13 sources as well as
with the distribution kernel (6.6.13-200-fc39.x86_64). Song, I'm happy
to provide the details of how I built this VM, or even the VM's
libvirt XML and disk images, if that would help with your efforts to
reproduce the problem.

-- Dan

