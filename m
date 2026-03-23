Return-Path: <stable+bounces-228730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kICvK6ZTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 601772F5559
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 299DE301C042
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59343AF678;
	Mon, 23 Mar 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RX8rYyeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964A2D9ECB;
	Mon, 23 Mar 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276967; cv=none; b=jOYo5mgJuXY4FNqfabzZoIbe5nno5g02kEdw2sYQOrGnRXwEjyqDOqVL8LHXUqmR6Z/yvdV++EMICdJcR69sn2pSnepnzAZC3QVBMla6TIBKDZgd1X5LfFQYaX6z+hHw+VFH6+f9VKaChTIdJzSmvQci3yPPCgFKi9YeIxwNNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276967; c=relaxed/simple;
	bh=/PtlGsepgMg3+t4TRhp6R7c3i41gdMiQ4k1r+k7imSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRiOjrdTs1DMQhLLya/kO6Ulq0mNhONCMPvuNMN9gCV+FbZuILUj2snxGQcY0cL+hQyBNNAAa4tEw3YFpyAB2w7E8Vcbn9vz6EN8TQMtg3CySTs3qmnfXKNt4MdSoiZ24cvovs0DqwB/iSPFg2s9+ujLiiXOLbteE9Yn9BxeYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RX8rYyeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17245C4CEF7;
	Mon, 23 Mar 2026 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276967;
	bh=/PtlGsepgMg3+t4TRhp6R7c3i41gdMiQ4k1r+k7imSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RX8rYyeOPpCCLuo1ZA/jq60nQ7hrnL7W7p/OpKnoDMbkfg1uAt+ea7+ovA2mlj6jO
	 UZOf0sNWuHXOKrCBr4qhK1rAD67ot4PoUl8VsCsj44fOFsHtb3zy+9XkEeJHx9nYE5
	 mHKrXX9lvrIo3kui6L5M3C6QADFCnpysnwbautG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 271/460] crypto: atmel-sha204a - Fix OOM ->tfm_count leak
Date: Mon, 23 Mar 2026 14:44:27 +0100
Message-ID: <20260323134533.144934535@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228730-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 601772F5559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit d240b079a37e90af03fd7dfec94930eb6c83936e ]

If memory allocation fails, decrement ->tfm_count to avoid blocking
future reads.

Cc: stable@vger.kernel.org
Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ adapted kmalloc_obj() macro to kmalloc(sizeof()) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-sha204a.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -52,9 +52,10 @@ static int atmel_sha204a_rng_read_nonblo
 		rng->priv = 0;
 	} else {
 		work_data = kmalloc(sizeof(*work_data), GFP_ATOMIC);
-		if (!work_data)
+		if (!work_data) {
+			atomic_dec(&i2c_priv->tfm_count);
 			return -ENOMEM;
-
+		}
 		work_data->ctx = i2c_priv;
 		work_data->client = i2c_priv->client;
 



