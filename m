Return-Path: <stable+bounces-235278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HR/Ja621mlxHggAu9opvQ
	(envelope-from <stable+bounces-235278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:12:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6F3C39F7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3C6301D4FF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027A37754E;
	Wed,  8 Apr 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tgLumnaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54336F41F;
	Wed,  8 Apr 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679146; cv=none; b=dAq+bFMIQu0H9kYVFovj/VyzxsU1oK8Mpc0PnrQuagxGye6fHbJ8z2q1CGKEkrB8an1bMewimd5rP5eNC6z2DpjfdbJ6HrfvTtC3aHntdqpGCyGdQ2S7VPr/etIea8NpKQP4RCLNLWRYA2UTtH5g+ExWtBn8DQrO4zqNq6JiS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679146; c=relaxed/simple;
	bh=jWtxorWDJl53Q0KzQv0WXS2TVhuItrBnYfd9ReIJmW8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ejfp4Fm+FSvdFDZDb9NIe39lu1TgwrtC1bs3Z553E2lZuD3eorlKzzOvn/Az/4kVDxOzVIRKhBNQ+lXxR+XvvbGLTkdQWD18JeQLXfP1ZZTams+FkZcIqOyCVjVCWXATtjSpqy+wJu0aFU4Ggevi7kmyh5GR5a40iAcGz8R5aHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tgLumnaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C85C19421;
	Wed,  8 Apr 2026 20:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775679146;
	bh=jWtxorWDJl53Q0KzQv0WXS2TVhuItrBnYfd9ReIJmW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgLumnaXpH345q8jT9Fjm5Jax/6HIDiasQn0qyheeqSLsR7CxefEmP+tDgUKZeeSs
	 ALNYHppWzlS34EcYXoUiGum5AO7eKjvSl6fH5E7XXE46xZOwSw0G3ToMz7WwlGuI8H
	 Q5TTxlsR9BmmPfQjTYiP+hsmQ8N5IRm8d5wro/YQ=
Date: Wed, 8 Apr 2026 13:12:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: tejas bharambe <tejas.bharambe@outlook.com>
Cc: Tejas Bharambe <thbharam@gmail.com>, "ocfs2-devel@lists.linux.dev"
 <ocfs2-devel@lists.linux.dev>, "mark@fasheh.com" <mark@fasheh.com>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>, "joseph.qi@linux.alibaba.com"
 <joseph.qi@linux.alibaba.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com"
 <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when
 VM_FAULT_RETRY
Message-Id: <20260408131225.a37cd581ca47b3512a4219bc@linux-foundation.org>
In-Reply-To: <JH0PR06MB6632F1A4381AB798FED980CE895BA@JH0PR06MB6632.apcprd06.prod.outlook.com>
References: <20260403035333.136824-1-tejas.bharambe@outlook.com>
	<20260403122947.2afc337b5333fb1990a78a65@linux-foundation.org>
	<JH0PR06MB66320ABCFAD8F239FE5112B2895CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
	<20260404175040.40a746040ddb0cb5ce347fe3@linux-foundation.org>
	<JH0PR06MB6632F1A4381AB798FED980CE895BA@JH0PR06MB6632.apcprd06.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0CC6F3C39F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 03:50:17 +0000 tejas bharambe <tejas.bharambe@outlook.com> wrote:

> Hi Andrew,
> 
> You're right, I missed that scenario.
> 
> The inode can be freed if the file descriptor is closed after mmap() and munmap() races with the fault handler.
> 
> I can do one of the following:
> 1. I can skip the trace firing when VM_FAULT_RETRY is set as I did in v1. It was changed to v4 after Joseph's suggestion to keep traces.
> 2. If we want to keep traces, we can use ihold()/iput() as shown below:
> 
> ihold(inode);   //pin inode
> ret = filemap_fault(vmf);
> trace_ocfs2_fault(OCFS2_I(inode)->ip_blkno, ...);  // safe, refcount held
> iput(inode);  //release inode
> 
> 
> Which approach do you prefer?

Well, that's down to the ocfs2 maintiners.  Me, omitting traces doesn't
sound good.

But we should consider performance implications - this is a fairly hot
path and iget/iput are a little costly.  Perhaps there's a way to avoid
the iget/iput if tracing isn't enabled.  As long as we handle the case
where tracing get enabled immediately after we've done the

	if (tracing enabled)
		iget()


> Thanks,
> Tejas
> ________________________________________
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Saturday, April 4, 2026 5:50 PM
> To: tejas bharambe <tejas.bharambe@outlook.com>
> Cc: Tejas Bharambe <thbharam@gmail.com>; ocfs2-devel@lists.linux.dev <ocfs2-devel@lists.linux.dev>; mark@fasheh.com <mark@fasheh.com>; jlbec@evilplan.org <jlbec@evilplan.org>; joseph.qi@linux.alibaba.com <joseph.qi@linux.alibaba.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>; stable@vger.kernel.org <stable@vger.kernel.org>
> Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
> 
> On Sun, 5 Apr 2026 00:30:14 +0000 tejas bharambe <tejas.bharambe@outlook.com> wrote:
> 
> > Following is my response for question posted on https://sashiko.dev/#/patchset/20260403035333.136824-1-tejas.bharambe%40outlook.com
> >
> >
> > No. For ocfs2_fault() to be executing, the file must be open and
> > the process holds an active file descriptor. The inode's lifetime
> > is tied to the file's reference count, which remains held by the
> > file descriptor for the duration of the fault handler. munmap()
> > can free the VMA (decrementing vm_file's refcount) but cannot
> > free the inode as long as the file descriptor is open. The faulting
> > thread cannot call close() while it is inside the fault handler,
> > so the inode is guaranteed to outlive the trace call.
> 
> I don't think that's the scenario which Sashiko is suggesting.
> 
> Suppose userspace does
> 
>         fd = open(...);
>         p = mmap(fd, ...);
>         close(fd);
> 
> Now, that mmap is the only ref against fd.
> 
> Now, suppose that userspace does munmap() while another thread is in
> the fault handler.

