Return-Path: <stable+bounces-224536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qErPLnVbsGn2iQIAu9opvQ
	(envelope-from <stable+bounces-224536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:57:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75258256037
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D03330EA644
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674A3D88E6;
	Tue, 10 Mar 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+Ftvvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF73D8127
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165282; cv=none; b=RhVYn4XcGWKJ3IySdOiKlhvo25MNSHZ0gifOaE/5mMpJffYn6wvRg0Y92x4kty0253U7pgeINAJgJsCrWDRtmutCFR82iATIe/xE06mmbjgw/TS3IuBz3dG+4EMkLVkzW/IwtSGZpe1eguM9etHz4en9SVOoMMN8XST0+7QjnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165282; c=relaxed/simple;
	bh=tpIcoWuPSsflrFdJ37N7ykid+E9spThfaWn0fNKRhgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfkEPOMU/6C4o1V9Chn6/1aVWijLA85VUX3mI+hN7/Qv6Qg0auUGiXkzKEw/MEH84RZGjSzFoQpb0AhmQj5MboakMBYfrN7gS2jBaMWGLPz5z4AG4HDnvbkGqudVvcw7tmlL3vmh4NaFKPq700QD3uwWXLdBmKsBzlYhXEIZoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+Ftvvo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79801df3e42so2611357b3.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165280; x=1773770080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=iI+Ftvvo1Vq6vn0KL8HprpuN7cBPPNq25MlSL3nsmTaoYutg/YmHGkeQK17yZm1iZZ
         OKwTEeSuOg8fQxnDgIFLvci8O67ASlmQ/+dYJdHgoVZElUSIxy1o7AzSgoU/ns1atoeY
         N/OGLdbG/YbE7Lxz5uABfC+1Somo4m4lGpgwjuFVRBCPsiqcc11O8oj7N5B3SHvvDYem
         4z8laTLMITpbYgS9GQ6W7L7JJgCswGHYWioWbk1hrwN7yDmAiclYCHpAXL8eVyvayPuI
         ZEiyHhVIYEFfhOP2UpZ3WJkbIv2JzoO0RHvlRLaCANNXYvghdDt/F9BXtn/ZQLDSmMyT
         E0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165280; x=1773770080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=oQYUFOcVEPDb7Uv0+30WFObWtu26R4M9JJ1ANt+OtZjqnVFDfc/BZbRgOLnKAaNOPV
         M5hg9TT8PqLb62HnGTj2YHJzkLFcditlMR/slrSHmF46WZBUwptj3B5F/ybkYHxtKf88
         QxS+Ft79FzUmAJkwE8tFAnZBe7dkpFWE5bde3vPnZ969BunGWsm3c1bfZpbxtrAXVjzi
         uRc+MHjsCBT9SMpFyc8KlPTAO1fB761MQzsxtkdv2LCMT33/S5qnCAaI0g5EplFi/ghh
         24kjW7Mo4uhyMlhoTdqW0XjMSjKJ95rw13REquDir73FbW+fuPv0ISCYZ0N80WOUZUAn
         YegQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXp6H880Mn8Kn9UNO+b6LmDy8AiTviN5SDfq9WEjz9kNz9yeF3tlB/47y5++oZhpt4YTWnkIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2VnSJWoDqQk5Z5P1d/BiJo92pvjnuOhJNSxcCOk3SSL5HMyG
	oV7XcFR66pRZxTzr1zGhgbuzjfPAztb1TwxkDcFJeuz+4DK+hVIx0fP2
X-Gm-Gg: ATEYQzxnBMOgHttwvg+iSxdOCUrcTYkBfe93txMuTca7uvEB1Y1NEVFdIdXBjAE/xCI
	V5BG/sOXOBamGpy9VzdO4iaEhPOUki4loKusaeB3ntC1zjoDnQ3ZsE5wlF/q4DZXwG3RGSNYX9I
	jsjXNMwAnAa8vnsj+vzc84qL+eoN8SBx4YCAnKNBMVPEmXyoOfNr3DCbYEdTpPJNKWxw9HCaWgt
	q6EUZZJhVUTZfnyciNOZw0+morgKp6ZY3UURzA+H6tAKh7UBsxw5eQu5Aqt7lRJqhgU8NfbIkq/
	x+ibRmRT3GEN+98NkXvcwKVyRKoiEHPs/jcKn/DRa9V6bCnWWV85qlxJC+zhlDmg/qy4IZvrgBo
	OWCuqBIeXy3599G2cwoupbg1kTDrCT+io0xaGUFgryHlL9IFFqOZZhAdGw/dDgd+Sf5BRpz3I48
	tT78kI7PcZRc5aw3PeVPc7VuRLol+N3Df63mRQuD+c/yruPJ2z9Pb1c8az
X-Received: by 2002:a05:690c:6913:b0:798:5bb7:4982 with SMTP id 00721157ae682-7990a86998emr40492057b3.16.1773165280041;
        Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a676fedsm19799977b3.42.2026.03.10.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:54:39 -0700 (PDT)
From: Mehul Rao <mehulrao@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
Date: Tue, 10 Mar 2026 13:54:26 -0400
Message-ID: <20260310175426.110496-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75258256037
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-224536-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

smc_clcsock_user_data() can return NULL when the listening SMC socket is
being torn down concurrently. During close, smc_close_active() sets
sk_user_data to NULL on the underlying CLC socket before shutting it
down. If a TCP SYN completion arrives in this window,
smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
pointer when accessing smc->queued_smc_hs.

The sibling function smc_hs_congested() already handles this case by
checking for NULL and returning early. Add the same NULL check to
smc_tcp_syn_recv_sock().

 BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
 Read of size 4 at addr 00000000000006b0 by task poc-F362/154

 CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(lazy)
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <IRQ>
  dump_stack_lvl (lib/dump_stack.c:122)
  kasan_report (mm/kasan/report.c:597)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/generic.c:200 (discriminator 1))
  smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  tcp_check_req (net/ipv4/tcp_minisocks.c:927)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
  ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input.c:242)
  ip_local_deliver (net/ipv4/ip_input.c:259)
  ip_rcv (net/ipv4/ip_input.c:573)
  __netif_receive_skb_one_core (net/core/dev.c:6164)

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..bb8966eeb332 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (!smc)
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
2.53.0


