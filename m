Return-Path: <stable+bounces-22918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC685DF19
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14268B2B7FB
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D67EEEF;
	Wed, 21 Feb 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWZLFfRr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64D7EEE4;
	Wed, 21 Feb 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524963; cv=none; b=SCl+uipp59KBksRGo3gNzcJ0it2xvF92QOIBTLRnUf8OayFXau+pVs5Nh3+C7KOM3ajCo210hOrZaPTXiDFgUFyUUNrL4NeQDrF8VuAiSE5ADFNYsySNeNxKmGwv2Lcutf/lJFazoLtDcQE3PCdJQJpQyRg8S75qCvJ6MSbSoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524963; c=relaxed/simple;
	bh=3y/bl14743TIWb04DSaupAwcQMcl1bKGO/gYBBpeoMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpcoTGmlnISTC1E/A9bs//I2WpExHR09tLzkyRQhks8JBJVIAovpRgJUEC08VtLsUDeir7g7f/j0iEmRLzKQLP30RZEAKmplfi4GD+2d0ThgbvzClAm/lIR61alnWDiOZMsN8of9tyhJW+nBeCah4nFsiK5zNjn4qA44YUSiAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWZLFfRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69531C433C7;
	Wed, 21 Feb 2024 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524963;
	bh=3y/bl14743TIWb04DSaupAwcQMcl1bKGO/gYBBpeoMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWZLFfRrtSeEfCkJI/+S1KqhACOfkKR2VFokYIMYGPu4iT7IGwzUd92IYYNBK3E03
	 z4063cfXI5nF2IcURrMktobBzir1zQW82DSYmxxhv4zv3powHzMRAdaLmDX1nQS8D7
	 Ws7ofF4uo+Cpq7Y01XrqJ57+1tDl+WwqXFzDwwqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 010/267] crypto: api - Disallow identical driver names
Date: Wed, 21 Feb 2024 14:05:51 +0100
Message-ID: <20240221125940.385035917@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 27016f75f5ed47e2d8e0ca75a8ff1f40bc1a5e27 upstream.

Disallow registration of two algorithms with identical driver names.

Cc: <stable@vger.kernel.org>
Reported-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/algapi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -217,6 +217,7 @@ static struct crypto_larval *__crypto_re
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
+		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}



