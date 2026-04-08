Return-Path: <stable+bounces-234160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L+cHfSb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:18:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308C3C061D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2453A30421C0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A93859FE;
	Wed,  8 Apr 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OPqIKCcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C11A683C;
	Wed,  8 Apr 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672139; cv=none; b=XJpkaApR+ZD0IQGGVLa5j03lqo5L23wWAOOPQSUxI+pnzkWtkyv9goJ2qz1bdeVFNwVxf119ZWN/2FftN7fCH2B//tAPhlcOopdbCKEi33iEkk93UZF1mvylPvPBxQCEvFd9OVO8deLcmROjWyd7UcbJ7ecNm/fnc5wSYFtPTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672139; c=relaxed/simple;
	bh=1OKxzee3U3LF5QAs1vFUpb5UF9oIKIREkYiHRSiqQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQIe79IrtK8z+0TQWRUtNM4ZYpjHTMmzQNyuNko4Vlsksw8stMICiiJLi7s42SXLuS5D9T809OrzTe0B8acHUt8tVfCHvlh3for1bdkI9fsVV003OgO8ax0izwWbkivwtLFnvUegQ5+cCCwp50dZj4mKPCQdyIDyzc4RVfWT0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OPqIKCcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C0C19421;
	Wed,  8 Apr 2026 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672139;
	bh=1OKxzee3U3LF5QAs1vFUpb5UF9oIKIREkYiHRSiqQRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPqIKCcKkaXbucbEhZy5rjSPEUo50UB6DuaCYn3/UyfaUUGZ1VJfmTFNP0TfZ/Jn+
	 CLIlPzFgxXTJZrQp1VCM1rWpjW7Pk+JBFwddROeeK3/B3pX1lDgWEy6Gn6FUpTJZiX
	 2o/5nNS4BpOT9R80tyxKTihQpeg5lUK4SJ/h7kH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oleh Konko <security@1seal.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 205/312] Bluetooth: SMP: force responder MITM requirements before building the pairing response
Date: Wed,  8 Apr 2026 20:02:02 +0200
Message-ID: <20260408175941.417323693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,1seal.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1seal.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0308C3C061D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleh Konko <security@1seal.org>

commit d05111bfe37bfd8bd4d2dfe6675d6bdeef43f7c7 upstream.

smp_cmd_pairing_req() currently builds the pairing response from the
initiator auth_req before enforcing the local BT_SECURITY_HIGH
requirement. If the initiator omits SMP_AUTH_MITM, the response can
also omit it even though the local side still requires MITM.

tk_request() then sees an auth value without SMP_AUTH_MITM and may
select JUST_CFM, making method selection inconsistent with the pairing
policy the responder already enforces.

When the local side requires HIGH security, first verify that MITM can
be achieved from the IO capabilities and then force SMP_AUTH_MITM in the
response in both rsp.auth_req and auth. This keeps the responder auth bits
and later method selection aligned.

Fixes: 2b64d153a0cc ("Bluetooth: Add MITM mechanism to LE-SMP")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/smp.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1817,7 +1817,7 @@ static u8 smp_cmd_pairing_req(struct l2c
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
 
-	/* If we need MITM check that it can be achieved */
+	/* If we need MITM check that it can be achieved. */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
 
@@ -1825,6 +1825,10 @@ static u8 smp_cmd_pairing_req(struct l2c
 					 req->io_capability);
 		if (method == JUST_WORKS || method == JUST_CFM)
 			return SMP_AUTH_REQUIREMENTS;
+
+		/* Force MITM bit if it isn't set by the initiator. */
+		auth |= SMP_AUTH_MITM;
+		rsp.auth_req |= SMP_AUTH_MITM;
 	}
 
 	key_size = min(req->max_key_size, rsp.max_key_size);



