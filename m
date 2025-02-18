Return-Path: <stable+bounces-116732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDEA39B03
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E9117241B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF722417D2;
	Tue, 18 Feb 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IuI0Mool"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7C2417CB
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878312; cv=none; b=DXH1yLKhsB+1qBJyHAtJKMG/sZacZVrsRMR7O4WphblYoET5hrKzwUA/66i3j33bWYG1yF/XD/ekYlv0xfIsjjm9KKFDrm2Gs1zkz2wHQ9LoCy2RZsGrPbbnSEr820oMVHbYpq9XRaOH6MScx3RAQBv54psQ35RtnYhdNaJ0yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878312; c=relaxed/simple;
	bh=WSy9/rkORYETM3DvdR22Ha8RyQabCewA11oZ7zg5snw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rmN4TNsferPhNINljma/io2ubL41o1sI9MN7RQ3pRYdf65o2XEBJXhjFjQJZr0BE9vKQKaRWqXBlwhmbmR3mZNoWHiu0SJPvE6xP0DBOM7W1H3lBgbKDoMwpuPthVvSBsXOAt4yvAZea1nPiH4QHBtrTpEndLmQ3+xUURgk2u9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IuI0Mool; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60963C4CEE7;
	Tue, 18 Feb 2025 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878312;
	bh=WSy9/rkORYETM3DvdR22Ha8RyQabCewA11oZ7zg5snw=;
	h=Subject:To:Cc:From:Date:From;
	b=IuI0MoolpwPhxkShimmh+Jw181JiZPt06s1bk6RcbwKfZFuoj7Oz4TyNWyqqTKYmJ
	 SaLVY2QhVMCCBan491zbYZqBC7Q7pUxnE961SZtSFpjys5NI8ng7KmMLTo2VTFlnUK
	 dLzEoNle620Tp9vgUGHx09maOO+Cz4JC2X9T9Fzg=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters" failed to apply to 6.12-stable tree
To: joswang@lenovo.com,amitsd@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:31:48 +0100
Message-ID: <2025021848-lend-city-f5bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 659f5d55feb75782bd46cf130da3c1f240afe9ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021848-lend-city-f5bb@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


