Return-Path: <stable+bounces-235983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Oxr4KM+/3Gn5VwkAu9opvQ
	(envelope-from <stable+bounces-235983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:05:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052333EA2B9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75194305D5E8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B6346E56;
	Mon, 13 Apr 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WsxgqwXQ"
X-Original-To: stable@vger.kernel.org
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6626A1C4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074437; cv=none; b=e5wuRSG8/K62Hm6LHpeJzLxkbRzAYeWSj1igpxaKdanNS8obxlJVO75ZgxCBZC+WLKU85vs24Jwlc/pmO6kGFjglmBflrfosqDaepqX0Dca8nlQnM/bYh7F+NL4bK+EyVsC+Qf5s2lH1WJ3eIgyvh9QVEuhqmGyqQ/Hpkntblks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074437; c=relaxed/simple;
	bh=sWKe8HP0sJXd7QJHbXK3WGN04TBury/ZKJX233KBMoE=;
	h=Cc:Date:Mime-Version:To:Message-Id:References:In-Reply-To:From:
	 Content-Type:Subject; b=LGRiaqg3mAaZIXK1YfZyKwHFLcIZ9LCQU3Rdb2j/2ZI5NZ6jaz3hY5Go+GpBD7T7muwsZx1R3gYgLAq1e8pjw3lMdA+ytvSqOkzpN5ruIf8ElSLG8vd/k0EHIG38yFusPrsi78XKG2hCLX2n8u8W8oIIs5sKEaeGkd6AKjIcXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WsxgqwXQ; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776074428; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wXZHMvOtArXocx/kVEUqHny6lc21xP+IWbJSc6coTew=;
 b=WsxgqwXQIM/n9h/qLGIKmFZ6dejNsGjIsLiUNiozddvBoyM/JcruqqJgEkTforlEEaszDp
 pY1fNcO9YpdSb87fbGdaWG43LEf+qrvTDIysqcbbk0qQXSFIUup94LNqlXZudbdqZZUiLN
 mvqxnAOyf5mNPteLVH7iGAgmxcAWITXHo0c2qyNkqcz/yNEk2HaTmkVFfmT7X2eaUeoTWb
 e+z7NqlHrvl6++WQ4ChJ/BH2w26IQCRIi+u7JlyrsfhkEBsQ9g75UjtO/JC9vGCBS2BCUT
 RZbakSIFDCIswYZDI+dSjSJcnjtxMxwhQUKu2clHUh1HcV3JPe0diF9oPkBY7g==
Cc: =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, 
	"Jason Wang" <jasowang@redhat.com>, "Jiri Pirko" <jiri@resnulli.us>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <virtualization@lists.linux.dev>
Date: Mon, 13 Apr 2026 18:00:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: git-send-email 2.17.1
Message-Id: <20260413100013.32399-1-guojinhui.liam@bytedance.com>
References: <20260413034046-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260413034046-mutt-send-email-mst@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+269dcbeba+e9affb+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guojinhui.liam@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:dkim,bytedance.com:mid]
X-Rspamd-Queue-Id: 052333EA2B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 03:45:20 -0400, "Michael S. Tsirkin" wrote:
> GFP_ATOMIC allocations can and will fail. If using them, one must
> retry, not just propagate failures.
> Or just switch admin_vq->lock to a mutex?

Hi Michael,

Thank you for the review.

Regarding the suggestion to switch admin_vq->lock to a mutex:

The virtqueue callback vp_modern_avq_done() holds admin_vq->lock and
runs in an interrupt handler context, making it impractical to replace
the spinlock with a mutex directly.

I considered deferring the completion to a workqueue so we could safely
use a mutex, but since this is a bug fix destined for stable@vger.kernel.org,
doing so would introduce significant code churn (e.g., handling INIT_WORK,
cancel_work_sync during cleanup, etc.) and increase the risk for backports.

Therefore, using GFP_ATOMIC with the existing spinlock seems to be the most
minimal and safest approach for a fix.

However, just replacing GFP_KERNEL with GFP_ATOMIC isn't entirely safe
because of how virtqueue_add_sgs() handles allocation failures. If kmalloc()
fails under memory pressure with GFP_ATOMIC, the function falls back to using
direct descriptors. If there are not enough free direct descriptors, it
ultimately returns -ENOSPC.

In the current code, -ENOSPC is handled with a busy loop:

if (ret == -ENOSPC) {
	spin_unlock_irqrestore(&admin_vq->lock, flags);
	cpu_relax();
	goto again;
}

If the -ENOSPC is actually caused by a GFP_ATOMIC allocation failure under
memory pressure, this cpu_relax() loop will never yield the CPU to memory
reclaim mechanisms (like kswapd), potentially leading to a soft lockup.

To properly handle both actual queue-full conditions and GFP_ATOMIC failures,
I propose replacing cpu_relax() with a sleep (e.g., usleep_range(10, 100)).
This allows memory reclaim to run while we wait.

I plan to send out a v2 patch with this modification:

--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,11 +101,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
                return -EIO;

        spin_lock_irqsave(&admin_vq->lock, flags);
-       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
        if (ret < 0) {
                if (ret == -ENOSPC) {
                        spin_unlock_irqrestore(&admin_vq->lock, flags);
-                       cpu_relax();
+                       usleep_range(10, 100);
                        goto again;
                }
                goto unlock_err;

Does this approach align with your expectations for the fix?

Thanks,
Jinhui

