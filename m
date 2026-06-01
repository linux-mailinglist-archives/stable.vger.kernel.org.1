Return-Path: <stable+bounces-259431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOmuCab4HGqJUgkAu9opvQ
	(envelope-from <stable+bounces-259431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 05:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06616191B7
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 05:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24535300B47C
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2D280A51;
	Mon,  1 Jun 2026 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7+YuXA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CB24A06A;
	Mon,  1 Jun 2026 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283483; cv=none; b=P6d53FJfsXzeboE6cDyhUaPZjMzvdZE+9JZobgVd076tRzoc+EXteTqJM+9ozapyVKcIEihRIOoN2SgY/JIxJ6ll9LaZt+zuG9/yeyTszGoTQjTNfeY/piqtB970QrRq3CMTM2xj0Q0+CqWB2W8NOD9nRtNxXrkWLGiMW57+pv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283483; c=relaxed/simple;
	bh=RT/E+puSLaZidPDXPx3TDleWNistOBZUBVAzhbx9FHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sH0rwjveHFwpvb0eCq22i2pQHCTMT0uvrXNIx0pZzTzUPlxFRzfM3ZOX3dpvxZ5RmQfi8FRrlvfRy/rjqUUzIh7prUIwfHyxgCIVc245bQ4zBjpB6bNVneTBXDPD/E9EPMWvRJ4OjD68bfdvaxeoVTneKqXHyFjBGGKH+vByxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7+YuXA8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACF21F00893;
	Mon,  1 Jun 2026 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283482;
	bh=TE32s63FN7oiWP8Km/xUybIoPrIk9f292PR3zY9E4mU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D7+YuXA8/hANe0DEyFcvVWJ4I1LUJ+VsGacyuy4Gg6aF7u0B2434LWnlieWx6Z0On
	 4A7xUOVqrTNH8vlYGZbfeKPId1vR98jVaLCaE6I5y9wnZ1PF+MWhAKu47iidaKMWA3
	 vuJOzdG1vcMFT2iIaq3Yv+DboU5N6GJ7KEqnifPiwBUXkLeV5P+2HjDFmDkymEHf5N
	 VSGSGPMHwnDZvVFrBDTK44r/Sg/nlThYA9PJGJzNpfOM69cxKh47k50t0mIhmDnWqF
	 hg4KDHUP0jzRrclwlEFjghJkYJsiuNOInU9hoJjEAHuGe+5J+Roi7kWvNbXIMkvDE5
	 17I3FAaMvYiuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:06 +1000
Subject: [PATCH net 10/10] mptcp: check desc->count in read_sock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-10-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgfPWYM9vCBC658ItD/tsv5LQUz+/8nLaps8
 Z6VvIX3bz6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HwAKCRD2t4JPQmmg
 c/T2D/9NKT/NKw81WzfQsMRXmA1ESwXdsFG3H/6mCVv4zqskxlBEkJLebZQOGopVl8adzJ3Pk8w
 +kjBEUh/Q+eLkKapvvr7lC/LeM6Wet34dIhx7HMuyYn2JVDqUWBETfwiB5WiU3uAor1qo6dJf//
 d5bf71N/LG0m3FvcamVvPJoYZMxxOVaqdWhwAlGICdvw0eLkeUjdOe8kijaFAvTsfnn96T0pFV8
 4hTTCvVvVZiSDqE9HiSuPkdWgSoO8Y4OsjE563Jx71q/Qmu2/V6R3ouxS3BQ8oxo4sHfX61PIrG
 Lrk2NOzXU71R+Qj87RvVwUxUz1U+w5b3qDo2sVK4xgdN42Z9hnMwWnY6n2wvGMycUmlwy51WehF
 +fgqbeYRSKFm5p+Bel7JV6MphTOk7HbjxwTchpn8sdq7oXb9b3WoAPpEdvW3mrtvbMeaNw/MqtV
 TbvRDGtaQvFdRCMWG6/v3UTcxA2hqiu98uk62I1LhkFEIr/dnBmKNgZUcUy5VZtdIMTznDwga06
 xqPqKr9rtTHY/czXYZLAeAYmhRFK1i5kEWFD0oGONdqnqJb9G3/YsgzBng/i95HA3mG90rUhIXH
 st9LD6bv7OHIdoNP17U6HIyeyEexsqmGZTja7Si+qoHJPUCCVBAxx6LB7JBY7LyAzFwRzKnQm7J
 Eu9Vz0tSwFwFAjw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259431-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: B06616191B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


