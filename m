Return-Path: <stable+bounces-52355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C478690A905
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61B01C22E4C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7732190673;
	Mon, 17 Jun 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOsSjun5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC1374D9
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615171; cv=none; b=nE+t866cqS3VQHet4FX1uGFjJQU/z+C4uvm/eORPEXwyJzLPzkTSrGAe/36n0MgldBIIVjwIB7/vhbWjE6GoJOn+Aap16TkrinLaqsOr+TPCrA31e07DVGJtRCQ8M317b0DjZVpusjNrYT56Pyzs1PjzUJ+F9IESHqgKrec8B/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615171; c=relaxed/simple;
	bh=87Kt7w7FmSh456l+grqcB5Hged7OLytIX0UK2Pd9Q28=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=de83qKcWrX8RKkW/rJaXNN7xGsGostoNviNDJzA+24g378y0vpJ4STXnC2DxieR2n0mggL0aNlDs+LcbHgE4DM9Mk4QI3lH79cv8UnSpv5/Ts/tz58BdelFn/HFA5bhWAoOb7eQyzc9DWpGjjHylo7S82FR7OSbXMHcDFnWMLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOsSjun5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9A2C2BD10;
	Mon, 17 Jun 2024 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615171;
	bh=87Kt7w7FmSh456l+grqcB5Hged7OLytIX0UK2Pd9Q28=;
	h=Subject:To:Cc:From:Date:From;
	b=fOsSjun5Gum2etCJWZPN0GpdsuT+tTX5KCrkaxHd7YlpMOHIOvY976tUSCgBlszkG
	 CmeO6yt57NPDqUKjCTPufGu+dddh27sbK/Rq/LXHaQWdEYJ6KOm9QqT+zG6fmYmrHQ
	 nVhujw3Mm978b+6evp5eqEtgfK9Q3RfFMDI341OI=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: Ignore received Hard Reset in TOGGLING" failed to apply to 4.19-stable tree
To: kyletso@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:05:58 +0200
Message-ID: <2024061758-simplify-keg-8ee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x fc8fb9eea94d8f476e15f3a4a7addeb16b3b99d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061758-simplify-keg-8ee4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

fc8fb9eea94d ("usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state")
a6fe37f428c1 ("usb: typec: tcpm: Skip hard reset when in error recovery")
0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
a30a00e37ceb ("usb: typec: tcpm: frs sourcing vbus callback")
8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
3ed8e1c2ac99 ("usb: typec: tcpm: Migrate workqueue to RT priority for processing events")
aefc66afe42b ("usb: typec: pd: Fix formatting in pd.h header")
6bbe2a90a0bb ("usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart")
95b4d51c96a8 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request")
8afe9a3548f9 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling")
03eafcfb60c0 ("usb: typec: tcpm: Add tcpm_queue_vdm_unlocked() helper")
5f2b8d87bca5 ("usb: typec: tcpm: Move mod_delayed_work(&port->vdm_state_machine) call into tcpm_queue_vdm()")
6e1c2241f4ce ("usb: typec: tcpm: Stay in BIST mode till hardreset or unattached")
b2dcfefc43f7 ("usb: typec: tcpm: Support bist test data mode for compliance")
901789745a05 ("usb: typec: tcpm: Ignore CC and vbus changes in PORT_RESET change")
6ecc632d4b35 ("usb: typec: tcpm: set correct data role for non-DRD")
8face9aa57c8 ("usb: typec: Add parameter for the VDO to typec_altmode_enter()")
a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration mechanism")
00ec21e58dc6 ("usb: typec: tcpm: Start using struct typec_operations")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc8fb9eea94d8f476e15f3a4a7addeb16b3b99d6 Mon Sep 17 00:00:00 2001
From: Kyle Tso <kyletso@google.com>
Date: Mon, 20 May 2024 23:48:58 +0800
Subject: [PATCH] usb: typec: tcpm: Ignore received Hard Reset in TOGGLING
 state

Similar to what fixed in Commit a6fe37f428c1 ("usb: typec: tcpm: Skip
hard reset when in error recovery"), the handling of the received Hard
Reset has to be skipped during TOGGLING state.

[ 4086.021288] VBUS off
[ 4086.021295] pending state change SNK_READY -> SNK_UNATTACHED @ 650 ms [rev2 NONE_AMS]
[ 4086.022113] VBUS VSAFE0V
[ 4086.022117] state change SNK_READY -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.022447] VBUS off
[ 4086.022450] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.023060] VBUS VSAFE0V
[ 4086.023064] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.023070] disable BIST MODE TESTDATA
[ 4086.023766] disable vbus discharge ret:0
[ 4086.023911] Setting usb_comm capable false
[ 4086.028874] Setting voltage/current limit 0 mV 0 mA
[ 4086.028888] polarity 0
[ 4086.030305] Requesting mux state 0, usb-role 0, orientation 0
[ 4086.033539] Start toggling
[ 4086.038496] state change SNK_UNATTACHED -> TOGGLING [rev2 NONE_AMS]

// This Hard Reset is unexpected
[ 4086.038499] Received hard reset
[ 4086.038501] state change TOGGLING -> HARD_RESET_START [rev2 HARD_RESET]

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240520154858.1072347-1-kyletso@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index be4127ef84e9..5d4da962acc8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6174,6 +6174,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 		port->tcpc->set_bist_data(port->tcpc, false);
 
 	switch (port->state) {
+	case TOGGLING:
 	case ERROR_RECOVERY:
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:


