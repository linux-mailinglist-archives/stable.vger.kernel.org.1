Return-Path: <stable+bounces-71271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE09612A0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFA282C4C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58AA1CFEDE;
	Tue, 27 Aug 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ceb5myww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBE1CFEBC;
	Tue, 27 Aug 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772660; cv=none; b=jkqFIsKicn2Wxux3wCRO6RvbfXujs0mu1lYmtZpOFrCCY5Vwqs+SuV+5AIDVr3vo2I2IaJThQFVxLmcYqqIRjnjYyw1Y8iyVXUlGx98HB4xFpUaBJL/HkytroRC1i7QG5Mw9OaM9M8e+HYCLyzbZdmTeP5GYCiRSHd/oMlIovnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772660; c=relaxed/simple;
	bh=+BN+vr3oU8RUomEsL9BttEL86ECDdB38eJVFYwpvlGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT+M5breT2eme9py7onQ0/bgCYC+IzmEj31qKS0uNnxRyExTExYvqS9g0u6i20gFl85kfKfFEuN1Y8AzzFieTVZQADZxtRhF6Ge9QTIMZ0c1i1d/53JrmUEVYlkEYbZ+Hdlqas18N4WUYGrgnJQVVHAG2v/Bl8yXlxAKgKHJDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ceb5myww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D74C4DDE4;
	Tue, 27 Aug 2024 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772660;
	bh=+BN+vr3oU8RUomEsL9BttEL86ECDdB38eJVFYwpvlGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ceb5mywwNK2V+EL36pmm4hINu8bWd/SlGQ3BxvLEX8pk47UDH4eLplvNEi1nfOp9t
	 tJHGuHca8yrGy5/K72q9/roO3PKfdrk21k3y7ajXOPFp9kkpvRYev+0EOGJFfY9CpF
	 CdipvNh1hFl7R3w0MiqNykU1HeXkuemVC8OxQV6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 282/321] tcp: do not export tcp_twsk_purge()
Date: Tue, 27 Aug 2024 16:39:50 +0200
Message-ID: <20240827143848.983304855@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -362,7 +362,6 @@ void tcp_twsk_purge(struct list_head *ne
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_purge);
 
 /* Warning : This function is called without sk_listener being locked.
  * Be sure to read socket fields once, as their value could change under us.



