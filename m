Return-Path: <stable+bounces-216222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCB3AM8tj2ksLgEAu9opvQ
	(envelope-from <stable+bounces-216222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:57:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93957136C9C
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8BF730090AC
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F25352936;
	Fri, 13 Feb 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpcE4MbX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C41684BE;
	Fri, 13 Feb 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991050; cv=none; b=SDPeDdaekcV4EpLeOfWN4s8t96iYkxBogEa1StLfy8Rjc/mUuJIVthycSsWJbJcidom9mhgcg9Ni8UBZFIubh14c5i9Ls3r2caExm9RfRhCkZON35wjQrIaM+toDWwT/gwcbP1C4UkG3FZIMqiNDwsjXLwp9UqRxh+cp9+s9+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991050; c=relaxed/simple;
	bh=DihnVKtd+BgR/KixSokzjM77GiLkRL/t78awVXxKzc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjY7U4m1EiYRDXkEwrJ885dCC6/Pc8YypNbEMtmH5AgHJXmu7ESgk7QrsW/bcggyMZEZqyIUNtUmaoOGduVfsGHuP5COY0ehHm9iNpb0YvpaOKKFNzvcnbUnRm9Uhm6+sJJwAmLWGHKA8mgJjYZAj9zzR54s53scUFGvRRYxJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpcE4MbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B567C116C6;
	Fri, 13 Feb 2026 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770991050;
	bh=DihnVKtd+BgR/KixSokzjM77GiLkRL/t78awVXxKzc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpcE4MbXDvN/6eLtCl8WB4w9PyU9+J5y7eo0laSJTTYL163+RSDl36rpLCTaPhlag
	 OvXajNkXCLlB74L/H/3NMDNroZ7sGMcqFYwlSh3kjuEwyWsWVPPu8xkVf9ArzwnhUj
	 oXtK+WlX42C8NAWJYRmvVdIw0j4ARw9rWT7hHuCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.6 09/25] crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req
Date: Fri, 13 Feb 2026 14:48:35 +0100
Message-ID: <20260213134704.224560801@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134703.882698935@linuxfoundation.org>
References: <20260213134703.882698935@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216222-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,loongson.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 93957136C9C
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

commit 14f86a1155cca1176abf55987b2fce7f7fcb2455 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -550,8 +550,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 



