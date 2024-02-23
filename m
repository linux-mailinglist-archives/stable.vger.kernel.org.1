Return-Path: <stable+bounces-23513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FF86179A
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F047B27726
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195918594F;
	Fri, 23 Feb 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hjfkcSFs"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5082D80
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705143; cv=none; b=B6trjf62bSvcWRtUcR9zksDkjHohEPoReXGeXPeamoPsbpbAuwcAuoFzgBKzMLTd8WVBX42+6l9WSv19rrNQsV1tJ3ur8nnw7ofKB1Gg28G6ArkDKNfvm6p8dUzakx6M/pVBf6DU0+YYp7ZcVnpSbU5H2wAih90+JVmnh1GKU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705143; c=relaxed/simple;
	bh=ct3T59uYwnO9+CN6fHbV+f/7ByxYKWmmT3Vjbq4pSI4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Txz7KrQIthBgGM12RM4K5zpB/UqMWnFARnhEFtptQ7kd8562KTrq55V/Njw+Q6FEsRR25YANfoJc+rlG4KcE8EsHXxn+B8pK53SqMm/AgvnQSDNDiLZOL3xnNJtt8pz+pnjJugGZIWqMzyYJUTAs1qPv8X6Ga+j9G9ycY3Dp0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hjfkcSFs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708705125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2D/5zYbUpXllosdw3zQ3wHY9OTR2dlIIzaxbR/7359w=;
	b=hjfkcSFsEHegaykaFWCd85rr9G3Yn1x+yPflB+vEmjxK98DKVvDGSCGwf8dcG8ybLrNIFT
	iVBoiRCDGn0C/9Gs/GG+ihS37xDdMur91kPEdeAMoQtKIxiKqUn5/Ki/Cf8rn8nKv2mQ+R
	q75crEuo4vTlI1AXKbwpiliwbTZRnEZrUVKhOL3Vg1QMB5gGaYGVJ58GacD03rZTLdzlv3
	KhPZLOjum3cMao29LAPrACXkKZA4RhK77ZidvLCNXr1+ySHkOP5UjsiHzC1DrQNq/qdCiM
	2mBOF99vj44LRHJPBUagLojsr5AGV2NKqs3lQ6Su/gNWTi9AuGLOjxwhMBjTNA==
Date: Fri, 23 Feb 2024 23:18:40 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Subject: =?UTF-8?Q?=5BRegression=5D_5=2E4=2E269_fails_to_build_due_to_securi?=
 =?UTF-8?Q?ty/apparmor/af=5Funix=2Ec=3A583=3A17=3A_error=3A_too_few_argument?=
 =?UTF-8?B?cyB0byBmdW5jdGlvbiDigJh1bml4X3N0YXRlX2xvY2tfbmVzdGVk4oCZ?=
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Hi Greg,

the issue might be due to this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/releases/5.4.269/af_unix-fix-lockdep-positive-in-sk_diag_dump_icons.patch

2024-02-23T15:39:05.6297767Z   CC      kernel/sys_ni.o
2024-02-23T15:39:05.7583048Z security/apparmor/af_unix.c: In function 
‘unix_state_double_lock’:
2024-02-23T15:39:05.7586076Z security/apparmor/af_unix.c:583:17: error: 
too few arguments to function ‘unix_state_lock_nested’
2024-02-23T15:39:05.7588374Z   583 | 
unix_state_lock_nested(sk2);
2024-02-23T15:39:05.7589913Z       |                 ^~~~~~~~~~~~~~~~~~~~~~
2024-02-23T15:39:05.7591564Z In file included from 
security/apparmor/include/af_unix.h:15,
2024-02-23T15:39:05.7593341Z                  from 
security/apparmor/af_unix.c:17:
2024-02-23T15:39:05.7594989Z ./include/net/af_unix.h:77:20: note: 
declared here
2024-02-23T15:39:05.7596733Z    77 | static inline void 
unix_state_lock_nested(struct sock *sk,
2024-02-23T15:39:05.7598516Z       | 
^~~~~~~~~~~~~~~~~~~~~~
2024-02-23T15:39:05.7600862Z security/apparmor/af_unix.c:586:17: error: 
too few arguments to function ‘unix_state_lock_nested’
2024-02-23T15:39:05.7603177Z   586 | 
unix_state_lock_nested(sk1);
2024-02-23T15:39:05.7605189Z       |                 ^~~~~~~~~~~~~~~~~~~~~~
2024-02-23T15:39:05.7606765Z ./include/net/af_unix.h:77:20: note: 
declared here
2024-02-23T15:39:05.7608497Z    77 | static inline void 
unix_state_lock_nested(struct sock *sk,
2024-02-23T15:39:05.7610208Z       | 
^~~~~~~~~~~~~~~~~~~~~~
2024-02-23T15:39:05.8002385Z make[2]: *** [scripts/Makefile.build:262: 
security/apparmor/af_unix.o] Error 1
2024-02-23T15:39:05.8005077Z make[2]: *** Waiting for unfinished jobs....
2024-02-23T15:39:05.8094726Z   CC      crypto/scatterwalk.o
2024-02-23T15:39:05.9082621Z   CC [M]  fs/btrfs/sysfs.o
2024-02-23T15:39:06.2502316Z   CC      kernel/nsproxy.o
2024-02-23T15:39:06.4094246Z make[1]: *** [scripts/Makefile.build:497: 
security/apparmor] Error 2
2024-02-23T15:39:06.4207119Z make: *** [Makefile:1750: security] Error 2
2024-02-23T15:39:06.4208636Z   CC      kernel/notifier.o
2024-02-23T15:39:06.4210296Z make: *** Waiting for unfinished jobs....
2024-02-23T15:39:06.8604827Z   CC      crypto/proc.o

-- 
Best, Philip

