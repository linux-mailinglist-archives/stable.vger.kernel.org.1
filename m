Return-Path: <stable+bounces-58970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8DE92CCA5
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC832863AF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA5683CBA;
	Wed, 10 Jul 2024 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DnXLFb9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334184D0F
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599329; cv=none; b=r/RrWypZ4uFAromKjjSElMYFHP3f4nMIPCszbrbIDEgsrZxzcIf5lbRZdNmYsGt9Nr5ykJP5aJXYODLqV6Y7NmFEtC+CfYSW/3JnyojPIbhsK2/26JZwRItsMUMBaWbvWcmGig9NgDbVhBFRFS2RNVeRz/dabWsgjdlUuiJdPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599329; c=relaxed/simple;
	bh=L9cYX0FZOqsEWUS6Dl4jXBnuh+p+V+nVGgMuCjsSSHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNsI9QOTbKTpYDtoiRSAxM/lw3UBp4N47XAcBA+5DdxVkfrj2Sbnmlbk6IudEIobxEPzLsB8X6N09pZq+yHMWV81a7SQJilV3xzmfuLcWrkk/exAiAEMdM5YSe5+hoFtAbjSc6fBDDFKLCOUXLWqp7wzRdtHr14oKZ9mHbrZ3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DnXLFb9h; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so8517411e87.3
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720599324; x=1721204124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHfy2kRUgaVp+I9p+R/nnBTbFpFOafOVt67JpL5cYvA=;
        b=DnXLFb9hPzDzRKcgU99mfhzZSYxsMYGUzKisZIt7nrzvimLnw38chgqDdyh9cCGgFN
         FUSMf6HM27LEZ7ICZoFxyhb4S1gXwN9FMTaWsME6AWPLWFPeTyw+WCduODLnqRWuevnt
         D+MmyInXNi/E5ZfhiedGhWpZu5YQIFj7QHrvoijcWz/5mON+MI3dBCBv6fuO2efF5oXn
         ezbMr5BV5L1cXQ9ix3Goi8DGEZUDts6ZHwPCzvldKjewHXJjpZQZJ2rupD7CnBFgHi4s
         TzrqwVOxUjJv2cfb74F+WiG9yTOZQLtb7rTrGCt5DKLQ0eArxImE3kfbIxrkYp2sVejw
         dm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599324; x=1721204124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHfy2kRUgaVp+I9p+R/nnBTbFpFOafOVt67JpL5cYvA=;
        b=h3rqRhnzGKYkqh7PdyR3lYJEh/0fmq9hCShm35lblxKXzUjTHeYZjJWSOJnUZekSpN
         YqTwZNDMlDrmFzmPfsNY+K7IzfC/Raicyho90xUA9kbsJu1etczHuIiTMdPXLiCQYwcQ
         AjS1O5yrH4QcsBtMZza5msfgDxqaFeJYbN9EqP6DXnVDELodCvAosc5W/4NF88OY4BhR
         +nnPuL/Gbz0OUmByi3CcsDSI9vTmnVNpjEZfYKvWTDcLwGCiAcPCQlbqv0MJGue6g36J
         +jqmePqu6gPkwPGb97InOiPhFZfL0duR146Sg2GN0/YWxsipvu4znV9g4cmNElmY2pXA
         vtNg==
X-Forwarded-Encrypted: i=1; AJvYcCVcsdZz6uwTUka9OWMbXN8wmB7N/CUusTSPTm4TrabkSQ8qn7r+FZVbIRKK61SoVQlYT/gWuLGf1+pftL5Cp+Lijiodm7TW
X-Gm-Message-State: AOJu0YyrPEUygPSbLAkWBE5T7PSh6nEz1IIPWsaOor6Ou9yplDv6Kt9D
	+gH1HVI3OvxX+GoN1pj5EjOXIMTb/uVxlylE62jl41OjQ+lmJl8uy2JqMG/fpE0Zi0xXusV7VKV
	GcuxS6k/Np+3UoPdQe9gIRzb6rDTfAn70
X-Google-Smtp-Source: AGHT+IHtfnocm4ldsA4+yF3b0rhj3hqvP8B6rA8W27iPtRI7FPGB+HWm8fxx1/B2ysSk2iRIP5gO/ySptU45
X-Received: by 2002:a05:6512:3b90:b0:52c:76ac:329b with SMTP id 2adb3069b0e04-52eb99a35dfmr3905436e87.35.1720599323983;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a780a8535a1sm694966b.224.2024.07.10.01.15.23;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 8228560117;
	Wed, 10 Jul 2024 10:15:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sRSTz-00Fz6w-7h; Wed, 10 Jul 2024 10:15:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/4] ipv4: fix source address selection with route leak
Date: Wed, 10 Jul 2024 10:14:27 +0200
Message-ID: <20240710081521.3809742-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
References: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_semantics.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..8956026bc0a2 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2270,6 +2270,15 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev;
+
+		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
+
+		if (!l3mdev ||
+		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
+			fl4->saddr = fib_result_prefsrc(net, res);
+		else
+			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
+	}
 }
-- 
2.43.1


