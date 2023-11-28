Return-Path: <stable+bounces-3076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E57FC816
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973DB283727
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4244C82;
	Tue, 28 Nov 2023 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="Iwyqayvj"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 13:39:59 PST
Received: from mr85p00im-zteg06011601.me.com (mr85p00im-zteg06011601.me.com [17.58.23.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD54AF
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 13:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1701207022; bh=8EgrIGGkKnoJKisc1H42SGVc/w0J4XCT9HdiJld5EXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IwyqayvjwD1xQmxscxr7LH4lWhHQ1vHpJOMcjhUUCEmDvIifRESLlm644nFnA0OVf
	 wBAq/gd/5TqPhxBy7W2DoQNU375PVThmJkVNuiJTDdTUvx+jzksH3cwKZsJzKFVkC9
	 XspyLNimzZg1CuYKRCg0J4r1eiZ4plFnooZ8kGcw5yYlAJGS7uahT0B9heCYUzGDEP
	 Kq5kypb9omKe4li/vOQ6wzzdD2REKbvp/2WkQctaofNRlRpNMIOy5iTESe/K510XiV
	 idF806M3ZTSjv0n+YsBNZX53J8oRLTomrzcxpTSXl4Nb9yrqltnMgNm4IuYcKZqys7
	 VN/HFGzvy2h1w==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id 6B4D71804BF;
	Tue, 28 Nov 2023 21:30:20 +0000 (UTC)
From: dan@danm.net
To: toralf.foerster@gmx.de
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference, address: 0000000000000020
Date: Tue, 28 Nov 2023 14:30:18 -0700
Message-ID: <20231128213018.6896-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2b5d6cd4-0afb-4193-ab88-235f910a7293@gmx.de>
References: <2b5d6cd4-0afb-4193-ab88-235f910a7293@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yHOGWyb5AYz0eJuRV1grMCXODbeaoiHr
X-Proofpoint-GUID: yHOGWyb5AYz0eJuRV1grMCXODbeaoiHr
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=470 malwarescore=0
 spamscore=0 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311280171

I'm seeing this too, but on 6.6.3 (6.6.2 is fine).

Bisected it down to commit 2e8b4e0992e16 ("gcc-plugins: randstruct:
Only warn about true flexible arrays"). Reverting that commit on top
of v6.6.3 makes it go away.

I do wonder if content such as that (which *looks* like it's purely
preparing for future changes) is appropriate for the stable trees.

Cheers,

-- Dan

