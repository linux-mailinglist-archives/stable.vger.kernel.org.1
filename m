Return-Path: <stable+bounces-102247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A699EF0F1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BF429E0DF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF4236F92;
	Thu, 12 Dec 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/Ne6RDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D4205501;
	Thu, 12 Dec 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020532; cv=none; b=bno6FSCo1ox+p0DO/Ux0xtZ0yAWyHGjLiPBNnHO+FtW5OE0reZ4wtPYrEsvJN/wtyc91xdJZa6p2qo1SZ3/9pPgKot5wgxPez611eJgE9I6NKsBwhMtX2tgfIkdrEZCMj+/QxoM26Zv4cGp/soC8nF15KUEVL7h99e+qYQtFtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020532; c=relaxed/simple;
	bh=mYCfxi7qzXJm9xeai4Y01ByTUWj0yVf+ipXmITS2uj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKYYZn/ApEbGAN8AxJhcqvNzYgnrYVeTUX9RRwFiHmixPTxR9i4X5vTa0zhe0uEEFSsMr4IHEggjqofGCDE44B8v1mKdbJcO0abrH2PwWo4cg6B1dkItqvKbO3wLgbooozz8BJVSWgznFNUHarKu1M0zHZttcPBEVLcXrNthgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/Ne6RDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C97AC4CECE;
	Thu, 12 Dec 2024 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020532;
	bh=mYCfxi7qzXJm9xeai4Y01ByTUWj0yVf+ipXmITS2uj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/Ne6RDK1GeP822MB+Ka0QkaVUnZtKpH28aEh5jSYTIGaFl9GO1yh2+MxlsislPpS
	 vUG14CRHPqnKmlnWPhZqSaurv94khphTf+1hLJPcdWpRDT9f702aE8rvwA7DfS5IvB
	 6vQw79T45TnrSYwM5t0yWcZ3Eyzxpyznf+87ZKjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.1 461/772] media: i2c: tc358743: Fix crash in the probe error path when using polling
Date: Thu, 12 Dec 2024 15:56:46 +0100
Message-ID: <20241212144408.983349678@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shiyan <eagle.alexander923@gmail.com>

commit 869f38ae07f7df829da4951c3d1f7a2be09c2e9a upstream.

If an error occurs in the probe() function, we should remove the polling
timer that was alarmed earlier, otherwise the timer is called with
arguments that are already freed, which results in a crash.

------------[ cut here ]------------
WARNING: CPU: 3 PID: 0 at kernel/time/timer.c:1830 __run_timers+0x244/0x268
Modules linked in:
CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.11.0 #226
Hardware name: Diasom DS-RK3568-SOM-EVB (DT)
pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __run_timers+0x244/0x268
lr : __run_timers+0x1d4/0x268
sp : ffffff80eff2baf0
x29: ffffff80eff2bb50 x28: 7fffffffffffffff x27: ffffff80eff2bb00
x26: ffffffc080f669c0 x25: ffffff80efef6bf0 x24: ffffff80eff2bb00
x23: 0000000000000000 x22: dead000000000122 x21: 0000000000000000
x20: ffffff80efef6b80 x19: ffffff80041c8bf8 x18: ffffffffffffffff
x17: ffffffc06f146000 x16: ffffff80eff27dc0 x15: 000000000000003e
x14: 0000000000000000 x13: 00000000000054da x12: 0000000000000000
x11: 00000000000639c0 x10: 000000000000000c x9 : 0000000000000009
x8 : ffffff80eff2cb40 x7 : ffffff80eff2cb40 x6 : ffffff8002bee480
x5 : ffffffc080cb2220 x4 : ffffffc080cb2150 x3 : 00000000000f4240
x2 : 0000000000000102 x1 : ffffff80eff2bb00 x0 : ffffff80041c8bf0
Call trace:
 __run_timers+0x244/0x268
 timer_expire_remote+0x50/0x68
 tmigr_handle_remote+0x388/0x39c
 run_timer_softirq+0x38/0x44
 handle_softirqs+0x138/0x298
 __do_softirq+0x14/0x20
 ____do_softirq+0x10/0x1c
 call_on_irq_stack+0x24/0x4c
 do_softirq_own_stack+0x1c/0x2c
 irq_exit_rcu+0x9c/0xcc
 el1_interrupt+0x48/0xc0
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x7c/0x80
 default_idle_call+0x34/0x68
 do_idle+0x23c/0x294
 cpu_startup_entry+0x38/0x3c
 secondary_start_kernel+0x128/0x160
 __secondary_switched+0xb8/0xbc
---[ end trace 0000000000000000 ]---

Fixes: 4e66a52a2e4c ("[media] tc358743: Add support for platforms without IRQ line")
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/tc358743.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2162,8 +2162,10 @@ static int tc358743_probe(struct i2c_cli
 
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
-	if (!state->i2c_client->irq)
+	if (!state->i2c_client->irq) {
+		del_timer(&state->timer);
 		flush_work(&state->work_i2c_poll);
+	}
 	cancel_delayed_work(&state->delayed_work_enable_hotplug);
 	mutex_destroy(&state->confctl_mutex);
 err_hdl:



