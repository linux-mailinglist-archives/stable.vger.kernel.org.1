Return-Path: <stable+bounces-216049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OoRJNUFj2ltHQEAu9opvQ
	(envelope-from <stable+bounces-216049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:07:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB55135735
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 651A2301060B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C133067C;
	Fri, 13 Feb 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJD5xfBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512A212550
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980817; cv=none; b=KxGpsmDew5i93y0yW0VYOx1NFRfBYXYGsC8cB2lks5M9YFrKcCEQYWjgDEcvI1/suoWFSpS78Ygj9RmQnYkRD8YxZJ4Obxm2gCiV5aUJnNvZCkQ/YkfYC4mTLUJOEN4Fj4jTCH37Ey9n3UHQCEWFbFOZ7bFW2pudPyv6nL2CLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980817; c=relaxed/simple;
	bh=WeXlhS6xdwcX5Q8escgCLndwGZckOARmCLWfgTjNrww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PdI3Q1BxqeNZipLMx4SXfsPK7BC3yjaBs7zNV43yE/g9IhGmlS9XCFsXBUyGL57Id088PJLL+L4ihv3KsVnaVirXy0IVKGhjJYdV5GOCQ8jJK+wZAI+ej3i1lv+XjOw0fD1CmArngBsWKHmpOp1OGPlViWPt7Aw3bkCB/zcnwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJD5xfBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4373AC116C6;
	Fri, 13 Feb 2026 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770980817;
	bh=WeXlhS6xdwcX5Q8escgCLndwGZckOARmCLWfgTjNrww=;
	h=Subject:To:Cc:From:Date:From;
	b=OJD5xfBQSIBRG7ZkEmdmcmdsiifr8TLV3U5/Ag8aQVfsr6AY1f9YIHV8uDpoA6k8L
	 63tORg7zltN9e+GSclsSSDbLxLJE/7T/f8KFGe1GcaOjrWXl7MY6P4yVF2csiu+c82
	 C1LxP5Z3GteLGOnjPSGLSXMQkMe6GP+jWJmmZyY4=
Subject: FAILED: patch "[PATCH] crypto: virtio - Remove duplicated virtqueue_kick in" failed to apply to 5.10-stable tree
To: maobibo@loongson.cn,herbert@gondor.apana.org.au,jasowang@redhat.com,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 12:06:45 +0100
Message-ID: <2026021345-delivery-dealing-7b00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216049-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EEB55135735
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 14f86a1155cca1176abf55987b2fce7f7fcb2455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021345-delivery-dealing-7b00@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14f86a1155cca1176abf55987b2fce7f7fcb2455 Mon Sep 17 00:00:00 2001
From: Bibo Mao <maobibo@loongson.cn>
Date: Tue, 13 Jan 2026 11:05:55 +0800
Subject: [PATCH] crypto: virtio - Remove duplicated virtqueue_kick in
 virtio_crypto_skcipher_crypt_req

With function virtio_crypto_skcipher_crypt_req(), there is already
virtqueue_kick() call with spinlock held in function
__virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
function call here.

Fixes: d79b5d0bbf2e ("crypto: virtio - support crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 1b3fb21a2a7d..11053d1786d4 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -541,8 +541,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 


