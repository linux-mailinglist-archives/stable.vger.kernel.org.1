Return-Path: <stable+bounces-92235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D459C533C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3B0B31DBF
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96420210184;
	Tue, 12 Nov 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoCI7cLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279820B20B;
	Tue, 12 Nov 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406990; cv=none; b=LY37iNn9N5DVePzMDCJo7p3DwOHFnxFCJZasPVlnAjcmiKLmtjlNjv9X1HFfWRqwd4ZYQy29x4nzusMzxroFcGWMY4oJQ+OsGSwVAHl9JSDDH+49PGzoBkb6BHFUIpK3d9LdCoUbxca7CxdlBMsxE+pHjL898ms2YkhBauFeCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406990; c=relaxed/simple;
	bh=QsnK123/hTsKY/FzQIEFh5SfjvcQls1u05Sqpj/P77k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC+hO0Yt8FQ3w56fHaeDslFdTNBz2Xoidl7s7unwFzerHBof9E0p+nxQCF6W9lXZixNXr3CQRgycgfAPSs4iqWGbCISWDcHN4EhlvGWCXkuIumHtGzQwaYFeYfPnvmMYwNMua3eqL6fWAcX3zDd62dkw4pWiQ9MC0cVPk+27RQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoCI7cLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82963C4CED7;
	Tue, 12 Nov 2024 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731406990;
	bh=QsnK123/hTsKY/FzQIEFh5SfjvcQls1u05Sqpj/P77k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoCI7cLvs0+0rv39O9UzQV4+d2eYvKNusSBA6VjU5T56WxrBwHQ6Q3Di1XsumoQzi
	 gduDgccZ1miCsNGwh6TKIBoKc4oF9uj5efpdmdYpfKzHK3Tg/3F4C9Ds16mvZhIavk
	 txr/IFR0G+W2tPp8gdug+h2A6T/FApdMsNAgw1V8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 18/76] sctp: properly validate chunk size in sctp_sf_ootb()
Date: Tue, 12 Nov 2024 11:20:43 +0100
Message-ID: <20241112101840.476434888@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 0ead60804b64f5bd6999eec88e503c6a1a242d41 ]

A size validation fix similar to that in Commit 50619dbf8db7 ("sctp: add
size validation when walking chunks") is also required in sctp_sf_ootb()
to address a crash reported by syzbot:

  BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
  sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
  sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
  sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
  sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
  sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
  sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1159
  ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233

Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/a29ebb6d8b9f8affd0f9abb296faafafe10c17d8.1730223981.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_statefuns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 13acb84b00c2b..b5f5ee233b59d 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3736,7 +3736,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
 		}
 
 		ch = (struct sctp_chunkhdr *)ch_end;
-	} while (ch_end < skb_tail_pointer(skb));
+	} while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));
 
 	if (ootb_shut_ack)
 		return sctp_sf_shut_8_4_5(net, ep, asoc, type, arg, commands);
-- 
2.43.0




