Return-Path: <stable+bounces-237742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DE5Np7x3WmMlQkAu9opvQ
	(envelope-from <stable+bounces-237742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6D3F6BDD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DE6030B0B62
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5B38229F;
	Tue, 14 Apr 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jXBkWTEc"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9F382363;
	Tue, 14 Apr 2026 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152829; cv=none; b=aty1Ilmf9lIJ3mA8NgpKCo9VEsizyVOYURxDfL/cyWXbqHpTUix0n33FLntcZi3actI11mC4HQhxj1z1OeQJwV1WViXCypYIVhEdCqpZcbPSUyLRBznDTYO+4dlVYIEQSoTc+EC01bW37i21FpmjEDxpnofakPwMdvKMeHeaR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152829; c=relaxed/simple;
	bh=2SvYolvgomNB05QQPc5Ipj8Z5sJ0NE/Lr9Y1GU7mXn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBdZS7e+SLZPiti4wf2mkSnjYiqPjLOC6iNvXKDJwN6yj2VOjz/1dmLLSYZEC7lk4DGdFlPc7chabg6JTi07GLRkKqhWWLKB6RXsx4E+3Q47Qx25OSq++xpI9H3YuXxkVRwtJ4w9nvJM7M7MmLTHXanPhAfc8yWF/9MK9xp0M3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jXBkWTEc; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776152749;
	bh=ijOBe32OJaXUt6Lriy0B3ACja7Vy3gV1h+L6V+TUVU4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jXBkWTEcpAiuqzv0/u4Ep6zru0sVgQeUyLB3Q6ANgUyVpNXGusR1lkQbTYWm85Ovc
	 mqjw8aD2AA4ZUCH8vTfNri0DJEHtFXrZ9aXEybAR+WPvuNGWRwPXngpKq/PtozBgTd
	 MXd2prG4fwtSTC6HHgl5RFPHlql2VxMeTpl+OF4E=
X-QQ-mid: zesmtpip2t1776152743t05dafc70
X-QQ-Originating-IP: 90aflYS48oZQTIzKwDmOLG2ZMpBlc0zy4H4mJgn6gkM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Apr 2026 15:45:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8781629494817420186
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
Subject: Re: [PATCH 6.18 00/83] 6.18.23-rc1 review
Date: Tue, 14 Apr 2026 15:44:35 +0800
Message-Id: <20260414074435.2566765-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mrs0LwfWgKNgOj/6Cpu1aQXurFmSIv/YEmjSw12Um/NY+9T83bLABCON
	9VbWT76ZfJP5nlY3bB0LxNupp852n5ptHh4Y/UUDAtoCtELsz3g03c5N89dYug9Kf06T36L
	irY3tETfLQx5647I9cCfh83GTKp8Y8gHdYX95cXBRx7dnorOr0981JEAVYJLYfNEbbMRWkg
	DSlYbJmdZYsO1WT0OLK2UW5aDX9fsT9cicPPDebytCp2BVtmDsCJkBNHzpj3rq0oHTEW6AZ
	zCu2eq8wiRKr+Jws6bUKqnDHk7y7InR76geha5P4z97gR2xJRja2Wpgiz1dvV/2ec23XxsN
	tk8ukC29uyRH69okHlY1HUUyGCHcblwaWkK1nR+1/cXT1524AYmh9bQrUzSLBuyI/h3PK77
	aQ7z4k6fK9jUX1eY0TkY5ZIoy5AKz5d6V3H7qyxJK+5+ZaNY+381aQft9FVzsVYcs5Q4NU5
	kkkvkkl48ACMUqPi2Om1IIzDowJvN3l9hrpPspsTClYLFNInktwpvhJmo3KaHiilmTEDRyA
	8NqlN/1No9LUt3KkeU0MCGgRWXuMW5t22JUrjqnNFzfxFb+NugCbfY7YoDOJONz8czboVHO
	iH/cye3u1x7ymRMZk1fE2YODuCLrubHaeQ1PVWVd1P5R9hN85IMGSWIumtC+kaM8fYSnCvI
	6h1u2A+cn9JThPQrHmInH48CgKfHODS/b+z1vj+KSACesRzm8qO/XtJxisO1OV+5JLePGOb
	JP7Woo9dL1l6c0ZckFJiwF66uO4GOsk82RB4XDGUlGCNGSwx8GzA6NOPSjzzRvzeS0w5tsv
	yRxGNihgMy/4/VdnR+9K3oF8ATh/bkPvM2Uyql7elUGxT8JsA5lONN/eHoEpaI69dEcC6CY
	5hyobmAyXc2GVt6/qNw+S42JmFOcVOyh920pv4hqnWUWJyVTer3cXDNfHR4VNuhUDt4NUY4
	zaU6YTjiaCz4jz5Yb9gYtNaX/JtCu0XRQVKlpq7amsGC7B9ihOIQ9RvR9eUMCZDR/upzxJg
	MsBhgbb70O40EEtWVrwwnrTiFo28QdbVVUzI5tpjc5yVLTiltoE4DMn9+ct7s=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237742-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uos-pc:email]
X-Rspamd-Queue-Id: 36D6D3F6BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/decbc7d88fbf68488a7d90e46f6d3e59

Log:
Linux version 6.18.23-rc1-gc600baa82c20 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.23-rc1-gc600baa82c20 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Tue Apr 14 14:39:43 CST 2026
Linux version 6.18.23-rc1-loong64-desktop-hwe-gc600baa82c20 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.23-rc1-loong64-desktop-hwe-gc600baa82c20 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Tue Apr 14 15:04:09 CST 2026
Linux version 6.18.23-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT 
Linux version 6.18.23-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Tue Apr 14 15:32:22 CST 2026
Linux version 6.18.23-rc1-gc600baa82c20 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.23-rc1-gc600baa82c20 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Tue Apr 14 14:13:29 CST 2026


