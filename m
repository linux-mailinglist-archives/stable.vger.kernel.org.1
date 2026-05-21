Return-Path: <stable+bounces-253570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA5nL0YXD2qVFQYAu9opvQ
	(envelope-from <stable+bounces-253570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:31:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F55A74EE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5371733956A4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4443ED11D;
	Thu, 21 May 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8WUZ4bV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3003806C1
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371642; cv=none; b=m+kIh/H9ZxGmflbNd3T754v9P63yXnAGQcplGzmMT/MGc9wRjVnWw69/iY/YDD7Fwtvh2Ckj64bNSRodUUBXUphBcNvru602Jqttw8SFqt4WNwUgT36VwGUF5h4vPVc5g5Q1c4Xxh/TjYkFw+nmCDqUK0/S9Dy6YJAqZI7/OkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371642; c=relaxed/simple;
	bh=ZPYyxldNf1fN5VUAwiTUbj3UyY6hRbzFaLHn0g1qtVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Flf+M1boiNWaArOlB2eRdBTZkNXure9lmmFPE0TWi89pycN8sNx6eHIPqDmDF5t0vJ6rV6KVssPd6kKA4nJW4mg2apwLBRD1OzVEDj4/keqkw4HeTCpExYDwjN2W4BoBrmcn7Vu+h8TsDO4svodDxqrf5Kaoh1X/6NE9gCt4C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8WUZ4bV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C61F01565;
	Thu, 21 May 2026 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371641;
	bh=Dmt5P+HtdfLkVoKYzc9WKU30QLHhuPEvOAR0b4ZZzLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8WUZ4bVke1B+YNfXgCddtJyPKjBhFS1fdXaXbZcRffbGFaDrRizFI0gq6y95Sw56
	 n9m/C4m6Uk/zw52jv9uFeqHeqL/4YAKpdHFejmbJTTBY6YaC/4mWOvylC1Qa/OIT7H
	 2ApiXcmqyHGSefdCeJ8P4HG3RHHyDffJW36X/ggozkNVnMhPGpzjW/i+KTq/+WKIzf
	 e6wGounDarywEwi7QStF04wjkw1vl2FmOhjwhvGWR0bu36CpSzsS+y5+Rvugvj0HSB
	 AF8IJNAjpMqAzfo8TbFVaFg1VmWPyUFQi4VIdkgWU18jG9uZAOrE3c0QH1PFhrn28s
	 Ax9PHnXB46tcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Date: Thu, 21 May 2026 09:53:58 -0400
Message-ID: <20260521135358.1280483-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521135358.1280483-1-sashal@kernel.org>
References: <2026051526-vastness-flattop-e72e@gregkh>
 <20260521135358.1280483-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253570-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 391F55A74EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 9a415cc53711f2238e0f0ca8a6bcc796c003b127 ]

In scx_root_enable_workfn(), put_task_struct(p) is called before scx_error()
dereferences p->comm and p->pid. If the iterator's reference is the last
drop, the task is freed synchronously and the deref becomes a UAF.

Move put_task_struct() past scx_error().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260511214031.AF5E9C2BCB0@smtp.kernel.org/
Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
[ kept `scx_init_task()` call site instead of `__scx_init_task()`/`task_rq_lock` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54621f6226886..5c1547df50130 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4814,10 +4814,10 @@ static void scx_enable_workfn(struct kthread_work *work)
 
 		ret = scx_init_task(p, task_group(p), false);
 		if (ret) {
-			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
 				  ret, p->comm, p->pid);
+			put_task_struct(p);
 			goto err_disable_unlock_all;
 		}
 
-- 
2.53.0


