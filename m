Return-Path: <stable+bounces-211787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC7UJ9m6eGmasgEAu9opvQ
	(envelope-from <stable+bounces-211787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:17:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77C94BF9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9C23019147
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A62BEFF8;
	Tue, 27 Jan 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wDd3Vr2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08421ADC7
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519831; cv=none; b=VZsHbO7uLM3Csz3Gir9wWa5nTZ0DNrwYDiNyTwqcni7iuRq2wYTXLc1iFhh0v0izNsN1iHSPBxw4mnY77i/eJoji+KAE9XYcnL4juyipOG0OQU735NDkqdVafeYklYA0p7PSYmBx5qpR0aQ5BhHIvSfpFzMCAOidkRcwossP+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519831; c=relaxed/simple;
	bh=Vq43WcnlFXUPtkrBPZxQgtg4YfWXBtxX+PAKUvyn4do=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i6XmoQZfs6/LtXF/xvhZAYvq1TUEcs6EFKX43VtGa3c3P3vo4IitFKzibXjdYPPTxJgM5SM7tI0ft3m9tGNmSH2liqAiriqlH0Wqg/X4ZAsPV6f5pkGIFsO4ieV+3li+c6GEj7SdUa3ls/ljyj/16VQvT+BGq0uB6nM9YUMBicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wDd3Vr2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E2C116C6;
	Tue, 27 Jan 2026 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519831;
	bh=Vq43WcnlFXUPtkrBPZxQgtg4YfWXBtxX+PAKUvyn4do=;
	h=Subject:To:Cc:From:Date:From;
	b=wDd3Vr2LAnLZcaSS0BXiKsi9MhT+AQHPb3INBK/0EQd4yu193skYGNStUEX0zVLOj
	 lj5NjunsyM4eeupy96EgzZbJ8eIq0j7HZeqJv+o3pbDRc5DRXOXLIaecC6xY2lmyx7
	 7Tl9waoGPhKH/TRkcfqBuZCcYw6uBwe+s1MgMN/4=
Subject: FAILED: patch "[PATCH] ksmbd: smbd: fix dma_unmap_sg() nents" failed to apply to 5.15-stable tree
To: fourier.thomas@gmail.com,linkinjeon@kernel.org,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:16:57 +0100
Message-ID: <2026012757-wrench-plated-2f22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211787-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B77C94BF9
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 98e3e2b561bc88f4dd218d1c05890672874692f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012757-wrench-plated-2f22@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98e3e2b561bc88f4dd218d1c05890672874692f6 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 9 Jan 2026 11:38:39 +0100
Subject: [PATCH] ksmbd: smbd: fix dma_unmap_sg() nents

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index f585359684d4..8620690aa2ec 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1353,14 +1353,12 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 
 static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
 			      struct scatterlist *sg_list, int nentries,
-			      enum dma_data_direction dir)
+			      enum dma_data_direction dir, int *npages)
 {
-	int npages;
-
-	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages < 0)
+	*npages = get_sg_list(buf, size, sg_list, nentries);
+	if (*npages < 0)
 		return -EINVAL;
-	return ib_dma_map_sg(device, sg_list, npages, dir);
+	return ib_dma_map_sg(device, sg_list, *npages, dir);
 }
 
 static int post_sendmsg(struct smbdirect_socket *sc,
@@ -1431,12 +1429,13 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 	for (i = 0; i < niov; i++) {
 		struct ib_sge *sge;
 		int sg_cnt;
+		int npages;
 
 		sg_init_table(sg, SMBDIRECT_SEND_IO_MAX_SGE - 1);
 		sg_cnt = get_mapped_sg_list(sc->ib.dev,
 					    iov[i].iov_base, iov[i].iov_len,
 					    sg, SMBDIRECT_SEND_IO_MAX_SGE - 1,
-					    DMA_TO_DEVICE);
+					    DMA_TO_DEVICE, &npages);
 		if (sg_cnt <= 0) {
 			pr_err("failed to map buffer\n");
 			ret = -ENOMEM;
@@ -1444,7 +1443,7 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 		} else if (sg_cnt + msg->num_sge > SMBDIRECT_SEND_IO_MAX_SGE) {
 			pr_err("buffer not fitted into sges\n");
 			ret = -E2BIG;
-			ib_dma_unmap_sg(sc->ib.dev, sg, sg_cnt,
+			ib_dma_unmap_sg(sc->ib.dev, sg, npages,
 					DMA_TO_DEVICE);
 			goto err;
 		}


