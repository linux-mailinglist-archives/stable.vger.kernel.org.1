Return-Path: <stable+bounces-214980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKIEGPDuiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A71104AF
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B260D3015A50
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9237AA91;
	Mon,  9 Feb 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aihzUkCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD735CB6B;
	Mon,  9 Feb 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647277; cv=none; b=inSUAg5HCtFg6YukTvxfsRLYaIO+h7A0OoDVUSWE0QoXJBQk9Q3CCxHxmyVrQN8//0DdJo+DX/lS9Yf6Z65ySFMf+yU73C3M7kDTOhb/7K9Du7AH+DENaZjPYnCLPgc4J3dpMDExXE//CWEpVVCgEl4X2FohyLDejru1NMISVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647277; c=relaxed/simple;
	bh=Oi+2F1QgTPaVRYQlP20lzEJWYAj+u8hcT/W0p9SDkHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7Uu5Z5Y+LndetUTzwBa3q8pOIhDaO2TVRBKSjv1+AeifLnS5tQ4SNnKOwVEWCVmIMYxLnNYFk6c3cocnd7Lx6Bss6pGgvvaBHpaXaqh/HdvPBKhU3jRzGsiTCrQ+0VFlVgCze+d0T38ZOPYIHCZEHiPuKMAPvvzYu+e66IMoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aihzUkCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E99C116C6;
	Mon,  9 Feb 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647276;
	bh=Oi+2F1QgTPaVRYQlP20lzEJWYAj+u8hcT/W0p9SDkHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aihzUkCsJXzYPAAgt0OkgA+KZ0BFV34U19CmMthYMWgdpaXeCsF8MrAWmKzPg2bmi
	 u3QvxY1A2BIdy6Iuic4S9P8gbjIKNuI8GeGmdMJxdXnJtHpIyevNme6oh9lX1dBqjV
	 SuoOgh2eHXPMk9DIHk4nOqy0eZCckRzrful1dPwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.18 018/175] cgroup/dmem: fix NULL pointer dereference when setting max
Date: Mon,  9 Feb 2026 15:21:31 +0100
Message-ID: <20260209142321.131476055@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214980-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: C31A71104AF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

commit 43151f812886be1855d2cba059f9c93e4729460b upstream.

An issue was triggered:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 15 UID: 0 PID: 658 Comm: bash Tainted: 6.19.0-rc6-next-2026012
 Tainted: [O]=OOT_MODULE
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
 RIP: 0010:strcmp+0x10/0x30
 RSP: 0018:ffffc900017f7dc0 EFLAGS: 00000246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888107cd4358
 RDX: 0000000019f73907 RSI: ffffffff82cc381a RDI: 0000000000000000
 RBP: ffff8881016bef0d R08: 000000006c0e7145 R09: 0000000056c0e714
 R10: 0000000000000001 R11: ffff888107cd4358 R12: 0007ffffffffffff
 R13: ffff888101399200 R14: ffff888100fcb360 R15: 0007ffffffffffff
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000105c79000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  dmemcg_limit_write.constprop.0+0x16d/0x390
  ? __pfx_set_resource_max+0x10/0x10
  kernfs_fop_write_iter+0x14e/0x200
  vfs_write+0x367/0x510
  ksys_write+0x66/0xe0
  do_syscall_64+0x6b/0x390
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f42697e1887

It was trriggered setting max without limitation, the command is like:
"echo test/region0 > dmem.max". To fix this issue, add check whether
options is valid after parsing the region_name.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Cc: stable@vger.kernel.org # v6.14+
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/dmem.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -700,6 +700,9 @@ static ssize_t dmemcg_limit_write(struct
 		if (!region_name[0])
 			continue;
 
+		if (!options || !*options)
+			return -EINVAL;
+
 		rcu_read_lock();
 		region = dmemcg_get_region_by_name(region_name);
 		rcu_read_unlock();



