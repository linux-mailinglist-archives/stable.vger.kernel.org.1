Return-Path: <stable+bounces-68690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F1953382
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D719D1C24C35
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5C19DF6A;
	Thu, 15 Aug 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C60IB6XH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48B1A00D2;
	Thu, 15 Aug 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731360; cv=none; b=gL41r+P3X01kG5/dP/0vHvaZ6MNtUnDuwEWjMNu+Xl4pQ/N+TVTWS3aWaVuRZecuayrz+JNUe9g0rpLVFOSoTz8CPhgXXwUj7CwvV58jLlVwwoJHqGtD1GG68vZ7sMSl7wxFhqqOOXgVfPJwIqdTr90dMy35Ubk2/eYx+5TNPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731360; c=relaxed/simple;
	bh=EIaB5MK+vteDVgywWza6NtY3rBDo5d6DcgGLwBnNHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE5HPn9bp1Z5WflTpWM+H/8NVhb1yrpVQZEaTrtRJz0WF6GvK+K3AWblFavxb/r3JDeeyi6Z6EAZ4o/SMvXj0hYlSL0Ti21+bjUH+WRTwrMvNAKzJdahhWsRQeEZhpSAKoDWvJAf4quL/+3tLR5r565ft/8EbFBU4kTpaF+Gam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C60IB6XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248EEC4AF0A;
	Thu, 15 Aug 2024 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731360;
	bh=EIaB5MK+vteDVgywWza6NtY3rBDo5d6DcgGLwBnNHB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C60IB6XH0ZScAkD+uOlp2xUKH1QOPQwsrNuZkqlqf7KS4u5gC30PbNCu5qa5w6ycn
	 84wy3KjsyUvzJGnXNpK1fyq77PcxFS1T4EhxqyFVdn1lq9dV3dSKnkEqYZM/329lJz
	 Tdys9wexLjpPz5Cneyc31qlSHwXCLoTY2sILRcTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.4 105/259] tools/memory-model: Fix bug in lock.cat
Date: Thu, 15 Aug 2024 15:23:58 +0200
Message-ID: <20240815131906.859957280@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 4c830eef806679dc243e191f962c488dd9d00708 upstream.

Andrea reported that the following innocuous litmus test:

C T

{}

P0(spinlock_t *x)
{
	int r0;

	spin_lock(x);
	spin_unlock(x);
	r0 = spin_is_locked(x);
}

gives rise to a nonsensical empty result with no executions:

$ herd7 -conf linux-kernel.cfg T.litmus
Test T Required
States 0
Ok
Witnesses
Positive: 0 Negative: 0
Condition forall (true)
Observation T Never 0 0
Time T 0.00
Hash=6fa204e139ddddf2cb6fa963bad117c0

The problem is caused by a bug in the lock.cat part of the LKMM.  Its
computation of the rf relation for RU (read-unlocked) events is
faulty; it implicitly assumes that every RU event must read from
either a UL (unlock) event in another thread or from the lock's
initial state.  Neither is true in the litmus test above, so the
computation yields no possible executions.

The lock.cat code tries to make up for this deficiency by allowing RU
events outside of critical sections to read from the last po-previous
UL event.  But it does this incorrectly, trying to keep these rfi links
separate from the rfe links that might also be needed, and passing only
the latter to herd7's cross() macro.

The problem is fixed by merging the two sets of possible rf links for
RU events and using them all in the call to cross().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Andrea Parri <parri.andrea@gmail.com>
Closes: https://lore.kernel.org/linux-arch/ZlC0IkzpQdeGj+a3@andrea/
Tested-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Fixes: 15553dcbca06 ("tools/memory-model: Add model support for spin_is_locked()")
CC: <stable@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/memory-model/lock.cat |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -102,19 +102,19 @@ let rf-lf = rfe-lf | rfi-lf
  * within one of the lock's critical sections returns False.
  *)
 
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
+(*
+ * rf for RU events: an RU may read from an external UL or the initial write,
+ * or from the last po-previous UL
+ *)
+let all-possible-rf-ru =
+	let possible-rf-ru r =
 		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
+			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
+	in map possible-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru



