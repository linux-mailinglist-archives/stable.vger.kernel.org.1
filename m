Return-Path: <stable+bounces-248739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D4aCadSB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F2554702
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B1531C4691
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0C4BC030;
	Fri, 15 May 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pTXGbyIv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8D3F86F7;
	Fri, 15 May 2026 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862506; cv=none; b=M9JXFZ0EbwOxaXXOOBoWO15uG3/ZnWr8RvlmGKVHhi7lccrNzdCImMY4zB6oMjSkbqImE+n1eHA8AJtyfuPsPCtryTk+0sli+UkqkAJIghYdMRC68NFD+nGMJt/Wp25XLfnIFz6vgURcmwpfNbsspcdyGcXNvLLo/tPfd6wE8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862506; c=relaxed/simple;
	bh=PlVrb7taUt8Qz5Xdf735/oB3zNi6x4p7HmcGWGQuZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmL3Xv7AmV048cZB169HDXRWdWS5rqGbxVkUuDaEvxlcrmPA1n+qWMMr8IYMSRMrGeahPA6JWdvOWm1INjHO9JrUDURoY8sOyy9dPCj2BaQQllXxhjmOkwPUHRbF/DpRtUVnN/dB6Q/qyGokO/7il2HWuXu4EZSSd07+TR2B3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pTXGbyIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B130C2BCC7;
	Fri, 15 May 2026 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862505;
	bh=PlVrb7taUt8Qz5Xdf735/oB3zNi6x4p7HmcGWGQuZiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTXGbyIvQaNdOBePEO1KsPKaOceeEVmE7lE721bCAycn7xsoIfHvuVUDUMBwrxo/D
	 9MEmcNBU0rtKhpSLImc49kn841+LO5q9ROxzNilnOaLWBRrPp0LaC/Wmx5r8icSBfm
	 B5rhd7RiomKzLDsBQ6uEL/PcxwG+XugxZNZydF9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan ODonoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 073/201] media: iris: Fix use-after-free in iris_release_internal_buffers()
Date: Fri, 15 May 2026 17:48:11 +0200
Message-ID: <20260515154700.116356333@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A08F2554702
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248739-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

commit f27cfdcfc916bb59297825805f4c3499f89f9e76 upstream.

The recent change in commit 1dabf00ee206 ("media: iris: gen1: Destroy
internal buffers after FW releases") introduced a regression where
session_release_buf() may free the buffer. The caller,
iris_release_internal_buffers(), continued to access `buffer` after the
call, leading to a potential use-after-free.

Fix this by setting BUF_ATTR_PENDING_RELEASE before calling
session_release_buf(), and reverting the flag if the call fails. This
ensures no dereference occurs after potential freeing.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/lkml/aYXvKAX3Pg3sL37P@stanley.mountain/#r
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Fixes: 1dabf00ee206 ("media: iris: gen1: Destroy internal buffers after FW releases")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/iris/iris_buffer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -582,10 +582,12 @@ static int iris_release_internal_buffers
 			continue;
 		if (!(buffer->attr & BUF_ATTR_QUEUED))
 			continue;
+		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
 		ret = hfi_ops->session_release_buf(inst, buffer);
-		if (ret)
+		if (ret) {
+			buffer->attr &= ~BUF_ATTR_PENDING_RELEASE;
 			return ret;
-		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
+		}
 	}
 
 	return 0;



