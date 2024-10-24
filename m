Return-Path: <stable+bounces-88073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA639AE70A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A51283CB4
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473C1714B0;
	Thu, 24 Oct 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kh5H7HBS"
X-Original-To: stable@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197201D8A08
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778206; cv=none; b=iz0yBpMT7DKHKVdQJSj7RvYR1ncVVYxe8G8AnvUtYOqvPE1glx2JvZ4enCvQV/jHaN1qfE7IRhNccgHffyXqGUO77eh+QOntZUYUdm1pDRs/ZmxKS/Ug4PL7cnKZ4iXnWMpBcu/hpME2nahSxVO576DlI0qY0IFVNIE2+MjmQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778206; c=relaxed/simple;
	bh=Bs1FG4XrGDFa6s8KshhYgWiyysPmb6ofq4bjBazVjRs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jhTeeM0Y4ko7l+arinwtZ/vM8T2cfDWrPVjgOW/+VKHTEV2zN6yLbRF+6EMO2qPc6n5D8E3mhvestOp8AW65c0C7Ke92N6/ME2Y2C8HrpeKHXIJLmCQt+9+Mk0g761ioi7GviXm62/920OPZE3tlMrmYG4uKRZ/400cYiEzkAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kh5H7HBS; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729778195; x=1730037395;
	bh=bcCezxVOZvxotA+T2aF5TjMOpW0NiuzhBzPhhwLDyho=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kh5H7HBS4HKqdRXJZUC9VTgEhF5vz+6FoXvSnYsFySWiRTY/YmW2EGBizydEwsNyf
	 G14mekT+Iq1SBQHn78AV9jXu2zlR1lxZKWb89JBuTXyaD6t/IfP5/Z9TRQXoi//aPD
	 S2Z4HTav6dQE/sKkd3jbPGUL0WgiDoXANOApY24DCPEvSWmevQFVUfGY03qjxqlNnX
	 XLpOpyyeLtDuvz+96l3Od1Lb/T/SpDqTfBes4jALt7PmgfmadmDr4UXB2msNTPV+hd
	 jYJO9ykx0AJgRMtpldHO15Jjr5jhLrrrtev2U2rQxVBIf6hMl3j1oLaCgE0IPFB2qM
	 RtrAbE/8sTELQ==
Date: Thu, 24 Oct 2024 13:56:31 +0000
To: o-takashi@sakamocchi.jp, edmund.raile@proton.me
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: firewire-ohci: device rediscovery hardlock regression
Message-ID: <8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.camel@proton.me>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 26ae4aaa2b97bae0006e07cda1a119322468ea29
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to report a regression in firewire-ohci that results
in the kernel hardlocking when re-discovering a FireWire device.

TI XIO2213B
RME FireFace 800

It will occur under three conditions:
 * power-cycling the FireWire device
 * un- and re-plugging the FireWire device
 * suspending and then waking the PC

Often it would also occur directly on boot in QEMU but I have not
yet observed this specific behavior on bare metal.

Here is an excerpt from the stack trace (don't know whether it is
acceptable to send in full):

