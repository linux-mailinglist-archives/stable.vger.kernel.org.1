Return-Path: <stable+bounces-237940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEMBHRZ93mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25303FD373
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A5930ABDB9
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AB3F0770;
	Tue, 14 Apr 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="EVcpwaMG"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847203F0761;
	Tue, 14 Apr 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188506; cv=none; b=k+/Rx28XSKLaU9N2HAh2luMpYvnLsAcB3jU42Kk9JvUOZTSKHGT1DGveSQ6Bi6y/GguA71yIwkLn8vvfBEDIOGqwzH4HLMI27OdJeenkIkUUipW73geVHORB7hTUefpnoQ3CXaaFTwy69MHsJagJc8JVKYxlazJQjSAkaF0c0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188506; c=relaxed/simple;
	bh=eXgzNQ5NkrTlccsPQl4sSnY8VKcl5C1idp/vdgGBXrE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nwmSQqtK2fjO1s7IUj4pE4Lc2fmXux6m29re69F2TgsTRBpM0qpaEr7Wk+NvGHEDOGbcNfHsiS2/mz011FNg4UdMkrQA8rpMIDb6/4c1vAhe1fdxf0z/ZK0s1/b4B1/cC6UW4vGPw6iVJM8xoxNZDFrn7R56NB7bN+kbWsvShtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=EVcpwaMG; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4fwBR82LcbzRhRN;
	Tue, 14 Apr 2026 19:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1776188500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85XEBKhx6cTDaz8IDeylrot8K7WN+I3kjCByPByGfyI=;
	b=EVcpwaMG1C8aVYs3NjWVVKpCi2cK4ctar6dflLLXNe7giUvJy3RrigrTTzulSuTHt9jq2o
	jj8BLPlTqjUlprr0KSrnvzqXfFF2fAf7bhBWE6EVjmXeoQilTS2+pA9sgscMBgDr+RZyJe
	gRwMyhD1lvSSxfXsl9uXCfHow85N3rvepNZ7SLzp0sBTPpkl1nfhtT71J5KmXqZj98dOtK
	8Mfj+VRYsDJtVHEEwQtqP6w+17DSjc5tFQtSrbUo28BDwTrNJ/ed8RbXCLI8yRfzXXwhul
	gGwijFkER1DZb/o2x8omohDBJ+aCn8R8g06JEBI+XPfFH9p2A9dfs9fPllfAWA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 19:41:40 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: Regression Linux 6.18.22: ipsec stops working: reason: commit
 153d5520c3f9 "crypto: authencesn - Do not place hiseq at end of dst for
 out-of-place d.cryption"
In-Reply-To: <ad5yOgkiFfRzy9pz@laps>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de> <ad5yOgkiFfRzy9pz@laps>
Message-ID: <95595fd4ea019882aa6407917d404330@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237940-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,theori.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stwm.de:dkim,stwm.de:mid]
X-Rspamd-Queue-Id: C25303FD373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 2026-04-14 18:58, schrieb Sasha Levin:
> On Tue, Apr 14, 2026 at 06:52:22PM +0200, Wolfgang Walter wrote:
>> Hello,
>> 
>> with 6.12.18 ipsec stopped working for us. After reverting commit
>> 
>> commit 153d5520c3f9fd62e71c7e7f9e34b59cf411e555.
>> Author: Herbert Xu <herbert@gondor.apana.org.au>
>> Date:   Fri Mar 27 15:04:17 2026 +0900
>> 
>>    crypto: authencesn - Do not place hiseq at end of dst for 
>> out-of-place decryption
>> 
>>    [ Upstream commit e02494114ebf7c8b42777c6cd6982f113bfdbec7 ]
>> 
>>    When decrypting data that is not in-place (src != dst), there is
>>    no need to save the high-order sequence bits in dst as it could
>>    simply be re-copied from the source.
>> 
>>    However, the data to be hashed need to be rearranged accordingly.
>> 
>>    Reported-by: Taeyang Lee <0wn@theori.io>
>>    Fixes: 104880a6b470 ("crypto: authencesn - Convert to new AEAD 
>> interface")
>>    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>> 
>>    Thanks,
>> 
>>    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>>    Signed-off-by: Sasha Levin <sashal@kernel.org>
>> 
>> 
>> ipsec worked again. We use esn here.
> 
> Thanks for the report!
> 
> Could you please check if you see the issue with mainline?

Same problem with mainline: v7.0 brakes ipsec here.

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

