Return-Path: <stable+bounces-55012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6834914DF9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BE81C21434
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AC13D889;
	Mon, 24 Jun 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VQpIOSZ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467613D630
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234546; cv=none; b=hH0gT17FgDH8G4bp7uS4zRaqhxZXzkgA8rSC3lPof7AVMY+GDg7DnRLSk6WvcFgEPo3/jonM7zazdEBKsAdJd6ARhIo+WOi/44299RW5wnPtGNBQHXCJh+Daei2r28J1QedA7Vz+QR59zPlj7FcKHwk4rcookxC7SrdMnFpTgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234546; c=relaxed/simple;
	bh=F18MNQqMgi2s1pXAA8VazUOW/a2/fCiXeYMprACDpHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur2EEa1kC9orMNs9XsohodroW9WGo87AhQ6gyxty3IGT3RjU5p5WRBzSmtFR5I9cIbnUVdvtCqr1F6qXZvGpL50mp9sq6WXnkOtYTsxOputCT8HYfdxKTjbDFPz4fLq+jVHmXM5GaKq8k9C7H3AeW+8VmruKRcRIpWn6bafh8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VQpIOSZ5; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-52cd9f9505cso3166590e87.0
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cua0A6GEdu0iOk0GUptHeWMm27awSaljV0LV/Qv+59A=;
        b=VQpIOSZ5DnV8YzmSsUKwgl6J/svEeSgdfs33Vnl1dKAGSCpcDhvo0bbZcLpBt7ScEm
         JgFpfEnJeDYRZKliXsOhYcloninrfxjy8D2KMGmI8ruu+E6O1LhJvDaeB7cNtllcxxD4
         iQz13uY0TKPTYwxAPsK3ES1oKdli8TS9szqVMHzH3JO4jS6LG1TivJpcmjC3vOGJ8uXC
         qY5YoYb0JNPV/ZxH6HPCMCezC3mkPu5PHXyAb/pGel6/bIyObKgATVx5WTBRkCNSmoDx
         H8+JqPvMVBNoPvV6UC51QVvZ5XuiP5tBoGgaGN3zLrhVlu6cPinxy+EF5oORSHeyekmc
         ZkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cua0A6GEdu0iOk0GUptHeWMm27awSaljV0LV/Qv+59A=;
        b=MvciEgMtp58OiulvDa0q4HG32Pk6H4gudelQlGAMGHrjOnz+Sw8CIHu2uSVnRxYkTo
         Rj18/sKYdG/NAolfqR7fRRKwRMG64Euk2rpU3+V9pnV60P5i5tvyHGylAGwCYftMbCag
         S5dokgOnHqFrpCqdvz+c/vyOEsTFID9M/TViupeI+oiNYlQNfXcKaXtnhdLWTGm81CNC
         urzL/gtJa2ZVGWRPG7RqS5o30BbJ2fx8GqVggPakUeFuYhaOSSW0pEGpBIEJhJsII0+F
         VfuaUW8ym+wT341sRsjkNIZvU94mENGxQV+eNG4Y8w7YbmdSQ9nPnziydvb1tFWwbJv1
         kAxw==
X-Forwarded-Encrypted: i=1; AJvYcCUFiO57vXW3OwnL0tT95dOFB2Ojk136wJFCwVSb/K2UFaV4kBpeKo5DTTFGGv4o6k7W1zvY34eaNk43ErzIAO1mYr8EXTge
X-Gm-Message-State: AOJu0YwIK/HXXEMlGGNYIonZX1hItTTSEgYBeCkeOP2K/UoGFa/rrgad
	veAgbSed4K0oBejAz0hioQOSIEly/oel0FddCjKl4BYA0wE+VLE/AwzpcVjFHzV+bEAYMTsuwGZ
	ATO7rjnabBURWBofpQM8A/ZCEnCEBeQnf
X-Google-Smtp-Source: AGHT+IEBpaCODeI242sIP+AcMfTXd1Z+51gSpsbjgQUQQht0K2WifHxuQsjBq8JFYi/VigFtbtGnLlvQoPKX
X-Received: by 2002:ac2:5f63:0:b0:52c:a002:1afc with SMTP id 2adb3069b0e04-52cdf7f66f2mr3244175e87.34.1719234542615;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-424817fcc5esm3530725e9.41.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 495B86036F;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRO-004067-03; Mon, 24 Jun 2024 15:09:02 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/4] ipv4: fix source address selection with route leak
Date: Mon, 24 Jun 2024 15:07:53 +0200
Message-ID: <20240624130859.953608-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
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
---
 net/ipv4/fib_semantics.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..459082f4936d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2270,6 +2270,13 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
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


