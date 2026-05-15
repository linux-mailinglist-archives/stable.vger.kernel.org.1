Return-Path: <stable+bounces-248122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBUEMJBEB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-248122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:06:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E8552AEA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6330230A068D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7253E009D;
	Fri, 15 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohq7QSwT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5230568A;
	Fri, 15 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860929; cv=none; b=Kaz9N0oY9B+qDOqWTqVFGGTygZgokKthMifbvRa5kpHzZwDk52HGlDn1EKGDIxrB5ueZ6HNqX0PIOB+PUSnI7hcT9v4ZWVagYbMyFGcVIthEChCWCVswLIWSnQQ1gCPG2eociZQmmQt8rZ9jKxOHaQ9r/fO5q9EO35ef1/vcQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860929; c=relaxed/simple;
	bh=9BvwSi/rzvHggpuM937P64kCQoF/i4nA5Ooxi3nArHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSGLN3zUTCBXfpLttUSnxAm3z0QZWoaT+wCImb1CRUY9j5eazeOEsXXvhUcZfrp99r5WyjjTBq9nTL8hC9VwRcQ0fb8sNxwyyd5y7prhzkkbN4G6UlJJk+eHdlBgZp4PIQ+KgJOFl5KXCcM1vWpdmkAmQVUPTpVVeUcQO0ZwrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohq7QSwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0ADC2BCB0;
	Fri, 15 May 2026 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860929;
	bh=9BvwSi/rzvHggpuM937P64kCQoF/i4nA5Ooxi3nArHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohq7QSwTPe0x5g+vKDBY5ETwzuZQUkFW+sEz6NbMFjaSf4hAa03qO5ZlaqzQQZdbk
	 Tk/XRLK8EJqAhaK6ZMF9KQKQmGAJNBr4PMpA9tFH41HU8mQwAJ+HeTtH+Wi+WElMi1
	 EJWh0aJsiGIkPBYcaYUJb97TxbrQfI18bUpF7hZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Garry <john.g.garry@oracle.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 133/474] scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails
Date: Fri, 15 May 2026 17:44:02 +0200
Message-ID: <20260515154717.910388360@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D19E8552AEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248122-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

commit 1e111c4b3a726df1254670a5cc4868cedb946d37 upstream.

If device_add(&sdkp->disk_dev) fails, put_device() runs
scsi_disk_release(), which frees the scsi_disk but leaves the gendisk
referenced. The device_add_disk() error path in sd_probe() calls
put_disk(gd); call put_disk(gd) here to mirror that cleanup.

Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Cc: stable@vger.kernel.org
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20260330014952.152776-1-yangxiuwei@kylinos.cn
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3727,6 +3727,7 @@ static int sd_probe(struct device *dev)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		put_disk(gd);
 		goto out;
 	}
 



