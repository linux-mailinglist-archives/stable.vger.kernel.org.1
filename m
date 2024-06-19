Return-Path: <stable+bounces-53669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BF90E0D8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 02:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1231B21726
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1D1876;
	Wed, 19 Jun 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyli4MaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F047139B;
	Wed, 19 Jun 2024 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756968; cv=none; b=BmjIIMFIzJ7feyaIra0dlTxQliI/pjx9K6rZ3+HRHP2o4wmEpEYACD1yc074lMYcUNb5ik38Bu/4yA5jC8vgfYIhwUO71/08+lGu5JY8f4FDE7kqufhyV8lObK6yHQV1p6Kh/z7UrFRh37LrgC2uFEkxh3jndYZ/SNSGhqnt7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756968; c=relaxed/simple;
	bh=feh3HZI6xAOXwvzQ8jylGLoBGGKJyhhqGB5M5+m8jBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ezgGmxGcW3TBstfE5+gdL4OQBx3S/HjrA9Pf5faw7VDC+k+9Pm0NYMktBV+W8XOoinTVdWXtNDqmu+t/TSd8bCeuoTMAQfKX/sZU8HUZJC4h8R2S/+tPmEe/1337E2BShaPjwDMCKsVxoTEU3cl1/uNLIkdQGgvKeCBm4EEB0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyli4MaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A21FC3277B;
	Wed, 19 Jun 2024 00:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718756967;
	bh=feh3HZI6xAOXwvzQ8jylGLoBGGKJyhhqGB5M5+m8jBk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Jyli4MaGewXe13vLznRBoNiql0uVlKhUTgXRMu4OSEa/+wkWCm5DVVKTf92VTt14+
	 5LtelIrOKX0IEaZn8rz/C30+c/Fpoumu4+v2Ru/iPa8rfoNa8938FzaStAMOkjfq9I
	 eminojFAnTzz01MBmQJ2hAi/QpB7u4JYakycrtBFRbG+CltIDfvDjQzfAKSRA0T5mP
	 zNHMjPMmJwFcxSvv088AXycyJUpG7iezjYS2l7xPrEByyXONFBaxW/J9mYuwIxClmS
	 g/+3T34dhg9EESKBA4WyAcOG5b/z/vkFb4O2pqLXuFyNeQ9dXSNtxz5ORY6Uw7Ul5n
	 2Cd/bcx5qFxNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE12C2BA15;
	Wed, 19 Jun 2024 00:29:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 19 Jun 2024 01:29:04 +0100
Subject: [PATCH net] net/tcp_ao: Don't leak ao_info on error-path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE8mcmYC/x2MwQrCMBAFf6Xs2YU2hkr9FfGwSZ52UdO6qSKU/
 rvR4wzMrFRgikLHZiXDW4tOuUK3ayiOkq9gTZXJtc63fTfwEmeWiQ3PlxoS3yE3di54GUKfDn5
 PNZ0NF/38tyfKWOhcZZACDiY5jr/jQ8oCo237Aq/AsvqEAAAA
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718756966; l=1410;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=U4ffmt+DUWeDhoiFE1PxHHKXEhF2E1etRzuFRWJAYks=;
 b=1nlpQ5rZM2edyZFchlRIuzQ9Kxs50YnffEPqyXXW0fnMWL2amUUou8Zbpd/ttsVw6enM+fHirgyV
 D/3Y/FMXBZgTP1rF8zQA46MTVXb1xaWWq1mug9ccyAvR7vO0wPfF
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It seems I introduced it together with TCP_AO_CMDF_AO_REQUIRED, on
version 5 [1] of TCP-AO patches. Quite frustrative that having all these
selftests that I've written, running kmemtest & kcov was always in todo.

[1]: https://lore.kernel.org/netdev/20230215183335.800122-5-dima@arista.com/

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240617072451.1403e1d2@kernel.org/
Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/tcp_ao.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 37c42b63ff99..09c0fa6756b7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1968,8 +1968,10 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 		first = true;
 	}
 
-	if (cmd.ao_required && tcp_ao_required_verify(sk))
-		return -EKEYREJECTED;
+	if (cmd.ao_required && tcp_ao_required_verify(sk)) {
+		err = -EKEYREJECTED;
+		goto out;
+	}
 
 	/* For sockets in TCP_CLOSED it's possible set keys that aren't
 	 * matching the future peer (address/port/VRF/etc),

---
base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
change-id: 20240619-tcp-ao-required-leak-22b4a9b6d743

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



