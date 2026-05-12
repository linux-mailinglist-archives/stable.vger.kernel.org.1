Return-Path: <stable+bounces-246181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH/mJj5vA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C852751C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80620315DF50
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208783955F8;
	Tue, 12 May 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXK0sPOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3F3ADB9A;
	Tue, 12 May 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608566; cv=none; b=gjVC+KfiVsnqa7VVX7L3o3Bgi1FnhogHS2QO8CHirk7RfYulkpB63y0HxZWaSEHYTWkInzvloBs2SrYSqNX6Tc1zuOFq2S8Uldx6VqkTvek404nChCOrbPH9vBJFtF0zaCFzK5zmVHJVvpLOz1MomtWFgpBSxLfhyYoSdknUHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608566; c=relaxed/simple;
	bh=b6FQaytxvETOQKhGJEM1U1BWrSjzwEyixYgKaw9wv/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoUOx7FMuKZ6MuDY32UHpEtq3whiHSoD2LUeu17S6gZyRwafmrCf12QgizVJJfvIEAJV3N00cIHP2wMeWf0doM9atrGoJ4CC2a1OddYhBj3z3BicRP5EYxw35FTuhlJI20eussqMegiP1AvUBGMY6hzBVRiqJ5aJgVgEdphYx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXK0sPOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC1C2BCB0;
	Tue, 12 May 2026 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608566;
	bh=b6FQaytxvETOQKhGJEM1U1BWrSjzwEyixYgKaw9wv/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXK0sPOu1G9cS+JSxpL0rtkzjZLkwsqilpwSBOGz7RLfliDCtvXljOQSvyqQjnbaQ
	 cooTYXTFNHNg4fGvtFJGJQAK40LqRnes4MAc7Je9Jyv5vwKS66eNPHWwslzAhz+gjW
	 MXuxSmF0yzu7fmxyyC5L4ctwWdNqmY5xDcz7LawM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dexuan Cui <decui@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 122/270] hv_sock: fix ARM64 support
Date: Tue, 12 May 2026 19:38:43 +0200
Message-ID: <20260512173941.024890319@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 375C852751C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246181-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -375,10 +375,10 @@ static void hvs_open_connection(struct v
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
 
 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;



