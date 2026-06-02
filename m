Return-Path: <stable+bounces-259810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sNpxJI7LHmreVAAAu9opvQ
	(envelope-from <stable+bounces-259810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B562DFFC
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fw+/GaxQ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259810-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-259810-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B63030EB306
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BE3E9286;
	Tue,  2 Jun 2026 12:15:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63A3E2AA1;
	Tue,  2 Jun 2026 12:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402526; cv=none; b=Hs2wTyI3NbKtnpyug6x6OeCHEHdNivuqPSyY5IIv727Vtyrq4ynIvk0RptJC9CdToO2XKehZawDQYt6Co7fWls+cNh8w9NaqXZJSBA9YzROXauB4oQhKyOEiZqerR1mV3ejhDcEkPvsMksbf91seD4pg9JluMxM+wzOZMz262IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402526; c=relaxed/simple;
	bh=RT/E+puSLaZidPDXPx3TDleWNistOBZUBVAzhbx9FHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0OSqIUm/93R8Cx5oGBlgF//aA7DyrjrqKsJGU1IfXuQ7zdEQBkxwNsoVuQ8rkHkYGoUkbAqvmywRs5U11Zk9GNzQIJYp1koFlnYmATb7qYYKjC6DkiUXXlNeljYXFo+bJ12dzttl6KY1HCH2mpVQ9Pjk9S/1Sh3T6ejmAwC+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw+/GaxQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82B11F00898;
	Tue,  2 Jun 2026 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402525;
	bh=TE32s63FN7oiWP8Km/xUybIoPrIk9f292PR3zY9E4mU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fw+/GaxQtuYIpWxX3I/RDuwiT7bFVE91FglusPhnm3c0p9VT7lSs4UWjxkax8U4ho
	 uwR4KYz4nXz3viQ4GZWeOJd2AFVSgQkzb1CMhiLsykCkQqru8gcsWOCMBcMU49japJ
	 T0VfIEN5NvO9XNXNBvwB43QaC0Gh9Okn/xC64qgdn6rviAh2uHy0nUfybYeRdT0fOJ
	 57NORM7XT6ut1Ze0mdJKjxm8vFWuDhtm7p2cv8t4UcdOURGPmFIQOA+lb/eBhwWzhL
	 LXYrQE8+iX8lHjrUHyMvDfnuPqh61xGo+tAVnpQ0GREpkAxReh0De/X4sXwJEIIL3r
	 8+wcVkR8wKxWA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:16 +1000
Subject: [PATCH net v2 09/11] mptcp: check desc->count in read_sock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-9-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ouh+8y0QVk20uitc41ZjPExokNTNSrOLDbO4PTnW4No=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksWaN6ilIurzO/hzZnxWVCBztHQP9abU+aP
 VsA0Ku3xkGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c9NVEACJqfhJ8a8FwMXrvsNBO8w7ZFgf8zsdFqFFpgI1NRT8vP49DA6Fk80dqB+FRFsTL76HEIO
 TU0zXRH8FWEplaE6p0TBVeh5Shc/L/E4JzMW5mZ8vUDo83EoD2X1TzEqghf5CvB0X1ZjcOvmnVb
 xgohauG4Q1YNbFXRlTHvRteTN2AO9oqbhgePaT0ZbEooirgHh2ibmFcCEsS73oT35Zgiod7ShNQ
 ilta6ftCuBwmuST/XWn+dDA8gtx4JNq0zwDBJaKEhQnJUAc/+99INlFk+q0R+WsmyfdROhCF5gg
 spQF9sBHJV7DHP0EQygZAJE5oDNyOMM7M8DKc217nVDJWVx2BemiSks9AZWDH8jkk6q3lRGJoU1
 tzFXMkI6B5LfVaa6+XC9aUo4nSa4H2/dRBzkbJpAeghgFGcwidRhMTyiFPy3eXMh3MTy08zEoEF
 slLRS0GrqQhGfcDgS8Meq2FdDjEpWazzjzY3R84u2dUxFi4Rg5igMAjv7AxiJtTVQJYQ7o91Kjb
 DPRfXLmCpO692BF4Zop5ckuam0rCg8zYy8c6MRV8fvt4IH7mbwW4GtDG0IoY108jZNtdys2KB9z
 zmZ7bFR9VILUS5Hoov5Cfsfv6v8XWtN9Evb8uTOPN3lc7kycH5E3z1lk/Hq8Qs4Wn6yJ2syrR+2
 xciUqmm6fg/O5Lw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:matttbe@kernel.org,m:yangang@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-259810-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F17B562DFFC

From: Gang Yan <yangang@kylinos.cn>

__tcp_read_sock() checks desc->count after each skb is consumed and
breaks the loop when it reaches 0. The MPTCP variant lacks this check.

This is a functional bug, other subsystems also rely on this check:
TLS strparser sets desc->count to 0 once a full TLS record is assembled
and depends on this break to stop reading.

Add the same desc->count check to __mptcp_read_sock(), mirroring
__tcp_read_sock().

Fixes: 250d9766a984 ("mptcp: implement .read_sock")
Cc: stable@vger.kernel.org
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7fac5fac2097..cb9515f505aa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4428,6 +4428,8 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		}
 
 		mptcp_eat_recv_skb(sk, skb);
+		if (!desc->count)
+			break;
 	}
 
 	if (noack)

-- 
2.53.0


