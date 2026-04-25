Return-Path: <stable+bounces-241092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGIcG4NO7GnIXAAAu9opvQ
	(envelope-from <stable+bounces-241092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 07:17:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C253E465055
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 07:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2493045AA6
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 05:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C42874F5;
	Sat, 25 Apr 2026 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfyitZa/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31520288C3D
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777094069; cv=none; b=KoMLsmNhHq1eKIseUTMZ+kuMApnu2VKRvdns9D9vqW7cnzKUpJyXPMch7Mq49VWrQxGH+u3DP77sHXqL4Zin1U87VREKCxXuhrD/tUDiDFS/mSbj/Gn6+fPLNXZex6l3PKK50/kgmNyWElHkHPPZ+5nptHx8LVsvwOys5sXGkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777094069; c=relaxed/simple;
	bh=92FoLcX0NIGnA51Acikj09Qm+3lN9YsfDC0DOOi7IrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSiUCDxyXBJSL9ZNP+FCkHmCrMjPmfXwfASNR4NtjgOpcEuqFpHUc/fHWrdSTvx197LCB5c+wCzqblil7UQM/gdklBw3HnoOJLifWAFWVn0W4/Joyj1cSd8RYfOHlaQjs7XLfkFBUY98k5PSQ9X9Aok81OADFk+M1OEx8Il++PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfyitZa/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d65f4073bfso1185152985a.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777094067; x=1777698867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92FoLcX0NIGnA51Acikj09Qm+3lN9YsfDC0DOOi7IrE=;
        b=RfyitZa/2LSF/RGu618I5DerfancFy/0YIlhWlsoctDoPqH4L3VPXu3oJbcYIbg2yI
         eG4IhSIp9Ttef9R2DyMsotuBKESUjjT7P/D6Keb25cFhs58s3JyeoHYN8xk/DY677vhn
         iKw9DzASadiMca0GhEjrPtWhqzaV/SvWOdp3pQidLsoBLSNyWOZ9VvMcZ/GaGmgXMGNj
         Cr5qmh0Da8sHsDcBjFh0APUtVJa1J1N6OykjEzY2vyjJ+ALEgjVsO19ddqt57VELE032
         FOXOzmc4Ei3loLTEuzmECurAOUgID6Ll0MiTRFVid7QJIQiR84DHvK8egaUOE0E9p/AM
         FG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777094067; x=1777698867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92FoLcX0NIGnA51Acikj09Qm+3lN9YsfDC0DOOi7IrE=;
        b=S+9jt4GRCXOQDAScVO9jsCCMj26UxCe9w3jMGwJARQuqRiBiXC/2yk8RFdDj034Osf
         fsO5JvftS/wshJlYzf/zAMYS42bT/6KUTcZ1plXXsQmCWzb4ORQ5Q0M6vJcoTW460+sA
         2ZF93x5ZJBaQPrtS9w6Z7sOJsAAglvfIoPrA+lvyjMV+/lC4chAHwQP8/ossw/9NPJAN
         0GDPptv3zx41upnadVwELLdVPnnPZzUgqfXVBEoAOljQXJ+VBv0qVJ2cDRFAzTq7SKSs
         h7sz2F/mFzvbt1nNv62KAaqyLyzitowip+xaoVHQxBnruPdxgrM3JJP722XVLfSsUTKh
         LwuA==
X-Forwarded-Encrypted: i=1; AFNElJ8FYFL8IBaC8EUGLJLd9e7ADqD9oLUupLsddOhOuW1UAL4Y5BCbrSrmHF88lF20Vh/0/V5JKz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQsG7hdjCZeHybHTjwWuqhMVNKdIg0qZbUbyKg+l1I7+yXCD0
	sKyzoQzRWX0nD0i+LKqwyfkPlEFjj7Mpu+RdFOLWfJ6QBrMIglb5ronn
X-Gm-Gg: AeBDieuVWzn2ARmO3f6FetfzyNbTppHXFcFkQW2/6lc49s6JqRZrDC2a+jeL9o71DkO
	UkeCOJ1o7kIx7nYoqFCxqy0EXSKzB5lLWcsShqnpqGioki288rsw4QjJPibD+BFyazsCf21tfBD
	yjtQMzANO9X41PwAPxqLToTPQeWm+iUJ8USKUdf7EZUsrbBjqsjP9mV5at3hU8XNC8oYzSjGVFN
	qy7rdTIH7lZgVIt9WaAdnlr5sw/Ld2ymrHuyWwARWTZKdqhzvtyocc0/1Uo24OT684K5Q3y77TZ
	Xj3Gy3jfkyP8oKxaeq8B1iaWZJiCl98u9q4GR6VI18r4Sh9qekkqQv/5wsofjOEswO8GNTsAQX0
	WT82MUhqKy1M7LIs4h3N5ADWtDeF8/U0LnoLhpsOh/zf6xVlKLPicuu5pY5xtSyimlbdlm//nE/
	xAIUIxPT7bio9++S7cdJUn8eXpoaCTFj/3VEGrZy+3J8FrMZ3xoA4OBhQ32w07Ljo2WuVJrvl0U
	1asMr4zx1hAlHSL19c6UHSXxAnH4nNF2ykjF3oiXRNaDboBidPNRxOpmikcERVn/0ZJkQNMRNbc
	sh23UVff75AUJbAI1YXds4VLNzY=
X-Received: by 2002:a05:620a:17a9:b0:8ed:3c1:4bc6 with SMTP id af79cd13be357-8ed03c154ebmr3032484485a.57.1777094067142;
        Fri, 24 Apr 2026 22:14:27 -0700 (PDT)
Received: from Christians.localdomain (c-68-55-113-25.hsd1.mi.comcast.net. [68.55.113.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb1923abc6sm1552004585a.6.2026.04.24.22.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 22:14:26 -0700 (PDT)
From: Christian Van <cvan20191@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christian Van <cvan20191@gmail.com>
Subject: Re: [PATCH 6.12 00/35] 6.12.84-rc1 review
Date: Sat, 25 Apr 2026 01:14:12 -0400
Message-ID: <20260425051412.112958-1-cvan20191@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
References: <20260424132411.427029259@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C253E465055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241092-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cvan20191@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Tested-by: Christian Van <cvan20191@gmail.com>

Build test summary:
- Tree: linux-stable-rc.git
- Branch: linux-6.12.y
- Head: 59f8529e7 Linux 6.12.84-rc1
- Arch: arm64
- Config: defconfig
- Toolchain: Ubuntu clang version 18.1.3 (1ubuntu1)
- Kernel release: 6.12.84-rc1-g59f8529e78a2
- Build target: Image modules dtbs
- Result: passed

No runtime testing was performed.

