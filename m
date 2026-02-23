Return-Path: <stable+bounces-217824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFd7GtaynGmxJwQAu9opvQ
	(envelope-from <stable+bounces-217824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 21:04:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F017CB19
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FC230E9BD6
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45B376472;
	Mon, 23 Feb 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuTgYCgx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0299374759
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876787; cv=none; b=bgnRQeY4kS4zPybfeLh257u8PK1Hx8yPHypMi9gqf/ONSi43rk++2n5j1YaOqXQ6aZJEai1TyqUA9u6V7Repw9wOSkKsfSRsuVSoApoNDm+wLdqQc/Wp9Tsw8SpCA8rzrrutfyJHpRIlYx2KKcuDCbYaR7Ly7uScrkl2ensxnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876787; c=relaxed/simple;
	bh=vSGezea+kHW8+I4FXMUBtjpPhAkkh38ljsBUp1un6Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pPQfnubRCz0j9/Br0vz9I18X23PNh/58VlqjJfMK8lWRGBsfW81p+etj4EAi62Q+E1+V9tMh1qFCgDmNQOsnoHMb00uDAJRhWpjE4Aj/oXLaAY96ILn6ivEr7wYApvpT0nQ4wJpSjh0OspzhFF2YPGEbGIcM91Wg1e3FCEYVDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuTgYCgx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so13105e9.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771876783; x=1772481583; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szNx6Q9HpZ/iwXNBTZ4lMVazeKKlYTctcpZDy3jvygs=;
        b=PuTgYCgxqHEeEQaPpdXskpsK/s6pQE+bbQL11TWMGAdhyx5mvimruMIPGPQYuKn/c4
         /4PvFooIdPWbfBvRbFEN344fS+lJZk5OB9H55jzjIJjLXNk+RNBjACQ+a78ab9meS4c7
         FkcH4X9LfcKbP4LUrBkWx7kZdP2H+uRzA18kIwCOuuPRG/vKA6S3FqwgG8KvFbXwEd3R
         o+8BLMvv0f3QlY77awO6OPiWUt7lNCGsH7o5O100LeS1Nw6WbwMQ1dMvf58WoQK6qwae
         VASxq68Qyk62krV+RfmbiFY6zuR0VakymyNeigK0PhgGVLSFw2ghaISekar6OIiavimF
         SL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876783; x=1772481583;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szNx6Q9HpZ/iwXNBTZ4lMVazeKKlYTctcpZDy3jvygs=;
        b=UNuIbvG8acX+P+xPjIdgJQFZgMaAwRbIFssOEBN8E58kj/lmLSUW3vp6pVARllZ2on
         1/ngnW5UMmOijvmd8kfjpvGvye4DPU/zlNtjrhc+q2CHoRhs86ndg+9axGl8rqA3k+wr
         2YNalGpSiOWYQVr1uUMz/0nQHVAhJG0T2XcOP9EbdNgN8PNy2sH/Zs2/5p/MptzEW3K2
         C9WDXtyhvfjytNS6Ulw36SmHUvdgSXJ1n8+RP6BbJ6aTFNMAXsC+qwVVkx5DNyASEmNt
         b3BjB9wU0mKhIbapXpUaW6N2Hki5rMZaDSmdP73ppWw2sqVY04ESvWnoufdZygVabNRe
         LepQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWxARbzvcqOZy9hdgUjzZR4Q5aBQj8d+jSlrvYq3J4dxI4mdN9iYM8hScW5RPv8I4TvVrYryc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUc8yKdqLUOBeeOHZXg9nEGjSnTZWfkwgVhp5DCzQa6blnuqC
	Hc+xX7wb8JQtJSBTSBF+J0PT/270ZLa2/FYwKRSZ3xrzhvyjr3ncLQfXnkRWjLt0SA==
X-Gm-Gg: AZuq6aJzqSk5aNA/EGDUbxQn3qwC0dvb/1eoNFRTIxkpeC/KKWw4d5y9Wwt5iXNTOUL
	aJidZ5C+1alVgC6PxIDUJpuIZExLaKoQeN35jXLTEdqHfrD0lBm9VS0P9j3Dmhmlr1viPYbe+JI
	Mz776j3pxT3+lbKD0sbsw2M2osieg/eF9dnPaeGsBJuQtOIbr8NiFKGhtPCtplaXSnR1eg8lQun
	JvZj+xLYlvhkOH0pLZe51bm50e9mA++K0fYS4E6/0BIu44ZWmbOI6SjTewckmaQbUBOrb6AIFr3
	YxaWzdRmEUWkO5QLuPd3rjsv2oe/SEVuRRr5OW/s4EuPiQYYnw1J42TZztV7qyRmo9QnPchV6/V
	oI5zqpoFh01sIerUv25vZShlXeLWRed5z4LbrxzmwA69glefSiBuVu6q+BV/1SmJhMowi1rMBm/
	skcvKCuAwT86FiPCjeA8axchXhCOIoSU/FUdlbkq0k42xIeucs9Gw=
X-Received: by 2002:a05:600c:4454:b0:477:86fd:fb1b with SMTP id 5b1f17b1804b1-483b878837emr116465e9.11.1771876782542;
        Mon, 23 Feb 2026 11:59:42 -0800 (PST)
Received: from localhost ([2a00:79e0:288a:8:e3f8:d6ab:bdc7:bdcf])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483b81f8912sm4486845e9.1.2026.02.23.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:59:42 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Mon, 23 Feb 2026 20:59:33 +0100
Subject: [PATCH] eventpoll: Fix integer overflow in ep_loop_check_proc()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-epoll-int-overflow-v1-1-452f35132224@google.com>
X-B4-Tracking: v=1; b=H4sIAKSxnGkC/x3MQQqAIBBA0avErBswjYKuEi3MxhoQFY0KwrsnL
 d/i/xcyJaYMU/NCooszB1/RtQ2YQ/udkLdqkEIOQkqFFINzyP7EcFGyLtyotOhXOyoyeoAaxkS
 Wn386L6V8a/Zz4GQAAAA=
X-Change-ID: 20260223-epoll-int-overflow-3a04bf73eca6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771876777; l=1946;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=vSGezea+kHW8+I4FXMUBtjpPhAkkh38ljsBUp1un6Fs=;
 b=RdragfDp77ExTy4XNQd7Cde3KK3Eu2MW9GuvLXcoBKzltgC7byd5LbGI5kPdL8Vyo4Wccnt4U
 6Gt2X0RHjm4AJOJHzmkeblC3ZLcrSB3Jwn43TzRKzit2MbcKn7TWTZT
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217824-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D80F017CB19
X-Rspamd-Action: no action

If a recursive call to ep_loop_check_proc() hits the `result = INT_MAX`,
an integer overflow will occur in the calling ep_loop_check_proc() at
`result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1)`,
breaking the recursion depth check.

Fix it by using a different placeholder value that can't lead to an
overflow.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Gah, I introduced such an obvious integer overflow when I touched this
code the last time...

No "Closes:" link because the bug was not reported publicly.
---
 fs/eventpoll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a8c278c50083..5714e900567c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2061,7 +2061,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
+ * Return: depth of the subtree, or a value bigger than EP_MAX_NESTS if we found
+ * a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
@@ -2080,7 +2081,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				result = INT_MAX;
+				result = EP_MAX_NESTS+1;
 			else
 				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
 			if (result > EP_MAX_NESTS)

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-epoll-int-overflow-3a04bf73eca6

--  
Jann Horn <jannh@google.com>


