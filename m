Return-Path: <stable+bounces-211168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EzkOFU8cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:51:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A35D9DC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8B588485
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE9366572;
	Wed, 21 Jan 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0NaQ46F5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D63002B9
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025549; cv=none; b=f3pybCfB/r5qw+pDXbF7g0mFdtTF+z+q6E/WmAGyuKeVlmys4fj31nzxZezH6Hqfw7YDzfv9wu5zHVEoM63o6GlaONgWVnfnFCHn1zV8ui+bqEBzlKDLkO5JY/TEEghIQ/pqPtZJGSm9/JyXU/NbxZTvxfQYpoXwTUej1yfe2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025549; c=relaxed/simple;
	bh=hJYW2bUaGRTYUgJWcLXMi1Og3WmKi5/jYe6eSdtcgYQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=R7Xr6mdfZoMIMB38jynrhcgm9tq6FxSJH5tOdKNz7iPBGQhtereq4051RCjS/+DLyC8nIw+pAz++0ugA1CUo7NYp9h8AGxuAeJcro285ijq9ezOxm3DiOTvCoFsFbQkyP/9haQwIUYBqegigehlWCBv1EhtMidKw9TZ9xJ0Aue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0NaQ46F5; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233bc1117fso937877c88.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769025545; x=1769630345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEL/n6xY7aov6zfxkKmdynuRrPrQdj+DPwweX5Hd0EI=;
        b=0NaQ46F5hd3njeo1CnjqAR6Ghv3Nr/aAg5KwoO6EcdKDW7XwlNWNTaLw/5EyRwRr/b
         5nPkFNdYOB6GU5VS8o8O0V/IEXREgXXzjHcPxSKW1EAyU0f77BOIKvH9a+6nD8Q7KSPo
         9LbUqGZiZP+5EKJct2ePmh/wuxWCIBnpdmlwvMib9Z3p1suYS7T2nvOh6fTb4ItdUJbH
         C2tHsdRS4VqJ642nEgSS+tTQCjZu+fOTv+tfmtQfaykvOCk/RvNEGJpwdfXEBVIILxmZ
         jSgR8yb3c/WZWAHY7P49HlZRZz7M4QGI1ZO8De+2lAvfl6miFPsU98Zh73nKmC3Ny2TQ
         4JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025545; x=1769630345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEL/n6xY7aov6zfxkKmdynuRrPrQdj+DPwweX5Hd0EI=;
        b=dSMRox3eg+K8BrZEh2al7HOE6prdXnldCrz5eOCyoK5sRr1T48zdhVt3zpo5S9LF6e
         kpv3UvLz9TndKkMFWSWp7zs1DiDI0t9g8UdKieWoMl5e8beg10j8AKqwnBcNz72RCEvq
         u6cAh4pyKmCWQujTqWMujExk8TaHYPXrJO8hl2oZidknbp2wnvzN96x/BJlhdclvwXMo
         6pPekwWBAdgr1b2H9kRUmbIhE5BDPoGzeTl413Ke52Ta0eDCZXrBQgkmkuiz34JAfX+l
         LKiF3/u8Yugrq5V189KfNboap4f3oHyks3Fr83entaIMBy98EBVZ16drkHm17gnK4Hvn
         H98Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5blgCQxvtCsFqzaCIbLc3wGi+6GdLqe0ykm497W2tPb8bv0BFQCdNlVEl08+q7E8YZAAfh5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rHR+PaQO36tUrkxkbgl3Y8ByeSSUea/DsYYohzkIqg3Qu/fD
	T/KKIJq4TjprjhADJ7R0kzJjcq5mVwB+POsjXw1ISsiGYPCb5kQOyn48trZARLAmhiNgVRdwDeH
	G88r+Mtg=
X-Gm-Gg: AZuq6aKRFk2ayB4HWVRpPvDkEhg1ybe4GzOJsiTpwiCQDJOx+BHvZ0icPfuA4LlqeSC
	XXFr6Z8HnHYJbLvFlrgHQMEt0i9h7BQeaEcmkvYxRrF8hnyBzm4leJMA0GU3hmXPcxkSFpeAu/R
	QwBGPcwrgol1CS1o7McZZZIU57Du+7ZQXjOfvtf7t/KZdpM9Lk7TbGLlGkBQORRNVWpsdaQwYIX
	n70qdrskqKXe6nQ4MkzyIW6qMllbjB8acx0xeyYN4SIO4j03y/KnSCq5lWUNodD/eT6icdM2k27
	V5g2wyBWVGxJazsOaQHo4WCwKngEudAjX+/pQAlzOgz6AfU1JFHnKf4orXugEUjEKQZDlF0jpY/
	iiFe6xTdJaTPdacGimvF8w0/d0UYjBTWu6PrArISv5ce3uc6FphhNzy/rGHgNH7ONjarCKnzRCF
	jSqFV2
X-Received: by 2002:a05:7022:68a4:b0:124:4d0d:6921 with SMTP id a92af1059eb24-12476a85266mr344214c88.6.1769025544948;
        Wed, 21 Jan 2026 11:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm28688664c88.8.2026.01.21.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) unused variable
 'atslave'
 [-Wunused-variable] in drivers/dma/at_hd...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 19:59:04 -0000
Message-ID: <176902554388.564.9173711858582421325@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-697117beb2a19cc73abf1e2f/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci-org.20230601.gappssmtp.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lists.linux.dev:replyto,linux.dev:email]
X-Rspamd-Queue-Id: 8A1A35D9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 unused variable 'atslave' [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:7d0a95c488f929c6d7f816114ea1b1fed59abaed
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d16e94d964e9243489e3ac17cfd7f6a1714b3540


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1323:23: warning: unused variable 'atslave' [-Wunused-variable]
 1323 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c:1583:2: error: use of undeclared identifier 'atslave'
 1583 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1584:6: error: use of undeclared identifier 'atslave'
 1584 |         if (atslave) {
      |             ^~~~~~~
drivers/dma/at_hdmac.c:1585:14: error: use of undeclared identifier 'atslave'
 1585 |                 put_device(atslave->dma_dev);
      |                            ^~~~~~~
drivers/dma/at_hdmac.c:1586:9: error: use of undeclared identifier 'atslave'
 1586 |                 kfree(atslave);
      |                       ^~~~~~~
1 warning and 4 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-697117beb2a19cc73abf1e2f/.config
- dashboard: https://d.kernelci.org/build/maestro:697117beb2a19cc73abf1e2f


#kernelci issue maestro:7d0a95c488f929c6d7f816114ea1b1fed59abaed

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

