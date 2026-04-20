Return-Path: <stable+bounces-239524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCQ4O1dl5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:41:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68869431D66
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C0835D4DF0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A333331A78;
	Mon, 20 Apr 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogmh4s3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A82E11C7;
	Mon, 20 Apr 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700473; cv=none; b=o3EFMPOxi91hvUW7aOc3q66vzNi3Yd3EXVvjbu0l0dKlFPAk2cBpWREZ4MSb5yllXma26ox7vS3URjv3hwt3zGspE3kCv4GoVqAZMWBllhzRZ7wkrC/Q8uKnCpEXSmX1shEVZS8gmeQyTNE2F1K934zEcWzV51KKqn1lyPsaU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700473; c=relaxed/simple;
	bh=gnikGA4+gfHsCFw7wjE4ZJ9GGhgR1Lj1bpE0Tk0L19Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei5mpZkFbR92Ntgp5lUNZPqng19vW7tGWqSJ3Ibvmx3c+97eR1j2X5uDNeFA8zs2QKB4nDeiqJ6yXM03l6nW1hSg5YeK8ERpt1v5h4eh0ranRpidIHFWba3lGTuMinCV5mGW9D/ggqHymLzibP2gSOOCE6RpJm++DhMGPG+3egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogmh4s3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683B7C19425;
	Mon, 20 Apr 2026 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700473;
	bh=gnikGA4+gfHsCFw7wjE4ZJ9GGhgR1Lj1bpE0Tk0L19Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogmh4s3VGqgpOx8gzLUX+fjN46A/KdMff1EJYY1XLyBNBXYNAvdU49Glj55Z+O9iN
	 kUCO1ppnVyhP2SgT8jPVFXDFAw4+a/mGczfGxd/DylFzCFuHr8914OPla1zj4vFEmC
	 3vKHg2sE1yVUjnxEf9tF7uTZsDaWiiocwvSxMTRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.19 187/220] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
Date: Mon, 20 Apr 2026 17:42:08 +0200
Message-ID: <20260420153940.759252706@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239524-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 68869431D66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 25a642b6abc98bbbabbf2baef9fc498bbea6aee6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c |    2 --
 1 file changed, 2 deletions(-)

--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 



