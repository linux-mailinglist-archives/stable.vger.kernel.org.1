Return-Path: <stable+bounces-246128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICksEthuA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC7527403
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C92B83145032
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946923002A9;
	Tue, 12 May 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXSl+Fki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563893BB105;
	Tue, 12 May 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608430; cv=none; b=Xp2TejccX4ZideMyIP++VLJEeNa7iUddCb0Q+E7DdSclSRSnJLDcv7Okyd6R120cBX58GBW+QzNERNHwmC8fVEhuJlDKZVcSLJZTqXBrUkRDxkJG+aORfSKO+ziGQlOjguUYftlYpJqXC1HXC06ym7P2fD8fZUYclBVMhbXH7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608430; c=relaxed/simple;
	bh=mwZSUzjdyCGIcWLh+Wqtrt9gPGs9qXQbyj/zZ/Gy8+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7/z/hhgPA75AFa9ABsUd3OADMxM+O9kaj/5/RSnTRpzHvpDOsshlszThilCfqUwE+kDBNnInn6sb30LvIlg7yOUhKpanCX+lU2X42jxVMXsnrIWO/7F0rbVAH/Z6qg+lZibbyARjr0py2hatc6IpPkiqy8TH4DRMZMTLg7Q60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXSl+Fki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE95C2BCB0;
	Tue, 12 May 2026 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608430;
	bh=mwZSUzjdyCGIcWLh+Wqtrt9gPGs9qXQbyj/zZ/Gy8+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXSl+Fkiq5j/wKfQieW7RjmV+id0ki8pnG/U6fZE0hkLBdcbzwWKdA2tZ3h6TrnRU
	 R6xkeBGB4r4WFoXkdm06YdwV4PaFCdgGlZVjsNS1LaKOH9rByzl2hWi0FVMl0uwMrj
	 VWgaNELWcSUPZjwd2sebhswkX74kZBR4IX/EfeQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18 074/270] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Tue, 12 May 2026 19:37:55 +0200
Message-ID: <20260512173940.010011845@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9FDC7527403
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246128-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fourdim.xyz:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siwei Zhang <oss@fourdim.xyz>

commit 78a88d43dab8d23aeef934ed8ce34d40e6b3d613 upstream.

Add the same NULL guard already present in
l2cap_sock_resume_cb() and l2cap_sock_ready_cb().

Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_sock.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1747,6 +1747,9 @@ static long l2cap_sock_get_sndtimeo_cb(s
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return 0;
+
 	return READ_ONCE(sk->sk_sndtimeo);
 }
 



