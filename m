Return-Path: <stable+bounces-251153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMOuJBvwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C4593E2E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62D98306AD0C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C073A7850;
	Wed, 20 May 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QStOcYV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BA3403F4;
	Wed, 20 May 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297237; cv=none; b=iKFv9ZpJjiSgeQ7wXEA7UQFOpY/ilF48lHvGdbqyyV3d0xVEzvLt3q5MFnGjF52Ia+LoWNNpPhPkKeW82qBpo39y4M8NGmk6BOXo7yi7nOHNvhshrqLM4ofgjaGWLtyp9nD6m67/YfMSVP48s82tFkN3tjokLvKtSbcz+b6CGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297237; c=relaxed/simple;
	bh=O8Jbh6kdcqSVt+ycsUMStTAnBmHTnpOZ1rLAkmjNORU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ0QyoN6CMYfgnIaLNm4HCocpegypZKLuD9rOeI35KsmMLm5IwiuG4sbiZOTkLBRDcpLc4dsH9FUWUufiyswcHq7xcn0jABbis/G1htJVdqGc8/W5C1MPSxZg95YCARi0RUxKuPw5N/BA0F8vI/JP54d2OGy/9VqgqCw5b+eOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QStOcYV3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FC01F000E9;
	Wed, 20 May 2026 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297236;
	bh=wpgNKafX2g4cfLL9d7C9xbzWFlKCgSsrAVSLxE2VsIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QStOcYV3w0B8LSCv4z6mcklFJ13qioadWxU9s2ujfLjOAgCRWPLXULdTJGTB7LXlC
	 RIcWLBRmZGjipHY2cTAEkVgcvEKa+gIRtCWb6O/R9KKTOFY8nhgII4mtVQtAHM4AAH
	 Oq0ZTDPwTM4dfGEfTr5pV4W1Pm/hxUVezQg3z4QI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 7.0 1103/1146] powerpc/warp: Fix error handling in pika_dtm_thread
Date: Wed, 20 May 2026 18:22:33 +0200
Message-ID: <20260520162213.207351783@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251153-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,iscas.ac.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 208C4593E2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 108d7f951271cbd36ca36efc5e5d106966f5180c upstream.

pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
but fails to release it in error handling path. This could result in a
reference count leak, preventing proper cleanup and potentially
leading to resource exhaustion. Add put_device() to release the
reference in the error handling path.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 3984114f0562 ("powerpc/warp: Platform fix for i2c change")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20251116024411.21968-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/44x/warp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -293,6 +293,8 @@ static int pika_dtm_thread(void __iomem
 		schedule_timeout(HZ);
 	}
 
+	put_device(&client->dev);
+
 	return 0;
 }
 



