Return-Path: <stable+bounces-246623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKScOUVwA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F25277EF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AA4D3170203
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481E36CDE0;
	Tue, 12 May 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EtSlAl56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863D36A378;
	Tue, 12 May 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609697; cv=none; b=gy08uaHOMbkS5BA5/nQE22+GMl23ju6mhJLq+46ik6k//svc01kCW0RsnpxA1cAs7jHGh1zYXXJyqAS/nQ7ga+ipEaqU/6a1j2FB5LJtplpesHZ7ATKjxFKuKOeog7s62VDhD7h/J2CNXSikCwDnz4Sk/jieoaO/ECFIynyGJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609697; c=relaxed/simple;
	bh=DaxzpXWFaTXdBHKNnmpzZxzQvS2OznJGnwgJx4C8g2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXh7ZvpoTa5uIq1krZ3LC+TDl0vRyidHjgEsrcjR5Rr5cjMEwBYF+KxXNMm1b6ACj7XmBWPAdbxG8j68jXKCogusIBKzzJxB0O/8nGqV8Ls+VZ9qRHisov3oHNbk9P3teH1GKY7kGBfY9L18Lae4OQDJomu8h2BledSDsCQ8VPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EtSlAl56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D3C2BCB0;
	Tue, 12 May 2026 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609697;
	bh=DaxzpXWFaTXdBHKNnmpzZxzQvS2OznJGnwgJx4C8g2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtSlAl56MlytEsd50jaQbMJjo2dpDLAkRoe+vvZZ6UN3AupJnCQ5odYJtcXx4cTgG
	 A+o8UiGF0QI48qvcHcinPxKqurm2zAs9MAMmagx5sI163uTRWVpKUAqCbgK0fyiSAM
	 yCPSJvBnSmeMNPTKEbxFj8EePwibDsM3hKMmHuKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 255/307] mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf
Date: Tue, 12 May 2026 19:40:50 +0200
Message-ID: <20260512173945.508274717@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9F5F25277EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246623-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 70ece9d7021c54cf40c72b31b066e9088f5f75f5 upstream.

mptcp_setsockopt_all_sf() was missing a call to sockopt_seq_inc(). This
is required not to cause missing synchronization for newer subflows
created later on.

This helper is called each time a socket option is set on subflows, and
future ones will need to inherit this option after their creation.

Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260501-net-mptcp-misc-fixes-7-1-rc3-v1-4-b70118df778e@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struc
 		if (ret)
 			break;
 	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
 	return ret;
 }
 



