Return-Path: <stable+bounces-3103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABD7FC9DF
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 23:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DB1C20F26
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8241C8D;
	Tue, 28 Nov 2023 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="fNukShFf"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760808F
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1701211709; bh=sqhOH7HDksvDaeNqmw8j4S6QM8peZMro746b6naa7vg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fNukShFfmOS+40vu5jj+975abPHCxKE2Y0UdYZ6Lhq4XF3BiHqutQX6FTiIZF9apP
	 OsYEbW8/2WNgKuuDvDhBsQEcBlAezs0W2HiHSGFT+02bOM+IG+eIOWCGZni2qlFCUW
	 DtX0iJ1PzKEgWwg2yY9igjN3bsB+EGWeOc079l/2pJStpRTmdl/WSzw8AWbddKM8nJ
	 gLhABa1o87aW/bm6GtWMy7DOaWxBYfk8t/AEqtah8cq6GIjn/vOEi+MHN3LihR+PsL
	 WJcsU8QUnnzLEHY+GSpLkE9MG9v8JwD4PIbGsbb65Ad8Ppyl/xTWy2fOq5HkBImsqT
	 1o50lyjrtLdfA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id E42E8357AEC5;
	Tue, 28 Nov 2023 22:48:25 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: sam@gentoo.org
Cc: dan@danm.net,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	toralf.foerster@gmx.de
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference, address: 0000000000000020
Date: Tue, 28 Nov 2023 15:48:16 -0700
Message-ID: <20231128224816.6563-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87jzq1lflc.fsf@gentoo.org>
References: <87jzq1lflc.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BzPu9jSF4Hw21U6xu4xtvi1w9T--vBIs
X-Proofpoint-ORIG-GUID: BzPu9jSF4Hw21U6xu4xtvi1w9T--vBIs
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=338 adultscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311280179

Thanks, Sam. Yes it does look like that's the same issue.

I applied that patch to v6.6.3 instead of reverting the change to the
randomize_layout plugin and the problem also goes away with the patch
applied.

In that thread with the patch, Gustavo does mention that many other
zero-length arrays, besides this one in struct neighbor, were found in
the kernel source. But a quick (and possibly imperfect) grepping seems
to show that struct neighbor was the only one used with
__randomize_layout. So, I *think* it might be the only one that could
cause a problem with the recent change to the randomize_layout plugin.

-- Dan

