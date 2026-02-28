Return-Path: <stable+bounces-220408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMXzCpFIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 662AC1C79C7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CFF731BF7D3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489633AF387;
	Sat, 28 Feb 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaBXCobQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECA3AF380;
	Sat, 28 Feb 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300300; cv=none; b=SHUFOX2pMGQs8i7Pp8zSsXpNfDkSbbQ8MxvOSiWKnPXG1tK7zYWjecmBcoH0Ea13ZBIQBHKFZDpiMXfsyn5rYoB4T9JFcF5ky273EyGYQ5oqgUwP9QJOprlDos/tvQPedTU82LplzF+ZqKxf7SS6MMJdRJVE7FPl5ckvricwNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300300; c=relaxed/simple;
	bh=cpgrSgAkJnKPCIz0KN2av2PGQbA/IqX1Sa5PRbhWHEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNfu2eXcvhKfXBpSkabBriFBQfDccLjNu14hxPGvv1JjZYHwy0gCotnoAYWj64T1p1IOpfQsmcAu5plftVfa0AGbWvAb8XB3CThxXmHjWF2DXWLitn2t89Xxs7WEt3B01BkOoPfKpcz/g9SiRBqM0mT3h9G/5H3JFpVKKZr9CHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaBXCobQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AEC116D0;
	Sat, 28 Feb 2026 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300299;
	bh=cpgrSgAkJnKPCIz0KN2av2PGQbA/IqX1Sa5PRbhWHEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaBXCobQSqi5aj/zbV9lHB4uZnFU7zoKtUTGboABiRkvF/pf09+tZSZqLNOjk936f
	 6asvcNwOezqcS6xzRqsU9KNd2gdPSlloSru1P6CIwNfFvbcH6t62qNUOd9AMtrLyaW
	 EteMU4Am19miYNgpHWmvd95cgTFsY/M8SCxd9xPm+i6Tibz574k5zrVESI0n0uTpHM
	 +8N5e7rTDKDKZCI94M1EkNe/O5OgXrKy2loSOZTar8iEctgZ4dCd2y5dzuEhf8aIDl
	 YP5MpOREGmmI7owA66sRKJBJJmB/hSoRbPplasMf+TN/hlPBOxZ2a2tP7cqtcLuMwB
	 e/CMPeIacKZ0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 329/844] vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
Date: Sat, 28 Feb 2026 12:24:02 -0500
Message-ID: <20260228173244.1509663-330-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220408-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 662AC1C79C7
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e25dbf561e03c0c5e36228e3b8b784392819ce85 ]

The gcc-16.0.1 snapshot produces a false-positive warning that turns
into a build failure with CONFIG_WERROR:

In file included from arch/x86/include/asm/string.h:6,
                 from net/vmw_vsock/vmci_transport.c:10:
In function 'vmci_transport_packet_init',
    inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
      |                 ^~~~~~
arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
      |                 ^~~~~~

This seems relatively harmless, and it so far the only instance of this
warning I have found. The __vmci_transport_send_control_pkt function
is called either with wait=NULL or with one of the type values that
pass 'wait' into memcpy() here, but not from the same caller.

Replacing the memcpy with a struct assignment is otherwise the same
but avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Bryan Tan <bryan-bt.tan@broadcom.com>
Link: https://patch.msgid.link/20260203163406.2636463-1-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d664..aca3132689cf1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 
 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
-		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
+		pkt->u.wait = *wait;
 		break;
 
 	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
-- 
2.51.0


