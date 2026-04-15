Return-Path: <stable+bounces-238064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDucCq5Q32nLRgAAu9opvQ
	(envelope-from <stable+bounces-238064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:47:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E531402220
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73B883060A33
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC631327A;
	Wed, 15 Apr 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsEnQhy8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A522561A2
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242855; cv=none; b=ivEdAYIKgALB9ms9v6iEhvNrKkOnt9hTuIUebzz5Z6V0FgHP5FNIqTIW7EH2Wqgig9mo7Ytd58HuVF7OTt/imT/N6FPGCmzJ3FQVT6+BIbBfWIzgDwHThcuJviMYfVDVNBNFxgNeny08rWKFj3O9/t77Oz8hWxWAwGl1fE0jeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242855; c=relaxed/simple;
	bh=lJ6ThLlEC5qIfLJ3GiWGSn2UDtZQp3g1MqucF6oNwZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA5paVklwAKycDKIntD45YzTNMi1x9A/EpVdxXstdpHc40WBktUBLi+AvSsFF9lhvVEscdMbCXGsK0x4FWDO7mKP/jshlyTXeYw9npvPvrUsztGQxJ6KwJbYHvxhuVWQbqadiwO1WyeyIN0qbWiQlpV8suyFbJuW11Pw1t/vuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsEnQhy8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso4054505f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242853; x=1776847653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhH84NXX33T2mx07NdMMkNioRpn5lPJ7BGqiQz9oSTU=;
        b=KsEnQhy8I/SUJIHCm33pUmPeCiNgEpk2gDeOh4ZtiOz6J7bDFOHC4vv2yE2VMOoQxB
         Egr/JcTbJA38vH0V5PCUF5+N3/RdlOYh9TG5/yiVg5a38K2IxLFFOHrXIE4Uzd5scBLD
         Q2SPGQFn/3zNcRvnVFSZhO5xMBPIPOKW3qQn8qPS+6inoz9/LU/mbwZdf2n9co5/jyva
         nHL4pVRmTGh77pLOiZ2zBkCGkvGQ89z19hN2dSaeTSyhfaW48G9DlDrlM7MFePpaH6Li
         Ma3ifDCU/GUArxzVmAS6h2uM4icUApTEDmsb44+fn99O5b4DbA+uZMqy/5+Cd5yR8FbE
         Tjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242853; x=1776847653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhH84NXX33T2mx07NdMMkNioRpn5lPJ7BGqiQz9oSTU=;
        b=pWYPTjEzqd1UlKFhXg3Zf2Y68ft1P4vMGFXDN0m5PQa2G8SU1tX+3JXoV1veV/L0ri
         QiGkyAfrwSQivAYRh4r7/XzsMC0eAcnCnkp7n7ggMOplem8ljtbhEyk2V09Cspeg7joF
         MsS204oRAzh1Tu7t2a3Pjcb6kj3MTMJLXAkFWrHZ82IY39KVbMBtkowUaK1t2CwzQtgg
         zjjCX2H/uDxxSYFEG1AzFw5tqu81AJb1qQnwk8ydqc/ZVT/2zzDW9YBN+F6Wjab8zADp
         G6RZnIDciuTiF5z756KRrjDbs/MVDi/mKDUp1DcV308B5Phv7p6J2jMSh9iIpnMwbVWy
         ITMA==
X-Forwarded-Encrypted: i=1; AFNElJ8BcWMbA0Uo5W7CYq3vvCx5XiqT+OrVOD/NcpmoQGHXZ4tTUEPHGVMcQMixxaB5Y/QpWMCH7L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7eZkVcQb/JgdOCzkcQHTCfNzZWwS34w/NO3xHHrhqXKcCqtX
	kPi9YEliM4Ds0vSKAd9tBJXK7gqsjrCXkJoJeP0pa3HDSTSr3cFXRuum
X-Gm-Gg: AeBDiesTqoZQkmPBD4NIKzmiYAB9p86OLD6nPuQNcurBQke8Z2obGGM62BvnAQ2nXxq
	0TCj6+fUBSht1BFK/A41Ob08113g/SqlMnN2F022ePLzjI5AwhZENe2+pIHYAwQzwGRmEdWxolx
	FlfSwqU9FCVtfPcudS5NMbNTb/gD6Z1+aC4EXO9T55egHiNwFbJ7ZpqAIeJhHsQLluoWiARq+rt
	P6lmTjNf0OkVSHD8CjZl1IWOiBJUeIseYtf8EC7RXnmynO+ZISJO4QgaaS4dxNsv8bDLlbwJ78T
	q20hjV51bwYgCYhIniilYCP/OIMjO0qUXXkmNA9xRdK1xpgwFbLkZYFV898ogwL0nd+Dj+dXdwF
	kpKOjTXoyYbuk9XhQTruQmFDOwctG8nhh0Yh4Ox0Z+BTMVgm3gnYYm66hIsPGp4xREpWvxWXbSE
	mZoR3dXK+KHjzgON0ot3M=
X-Received: by 2002:a05:6000:40cb:b0:43d:1c39:593c with SMTP id ffacd0b85a97d-43d642b6a52mr29169874f8f.30.1776242852517;
        Wed, 15 Apr 2026 01:47:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d665sm3372873f8f.7.2026.04.15.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:47:31 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:47:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
Message-ID: <ad9QoBHfCdJuYIw_@stanley.mountain>
References: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238064-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9E531402220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:39:59PM +0200, Alexandru Hossu wrote:
> OnAuthClient() accesses pframe without first verifying that pkt_len is
> large enough to contain a valid 802.11 management frame header:
> 
> - get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
> - GetPrivacy(pframe) reads the FC field at bytes 0-1
> 
> Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
> unsigned subtraction passed to rtw_get_ie() wraps around, causing it
> to scan well past the end of the buffer.
> 
> Add an early check against WLAN_HDR_A3_LEN before any pframe access,
> and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
> offset to guard the seq/status reads and the rtw_get_ie() call.
> 
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---

Looks good!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter



