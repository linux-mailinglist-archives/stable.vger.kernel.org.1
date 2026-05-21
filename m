Return-Path: <stable+bounces-253595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aONNB1UpD2paHQYAu9opvQ
	(envelope-from <stable+bounces-253595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:48:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7F5A8A01
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9667630327E3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB342EA173;
	Thu, 21 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoALMLLa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9123BCEE;
	Thu, 21 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376111; cv=none; b=WEXtWcWOcabrQUcqv95QsyvI4gs3nyc3DwLkds+DwhzK+czxOKHy5xQuPEXGs7oo4W/91cmVGs3YOrvCDkbLD4VIHRIYO7j3+Udr7IkBkRGMuFCUVSRbfaiw9OVSFhZqt4Rg7TIoCsdiLRCHS2luV/XWWHtFg8S85+NXZI+lvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376111; c=relaxed/simple;
	bh=jb34L8VcwgEauQgJyCRvP26vEIKsWar8YNnCNAzos48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmU7iYQZ1FTYqj0pUjgFoh3zdsCJRqb6Ut3rpN6jRENob90buoeMGFaJo6B7+40CT0XAkmIgNv+OU/nePiUIccqeWitFkbegssTXk6m39CZZA5SktgWchxHBP7ZSHctFnd2e5pC4QAqjVO4PnlWrS6FhUr/0emwtEfSQ9gKJ/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoALMLLa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7D31F000E9;
	Thu, 21 May 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376109;
	bh=wsI2JSu5ZVhkCKTuqMWxdeMbkee5Xrcr6HitnmGytsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YoALMLLayXF0ALUJvhkhFGoFdVzju9pBQKZMMfkOBY48EHv/+PMq+wOzBeBqkMvC0
	 jEGDLzN8o0T7QQ3GUJMV4ikUHeahRD4XwiXH92JXVwOjph81ijCfSWUwgcg3cvsKyK
	 Y2geeg1mQ6qS6kum/uKa3560VFHIx7G0blOOAX7SK1NowOLYgaVbTZyrjRF2k7PzkW
	 B7EypWUyjFPpZt78Ef8xaKU+2f/XK+YqCeThLk6NoFXjUIFakoLvcIkSssGZL67w5W
	 ix6zomjqCftYvNKIywzx+6rQbCy+KEhxLYNot1coSDpeC/lvV+7GqgrU2TE3070n5i
	 A9qkc1KqCRB7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: nihaal@cse.iitm.ac.in
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: fix potential use after free in ipc_imem_cleanup()
Date: Thu, 21 May 2026 08:08:28 -0700
Message-ID: <20260521150828.851544-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519064028.60992-1-nihaal@cse.iitm.ac.in>
References: <20260519064028.60992-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253595-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E5F7F5A8A01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: iosm: fix potential use after free in ipc_imem_cleanup()

This commit reorders ipc_imem_cleanup() so that ipc_task_deinit() runs
before ipc_protocol_deinit(), so a tasklet observed mid-flight does not
dereference protocol memory that has already been freed.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> index 1b7bc7d63a2e..a3353af6960c 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> @@ -1256,8 +1256,8 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
>  	ipc_imem_device_ipc_uninit(ipc_imem);
>  	ipc_imem_channel_reset(ipc_imem);
>  
> -	ipc_protocol_deinit(ipc_imem->ipc_protocol);
>  	ipc_task_deinit(ipc_imem->ipc_task);
> +	ipc_protocol_deinit(ipc_imem->ipc_protocol);

[High]
Does this reorder fully close the cleanup race, or only the narrow window
between the tasklet and ipc_protocol?

The MSI handler ipc_msi_interrupt() remains registered throughout
ipc_imem_cleanup(); ipc_release_irq() / free_irq() is only invoked later,
from ipc_pcie_resources_release() after ipc_imem_cleanup() has returned.

Once ipc_task_deinit() returns, ipc_imem->ipc_task->ipc_tasklet has been
kfree()'d:

void ipc_task_deinit(struct ipc_task *ipc_task)
{
	tasklet_kill(ipc_task->ipc_tasklet);

	kfree(ipc_task->ipc_tasklet);
	...
}

If the modem fires an MSI in the window between ipc_task_deinit() and
ipc_release_irq(), can the path

  ipc_msi_interrupt()
    -> ipc_imem_irq_process()
      -> ipc_task_queue_send_task()
        -> ipc_task_queue_add_task()

still dereference ipc_imem->ipc_task->ipc_tasklet (now freed) and call
tasklet_schedule() on it? Once kfree(ipc_imem->ipc_task) executes, the
q_lock and queue array are also freed.

The only attempt to quiesce the IRQ producer before this point is
ipc_imem_device_ipc_uninit(), which is best-effort: it is skipped when
ipc_pcie_check_data_link_active() returns false, has roughly a 30 ms
timeout, and does not call synchronize_irq().

This race appears to predate the patch (the freed-tasklet use-after-free
after ipc_task_deinit() was already reachable from the live IRQ handler),
so it is not introduced by the reorder. Would it be worth calling
ipc_release_irq() (or free_irq() / synchronize_irq()) before
ipc_task_deinit() / ipc_protocol_deinit() so that no MSI can schedule new
work against freed resources?

>  
>  	kfree(ipc_imem->ipc_task);
>  	kfree(ipc_imem->mmio);
-- 
pw-bot: cr

