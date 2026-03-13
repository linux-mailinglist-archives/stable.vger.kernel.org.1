Return-Path: <stable+bounces-225359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCJaN3o9tGlljgAAu9opvQ
	(envelope-from <stable+bounces-225359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:38:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9862872FF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FA63305ACAF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE43C73D7;
	Fri, 13 Mar 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+Tcqxjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040338CFFF;
	Fri, 13 Mar 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419829; cv=none; b=naxNbScfY8una9Y0U2SO+9xatPU/fjneFCjnpmdxVwg/Ud/oxn09gO+9QRKWpu4o0y+0CyNfetQX905s6QrH3NmXNxneu++SBnPhJjVF4iX1z6YS8g/pYvpt9TYoQePDujtispxvVtEUzVM21glaeRvn1rgi9HfoTN0NSt+3dRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419829; c=relaxed/simple;
	bh=226mruRRB3XgwVtslHwnWUCPdNzAfxMgkBTQ+WPTZtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvGrYeK0onph6iu4bZXsxIjztKJWqS7tou0dUdD4k2rw3MZJuAxngfCCiR/h7YTBmY/1wXWm87BW8x8zNrgka9AymWUw+ynhwEKzn6cOaCuFINfYZhE7/rZ6fZ+VPSiTcsNtxGEBnPRufEuvut25wLAW076qHhMLtB1/03X3sMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+Tcqxjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA60C2BC86;
	Fri, 13 Mar 2026 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773419829;
	bh=226mruRRB3XgwVtslHwnWUCPdNzAfxMgkBTQ+WPTZtU=;
	h=From:To:Cc:Subject:Date:From;
	b=f+Tcqxjj9f0MFWvIDxj4BjueaYQa2tC0M7PWh983lgC+ww9Xe5A8xCIePxEq27EjH
	 aJM1Ajx9Fmsr06b3sk+d+ZoHDldM2O4cmh3J/BXPe3wMMjuHz22mqgRHiIY/jH6+CW
	 LaYjhsu34dKeKDYnQdo9oHL8lXPWQ/3a3a47CREk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.18
Date: Fri, 13 Mar 2026 17:36:49 +0100
Message-ID: <2026031350-palm-mobile-fced@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225359-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.930];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8F9862872FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.18.18 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 drivers/ata/libata-eh.c                   |    1 
 drivers/ata/libata-scsi.c                 |    1 
 include/net/act_api.h                     |    1 
 include/net/tc_act/tc_gate.h              |   33 ++-
 net/sched/act_ct.c                        |    6 
 net/sched/act_gate.c                      |  265 +++++++++++++++++++++---------
 net/sched/cls_api.c                       |    7 
 security/apparmor/apparmorfs.c            |  225 +++++++++++++++----------
 security/apparmor/include/label.h         |   16 -
 security/apparmor/include/lib.h           |   12 +
 security/apparmor/include/match.h         |    1 
 security/apparmor/include/policy.h        |   10 -
 security/apparmor/include/policy_ns.h     |    2 
 security/apparmor/include/policy_unpack.h |   75 +++++---
 security/apparmor/label.c                 |   12 -
 security/apparmor/match.c                 |   58 ++++--
 security/apparmor/policy.c                |   77 +++++++-
 security/apparmor/policy_ns.c             |    2 
 security/apparmor/policy_unpack.c         |   49 ++++-
 20 files changed, 592 insertions(+), 263 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.18.18

John Johansen (6):
      apparmor: fix: limit the number of levels of policy namespaces
      apparmor: Fix double free of ns_name in aa_replace_profiles()
      apparmor: fix unprivileged local user can do privileged policy management
      apparmor: fix differential encoding verification
      apparmor: fix race on rawdata dereference
      apparmor: fix race between freeing data and fs accessing it

Massimiliano Pellizzer (5):
      apparmor: validate DFA start states are in bounds in unpack_pdb
      apparmor: fix memory leak in verify_header
      apparmor: replace recursive profile removal with iterative approach
      apparmor: fix side-effect bug in match_char() macro usage
      apparmor: fix missing bounds check on DEFAULT table in verify_dfa()

Niklas Cassel (1):
      ata: libata: cancel pending work after clearing deferred_qc

Paul Moses (1):
      net/sched: act_gate: snapshot parameters with RCU on replace

Victor Nogueira (1):
      net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks


