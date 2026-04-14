Return-Path: <stable+bounces-237927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEKeATdz3mndEQAAu9opvQ
	(envelope-from <stable+bounces-237927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBA3FCCC4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713193055411
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907C25F7A9;
	Tue, 14 Apr 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="nkiGu7nw"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (email.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF03B2BA;
	Tue, 14 Apr 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186106; cv=none; b=nBkUJG+M15jkCw7bjeXP6E6fFI41RuK/MwSyn0gpmIe/83Wp6Z7jqI2RUZTf8+G3/ev4iydStnK5lQN0ooNN5kHJigIM4b2Iq4z9zLc89K+ieNUN/M7KrHmQpPuXBj3ThwYJS3kSQ9OtlTZRb9D+G0X+UmmYeWBT+YEieumXJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186106; c=relaxed/simple;
	bh=gHZPrFG3LDG8oEy7CnrVaWDUBCHJqWi6pduHY7Kh2CI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oGR9QXzUXqXY4kz61ZE+kKo33z3SLWjGT1/FNYQ7jPApu9VHR5HtHST+5pM9JfFxaPLdP3U6BMyk2UGrhmGwrEMzAzXMMe0wxco9DIBiLTkZ1TlzBnoQDSiKZCBzWqNEa44w/1tFUUdaQDkXp2EM+IwIjZ7V0awN1cNVKJU9IS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=nkiGu7nw; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4fw9LG6Y52zRhRN;
	Tue, 14 Apr 2026 18:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1776185542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuUOAS4QDYX1ofYZk0KZwmhWyuzk2e3HVXTOLnsac5I=;
	b=nkiGu7nwQWrZPot5m/B1bt+b2iTsqif7ZOXuhKUMbbPGaiqSlQorpYXFE0wiLatCr4Qohr
	yAnconKVX/V/YYEKiZ51hoQbFROrEfRc8EOxpvIzmkoBXjDG3+8sors53TW+z8QcbpYsed
	sw90J1nmWt5+DyCMGbgT15Ad+eOwrXNgGe2AiLGySIzj7ScBgOfkJhovzDNjCYyHmXIEnd
	YB86FAWy8pTdPLBlONs/axd+tW9JyvVynfUvnrXmXHGjcsSMt4HRPrpie9fh3Y6648+JL9
	dQSWflQIEs/QD+QxTeIREtj3JbmzksEQhhJMr6C3CQ2H0wzbrFS3dya7N7G28g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 18:52:22 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, Sasha Levin <sashal@kernel.org>
Subject: Regression Linux 6.18.22: ipsec stops working: reason: commit
 153d5520c3f9 "crypto: authencesn - Do not place hiseq at end of dst for
 out-of-place d.cryption"
In-Reply-To: <2026041152-boaster-patrol-1918@gregkh>
References: <2026041152-boaster-patrol-1918@gregkh>
Message-ID: <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237927-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[stwm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,theori.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BEBA3FCCC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

with 6.12.18 ipsec stopped working for us. After reverting commit

commit 153d5520c3f9fd62e71c7e7f9e34b59cf411e555.
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Mar 27 15:04:17 2026 +0900

     crypto: authencesn - Do not place hiseq at end of dst for 
out-of-place decryption

     [ Upstream commit e02494114ebf7c8b42777c6cd6982f113bfdbec7 ]

     When decrypting data that is not in-place (src != dst), there is
     no need to save the high-order sequence bits in dst as it could
     simply be re-copied from the source.

     However, the data to be hashed need to be rearranged accordingly.

     Reported-by: Taeyang Lee <0wn@theori.io>
     Fixes: 104880a6b470 ("crypto: authencesn - Convert to new AEAD 
interface")
     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

     Thanks,

     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
     Signed-off-by: Sasha Levin <sashal@kernel.org>


ipsec worked again. We use esn here.

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

