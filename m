Return-Path: <stable+bounces-248996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CagHTdWCGowkAMAu9opvQ
	(envelope-from <stable+bounces-248996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 13:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA455B777
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94296300B5A0
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6213D647E;
	Sat, 16 May 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX0ylpmC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2D3D47DD
	for <stable@vger.kernel.org>; Sat, 16 May 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931245; cv=none; b=KbXQ3B6aZST4NTK4qin+QBqD7K//4JJMj8NRIMNFIfcUnda0jT0Fnyh2/dqk7Fa/s/HefUIS0OgqyL0UL6fassK6z8qFsms1QyzsvOOGkLKwlSkFdBVTbzgo7Iukm+HIu1ULwzWNSmGEbMjvLtYHQD1oBY60efl5wQhctHRjjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931245; c=relaxed/simple;
	bh=kS9Q1v0jE50HuL+kLJLERVYaxzIqhv2g23wbEVDAAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmrKxxAawBRVMuISRlMcQaKRBNFNQpfVgo0rJQYBi74a4azjoK8jUsoLPOSc7fHA6u102968/DaD69LMOslgFlB+dPhqdEZWtBI9ExZG5KFYraRYhU/6RkFCkaLa8sxFixsZAHDz2DGQ8npVu44HwCK2813yM8CWIosi+4YqCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX0ylpmC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so119396f8f.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778931242; x=1779536042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXRm8wHLMvu7h8cKS/PMy3rIET0MllJuf9jGLxBvpQs=;
        b=BX0ylpmCyBrPOKvAE7i+QMm+Opwg8fyoDDQ27gqJTSpOL1QAyRqFdnevY2CWhRwiJL
         RdQTw09kFSD41jbtBDbGRjA0lsVrkjKSe+yXkbYfEyWV4rc4E7ryeEXeP8iliccxMRBZ
         kMuUhui0lVxR6NYzRiaZoFE2ZCrZcc9cIZyPFvyP0A9s/iHLsK/WS3gqsK63i5UoPewa
         P4Ytg89XML1rQZ6Q8XnsdlOpJTwcrb3nwYz8/XlgTwCHbhCUZnm3TIQSeO54IpuTWpId
         tqTYKjxs3jBXvHJXmUDJCz4GcZ/fUdfUyarmHv64M+DQPmejP5Pzn3YY55qZejDwnlor
         +dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778931242; x=1779536042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXRm8wHLMvu7h8cKS/PMy3rIET0MllJuf9jGLxBvpQs=;
        b=BffpwDm+IvGePce3RvFctN3R3cN37T0frXh+ZbWgGrY4fKSv28CLktwlQEliYEpdM9
         XQceqGyv+F9ygxFSnref6JPqiWR0jGlesmF6GYPMTswPYOXJ3qbosUIchYpjNi5floeQ
         D7eaHLATHU5h3Ruwn60hjT3Gs7ULN6PXfW32JjC0PSHR26AXMlTFuDvqqLi4Z7/SMGGO
         QMSpPjAU+z/UMYQ01dTJZJYG+dQCcBG+7+1lkPFsujbfOB0M2RYQZho/ssTBERY48jRc
         0zpwSoKRdQNxXlA8TBJ2TyKuKRixq048Y+aIBDVqFy3r0kBuh4a861ofiQ2SPCuqaMaW
         am9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1CpmoEPLttN8hsMDqzffJi8+f0etOSvRhwgEODDrKVh38Cv7Ng7JeEacg4/4p+iOH0ZLJfv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymgm3Q5D9rVFnFK/mTBuqfEyXyrVLpLz0KaRSv/zN4QPdKjm2i
	5wvgsKlQQq+SoWFFZqL4A8bD8MKwljA0aMQ98cR/EReIWz4ap4zUnpc5
X-Gm-Gg: Acq92OFpfA7bDDkghe1qEZzby6QMpcdE6KgMPMEYJFymtHtfPyjzyzO8QAOVk4UmCEG
	jKkiTLRPrswLXLXv95Shmjqd6nSWLGma7sHGjmjZgPraYrXmwPF0Vr0cjzEd3mhW5c9UVuUPuH2
	RzbFEAC9bViTgeVYz0mU8lrl41GvMln8lzX2yAqL4q3J0LH88iEB75VAm7vJkbqZihfzJA1jcHo
	n6vBmbzIGi8DLN2UJTGjXl31nHlfmQmpmPXULyQmbNMCPxY6cTgiJxvlFjIKSXPz3wy/XSwCziG
	b6+hnfT7g02OM1FBEQK5V/xLmGkGNa/MMgM1V4xCDafwkbMwK6bC3+VWCR4DVgc821LDzzk+eIJ
	4ewdscssUYSR5NqiDZsLIPVP0tlSaG4UwP8XtdQig97tDFzhnJHR4i1UV5WLQzPi3SErMPVYwVh
	AT5IIeRPC506DqwR//Rzv+r9ZvpidyYaJ2eUH/SJzMghJNK/91igDelPH+mu3avuguG6Lw2YhFW
	NNr
X-Received: by 2002:a05:6000:2dc2:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45e5c5b39admr10857244f8f.4.1778931241865;
        Sat, 16 May 2026 04:34:01 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-304-238.w86-195.abo.wanadoo.fr. [86.195.26.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768acesm22686198f8f.7.2026.05.16.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 04:34:01 -0700 (PDT)
From: Bernard Pidoux F6BVP <bernard.f6bvp@gmail.com>
To: kuba@kernel.org
Cc: toke@toke.dk,
	stable@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio (hamradio) subsystem
Date: Sat, 16 May 2026 13:33:55 +0200
Message-ID: <20260516113355.24110-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10EA455B777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248996-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

  https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

  1. rose: build with hamradio_compat.h on pre-7.0 kernels
     (compat shim for struct sockaddr_unsized, required by af_rose.c)
  2. rose: fix dev_put() leak in rose_loopback_timer()
  3. rose: hold loopback neighbour reference across timer callback
  4. rose: fix race between loopback timer and module removal
  5. rose: clear neighbour pointer after rose_neigh_put() in state machines
  6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP

