Return-Path: <stable+bounces-238115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOhrOKSE32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:29:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FDD4043F3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB520301073D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA481C01;
	Wed, 15 Apr 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzc3OiHV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E142989BC
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256158; cv=none; b=XYWUKpiS27x1DTUDFA8Kz2NjQQ4LpmPYBmv3u1MsH00CuH7EDjJWczmhOtNg01ltR91i8TMKr6L2UIBYc0raUAA6JGhyMKalrhH1/99/cyPyMhGlDJk0118MXVKHlbaTWc+p6pAJRTsaChTWFC2Da93X5hXUaAaU0HdbhjDpb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256158; c=relaxed/simple;
	bh=VwSycxcMvzv0AC7JXHVYs4iVgHpyetPvOhSnM1Rqphk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWPzt0q/oyIflTGWrvSQ0sfKS6Xjin1/MOPPuO/vCC3pOhmDMrhBB9qEkOz/nEH7RMFs7am0ewVQjKENG9f7v17B3HoA+bW/zQX0t8Z3M6LAak3H6FhrUSft0lksVmLeNHBAbsVzn9jw+SpcsugKwORHlpSsCuM9OWRXqhydLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzc3OiHV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso63243575e9.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256155; x=1776860955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xImlqYNPeJpJPui59NA6HzPPHUbHf/Rvw0mGCXMcsz8=;
        b=Tzc3OiHVUAGgyerrRi61Nlr7YW1F9ORxUxb0io/FeWt29nPF9OPU0iRmJ8eTrDWQSZ
         Ccs+FunZr8L2o69kNmNoyal9NGfloeE5kz6Vji+wb9a0YRPk94Or3N2FwfNyo5yLFqMK
         deNxtSLYJ9APj8ggaz608zXcj9iwAipVcH2ttNAgiKzy7/ITUhijxQReuR3ViQ76tLvN
         COpIgGUNls9CTSM/kD9p58XvLNNL5xeHjie3SGktjXGVxIx9dKpeeeFyQGE9s2uuOohD
         lv5I4DlHRW7MFrfR8R4rkCBSK4slzCl1MJps6JdlVJ6LGWC4v9oybxkLMXhvt/p8rp+l
         Fucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256155; x=1776860955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xImlqYNPeJpJPui59NA6HzPPHUbHf/Rvw0mGCXMcsz8=;
        b=kUN0YZu6jdyIcgnp4a835toxauRXda2R8H7QVbBw15zXDUk0Xo9fZqhw7PEt1nH9vt
         fwu+nQMGNzQGeTFxZqBSiGhgHtADkna2dPt3rm23pCCGIt/4L7rsCPeC1cm8SoFiCBVg
         ZbjtSL6boODPm03SwdaJkeQxwkHNB437KxTal3SuPI+yAhlq9/ybUwC3I89Hpj03tpvM
         bzD5ZAUEW2scGlNbgt1BOwSMZULv7azo3hmmeMisJ1JrDbA0I4DQeos2qZXE2g2Lchri
         MGdJ5gdV+XZCKdnZO0iHvq9wcI0POwBpSLBrix/EmwNwRoBlK3UuLsUB/uxWe2aMYcDI
         14nA==
X-Forwarded-Encrypted: i=1; AFNElJ9MdyRGDDOm9+4WaOtMDSVlbktAP465Op3vMVr56SphnMkZur2z20PQOUemOZOtVMJcPLJe3xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXIkMCNCPCc3A04l3x0iWKtUftYz/jKxnG5hoB3dU89k9Hgsc
	0i5dNr7WYil3xSffthoXpvhcZ3XIN2BsfeMVc1gbfNBnZdMz8MDu/aNf
