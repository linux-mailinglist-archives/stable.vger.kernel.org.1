Return-Path: <stable+bounces-248129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNPoDIxHB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:19:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A7553045
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E8E30F65F8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA593E00BB;
	Fri, 15 May 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vycx60NJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB33A961B;
	Fri, 15 May 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860947; cv=none; b=iYYPd/hA5dMsjTBpLQNOqlkWE8Y5ERMzBK3aFvtaMWP2vsrGnDOMS/Hw9LgOHWpZN4/IzQRwx6USHdo5OgrfUK1+GWil6t9VVwXjvWOPR/RcJ9Nm08D96ym5jW5FyxEDxhrKu/IBVAbaf0JFTGMiJX94oy/MN2HYIprOZvo7Ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860947; c=relaxed/simple;
	bh=y5SfnvDnSxte7xZkoH/D0+9Qyqi5Zo4y/iGVgjaEVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAtKI28I+VIr6GHZpp7B46YV3PCfZZXsxq/c/64YTNVlHHDc6RPdH5BBsXDVlBQwKwj+SOxyHozKtwCzGXdf7AcWFhCSUnDTW0aYWPCFuRLue/qev1noBH5LKoITXAWHZ1cD3RzLi8EU5P/JuNzZExWklC3ppGpXp54SxBswpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vycx60NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB33EC2BCB0;
	Fri, 15 May 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860947;
	bh=y5SfnvDnSxte7xZkoH/D0+9Qyqi5Zo4y/iGVgjaEVdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vycx60NJ91+9RVkzahTmRvKIAHe0Z9xMqr5S6p0y5fRF4kDSReoMJvKL3AgkuXR0X
	 PH+mANkiaSP1OET8o7LFYNGvAHHHxhBuxpoVcS9AljVXmTauSsWw+2aBtWnKNBUVTx
	 BBvMLSi4HS25b9dUfY7irqjUwnNQ2QK5DCht4blY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	FengWei Shih <dannyshih@synology.com>,
	Chia-Ming Chang <chiamingc@synology.com>,
	Yu Kuai <yukuai@fnnas.com>
Subject: [PATCH 6.6 113/474] md/raid5: fix soft lockup in retry_aligned_read()
Date: Fri, 15 May 2026 17:43:42 +0200
Message-ID: <20260515154717.481752624@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AD2A7553045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248129-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,fnnas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-Ming Chang <chiamingc@synology.com>

commit 7f9f7c697474268d9ef9479df3ddfe7cdcfbbffc upstream.

When retry_aligned_read() encounters an overlapped stripe, it releases
the stripe via raid5_release_stripe() which puts it on the lockless
released_stripes llist. In the next raid5d loop iteration,
release_stripe_list() drains the stripe onto handle_list (since
STRIPE_HANDLE is set by the original IO), but retry_aligned_read()
runs before handle_active_stripes() and removes the stripe from
handle_list via find_get_stripe() -> list_del_init(). This prevents
handle_stripe() from ever processing the stripe to resolve the
overlap, causing an infinite loop and soft lockup.

Fix this by using __release_stripe() with temp_inactive_list instead
of raid5_release_stripe() in the failure path, so the stripe does not
go through the released_stripes llist. This allows raid5d to break out
of its loop, and the overlap will be resolved when the stripe is
eventually processed by handle_stripe().

Fixes: 773ca82fa1ee ("raid5: make release_stripe lockless")
Cc: stable@vger.kernel.org
Signed-off-by: FengWei Shih <dannyshih@synology.com>
Signed-off-by: Chia-Ming Chang <chiamingc@synology.com>
Link: https://lore.kernel.org/linux-raid/20260402061406.455755-1-chiamingc@synology.com/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6691,7 +6691,13 @@ static int  retry_aligned_read(struct r5
 		}
 
 		if (!add_stripe_bio(sh, raid_bio, dd_idx, 0, 0)) {
-			raid5_release_stripe(sh);
+			int hash;
+
+			spin_lock_irq(&conf->device_lock);
+			hash = sh->hash_lock_index;
+			__release_stripe(conf, sh,
+					 &conf->temp_inactive_list[hash]);
+			spin_unlock_irq(&conf->device_lock);
 			conf->retry_read_aligned = raid_bio;
 			conf->retry_read_offset = scnt;
 			return handled;



