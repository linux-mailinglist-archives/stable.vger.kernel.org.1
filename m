Return-Path: <stable+bounces-10722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCF82CB59
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A11B1F224E7
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292B63C3;
	Sat, 13 Jan 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfeOoK6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE852C8DD;
	Sat, 13 Jan 2024 09:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC0C433F1;
	Sat, 13 Jan 2024 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139911;
	bh=bRLdzc3iWHnD3YeEawBhUpV0AOe3aB6Egm0IgD8qZjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfeOoK6L/piWVmo2wJ8qaIHkyP05lgCi+Q8+Sv9TIb28/1uhDfh7fh+EDXZkBsrRa
	 A+cVRmhTM63IraPRRcf7nhCO0DlUlcmx6v85Hry1kmcKhUvFtI1PgNbB+4I31NGliZ
	 Uotjfi1D7iG83JSplbSc45LsmH4rwxTFsf7JIajk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 09/43] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
Date: Sat, 13 Jan 2024 10:49:48 +0100
Message-ID: <20240113094207.231546964@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>

[ Upstream commit 7f6ca95d16b96567ce4cf458a2790ff17fa620c3 ]

Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
sk_setsockopt(), querying it was not handled in sk_getsockopt(), though.

Following remarks on an earlier submission of this patch, keep the old
behavior of getsockopt(SO_TIMESTAMPING_OLD) which returns the active
flags even if they actually have been set through SO_TIMESTAMPING_NEW.

The new getsockopt(SO_TIMESTAMPING_NEW) is stricter, returning flags
only if they have been set through the same option.

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-berlin.de/
Link: https://lore.kernel.org/netdev/0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com/
Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index a069b5476df46..9c3bc24bfdd1f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1383,9 +1383,16 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_LINGER:
+	case SO_TIMESTAMPING_NEW:
 		lv		= sizeof(v.ling);
-		v.ling.l_onoff	= sock_flag(sk, SOCK_LINGER);
-		v.ling.l_linger	= sk->sk_lingertime / HZ;
+		/* For the later-added case SO_TIMESTAMPING_NEW: Be strict about only
+		 * returning the flags when they were set through the same option.
+		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
+		 */
+		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+			v.ling.l_onoff	= sock_flag(sk, SOCK_LINGER);
+			v.ling.l_linger	= sk->sk_lingertime / HZ;
+		}
 		break;
 
 	case SO_BSDCOMPAT:
-- 
2.43.0




