Return-Path: <stable+bounces-47968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52C8FC1D2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 04:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D96B226D8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6F38DD6;
	Wed,  5 Jun 2024 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CObOUJjl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57D61FC6;
	Wed,  5 Jun 2024 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554573; cv=none; b=lbEd/sHx1KI+fK/hS8CLJ4GemkCpEu4pJnaWoOaTzD/7WstheSaV6HBnrF1oKa7m6TzWTvXSZVH0n39vkp6FeuEv2KgnrQFY47+kc+ehS4YSbsnZbdWQXIFyNgb0v04RtsLuojJbLCjAHfdNguEEBBw61Gayg9rOV6CpyJd5JfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554573; c=relaxed/simple;
	bh=MGZTnPwwfwH9nId6Axtqz26zfs1RL57VKult57Ki1cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sl3O2n7EA1e3ejCfoi99w6rVfCFqaIYLcIX2p/ZhaREVkn68SVpRhxuqfP5YDJayj0wqXf5F8+GXk/PX3yyygUTs/rafUzYeBYh/MVm0WRjrnnf8UroRqlPiI924eMf610VXx7dUj7T/Ld7Agv7qZJ6Zo3ZJDegqiZMDIgvAMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CObOUJjl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c284095ea6so99937a91.0;
        Tue, 04 Jun 2024 19:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717554571; x=1718159371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RA8N3xOBtdFnF4yqjReJeQ4Rlub96BDXBYIzJsytfmI=;
        b=CObOUJjlpaY0/1XqqgiUQIzNsCtclyVImv8pf18voicDZS0chEvDno8p4ObdOBt98H
         BlTOXcjH1EGRLBa91DMtWXBoEZ44hpgQ1UsMthGVrOuqPBoU0qJS5K+Z+nbOyHgXIxQU
         07EqVuRHXhbisJf+t3sUwiSBASc8DVw5Qmt76ni3WQ4ZICj9IUuJejswWzJrLr9AMuZ5
         ZIzRl3JoyF1WTIu5UEPWEW/t1D5jEPpjKc/aczo7vrkFMN/Bi2NXg6hz0WPeHj0r5J8G
         OI4KXXofZzoOVJvgU9dE6gmAfA398lTo9mC1HOdEpl0DLnTClowfTrrlv4z9EkOMziMO
         hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717554571; x=1718159371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RA8N3xOBtdFnF4yqjReJeQ4Rlub96BDXBYIzJsytfmI=;
        b=p623RaVIg+SwhpXQ5N4l5BskYP0DjRNrtl9dp40ODkxf+i6qxonEGkfKHbQQze/XIi
         f5IbD20zpUCSZRJFRVByb9pcZotoya6dt9Ul6Ucf8IWfWpR6b47z8QSrbQeSvFbyZf1H
         91MP1pdmFfcx+FhDFMN6qoAisBmOpdPkEBYCxCD+lRyNzWcLyfj/mqMoTNkX1DUtlDPa
         zVKslEQPTis1cSWy/p/1DOLS/gR/ujv/iWqduAuDt4C7rFydFAxDNv3mAJvYZz1XeymC
         gu1ybZdyU0ovX7rn035Z9XUfdjtFDa/P+E4GXjWCXPDe8P9FR6QzpHSTgtaJxtoPsPp1
         YFjg==
X-Forwarded-Encrypted: i=1; AJvYcCXMkquh8Xg5iDLhEwafBmGObpEJCxT+LweXYq7xZmZm39Wl8rvdvOB+0rF+VMR6l1mi42MkQlON/UHc9SVmHCHFYEHL5B8oqvFasCeB4kKipxn5IKVZVdUEsrPeRnDF883B+7rm
X-Gm-Message-State: AOJu0YwKh3nUhAppIDQatG99HRpjOcu7JwFTO8ZSRT6laIXGnQzeUJYq
	pXXTQQHHAOlBTtR5y7FC+pmhnXl850guPwB6/tjd36ONx3vppEOHu5QOtUlH
X-Google-Smtp-Source: AGHT+IGa9p2H6aINUCNgpshF7BdrKX9fvyuZVmxk4LegnukU52d/xXmeuDiv9VFqUd3V21av5+4Wxg==
X-Received: by 2002:a17:90a:de98:b0:2c1:c581:8eae with SMTP id 98e67ed59e1d1-2c27db00387mr1359340a91.5.1717554571110;
        Tue, 04 Jun 2024 19:29:31 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:6811:183c::26a:4f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806b2f9fsm258728a91.51.2024.06.04.19.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 19:29:30 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4.19.y] neighbour: fix unaligned access to pneigh_entry
Date: Wed,  5 Jun 2024 10:29:16 +0800
Message-Id: <20240605022916.247882-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

[ Upstream commit ed779fe4c9b5a20b4ab4fd6f3e19807445bb78c7 ]

After the blamed commit, the member key is longer 4-byte aligned. On
platforms that do not support unaligned access, e.g., MIPS32R2 with
unaligned_action set to 1, this will trigger a crash when accessing
an IPv6 pneigh_entry, as the key is cast to an in6_addr pointer.

Change the type of the key to u32 to make it aligned.

Fixes: 62dd93181aaa ("[IPV6] NDISC: Set per-entry is_router flag in Proxy NA.")
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 include/net/neighbour.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index e58ef9e338de..4c53e51f0799 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -172,7 +172,7 @@ struct pneigh_entry {
 	possible_net_t		net;
 	struct net_device	*dev;
 	u8			flags;
-	u8			key[0];
+	u32			key[0];
 };
 
 /*
-- 
2.34.1


