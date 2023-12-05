Return-Path: <stable+bounces-4099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A9804600
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3104C283382
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A036FB1;
	Tue,  5 Dec 2023 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PABZ3lHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE85A59;
	Tue,  5 Dec 2023 03:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2EFC433C8;
	Tue,  5 Dec 2023 03:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746614;
	bh=lbv7gN7TS4oWTdaAcjzzLozYFz/ptqBuXLCXgB5mR+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PABZ3lHWyUL8N4MO0pWKerghHtglHWqR0vzVniqLc0bDLk3WLmy0Li7cifbRG4AfF
	 AljzQElCyPqbQdEzOUhYIJyecNit+FMCbRlLsbJzrOjmItrqA8jh5BNbwAUgVckqo5
	 AcNYyeO+Dj11u7RX7fAO0qlbpbTrqulFPn5AAo7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/134] selftests/net: fix a char signedness issue
Date: Tue,  5 Dec 2023 12:16:04 +0900
Message-ID: <20231205031541.311214220@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 7b29828c5af6841bdeb9fafa32fdfeff7ab9c407 ]

Signedness of char is signed on x86_64, but unsigned on arm64.

Fix the warning building cmsg_sender.c on signed platforms or
forced with -fsigned-char:

    msg_sender.c:455:12:
    error: implicit conversion from 'int' to 'char'
    changes value from 128 to -128
    [-Werror,-Wconstant-conversion]
        buf[0] = ICMPV6_ECHO_REQUEST;

constant ICMPV6_ECHO_REQUEST is 128.

Link: https://lwn.net/Articles/911914
Fixes: de17e305a810 ("selftests: net: cmsg_sender: support icmp and raw sockets")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20231124171645.1011043-3-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/cmsg_sender.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 24b21b15ed3fb..6ff3e732f449f 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -416,9 +416,9 @@ int main(int argc, char *argv[])
 {
 	struct addrinfo hints, *ai;
 	struct iovec iov[1];
+	unsigned char *buf;
 	struct msghdr msg;
 	char cbuf[1024];
-	char *buf;
 	int err;
 	int fd;
 
-- 
2.42.0




