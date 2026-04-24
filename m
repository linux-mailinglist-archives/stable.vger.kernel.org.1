Return-Path: <stable+bounces-240557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMMhD+/h6mnJFAAAu9opvQ
	(envelope-from <stable+bounces-240557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:22:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926034596E4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A6B3025295
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1131AAA8;
	Fri, 24 Apr 2026 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5x10gU7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF4224FA
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000861; cv=pass; b=LsYBWoI/jr3V2PxvCdW4Tp+Y0M9PhnyPJkb6nojUXzPufYiuLdo0E8S9QNETciFSCn4IGtkqX57eWXC+3qAiD1r/oRdUvNfdCC9VHBX4fSFUQg1aaAABJGzM4emtm9VhgZuqCJ7yldDnIHDSiScNhKd/VaauURjHAir6wK5BmRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000861; c=relaxed/simple;
	bh=O4+xU8YH2F4OtxUaggPxhN/iV0XySXeHrQmwltY4a64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1H28ylDPaUgOQaPQMoBWhT1td8k8ftWATQRWUHtfYaRvIqq76+yS01tULZL1jdOvWwDO4Qn/2N40bFM2Ic3MLqHFs/yUjp59dcO9Vt3F0cDZweYj6HN1HuPdPyk5pNG5SGjG4Df/r/ZotFKJT13tv5emxfF8N/rp74Oe3cOloM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5x10gU7; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba92146cc86so653966366b.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777000858; cv=none;
        d=google.com; s=arc-20240605;
        b=glBI8MstgN5GBUKN7MgmCS1rOIDcrh1qWtkD/dPljmZmrz0Yb2/VDj6LlMYpR46EpF
         o73m+qJzkKTGtWKfRZtsLk/47s+8+PkLU98zuLNDSWw4gZ+vNox+vrf/oa+DzTciU8gh
         vfBhA7pQKzEc2ske0BtfAeHGlrOIn55z9qeerNErPIvPTzB+VAwXdFFL4RjDc7uAWm69
         4X1/imD/YYt7nREzGCNrwer3AAODdEmRQvo1e1znozuNEkHRh8EdfDxNYdgSxUCHTYRU
         0xPNPSf8wtUC8GCw6U26qgV1B5rvZlbg7JQOxDHZ3xZr14VRURROxRJ9nj2ny0SqHwMO
         Ysxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4+xU8YH2F4OtxUaggPxhN/iV0XySXeHrQmwltY4a64=;
        fh=c22SORguFTcQhfCKXyHL1ZSnpZBc0wmpXoWZkGzfY4A=;
        b=JDkBhdYQwgHFMeWmEpcsNBdnSwcJSPZCCw3HWtRx7wbiU6r0udlVBLEnFsbBQUPlM2
         299PYAVNMKBG2dBhgpQJp2KZtdMc8VqaORnKFGZddlPWjSw93aQNOkYTMM/wGE2xiQ1f
         Zj3bmUsSibg/PmlQCN1ZWJvvrGkirqb2Yv6ByFINPr7v7hOmFQwFbjFJJSAjq65xyvMT
         tJa1BNTvCJNe+67Yn0eUQDRQqPZLWsfvsws+c91h3yWF0Rka+OXN0QV63PnWbjUKulJz
         ICPNvT+VdUotZva/GabDQYvqzjludX5u4aUGg9uPd0ow8ArXqzNo8O/C+IARe8uvqKmr
         BBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777000858; x=1777605658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4+xU8YH2F4OtxUaggPxhN/iV0XySXeHrQmwltY4a64=;
        b=G5x10gU7MgsMIfl4Qy+tf/GjH1kGSs4II9QcEK1l4sta5sXjgN4FZzgoSgN4wESIHm
         VSkUYVBdS7Y+CcvCvpKJSIHMkaQVgW7lOXKho7p9ndfFrLeFVHZUWIZjX+wKyyO2kdlZ
         kTeP3qvkVEnfQWce98VIrqE/9EyG6fZy+87THQSkvN4W7aH6AOJPCJAUuovQa8xQRlL4
         7UUp6bbRnSKTjSJG5GEJPeh0ORKy74UA/wsLsfd+yZdQdk52e9hanUqFtd8hRvP10zin
         4SES1tLx+uSHePYN8sOAbT4A5CSSZtnvGYQUu5PzzRcOUsHhxsNYFRe5Im8/sv1PO4C6
         omeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000858; x=1777605658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4+xU8YH2F4OtxUaggPxhN/iV0XySXeHrQmwltY4a64=;
        b=NFUBOW+TV7GSfhh1aNAwAfLfGBLqEt94oPKH7+nMrmy4AaXqtFxNzaWk+8pH8ZFuKc
         KRJZcmdGe2fpvK8MCUhoUI3pqTT8TBF8/Evo5pCXMgvvmwWjCtTvvTMp68Laq6ZLaWTU
         ULIfsa8IfwWZyUOOB5PX5DxABPNPmh/lolzcXA+IWrc2f2fF7nQ70hYtJHM1sszwssNZ
         6zOzLI1J1xtkuWcC2V88L6/eALZ7b1kDYpIgBCDCnTBvu9FAgEeWFq5oKq7vMvIfjkze
         Qps3ZrnNU/yKLsv4W6nGwVDIuw0xLm81Q2sSQM2u7MRaeUJo0zPYok5qWtpb7vtjo+Sr
         DEmg==
X-Forwarded-Encrypted: i=1; AFNElJ+I5XFXgxDQgg0UE5+471eGLghJ1LX14YFICz59hDJAj/mqDRwtKNNkrEcdWCgr3rSI4rMoD0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UKbg8DpRtIrCYmWIB0/DWHgTX1zPNpm4hTRWy2a1q2bKtEBc
	hjmpKX05IE5QcPn0tiS5yo1ba90tGfP7nd+DQuCGm7dtziZRkCoaUjB3ck015Bi8aGAlbgT/7AH
	+cX4mXH36mLpufwZJ8UAMoME2NWZbMVk=
X-Gm-Gg: AeBDieu4DXnxcpUIR3yCXPRZw2Ec4g0Qx6JbZ73yyYrMRaTzNMuH0Rjm/KhAEbuSrkE
	CcVSfa52e8HaDKCOMfWa8imnDDKnZ95qNbhcWoi3IK2QcdjiQzu/x0IDiUJlISkRowQxrjYpXfi
	Uf9YYIKwygSYFlNKKp7Yr+yqINJk9YhT5jRrEQlf8cXdJP27DmvCaudY8r0tICkdxMyPZM6at51
	oZLuoweUFP11JOhgf0VqLO1iwLsBfjOPh5xo1ZHcu+1Xn615pfyjPLbiOPo8E7M5R7bqxL/Q6FG
	e/wdZ4MhdxeJVNiXoQw=
X-Received: by 2002:a17:907:cd09:b0:b9e:f58:c581 with SMTP id
 a640c23a62f3a-ba41b3dff09mr1772258466b.45.1777000857919; Thu, 23 Apr 2026
 20:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776094300.git.cyyzero16@gmail.com>
In-Reply-To: <cover.1776094300.git.cyyzero16@gmail.com>
From: Yiyang Chen <cyyzero16@gmail.com>
Date: Fri, 24 Apr 2026 11:20:46 +0800
X-Gm-Features: AQROBzBBnk_YvFCEfz_lFuAXWvexpq1ySeRqzLcj4iJd1txSatLuwGNuWuWkmTo
Message-ID: <CAD_b0500_rzz1M3CjnNNunnhiWgaBchSbhNSD6fmCNL4m3OZCQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] taskstats: fix TGID dead-thread stat retention
To: Balbir Singh <balbirs@nvidia.com>, Yang Yang <yang.yang29@zte.com.cn>, 
	Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 926034596E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240557-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Andrew,

Just a gentle ping on this taskstats fix series [1], which fixes a TGID
aggregation bug and adds a kselftest.

The series already has an Ack from Balbir [2], so I wanted to check if
there=E2=80=99s anything else needed from my side, or if it looks suitable =
for
you to pick up into nonmm-unstable?

Thanks,
Yiyang

[1] https://lore.kernel.org/all/cover.1776094300.git.cyyzero16@gmail.com/
[2] https://lore.kernel.org/all/d530ffd7-ebfa-46e1-afd3-2599a3ffaa55@nvidia=
.com/