kernel: ------------[ cut here ]------------
kernel: refcount_t: addition on 0; use-after-free.
kernel: WARNING: CPU: 3 PID: 116 at lib/refcount.c:25
refcount_warn_saturate (/build/linux/lib/refcount.c:25 (discriminator
1))=20
kernel: Workqueue: firewire_ohci bus_reset_work
kernel: RIP: 0010:refcount_warn_saturate
(/build/linux/lib/refcount.c:25 (discriminator 1))=20
kernel: Call Trace:
kernel:  <TASK>
kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
(discriminator 1))=20
kernel: ? __warn.cold (/build/linux/kernel/panic.c:693)=20
kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
(discriminator 1))=20
kernel: ? report_bug (/build/linux/lib/bug.c:180
/build/linux/lib/bug.c:219)=20
kernel: ? handle_bug (/build/linux/arch/x86/kernel/traps.c:218)=20
kernel: ? exc_invalid_op (/build/linux/arch/x86/kernel/traps.c:260
(discriminator 1))=20
kernel: ? asm_exc_invalid_op
(/build/linux/./arch/x86/include/asm/idtentry.h:621)=20
kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
(discriminator 1))=20
kernel: for_each_fw_node (/build/linux/./include/linux/refcount.h:190
/build/linux/./include/linux/refcount.h:241
/build/linux/./include/linux/refcount.h:258
/build/linux/drivers/firewire/core.h:199
/build/linux/drivers/firewire/core-topology.c:275)=20
kernel: ? __pfx_report_found_node (/build/linux/drivers/firewire/core-
topology.c:312)=20
kernel: fw_core_handle_bus_reset (/build/linux/drivers/firewire/core-
topology.c:399 (discriminator 1) /build/linux/drivers/firewire/core-
topology.c:504 (discriminator 1))=20
kernel: bus_reset_work (/build/linux/drivers/firewire/ohci.c:2121)=20
kernel: process_one_work
(/build/linux/./arch/x86/include/asm/jump_label.h:27
/build/linux/./include/linux/jump_label.h:207
/build/linux/./include/trace/events/workqueue.h:110
/build/linux/kernel/workqueue.c:3236)=20
kernel: worker_thread (/build/linux/kernel/workqueue.c:3306
(discriminator 2) /build/linux/kernel/workqueue.c:3393 (discriminator
2))=20
kernel: ? __pfx_worker_thread (/build/linux/kernel/workqueue.c:3339)=20
kernel: kthread (/build/linux/kernel/kthread.c:389)=20
kernel: ? __pfx_kthread (/build/linux/kernel/kthread.c:342)=20
kernel: ret_from_fork (/build/linux/arch/x86/kernel/process.c:153)=20
kernel: ? __pfx_kthread (/build/linux/kernel/kthread.c:342)=20
kernel: ret_from_fork_asm (/build/linux/arch/x86/entry/entry_64.S:254)=20
kernel:  </TASK>

I have identified the commit via bisection:
24b7f8e5cd656196a13077e160aec45ad89b58d9
firewire: core: use helper functions for self ID sequence

It was part of the following patch series:
firewire: add tracepoints events for self ID sequence
https://lore.kernel.org/all/20240605235155.116468-6-o-takashi@sakamocchi.jp=
/

#regzbot introduced: 24b7f8e5cd65

Since this was before v6.10-rc5 and stable 6.10.14 is EOL,
stable v6.11.5 and mainline are affected.

Reversion appears to be non-trivial as it is part of a patch
series, other files have been altered as well and other commits
build on top of it.

Call chain:
core-topology.c fw_core_handle_bus_reset()
-> core-topology.c   for_each_fw_node(card, local_node,
report_found_node)
-> core.h            fw_node_get(root)
-> refcount.h        __refcount_inc(&node)
-> refcount.h        __refcount_add(1, r, oldp);
-> refcount.h        refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
-> refcount.h        REFCOUNT_WARN("addition on 0; use-after-free")

Since local_node of fw_core_handle_bus_reset() is retrieved by
=09local_node =3D build_tree(card, self_ids, self_id_count);
build_tree() needs to be looked at, it was indeed altered by
24b7f8e5cd65.

After a hard 3 hour look traversing all used functions and comparing
against the original function (as of e404cacfc5ed), this caught my eye:
       for (port_index =3D 0; port_index < total_port_count;
++port_index) {
               switch (port_status) {
               case PHY_PACKET_SELF_ID_PORT_STATUS_PARENT:
                       node->color =3D i;

In both for loops, "port_index" was replaced by "i"
"i" remains in use above:
       for (i =3D 0, h =3D &stack; i < child_port_count; i++)
               h =3D h->prev;

While the original also used the less descriptive i in the loop
       for (i =3D 0; i < port_count; i++) {
               switch (get_port_type(sid, i)) {
               case SELFID_PORT_PARENT:
                        node->color =3D i;
but reset it to 0 at the beginning of the loop.

So the stray "i" in the for loop should be replaced with the loop
iterator "port_index" as it is meant to be synchronous with the
loop iterator (i.e. the port_index), no?

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-
topology.c
index 8c10f47cc8fc..7fd91ba9c9c4 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -207,7 +207,7 @@ static struct fw_node *build_tree(struct fw_card
*card, const u32 *sid, int self
                                // the node->ports array where the
parent node should be.  Later,
                                // when we handle the parent node, we
fix up the reference.
                                ++parent_count;
-                               node->color =3D i;
+                               node->color =3D port_index;
                                break;

What threw me off was discaridng node->color as it would be replaced
later anyways (can't be important!), or so I thought.

Please tell me, is this line of reasoning correct or am I missing
something?

Compiling 24b7f8e5cd65 and later mainline with the patch above
resulted in a kernel that didn't crash!

In case my solution should turn out to be correct, I will gladly
submit the patch.

Kind regards,
Edmund Raile.



