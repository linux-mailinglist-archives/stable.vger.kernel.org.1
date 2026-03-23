Return-Path: <stable+bounces-229422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQCDANiwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:53:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636812F710B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA5D3261E2E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98F3BC68C;
	Mon, 23 Mar 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgVTDd94"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB13B3BE7;
	Mon, 23 Mar 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279196; cv=none; b=dp0JeyLtJtQOfxBw7RMN4ePxC7AtWojqerHWERIo8cvPJasV9DNek/PlPbs0QXJAUanduVYe0WWpZtRzJwEb8FHbP8/z10WgwRmwqvDB2Qzp2aInjiKEvVC7dg+88Cs83dwMG+b9ybOlM7ZABYgK+nBbfkYO9RRWB5MmIjTXtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279196; c=relaxed/simple;
	bh=Ui2lZ3iFeRpDuZNkC4pkn3VdJClzjbXDYhMmQNuVMLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+BlycvhfIt1ElJfYEOhw/9T4zaqOGLKNTiIBNOzDvtozLGWV3488nqoDzH14iSfBZ3QApsZevH9VYIBC3r3ppNIlIjn5vd+OHRuW7UoCo1Bn7JlGj+5IOaEEHUx1vLd2R30xOTW6LqjldJ19beEZKC8zSzkItW9YHzQ61ViDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgVTDd94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2202C2BCB1;
	Mon, 23 Mar 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279196;
	bh=Ui2lZ3iFeRpDuZNkC4pkn3VdJClzjbXDYhMmQNuVMLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgVTDd949RirQoI+tH1EvUW28FSb12iWLHYf+jk2PiQdLSCjw+ubZDIFfv4DnZH83
	 UYdm0BIdSFXIOCaVqTXCxuYrK5SeKEgvpbA+9Z1dnWwm37cNu1ISndjWE8D2WJsgZy
	 TaqqgSsRgulknpXyhbojNYwWYDwbCldvmTTl5jvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 505/567] Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy
Date: Mon, 23 Mar 2026 14:47:05 +0100
Message-ID: <20260323134546.514509098@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229422-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 636812F710B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Eggers <ceggers@arri.de>

[ Upstream commit 0e4d4dcc1a6e82cc6f9abf32193558efa7e1613d ]

The last test step ("Test with Invalid public key X and Y, all set to
0") expects to get an "DHKEY check failed" instead of "unspecified".

Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e7ee13fe83a74..62c8eab1b84a5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2744,7 +2744,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !crypto_memneq(key, smp->local_pk, 64)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
-		return SMP_UNSPECIFIED;
+		return SMP_DHKEY_CHECK_FAILED;
 	}
 
 	memcpy(smp->remote_pk, key, 64);
-- 
2.51.0




