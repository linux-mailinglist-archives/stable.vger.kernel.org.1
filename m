Return-Path: <stable+bounces-253509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPBoO8XxDmqmDQYAu9opvQ
	(envelope-from <stable+bounces-253509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEB5A442C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9B91304DAEC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B153C5827;
	Thu, 21 May 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YlZVLkwU"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78C3BFE4D;
	Thu, 21 May 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363910; cv=none; b=eG8ZpiPVN/kSpgnH6d0ufrj4gJwu/8+GAzJH/e96/IuP0Gz98ULjCU+CmuxDCOf0PhFbhYnmjYEcd3GJULlVfXgZgkxPA2kgkIS/oYiaFqiwMilZZ6E2vZdscMWj5/R7IW6d9ebnKzidQ4oCGupm0SFVWSAK5ZNisqbRquaGAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363910; c=relaxed/simple;
	bh=7h37GX1wcmywvJ3Wzq3s1EKqDrJo/hFwIrKJhy7/0rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVWuRWu/zLTw8dDIdRKzcqrCcLOxIqXbwrOe/lhmvw+jU+rJBkXFuK+KLXwS/W/hiAljC1ERc5ho4kf33X6tCHlC2jyBi3QF71x4OAD1kf1xjEhzrNH6HKXCu8P4t7LbBzj5WV9KCs4rGoUQ7yfNEk9kRyjvh8INRwPGAhEZROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YlZVLkwU; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779363822;
	bh=Mg94N7FQgywmG02cYGRlFlcn0lX/r90w5Bzk+bIY0p0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YlZVLkwUBG+O7m4WewrBymBNanpk2MeUYq2r2YThsZ/Kayz0ZlByVo25+2qCBQ/+t
	 8KqeNUw9mZAzYNsMJy8mJIsoeUPQXDZrycSqPXwCvuApDeoRRwQROp+usW/8GMPjEj
	 8VT7ok1QN4/wuOYzPSbrOBLfYcU5JfEvdqCx8qmI=
X-QQ-mid: zesmtpgz8t1779363816t1905b49e
X-QQ-Originating-IP: E4V5oVKH4h9VuNW3JnH52ZODYyn7jcOt/9iCo0lNCIU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 19:43:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7367027533482139346
EX-QQ-RecipientCnt: 21
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Date: Thu, 21 May 2026 19:41:49 +0800
Message-Id: <20260521114148.1195326-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NbAqzpwV8myl6G0oQv4muJuiK97uKZ4I9dPP87W2NnlzUpHekHCgPI4t
	3XIvOpknQtE6AUfJwITBIL25GGR8iegcjLfizu8q2dKOKc8C2UtuxMOFniZ1q6liRDfaJpB
	UQOEB+7+YUCawCb/nEYBjkd/GwyDdgV+SXX78ocz4c9oeqCgK5wGnzubzbx7tj99xjvmdMr
	vXj5vd9JvONj88BvC1B/NHL5b/QJLtJvCcwoB+xgfH2zM/uQ8RvsWTVWfjT+4zenIfBDGkt
	b976eqwSdnyAjFbhpPoZOY7ujNSmKogjh6QbXe2n/y7tuhicpBrbazG+bvRoimruuO5VxSb
	VXTt5xtU0qUKjIqPAK3vNN9AJtnaawruAbvDF/Nk2dJpfRxD32wA638FEcYqdbzIk1AQXQZ
	MoakHpHKOOpmeyozIWyY2zCA9Otd9D+w17RED0fUyZCGDqMCEMAnPEuibesvuqpQF1SgeO0
	WjNoMIh4gH/CR5vmIkhoAxny3H5noqe3nHqbelgiBpAY/l+BZCnLLMkbrwsbERq2k8hy7ym
	Jk6gP/lcY/U4OBsti1w3e4wZpXmwEVqrBBFGDzMLcAwcstGfApmwnjlN5uExC2isM/Oq28n
	fmhAc/FySp5OSgAj88ounx2+WJjAC8WcT6wi8ZWqiftuoQ9iw2jn5Mtuw16t6Ik9nlvQDRe
	FkrHUpWNzrb0hkEZmbnEY6yfFAA+eWfkCCi93fs/UsMNtIXio7c8iyJiaBje2IP20oq2qcd
	WkZUmDojC279Nml73A2mHDHwMOqW902/HcccELDN7lrB2amyQ2rYtriuKQGSW+u0KgnN7EB
	Eg1foB5YVEvxLvhg9PswuDJLxrfw6aRgAd03Sa/D/692CHJxH6jrkaxzgRVejT6BT/rYaXn
	TTvEm0KzKLxcFr9OCHoWO5qadCUnkmGa2EFNc3oNnPGWPuqG5bSi6kV5Bnz2RDPhJZ4qIkE
	mHJyFEEyUiSh2hmh+pupStWG1vzhXEQMYuWzV/MorTUm+X8LQmaPe77lXL3rSm59xu3eYDh
	+CYrcyd58MdviLWPBseQBITw1dHP0TH4MT7gCLKeWMAo6M6PpVWo9x4LPlmSM1ZYaRh0VTU
	KOjdtMGQqgZ
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8EAEB5A442C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build tested in our x86,arm64,loongarch config successfully without error.

Failed in riscv config,
you can revert af7b502c916a4950d697b67f5e39c19cfeb5da4b to build ok. 
Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan


Log:
arch/riscv/net/bpf_jit_comp64.c: In function ‘arch_prepare_bpf_trampoline’:
arch/riscv/net/bpf_jit_comp64.c:1064:9: error: implicit declaration of function ‘bpf_flush_icache’ [-Werror=implicit-function-declaration]
 1064 |         bpf_flush_icache(ctx.insns, ctx.insns + ctx.ninsns);
      |         ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