X-Gm-Gg: AeBDieuWicOw0Ft+40hu37K6uXTU7V7DInB4Y0Msk5ummbw7HEB+etO/zcY5tVBMGCF
	pfyiRd85kISdk7l1Q3iZFDzNGnuBzeGMvuBDleSivzAAJgZYsOLGujYpI20hlcPnd5fZalrD+pu
	7mjLPCeTJg2exjlu2dQ+O+H2thNZhGNPTDQ2nKVjKcGi9EDXPGzeDx0jfI/ZE6kaLmsqq5e6SaZ
	3ifXf1oMDQL6TH7ZMH/qv7KMFDvgQqBsEAYNUFpsTQibrSm2Gmy1VzJZj1nvHf9MR+5K9KdCCLq
	b4a4wQxJ7U45cvwkzksRxeYLV3LvbiEdD2CqEH89nUNVnzUw+8ftkRSJETtioZTknNmTOJO9sGA
	ED52g9+ubtl2Vo09pu85jlqK/uyxFW/O8lqOCyJAxpvBnl0bmIxQibNi1WnVgU5Jjaxlw8vxVqG
	vVYn3GP5amclABXko8YRWNxccWs9+ogQ==
X-Received: by 2002:a05:600c:628b:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488d68603ffmr271059445e9.22.1776256155141;
        Wed, 15 Apr 2026 05:29:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d65asm4951177f8f.4.2026.04.15.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:29:13 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:29:10 +0300
From: Dan Carpenter <error27@gmail.com>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix remote heap information
 disclosure in issue_assocreq
Message-ID: <ad-ElrLRiFsee0By@stanley.mountain>
References: <20260415050302.9934-1-luka.gejak@linux.dev>
 <ad9TKjTLxDRwDyIy@stanley.mountain>
 <DHTO9P2GULIP.2VT8AWTTKPL8W@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHTO9P2GULIP.2VT8AWTTKPL8W@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238115-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D2FDD4043F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:55:48PM +0200, Luka Gejak wrote:
> On Wed Apr 15, 2026 at 10:58 AM CEST, Dan Carpenter wrote:
> > On Wed, Apr 15, 2026 at 07:03:02AM +0200, luka.gejak@linux.dev wrote:
> >> From: Luka Gejak <luka.gejak@linux.dev>
> >> 
> >> When building an association request frame, the driver copies the
> >> ht capability ie using the attacker-controlled pIE->length from the
> >> ap's beacon. If the ap provides a length greater than the size of
> >> struct HT_caps_element (26 bytes), it causes an out-of-bounds read
> >> of the adjacent heap memory (HT_info and network structures).
> >> This uninitialized or sensitive memory is then transmitted over the air,
> >> resulting in a remote heap information disclosure.
> >> 
> >> Fix this by clamping the length passed to rtw_set_ie() to the actual
> >> size of struct HT_caps_element.
> >> 
> >> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> >> ---
> >> ---
> >> Changes in v2:
> >> - Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
> >> - Allowed the line length to exceed 100 characters for better readability as requested by Greg KH.
> >> 
> >>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >> index 5f00fe282d1b..08e597bc0345 100644
> >> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> >> @@ -2954,7 +2954,9 @@ void issue_assocreq(struct adapter *padapter)
> >>  			if (padapter->mlmepriv.htpriv.ht_option) {
> >>  				if (!(is_ap_in_tkip(padapter))) {
> >>  					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
> >> -					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
> >> +					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY,
> >> +							    min_t(uint, pIE->length, sizeof(struct HT_caps_element)),
> >> +							    (u8 *)&pmlmeinfo->HT_caps, &pattrib->pktlen);
> >
> > You're being conservative and trying to work around the invalid
> > pIE->length, but in the case where the original code corrupts memory,
> > we're allow to just give up and return a failure.
> >
> > There are two other cases where we trust pIE->length in this function
> > and those need to be fixed as well.
> >
> > regards,
> > dan carpenter
> 
> Hi Dan,
> should I keep my approach as is or just return failure. I will fix other
> cases as well with whatever approach you consider correct.

You should return a failure.

regards,
dan carpenter


