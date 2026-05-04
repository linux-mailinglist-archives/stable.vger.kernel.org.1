Return-Path: <stable+bounces-243885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPwGKk7S+Gm41AIAu9opvQ
	(envelope-from <stable+bounces-243885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:07:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57474C1BF0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7889D30074DA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25783E3DBF;
	Mon,  4 May 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W+RxvsOx"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A8282F10;
	Mon,  4 May 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914433; cv=none; b=sj9kwOtv0/ZGQ8d1gHnPyq0Iznv5Q/0nkLMvfmOdZvFElnYEcKqtIBk2vOOqIcq8yZwpQ3mkSiD+nh2h/WX+9kSDwSZh45ymI91gzcYjowjYerShZC9AOnFoujzJ8RqlH+xgPyPydDr6tWgVo/XuPtIdgD2mysKvC/0gfgzjd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914433; c=relaxed/simple;
	bh=E1AcLk8yHFPszixVdXasImuq2CqIwp8AyUQdxUPaFxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dV6Qs5+cShuEtI++kKx/jjkJHWO8FH+cTamk9uSveQ3gIe8d40J1YpJs7HS848zO/ThS4CrJ+XgazNna3sYRBG6fUTdHh0iIG18Mv4hfWi+JJSlNUZSksABdHkKyCWg12UJ3p4AYx7Jk+VbrnvWDOrjCc6tNyaHw0E82t8KqLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W+RxvsOx; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777914346;
	bh=uIk2Y9HeeoS78SLWasIDhipN/GYx9yAXe7UFugTa7X8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=W+RxvsOx+FmYogo6+yRY6F+4tReNC4BX542hjgpE8n6Jl/SlKSfZi61thdxKZcTQA
	 50EIi0JVczn6zygsFtIRKbmW0rnCBr4VJX+XKb4afW+Sh+HltB0UKYcrb5dM6AlJo4
	 v+/X9dY8YVLGHt2pjdC5u2YmVDFLjYemldxZBr/E=
X-QQ-mid: zesmtpip2t1777914340t6acbb486
X-QQ-Originating-IP: Nz3D9vAql6z84OnwlRP0yXkOQTkLzaThNdNgctz3tpk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 May 2026 01:05:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4050741224278605350
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
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
Date: Tue,  5 May 2026 01:04:19 +0800
Message-Id: <20260504170419.1313610-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N8C4ARcmNX5DiA5Vuu0G32nvsp0ZRAptnS+GBqe/WL1vmxX/lJa8G7TT
	j3K5rs+qa1OENnEBWprxeiuIrlILGucqKjE+eXa3C+GKSWY0WGMxa5zuGokYS6k3UW2rLkB
	ZxWMNXDyqIBFLnIFr69p/UaFpo+nem6zpFPfY574qg6lhxrH1KCxyZqgJHBfW3xH/F3juBG
	hx6Yejb+UL1ews0Iq/GACVWgXZSEXHR+smzLCxgytDeU7ERKORqigtXWreXt89cbNfnfm7h
	1657pQADDXaK+Ov9VDsHwzXmZo7TKlhu+dsuzInHD/nFRB36YmHbG9FIbQq9W+89KBgGTiI
	S1TJ2IGkmdQ8dNUrbHhi4vG0qS6M/qe4JM9bXMA4OizpKolkayBJJgo+sJYQQ0SrGfx3XsM
	C7gRaAsLyTe2WY30WUgk9XxPJ0mP/WamzDpBpM2RwXa8hV1OnqntmDRuyGi6AXs9CS1o3/E
	gz8hYxTH1B7BY39UH3Ou5qTK1Ty5o6JXT46yZ5bJJfDyCtg+fr1XTZPfAh50I34qWcmHf0+
	IBm6AaDQFtvKzjsFokXKhEoA8knREjUayzaryFrBXBsJoBnh8kQGq4Ugjz4j9RkRAiDea94
	d/q2MXgv+ltzuvnsz4EntODk2gApsOprK/xvAhFLmp4SzVrh+cHBxX5r+nOkbpjeMk4LPt1
	SXOOcy1f1G0YjU01d5aS6o8A/8xmS9XXOAviqvsH7uqxy07/sLrLRkUd/3fDD3pI78o0Jkf
	bN29s1vMED6JngAd+98nY2gfDDLJxVUXoN7h4V/21HjUvQmXUzUXR/o7kzTwMHyM2DCa0BB
	L5S6nAsGDhQQgU0sU40c4NrjiERHZ/0DEgercdZQiko33x7rTcNKuPqvaEDACEljKL4fUJq
	Jm1wx+c/OI4uqBXHzaXOvnilfMAemHmOKOQQEjGTGEK9bUsjk9ZjHT/5K564Mupf0HWMwXU
	x45CY+xGn5BrCKLdmBiCwzHe9Ku5vcIPnVAFd6o2LbWzN4N/VoBUHuFy4toRefI4Nn2YIay
	300M9AIrEKrNUqWWqlQyq84NOnni8K3A0MxXWfrfKym+zydmtlU7ZQWkgvCzxJGEW99kswK
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E57474C1BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243885-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
strings vmlinux-* | grep "Linux version 6.18.27-rc1"
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Mon May  4 23:35:30 CST 2026
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Mon May  4 23:51:50 CST 2026
Linux version 6.18.27-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.27-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Tue May  5 00:07:43 CST 2026
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.27-rc1-gbc63ee3bfa32 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Mon May  4 23:17:29 CST 2026

