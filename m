Return-Path: <stable+bounces-224854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGLhGJSysmmYOwAAu9opvQ
	(envelope-from <stable+bounces-224854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:33:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5477271D2D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B1730F14FC
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B432D7DD7;
	Thu, 12 Mar 2026 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eUW/uwyE"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4214EC73;
	Thu, 12 Mar 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318472; cv=none; b=F+iOiV0gGZMNOaofiL5APswg4rzdIgkz/5USsxuA5JaOwkkC0x1Xpp5TtdsKu3lLrKgcaYQTve1jRIZtieKwNyhxlX96xHVUw1c22vO3ANt+8MlhsYkiDhdaUhU19HTBdUNvxXB9Pqb0g0M0RUM+x0L/iaPRBYOKWNOu/rECb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318472; c=relaxed/simple;
	bh=ieLHoto4+96APZSwNtBq+cq/bsSxRVVMPY9/iG19O+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AuHXb0mKGWQDYQrKmg5dhzFUAFHaNxhh1/0O1OwJ5Qgh2S9B7RrTwhykCcnSVkqxZEnV2wN/nk9aQE2NWrGwbD93EWH1pi5QRJk2uO4gQFY/Nac6eh9935+3l30MgjXyTFXkgXHqrL6CqFGMk97nTQY0whkfX3SKtd/dgaFoxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eUW/uwyE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=crT96uBlmju1P98PXOgVEI4VATCQ71GLj65C0UFT0gY=; b=eUW/uwyEN3Wi/+wuGdQ2KsYzvT
	Xt+u9p3SqGOxg5MreeQ5klBm85bcw4ycyZyh+hB/rjpSBquDDLaYv+7vGsLxMv2XvaLxm2SGsRWiz
	S0voa/JfMWaPFm1EetU28jpDUtHmzXallPsu5fV5InF0WEYQxU+kVu4UZhPPQOW/DZSjgYYk76fhr
	tZ3MvKXtNavpokrL74NjKNdDAti6/2GLza0+Ovvougto76MMsA2ZnBWqADC4poeo1ab5Ooc5VA2UF
	K6QEchqWzk0e/j+batObWLMVysw8jJHABM0mBa2Nf0mxtGmnrCQ9xXfL2oYg6AmWLeqK84v79wcl+
	pvoAivCQ==;
Received: from 177-136-93-197.vmaxnet.com.br ([177.136.93.197] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w0f8c-00EUa0-Rv; Thu, 12 Mar 2026 13:27:39 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Thu, 12 Mar 2026 09:27:28 -0300
Subject: [PATCH] usb: usbtmc: Flush anchored URBs in usbtmc_release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-usbtmc-flush-release-v1-1-5755e9f4336f@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M3QpAQBCG4VvRHJvaJYpbkYO1Pkz5awcpuXebw
 +fgfR9SBIFSnTwUcInKtkbYNCE/uXUESx9NmclKk1vLp3bH4nmYT504YIZTcNFXvjSwLoenmO4
 Bg9z/tmnf9wOqHm5mZgAAAA==
X-Change-ID: 20260311-usbtmc-flush-release-5d9c60e1a3ec
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guido Kiener <guido@kiener-muenchen.de>, 
 Steve Bayless <steve_bayless@keysight.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224854-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[igalia.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.006];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,9a3c54f52bd1edbd975f];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: D5477271D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When calling usbtmc_release, pending anchored URBs must be flushed or
killed to prevent use-after-free errors (e.g. in the HCD giveback
path). Call usbtmc_draw_down() to allow anchored URBs to be completed.

Fixes: 4f3c8d6eddc2 ("usb: usbtmc: Support Read Status Byte with SRQ per file")
Reported-by: syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a3c54f52bd1edbd975f
Cc: stable@vger.kernel.org
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/usb/class/usbtmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 2526a0e03cde..3d6daa8b748e 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -254,6 +254,9 @@ static int usbtmc_release(struct inode *inode, struct file *file)
 	list_del(&file_data->file_elem);
 
 	spin_unlock_irq(&file_data->data->dev_lock);
+
+	/* flush anchored URBs */
+	usbtmc_draw_down(file_data);
 	mutex_unlock(&file_data->data->io_mutex);
 
 	kref_put(&file_data->data->kref, usbtmc_delete);

---
base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
change-id: 20260311-usbtmc-flush-release-5d9c60e1a3ec

Best regards,
-- 
Heitor Alves de Siqueira <halves@igalia.com>


