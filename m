Return-Path: <stable+bounces-100858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E29EE1C6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F7B1887E34
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDC20C499;
	Thu, 12 Dec 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bkMu+IpR"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE820CCF7
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993258; cv=none; b=qaA4+T3wzasZRrN6dq8/R1s9fGD7xS2f+2US2jamdsIQ8EPfeLMvfH4atVuxLFLzjKShL4UqTofSG7SrGyYBLmXpXEmo0BIIzsLp/ZK8eYxB1yb7luqaWiZqzBswPktmv4LOlwswceMo8MdMomlDWOc9uCxBjEvsPqE5WorkOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993258; c=relaxed/simple;
	bh=QaK94OhTz94Yp3Kfi8VYUuyzcRiOCySfvOSHW+Q2Kso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHGfgLJJt2YQkx7i1/5cvOt8HiACzATkLWEx7oFfPP07jUoXyYrIRc9ns/pfTPxWXV0fWvpSIOek+QCFpT5y5fGZKGvOgx5bmPcY/a17B1yOp75+lZdxWAYCvReSdujVoqWlJXsq6+xmum4a7qUHB1lq8FzPOf0u4cu/Gz+lsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bkMu+IpR; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1733993174;
	bh=lxB2DJiSuMaO9kZIbF1vE3sGU0IY6tbMU0+Nk+QNflM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bkMu+IpRMa6oRr6/WlNDQdDKri83ZGA/egGNSvchEQZM7ey1Lkd3bRgF5FLq7MOE8
	 0Ck9zEy/1B7K8tr4QL3jwnq18NXmSUW9MB5QtIZDk1+F+ask3uc/BSoBrLfL39/ZfY
	 uFG4ZzLvs96auMT3lxCK38lP5uNQgssJ5quj5evQ=
X-QQ-mid: bizesmtpsz9t1733993127t3oniuc
X-QQ-Originating-IP: aDaLQ1cMAxg82X4ajo0jQTDLp32MsJu0cAM/pN1c9ko=
Received: from avenger-aosc-laptop.localdomain ( [223.104.122.80])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Dec 2024 16:45:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 954694624248184806
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: bentiss@kernel.org,
	guanwentao@uniontech.com,
	helugang@uniontech.com,
	jeffbai@aosc.io,
	jkosina@suse.com,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	ulm@gentoo.org,
	zhanjun@uniontech.com
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
Date: Thu, 12 Dec 2024 16:45:23 +0800
Message-ID: <586B243DEB263A26+20241212084523.13674-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
References: <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MyhNtuNETreeNIUVRvyeINfg4a9Lh6KUxrfuyELOyxI1IENHhUxkpiQ9
	4HSnJWba3AkqZm5YK3bapenKwRchgSV5p1iD228G+0tsBu1bfprFG4ve7TnyOksCaptnPom
	UTKyMHg17eah4AntO14sHItQgKhiVRhVM3MQc+u9xjPzj/GLUkoBOvp2zy1lqyQCTtADtLM
	dHvzlm/AMRBJXDWxfCbXR7BuaxoK1yEb0GFYBC41gvYTncNfK4AuhwNVKzVx1VIc4cnIfZk
	0LO5oRPUIsPC0h7MJtgJewPqwdwrgnBbXzZBI4i+f5h+e7pLAICPQ2/GT6ynJsD+8oR8Vle
	1SZpt+toekVs0k524eVriG77HOKtEHq4YSlKMMCn3WKXvTLzY+8EkhocLJpn2VFemH0mCWR
	/4B0/g6A2bhdvlmnfnF7XbACrorE26jneI8bnm0vJ4Ut67ExjbZQzkwrcT7rSQjB6GS5zII
	TPr06NNnw08gy5lfmotQ/FNnodUxycyeswriwtc4bG3/1Pr0dkpZ9+sQlCHhiFnYUvbS4Fy
	wKXheJS3m3E9OZ4+vQxRLNHpy9nPCppCj/rw0pBJYt532Og/1iBMqBLNaoun748T7LWX+Aq
	ia15dYYGxs8ZExoEhq/b7PIwHdyu8i+fdiKYjO7yx2offZ2cXC4bgaQ8okWbzMmy50qrdCb
	KGbtaRUt3I7FOsDujeqWpCN2tywrkSvQQM1H3krqxr/V/xkVN5fCB1RxsQ+jSuB0f1J8cMO
	AzfYhGp+qxOza6Z+X283qccJZJKCyIJVgyZD/DMMRxEx9hIWBgwIIAoVaT7RRkhHTz5KWdl
	NJ3vJdH432y2o6A2YE0///hthqoiPkeGOFMVhizPDCtJ17f8e51HPxOmHrPgyEwswz/+DQ2
	fXSWfkAxLaW+DAd8J7HdgGTJCK7XAs00zLHzJvFt2/5QWBXDfHyrZKXAuR6tsPidsqVKBzP
	C8o7nlMdaL9BdvxUHAnVR7BIXMpH8eOdaLUd/3CTQvZyoFbL8qYgjrIiRWWMrwFxYxY/cHQ
	3Xs1PXxfhSy+A7Mjyf
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Thanks to everyone's help, we've been able to determine that the initial
report about the 27c6:01e0 touchpad was a misunderstanding.

The 27C6:01E0 touchpad doesn't require the workaround and applying it
would actually break functionality.

The initial report came from a BBS forum, but we suspect the information
provided by the forum user may be incorrect which could happen sometimes. [1]

Further investigation showed that the Lenovo Y9000P 2024 doesn't even
use a Goodix touchpad. [2]

For the broader issue of 27c6:01e0 being unusable on some devices, it
just need to address it with a libinput quirk.

In conclusion, we should revert this commit, which is the best solution.

Thank you all again for the bug report and your patience and support.


[1]. https://bbs.deepin.org/post/276451
[2]. https://linux-hardware.org/?probe=35b1e770a7


Thanks,
-- 
WangYuli

