Return-Path: <stable+bounces-238765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EunKrgm5mmgsgEAu9opvQ
	(envelope-from <stable+bounces-238765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:14:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89C42B669
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D4C30ACFC2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F4238B7DA;
	Mon, 20 Apr 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAxGfNCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDF3A1DB
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690431; cv=none; b=VVlb5oh1kfpgHTmtOmqrLk0dVlVkqcEQFiBCpc8aHrav/lS7n4oy2h0yFlD1AsjwonczVwQN0t8cGQCo3gxtDATtqMzmKZxmIlI4+G3HWRXBB0h/9NHTmniPkEKV6JdILKbMdd254lwm4lv/2w8WbWwk2CWfYo+WBdiv586Pfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690431; c=relaxed/simple;
	bh=+DFgMw0gWLTlWRDEDAEir58Ko0IOrPzm7c/TfnVr2u4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ubl7JFUofw7int3dt80GqWZv1vQ+X/SrA04xMXpPFG/Y6P+TeCudTtVCQtfNqnBG7zlEoT5K36JVUoyrY7rcisVd6YvH2TB5IA79AcABLYyQ4HXyK112ex+Dh33Atq3AS41AHf02de/YNkF1HAB9czs1RwFXiy3gLfqI/FcsJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAxGfNCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664D5C19425;
	Mon, 20 Apr 2026 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776690430;
	bh=+DFgMw0gWLTlWRDEDAEir58Ko0IOrPzm7c/TfnVr2u4=;
	h=Subject:To:Cc:From:Date:From;
	b=pAxGfNCsEpyLtenCW+kDBoBdJt2eB4FB7YqFKLS64eRsWvRoeLixZNLieRSHempcX
	 7AxOiWNeqaX2nKRy5iND3EOsFX1ZsIvsIFd72CCVMMBzU8I8c4UFXL9rTSADrGcI86
	 Vrq4eigJHo1p+5rUeTpzFaAgTZlNo8ReKCZZWNDc=
Subject: FAILED: patch "[PATCH] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in" failed to apply to 6.12-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 15:07:08 +0200
Message-ID: <2026042008-thesis-flatworm-d8ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238765-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 1D89C42B669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 25a642b6abc98bbbabbf2baef9fc498bbea6aee6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042008-thesis-flatworm-d8ed@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25a642b6abc98bbbabbf2baef9fc498bbea6aee6 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:09 -0700
Subject: [PATCH] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in
 SEV-ES migrate test

Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an SEV-ES
VM in the SEV migration test, as sev_vm_create() automatically updates the
VMSA pages for SEV-ES guests.  The only reason the duplicate call doesn't
cause visible problems is because the test doesn't actually try to run the
vCPUs.  That will change when KVM adds a check to prevent userspace from
re-launching a VMSA (which corrupts the VMSA page due to KVM writing
encrypted private memory).

Fixes: 69f8e15ab61f ("KVM: selftests: Use the SEV library APIs in the intra-host migration test")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260310234829.2608037-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0a6dfba3905b..6b0928e69051 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 


