Return-Path: <stable+bounces-217553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC2jLlIxmGkRCgMAu9opvQ
	(envelope-from <stable+bounces-217553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:02:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 606281669C9
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6713007CB2
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1323370FF;
	Fri, 20 Feb 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBJw7qDd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA962DE709
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581703; cv=none; b=X1rd1wsL3+8N1MpzECP2y8Z/VXOtVPvqv5Ghrz1A+6MBtFk77pA17vNk6yfk86PwmfzLQ5B4FBOCHkHLtO5Cwzyn/Aauv4amu9l8pNh/7kj5NUly4kK+eip0ff1OmPadc68VCRzgWZAzDt4CBerZkE55AJ2R57TyTEauNgjt9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581703; c=relaxed/simple;
	bh=jBiCFIM1TY02SGwb/3Blp2Q9yS47V/hSmv/Fa0fXxII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=r5JsYBuOuXoEG00CXoWOJ+zKwEX6aYbWmGAEWfu9IEKK/tI+gV0igcw15oV9qQTZv3guLgvvffn94ox1UwNdj1CfE70dc4cH05+LMaMF+MJvJhnEMb9TTolzkWqAgXMsB9xKTmeqdFnQ0IVp7A/g8cZxPVN7OMGLVCeS4YDEAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBJw7qDd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so683096a12.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771581701; x=1772186501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZqELffXnpUaFWM6UP5mc2YGiMCwLhF/CT8oL4oYv+s=;
        b=MBJw7qDdKjJiQA43VxYICMohOUFF7uroWwWNZa2AH/LRcwWdNBGQCfycCawd8vfU5V
         KmnZfnQM4Bf9KSmR4OG9rZGlm71cApSWOcA3GeDjzJk5xlQ17lCPUy03LYHy43arfu3n
         vwpmymlieHiQZboVNQ8cJVZlru6Ya7x1Dt3v9ERptGMOBm4pJDpO3eGwXa6CrzjJRBfU
         CJD7It9SPebdCvGoNE8mOq3vV1mQjuDD7rtVWj4rW7cvSCU/sNrPIjpmLft5tvrZNzD1
         +ZKm7JMmcATn2g/taF3JpTi+hR5Dw95vwK8fw3wiEmBTMgzfwMgUIngh7h/bkAhzU/25
         mWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771581701; x=1772186501;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZqELffXnpUaFWM6UP5mc2YGiMCwLhF/CT8oL4oYv+s=;
        b=YZSGaUjVNtcSmOdU3AakX4iIDsAoyLdWbWAHe/mIIYtY7KNq4hrc3naf08gqUX52Iv
         3NbySfMlf6OxqFw1ziHn61ZchtQjJEt8HVoTvrcIzhTu4IjJFwnQkFztbxpX6jmmCyBO
         NcNspZ/4aDWszGfcIxG9TdMYq47SWwHuzZljCLbVb9NEBINHFrJjsa27TSXa3+n0IE8l
         R/tUxwGHcA823K6kx+yrvVCFjS3/aHLK3bjK86xpFDpL/hUkX0bSdIVIjWYoWbuUnZpD
         SjvMJG8ZKMa9LxAVLYVpOpuygTHpqJCawTn+ouZnNOCkFQ9rcwZVyhsKYubFt3Phh9E4
         L8tg==
X-Forwarded-Encrypted: i=1; AJvYcCU1lJJPgrQSjwm3mXOxTo6X0/9pt3TtLOhVB7L23KVytoqSp05N1T3llh2uCT2qPjqAtQigTyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9k+E9qd6fdEQ4q0spl8n5frIAnN1y+P6+6txyguQHFPxsRAn
	OVZs/lJLyBnNtam8uFBzNWwWTZdZV0w1KxLusSgLxuxOw5euJT/JEH+G
X-Gm-Gg: AZuq6aLw7Pf/c2VYWtl4C+AkTJPB8qiQCqswAtVUrLcvbx846ydkjpmmzm4dCFpJZrL
	Ck9H9fSYVIdJCXn6dZDj//N7imZvDSQkE9m/qmRpW2Qfghq/kj1dmqCm+NyMCQxi6AHa+XPpQzr
	CuAbHq1Aq9Shi+pLHyDNh+w1ZWwiSAFAa875sE3+YGNZq9xkp9Glisz25ME/hPC3G2NPR8g3Lug
	c/bkpfXHKEDJDr+9VFY24h8tmZ2cCpYAj8bVirbzQZiTxdVwBnlbPxMjbj+nAAO37GRXbrzbNFI
	cf20ADFUsmcp5+pcIqRlxvRYjGYgPYJP2R3jc3Kb3/gO+GxW2pf/D4ww05PWRZ1wnVMvtJgNuB3
	wDi0eUgjak2CnP08vDEdCEzMF/+LdwLUIcG2GTY4i1Q6Ol/NRSAhztfQp2hr1JGoPGxTl8AEDgo
	YkgxffXZ+egAWftPiNK8PhQcf1fQrRLX7+lGFooiZ0ydlWBZn4DinqLUuEWGddrfns2mSFx65up
	w5s
X-Received: by 2002:a17:903:19eb:b0:2aa:f2f3:bcb0 with SMTP id d9443c01a7336-2ad50f9881fmr81093265ad.47.1771581701209;
        Fri, 20 Feb 2026 02:01:41 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.233.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa5cbsm244689215ad.9.2026.02.20.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:01:40 -0800 (PST)
Message-ID: <f4b1f5024a17098b29d4623f1a5c60519194ad52.camel@gmail.com>
Subject: Re: [PATCH v4] xfs: Fix error pointer dereference
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>, cem@kernel.org,
 djwong@kernel.org
Cc: brauner@kernel.org, neil@brown.name, jlayton@kernel.org,
 amir73il@gmail.com,  linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 20 Feb 2026 15:31:35 +0530
In-Reply-To: <20260220033825.1153487-1-ethantidmore06@gmail.com>
References: <20260220033825.1153487-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217553-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 606281669C9
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 21:38 -0600, Ethan Tidmore wrote:
> The function try_lookup_noperm() can return an error pointer and is not
> checked for one.
> 
> Add checks for error pointer in xrep_adoption_check_dcache() and
> xrep_adoption_zap_dcache().
> 
> Detected by Smatch:
> fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
> 'd_child' dereferencing possible ERR_PTR()
> 
> fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
> 'd_child' dereferencing possible ERR_PTR()
> 
> Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
> Cc: <stable@vger.kernel.org> # v6.16
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> v4:
> - Add blank line after closing brace.
> v3:
> - Add dput(d_orphanage) before returning error code in 
>   xrep_adoption_check_dcache().
> - Revert xrep_adoption_zap_dcache() change back to v1 version.
> - Include function names where error pointer checks were added.
> v2:
> - Propagate the error back in xrep_adoption_check_dcache().
> - Add Cc to stable.
> - Add correct Fixes tag.
>  fs/xfs/scrub/orphanage.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 52a108f6d5f4..33c6db6b4498 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -442,6 +442,11 @@ xrep_adoption_check_dcache(
>  		return 0;
>  
>  	d_child = try_lookup_noperm(&qname, d_orphanage);
> +	if (IS_ERR(d_child)) {
> +		dput(d_orphanage);
> +		return PTR_ERR(d_child);
> +	}
> +
>  	if (d_child) {
>  		trace_xrep_adoption_check_child(sc->mp, d_child);
>  
> @@ -479,7 +484,7 @@ xrep_adoption_zap_dcache(
>  		return;
>  
>  	d_child = try_lookup_noperm(&qname, d_orphanage);
> -	while (d_child != NULL) {
> +	while (!IS_ERR_OR_NULL(d_child)) {
>  		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
>  
>  		ASSERT(d_is_negative(d_child));

Okay, so you sent a v4. I gave my RB in v3 - also giving it here too.
Based on my reviews in the previous version[1], this looks good to me.
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
[1] https://lore.kernel.org/all/61386abf00c817e65ab70c994ed584fde339f9ed.camel@gmail.com/
--NR


