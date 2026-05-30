Return-Path: <stable+bounces-258227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBClNTokG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E76109AF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1F6300145C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98383546EA;
	Sat, 30 May 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAj8CQGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894133AEB5C;
	Sat, 30 May 2026 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163640; cv=none; b=ruryK+A4i/Nyrh26tG442NofCdxaqeM6wNFM5dP2Gf/T3UDH56PkuJW4YJaGO/BfhNXXzdNKD/N/r1JM88Jli4LfGHn63fIiBOFnl+brILbA+ZSiPE5DGuJLAVTflCyMDioVcRKgVXmCCy3iJx/NOhTQA411LafBq9tvjSJSgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163640; c=relaxed/simple;
	bh=BLBYhwd31pcSv0NO9MJT1WEJjzooQv41JYMZwQywK6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b23JPJCv3B3fpVnD73Jp6AuFrOJHT8h9RZRhOzWMA0SQGLwUtkQmBYzYmd9biOTzGwRbcneFZfV5CHZBLx7zw41aLES6eWzs1zaIs/5iKxKE01ln6edFzpoiuU04QPeLmrxQ1JOt0XF53iGTYbH0IxDbhKu8hARv+OUZSeMoXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAj8CQGz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBBE1F00893;
	Sat, 30 May 2026 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163639;
	bh=BRAbv0Wb6XI+/2qMeG51uhjE4oZMFkGKybUpkyoGQJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kAj8CQGzJXvht8r9rwUh9HaJvbMBdhnp5mhGSemG6RRZo36beuOMXwZ2tgee4rn3e
	 NklAX2ZsT/AI76XdN4Q+ELcUKh6hZVttUri5EF3b4xKWs/SncYUmUBVR9Aft00hNUa
	 NE5ozFIhv2R/rb/YZx0+o23ug37CIkJGBjIl0xVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dexuan Cui <decui@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 318/776] hv_sock: fix ARM64 support
Date: Sat, 30 May 2026 18:00:32 +0200
Message-ID: <20260530160248.786808857@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258227-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 747E76109AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

commit b31681206e3f527970a7c7ed807fbf6a028fc25b upstream.

VMBUS ring buffers must be page aligned. Therefore, the current value of
24K presents a challenge on ARM64 kernels (with 64K pages). So, use
VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
hold all of the relevant data.

Cc: stable@vger.kernel.org
Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260428125339.13963-1-hamzamahfooz@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/hyperv_transport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -366,10 +366,10 @@ static void hvs_open_connection(struct v
 	} else {
 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
+		sndbuf = VMBUS_RING_SIZE(sndbuf);
 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
 	}
 
 	ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,



