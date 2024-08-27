Return-Path: <stable+bounces-70713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA0960FA2
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA771C233DD
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA3F1C579F;
	Tue, 27 Aug 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hskb2uYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA873466;
	Tue, 27 Aug 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770821; cv=none; b=Tp7sfqq+Nq9YH/KKeGoVe3uO9UvTND/+GpukpV0qlRMJwxt7jMRIxt275DqJqWrLQRMyeMmyElcNqaccV7wFdSra/81G2E1FRo1sVcglR41sWCPMfHn1NbOjlYA1eP8mlq5ffr1DBRwvJcGVJ9PSlT1gO5xQS5rHC44Rn15Bb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770821; c=relaxed/simple;
	bh=k4mciPyFpnzRPajvJ3Zq56u0Azso0YKdkd4YeBSH1cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8Kra66RgKC7pvt4Fez1d8IFluJuprIuNXSrpfkmd5l4CD3yIqlRJ+65s4Oc/3pMqBGauUMJrt1tx6MU7nRklOPe8TMQ2gCsXP+14JO6iGliHDVageZ+Jfgm9qL4NR5j4rTvOlYS+CyhJbiQyMnG+gSTCv7Pi5lM1B2qXthQJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hskb2uYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE0DC4DDE2;
	Tue, 27 Aug 2024 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770821;
	bh=k4mciPyFpnzRPajvJ3Zq56u0Azso0YKdkd4YeBSH1cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hskb2uYa8fjX9/BCdvcNdUhW+pKna4sulG6gvMdhhvJeh6Q0kxaZr1B9MreyQiqR0
	 V0IJrO9sqGxQIbVcS8AMOvG1OsjkQJAgvMexEVNQFc5ojpF+X79I4xX0qCT7EBHTTp
	 RDlxJHV57B3UPCEPWqVN9ECvBlGw/kG3KvV03PTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.6 325/341] tcp: do not export tcp_twsk_purge()
Date: Tue, 27 Aug 2024 16:39:16 +0200
Message-ID: <20240827143855.763067478@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit c51db4ac10d57c366f9a92121e3889bfc6c324cd upstream.

After commit 1eeb50435739 ("tcp/dccp: do not care about
families in inet_twsk_purge()") tcp_twsk_purge() is
no longer potentially called from a module.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_minisocks.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -378,7 +378,6 @@ void tcp_twsk_purge(struct list_head *ne
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_purge);
 
 /* Warning : This function is called without sk_listener being locked.
  * Be sure to read socket fields once, as their value could change under us.



