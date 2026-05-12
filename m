Return-Path: <stable+bounces-246192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOP1HmlsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F045E526D0B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B173238650
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF63EDE59;
	Tue, 12 May 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FDbnsW+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123423EDE52;
	Tue, 12 May 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608595; cv=none; b=n7LSdkr/vYagETnTiE3v8KKHpY3703XdMy2xNyHgCI7FTGUPYOe/RdF8iv9HeMiO2KXMqkNu1lCJFIfYmCn0w+Y5mnQ1kvTFQnP8x4HLOoo1WmSn2sPx+G6ShRq2+YZ950YGLU4Skznj4lgPlfKKJxonezoA0rkKvNlzIcXhG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608595; c=relaxed/simple;
	bh=RZYMRUlSXTMUgujfV2bBWnvuzxZgjz+sxSJrajCh4bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2VApV6hHxgssOxRHvQpY/EFX2DB8VWzyafszblVUtBdzg1/rd6ys1hFJ3lcp2g/GWQWUCHtVz2bhH/gblQUOJAUdk6P9mYU84il3IzSpOiA02VZoq1NOwD9b1Lk6Ix76omNt0SpNrptrcoUJ/xNPjByObqVQeyWDMGy3XGwi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDbnsW+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D823C2BCB0;
	Tue, 12 May 2026 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608595;
	bh=RZYMRUlSXTMUgujfV2bBWnvuzxZgjz+sxSJrajCh4bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDbnsW+4fuuocb+QL8S9SEcpvU/eqCL9G61KuuO336WUj7DiR8bdzK+b8QoK97VMj
	 RMXxjb7U5Ek7rUE/BUV8tpqo4b/o0fRzvXZYFvShi5EndN7sxJ++iR/llzClLOQDXa
	 xbh8VdQUE/BwEjAIfh/Hi3h9cSNqEi6Gq5UoLS8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Hillis <Ben.Hillis@microsoft.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 123/270] hv_sock: Report EOF instead of -EIO for FIN
Date: Tue, 12 May 2026 19:38:44 +0200
Message-ID: <20260512173941.045478431@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F045E526D0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,microsoft.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-246192-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit f6315295899415f1ddcf39f7c9cb46d25e2c6c6a upstream.

Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
and the final read syscall gets an error rather than 0.

Ideally, we would want to fix hvs_channel_readable_payload() so that it
could return 0 in the FIN scenario, but it's not good for the hv_sock
driver to use the VMBus ringbuffer's cached priv_read_index, which is
internal data in the VMBus driver.

Fix the regression in hv_sock by returning 0 rather than -EIO.

Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
Cc: stable@vger.kernel.org
Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
Reported-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260416191433.840637-1-decui@microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 2b7c0b5896ed..76e78c83fdbc 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,7 +694,6 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
-	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
@@ -702,9 +701,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (hvs->recv_desc) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet: see hvs_update_recv_data().
+			 *
+			 * Here all the payload has been dequeued, but
+			 * hvs_channel_readable_payload() still returns 1,
+			 * because the VMBus ringbuffer's read_index is not
+			 * updated for the FIN packet: hvs_stream_dequeue() ->
+			 * hv_pkt_iter_next() updates the cached priv_read_index
+			 * but has no opportunity to update the read_index in
+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
+			 * 0 for the FIN packet, so it won't get dequeued.
+			 */
+			return 0;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
-- 
2.54.0




