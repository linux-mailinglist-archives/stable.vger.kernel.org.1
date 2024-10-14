Return-Path: <stable+bounces-84704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52199D1B0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DC9B2511A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557961D1512;
	Mon, 14 Oct 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIX2cbDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB41C7269;
	Mon, 14 Oct 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918923; cv=none; b=nnbe8uwYiJP4uUZWRbbxksmwFFbXxqEaEtFnPmjqizXpVve3qNeEv7UQgIMrTdznHMhkSIRk2SHYnrNGORnyN++QcDS4TIzw7pZQWXwEgSuV785memkRdX/KNlHarSUI/0EbyYDfGfKySGq32LQUUzzMMrHS5EVt1fWUY3fWS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918923; c=relaxed/simple;
	bh=i5OY1H5ximHzZ9lfHZXhCaye31eS5kGEY9A8I+iDzg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8v2DLIlfkqhDK0qwRRHlAjYBzSzHpuiHr8qH9d9ZRUSAA7oVgbE1FK36LdRkejFbR/8izSCjhcocIs85m8c1mceZuRJlRKC+qdYHGMCUhLJzC82dFgZdfh2vREofIp7OOzq1Vc46elehrXk0gZMf3cQ4KBv95fKLAtaX4g5+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIX2cbDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BCAC4CECF;
	Mon, 14 Oct 2024 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918922;
	bh=i5OY1H5ximHzZ9lfHZXhCaye31eS5kGEY9A8I+iDzg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIX2cbDBpDlxmWV8ITFbwJ3eIdObohQKYQuINX4/g6M2V3lOX822YyRpuUEw8Y7ma
	 iZE1Q2c4OlsDW/5GPAidXYhkS4tMat6nqrNfYNrPB4yV5NXy6Nak7aFEf3Rb3MPKw1
	 eqgxxxy1DpWunw6gsg0mFagYJxJJ0Jb2gNjv3+v4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 430/798] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Mon, 14 Oct 2024 16:16:24 +0200
Message-ID: <20241014141234.848023102@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit d5c4546062fd6f5dbce575c7ea52ad66d1968678 ]

According to Vinicius (and carefully looking through the whole
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
once again), txtime branch of 'taprio_change()' is not going to
race against 'advance_sched()'. But using 'rcu_replace_pointer()'
in the former may be a good idea as well.

Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 41187bbd25ee9..07f6f5343dd71 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1668,7 +1668,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		/* Not going to race against advance_sched(), but still */
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 	} else {
-- 
2.43.0




