Return-Path: <stable+bounces-233086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IBhJZerzml+pQYAu9opvQ
	(envelope-from <stable+bounces-233086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750538CB74
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03F7E30312CD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A13C3430;
	Thu,  2 Apr 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2wmrbjv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F336F40C;
	Thu,  2 Apr 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151727; cv=none; b=ngJtXDANOYWL8gLPiOBVxUau6lYEcCeXta8VAOt8kNRfCxSCq3AjV4b7ZCRxrsAbWZG5c+cJPsVaNlI8cIOdx002eGwhIsFvQeVjjDoEEfcifnn39O+dVmCrE0lJZQMTMBE5D26HpUly6wYaSnrf25qW54YpRKUlIkQsNC+ogiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151727; c=relaxed/simple;
	bh=A1GzfmivvuhCSCB/nkSJihhA1T5J/EcQFeWiGdMOIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAoM5OYpKAiAAQAaJ47GpOCm0aXcnV673C5iWTFT3MolY4z1d/53cKneBqTxgmavPg0gpwAPOxP3dVO1xvmDE3Gx4LGyVdB1xNLCDl9PUMkQuCYn4LkWbgETy9ul90JCpg21gLDxLtJZLGm/z0vSqt4MikdIO/Bdlk7HwvAh5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2wmrbjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2250C116C6;
	Thu,  2 Apr 2026 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151727;
	bh=A1GzfmivvuhCSCB/nkSJihhA1T5J/EcQFeWiGdMOIy8=;
	h=From:To:Cc:Subject:Date:From;
	b=A2wmrbjvi2aspjTF32LSuFNS82MuDzntfoLqmf/oFFQmggi7HjNi2pzb4Rv109H7d
	 ceWjEdV9CH2mYB0GSVwIktlzDnpIWZCn1KagNwVdy4oKm78YXb/SlHK7Swgx+ZYEpk
	 CoPS6ivA71tXJ+B/AQ6ejjXhn0bdAXyv7sXkG9EeJ4qkFhpwlzLsjnBtvaxbhUPyG8
	 NvAMNLSOBhnELvfTeDl3GYOWLq9vgPoJ4yg6HwOd0ZEfDOJT5l/yLFeg2J/2cAzdmk
	 BErgtxrXYg8q2Tp04ILtrDaWJ/z0ne/c4TbEFo9gP5rRnbC//ECQcWBiFx4IR3f73c
	 RRERWvyfhGiBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu,  2 Apr 2026 19:42:01 +0200
Message-ID: <20260402174200.3474039-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=matttbe@kernel.org; h=from:subject; bh=AwTs4DicXzyi2VlRzLAa8AqUkkfLg1gGpoGeSakWuxc=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPrcrojvkibiIatrz6veT3x8d4dtnt3/h5QUtY8U1JD 4auK2H+HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABM5uoXhf+bhIs+HT/6tvr6B ddrMm+4Mon6cxr9DTDIl1Dt//0iWTmFk+M9Wl3Nwb5yt9LrKoviTYvu713mVSxgF3VXe1LNjZT4 7BwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233086-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2750538CB74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li Xiasong <lixiasong1@huawei.com>

commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229 upstream.

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260319112159.3118874-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm_kernel.c, because commit 8617e85e04bd ("mptcp: pm:
  split in-kernel PM specific code") is not in this version, and moves
  code from pm_netlink.c to pm_kernel.c. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 634fe0360c49..03e9a861140c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1042,7 +1042,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct socket *ssock;
-- 
2.53.0


