Return-Path: <stable+bounces-116737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC273A39B07
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974BC1725A7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECFC23ED47;
	Tue, 18 Feb 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ezc5WDWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283B23956F
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878333; cv=none; b=Mjy3gg+zkp0ckYbxkRXze8UJNAuuXmaZVGbTP9eTaC0sw+dP8G6ZLkqd3Tsa9Whn8RFVx5bW3zkhTU2CnH/banHve5vgYitXUY1I3s6YnmAMny3gCYJRVGZogotw93pfnmsJS8tsejsYtjl9AFqD98RMvspgemizb81hh8qu+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878333; c=relaxed/simple;
	bh=lGge7QSSBiNOsG4Cjet6g+5bhZy8D0En96/TV5tYSeg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lZMm5w8Cp89kOQFRf1viICaVfc5zWNr6sfXK5gQaBzPfOg/WMSiaFIqggM2fHXyGTU8kTSR+m4b8XC4sR619dcR6Sbjx/l6CnmZRFVMGzX0gvW98RrKM2sVfacCyOVwKaudum9WEOP9j+JJuOFahSdRJNLZv2qTU/UOkp4HD89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ezc5WDWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCA7C4CEE2;
	Tue, 18 Feb 2025 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878333;
	bh=lGge7QSSBiNOsG4Cjet6g+5bhZy8D0En96/TV5tYSeg=;
	h=Subject:To:Cc:From:Date:From;
	b=Ezc5WDWtMt8ku8TdxsofW7VveiGi1IzlomfxhR9qALZ3+PEpE527ULFH2bXaEU9zu
	 B3skwfsQIQUQUK08kmrqcWSVZhDaPpF22k9u2/JfSF9XKsWUUMYC7SdQGDuA/FDbRc
	 cJOIl1QaEZub01AQhNG9+AVNjuc1WcDG10yK5h/s=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters" failed to apply to 5.4-stable tree
To: joswang@lenovo.com,amitsd@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:31:52 +0100
Message-ID: <2025021852-blemish-humility-00ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 659f5d55feb75782bd46cf130da3c1f240afe9ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021852-blemish-humility-00ca@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 659f5d55feb75782bd46cf130da3c1f240afe9ba Mon Sep 17 00:00:00 2001
From: Jos Wang <joswang@lenovo.com>
Date: Thu, 13 Feb 2025 21:49:21 +0800
Subject: [PATCH] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters
 ERROR_RECOVERY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")，the PSSourceOffTimer is
used by the Policy Engine in Dual-Role Power device that is currently
acting as a Sink to timeout on a PS_RDY Message during a Power Role
Swap sequence. This condition leads to a Hard Reset for USB Type-A and
Type-B Plugs and Error Recovery for Type-C plugs and return to USB
Default Operation.

Therefore, after PSSourceOffTimer timeout, the tcpm state machine should
switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also
solve the test items in the USB power delivery compliance test:
TEST.PD.PROT.SNK.12 PR_Swap – PSSourceOffTimer Timeout

[1] https://usb.org/document-library/usb-power-delivery-compliance-test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable <stable@kernel.org>
Signed-off-by: Jos Wang <joswang@lenovo.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Amit Sunil Dhamne <amitsd@google.com>
Link: https://lore.kernel.org/r/20250213134921.3798-1-joswang1221@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 47be450d2be3..6bf1a22c785a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
 						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
-		tcpm_set_state(port, hard_reset_state(port),
-			       port->timings.ps_src_off_time);
+		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
 		break;
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		tcpm_enable_auto_vbus_discharge(port, true);


