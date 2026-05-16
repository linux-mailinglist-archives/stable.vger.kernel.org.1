Return-Path: <stable+bounces-249021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBmxOlezCGor1wMAu9opvQ
	(envelope-from <stable+bounces-249021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2355D096
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A44300F9DC
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B842F8E91;
	Sat, 16 May 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BBSLeAX9"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F22F1FFC
	for <stable@vger.kernel.org>; Sat, 16 May 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955091; cv=none; b=fRgBSJKPjlBRgZhhUUomQQI5kH2hWZ6xs7BAhNGiJvTvfwkBqIZu7CU3bb5f71l6EakEA8E7K3Lw+fOz7YajnkXHNAgA69Pk7fiZyBcoFBvnGTeupCdFYI35T+LZLkOczSCUrY4kRndFtFsxtkIGAObtzREOMLqLk/qhcFEvFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955091; c=relaxed/simple;
	bh=PhObpNEhS0ZiJzgQRmVbLLCNQRddfTvS00Q0wi3M2Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbNKERDyCGYcJV3hJXTxY9i0Lv3SgyKkCz0SMQFzHe7DSA1PUgsMezqWnC/uaziYn1ajGzuGmKnMVDQ4pdagOJl653EPrkD/ze8tWozgWipawMgIlNtsHkpdUM8PlzAU+raiU6Op2rYOGDmBNs9+bYRR6ffm95wHD1QNgsdptLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BBSLeAX9; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778955068;
	bh=ay4X99PYrhcKWpqwz/XJNqfa7qJBbCHbzSE/HguNIXE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BBSLeAX9pQQ8e2ih6pnldt4u5SGL1WJB64BQ2JUWc6YeQ7CRYZu+Zye2IOhVp7Xzx
	 9tMjGb+JBOlSkIkHaX7eIT7aV3PjqWyMVwYQvCRHW075Y58Bmo7g3cXDdcGWkT6y65
	 Ned/YIEToaA+sWCGCAg7331iOLPe3NYJvCzaVIz0=
X-QQ-mid: zesmtpip4t1778955063t5144ce51
X-QQ-Originating-IP: MkhxMI1W+wXBJzRfC6W0i8u4/qdFp17V6H78mJ7pmGU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 17 May 2026 02:11:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17173971163173199362
EX-QQ-RecipientCnt: 22
From: Wentao Guan <guanwentao@uniontech.com>
To: pschneider1968@googlemail.com
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
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
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Date: Sun, 17 May 2026 02:09:41 +0800
Message-Id: <20260516180941.704379-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a56911f8-9c02-464e-b61c-0d565a5dbd43@googlemail.com>
References: <a56911f8-9c02-464e-b61c-0d565a5dbd43@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MJsUkRPIFlJqZV2i9JatPh0nt0T9P7LllD6BEDYOwNWdVEhJmf5EoKsR
	+fji7ZiK1sL/uT8rfPRoDfNFNCNVOYT7RrjISifD/uBZdecamRe6aQgXs5TXGm2K15ggFQV
	AFqiGEbHsd5u/jyPZeQqMbO2nvANdu9dWm0+RlE3TfCgHqlw4cGmmyjKSaG3L6yIxlwfYwV
	cRO4pwK/h57/lIoMMbd0/KP3lDliIuZawUZgLoEoz/RlUnNem/6yT6MUH23r+goqEBabdlb
	IR5XT+ZE5OGIe3NHB3FXgtvAk8oVajjjNq9KdZCL7wCcxFSt8q/u8j/ygasZIplpK6jrFjE
	DCONo07/UkfU6viR1PLOVZTq1+ttm8KAVDo8B+cDYozXiWVlkX6f2IXZ3b464Y/I9kM31Ss
	kwESAtunZAaiIakgGrRZecDep0pWLAuQxeTQGw0/oKJzbouvpFTcOliWGhLc+QzoF5Ff5eN
	zPCplQPYfx330Vr0gKqRZ0MJ/8jvW63f55ZkRNxuq2mKodSsIu2EfEAyfqxOn1An2Y4vyeL
	XF9JNbdYzenuArSZ+ph5v7BnR72r6TBRURppNe29rQsXhO5L++p/rTyLO+UI2Jfo1zmgUOE
	XFaFET7MQX1QcoIyYbjDNzPxiwtZe1b71ZWzV6LNe5Ol0goYKvfr1JQOloRbja6yRsf/RpU
	VShbk9A2S8vfo0EvpYoYrx7ROhgkIiI9fP4djWi77k7EEPuiBkzpaY2jcUM2x+OSxfHwuiy
	lPPb3UDlX64Hqp5U7OeheWHnan2xHPY2Rv2a0ENsk1nerWNJH6Z26Ooh2loUadmeV/E70g6
	9jqgEeEjdHLKQPRHwVS8JNTUMxqDfCojTnIz1sp8z3xq191/Z3UxIneaIjj5zXvMiv30wCc
	2/l18HjurkFEXg6kQS2+POi3dbhWkGV0ZjkUquxnpNMBEVUEFVNGBbn/5+WF7TXZ2j22CoK
	HFaTPztm2lxyBY2Ucue7lAik8tcmC28UXNm5VIUBU9DROKhGBVBu6+pbC+TLJGejZtGUnl7
	wNAUslxM4NZxIx1QQDkX0Y2WsQjt+PHnQ9C0ICflFUg914G8vqtekcPrFpHAA00Iqxf53EE
	FDzX2sQB2VWfLWig/ViyJzb/m9R+gS4gHfDWmYZik/xex0z+iGYZZy8ilh/IPQARvtSFsJZ
	dQisHtEFKfxnvQ8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 0BC2355D096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249021-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,uniontech.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,18.194.254.142:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,suse.com:email,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Action: no action

>Am 16.05.2026 um 12:09 schrieb Greg KH:
>> On Sat, May 16, 2026 at 03:07:14AM +0800, Wentao Guan wrote:
>>> Build failed, you can drop the commit to build ok, same as 6.18.30-rc1:
>>> git revert 14d9ce90cf4855d638ecbcdb0c208a144d6f991b..
>>> Revert "sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation"
>>>
>>> Tested-by: Wentao Guan <guanwentao@uniontech.com>
>>>
>>> BRs
>>> Wentao Guan
>>>
>>> defconfigs:
>>> https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9
>>>
>>> Log:
>>> In file included from kernel/sched/build_policy.c:63:
>>> kernel/sched/ext.c: In function ‘scx_ops_enable’:
>>> kernel/sched/ext.c:5524:34: error: ‘HK_TYPE_DOMAIN_BOOT’ undeclared (first use in this function); did you mean ‘HK_TYPE_DOMAIN’?
>>>   5524 |         if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>>>        |                                  ^~~~~~~~~~~~~~~~~~~
>>>        |                                  HK_TYPE_DOMAIN
>>>
>>> missed HK_TYPE_DOMAIN_BOOT is introduced in this commit:
>>>
>>> commit 4fca0e550d506e1c95504c2d9247bc92bf621bf6
>>> Author: Frederic Weisbecker <frederic@kernel.org>
>>> Date:   Mon May 26 13:06:21 2025 +0200
>>>
>>>      sched/isolation: Save boot defined domain flags
>>>
>>>      HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
>>>      but also cpuset isolated partitions.
>>>
>>>      Housekeeping still needs a way to record what was initially passed
>>>      to isolcpus= in order to keep these CPUs isolated after a cpuset
>>>      isolated partition is modified or destroyed while containing some of
>>>      them.
>>>
>>>      Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>>>
>>>      Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>      Reviewed-by: Phil Auld <pauld@redhat.com>
>>>      Reviewed-by: Waiman Long <longman@redhat.com>
>>>      Cc: Ingo Molnar <mingo@redhat.com>
>>>      Cc: Marco Crivellari <marco.crivellari@suse.com>
>>>      Cc: Michal Hocko <mhocko@suse.com>
>>>      Cc: Peter Zijlstra <peterz@infradead.org>
>>>      Cc: Tejun Heo <tj@kernel.org>
>>>      Cc: Thomas Gleixner <tglx@linutronix.de>
>>>      Cc: Vlastimil Babka <vbabka@suse.cz>
>>>      Cc: Waiman Long <longman@redhat.com>
>>>
>> 
>> Also dropped from here, thanks.  My fault, I should have only backported
>> this to 7.0.y as the commit itself said to.
>> 
>> greg k-h
>
>
>Now I really wonder why I didn't hit this build error with that patch included in 6.12.90-rc1...
>Because I hit it in 6.18.32-rc!
>
>Let me check my .config ...
>
>Beste Grüße,
>Peter Schneider

Hello,

I thought that 'CONFIG_SCHED_CLASS_EXT' is what you found,
and it is depends include 'DEBUG_INFO_BTF' which depend pahole (maybe missed).

BRs
Wentao Guan

