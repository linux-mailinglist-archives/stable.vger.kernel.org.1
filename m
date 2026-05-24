Return-Path: <stable+bounces-254002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IES+LX+tEmoJ2wYAu9opvQ
	(envelope-from <stable+bounces-254002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 09:49:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBB5C1A33
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 09:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DCC2300DDDC
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84B36A02F;
	Sun, 24 May 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEuwohUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AD23A562
	for <stable@vger.kernel.org>; Sun, 24 May 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779608953; cv=none; b=iFy0iiUFWG1SS52VXu8fVfbDbXsXrJM3d00qBDawVfqnuNwfMkrKTLeZclm382yV14eYGSdfU4YwxaSBvhyzLRw4zRtFULpLe0uakg5BkUfxc1hM3Q0Ik0JO1xFYCOdQLgI935/P4jPuPMHJMFfwC8aitBiNYLxLLQeywLnuBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779608953; c=relaxed/simple;
	bh=w3GyaXOKkKvLzK7c4V/rn3jVlhkCTZ4qzh+NDvYWL1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7nzenlxM/qPAIQ/6E7OrICVn1SdEfUZ48Ss1EYuMPPI/ZNDS3AxNylZxYthoavScwKSsnFpJEykkwHPvcjf6TLmYye74rkj5vreu86Bsw/1Txo16lh40bMfAu5Jdy6hSCaRf6k4/+DHgXEiZb45NF9tCq4qm/jBnKF73UI7Uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEuwohUl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso74671775e9.2
        for <stable@vger.kernel.org>; Sun, 24 May 2026 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779608950; x=1780213750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3GyaXOKkKvLzK7c4V/rn3jVlhkCTZ4qzh+NDvYWL1s=;
        b=ZEuwohUlq//qm672pP0EHDjIitCqhOXyhsIQH7fbY13kZYRvjipzueVPCGfKz7k+iY
         6Va+5skbfAUBgi0k1xMPbvzJdiSqhNmcj1smHmBvbxmVTxMdTp/wx2OczUb2tvwCr91L
         mssszuoNEaNk2J9opY0eURK7YZihdojsYnR7bP3nx3gCEC36ahJlFKTcNJsf6kXLGH1C
         5eW1eOn3AgXwK+eYmDFDBJgHLECWJHt+HZfNG8XBbfbn/bQLGn7S3GOqFPGwUWuillpG
         TF0aZp0kWCgs5iDe3f6Ywjds2df/qbPPJ9Zoj1tL/bm4lJV8tH8O8+xUd0aDqHL31AjF
         Pwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779608950; x=1780213750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3GyaXOKkKvLzK7c4V/rn3jVlhkCTZ4qzh+NDvYWL1s=;
        b=nEPebpss6rVvfjfhNtkaapWftYW7gS3/IF3DMCe+X43DUdVUKL/XsmgRqZsV6gP3AH
         bRRnLypLUFZnXnPORRwXaj93Fcrog0J59r/GxCh20FItg5L4baWDJOx2Q1ZMYpPpXZCN
         ykcNSpdyBh7SrXy5FIr3MIaumJcK1r5SCBSPBwSFkLsWmqh+/RwFcT6cOvIOqsloPTaw
         rwc7sIbO/QnZeXTBbktWztuTfiQBC7KEL+jxqSa1TaqUBInvQ20+DihIt1Uh+SA8fggw
         rgcfdrhEt4cqSzLEqOwAUbZEsr1U7vtXy9WmgAAbVGNGKKGPsPB2Ej1b4btHm2mUzTlL
         KMtw==
X-Forwarded-Encrypted: i=1; AFNElJ8f2MviuYRO7TEGbMNsPVxzB2CiPi/mQVdcWVlVp6aVAgtFD9avFxpu5j0d4qpj+M0f/54VmB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqAzjhTWFW0cysnVbg88yBM9qV86QOf3kkRMzHL4SWOjQVHVK
	3924xNHXGLyaQNDtccOea1/WTDHtjDDfF4Wv0Rb/4baNKl9GaUyHu7mxn66FzOHnNcY=
X-Gm-Gg: Acq92OEk1ZkNIeV9RGONthayjFzNJ1aFanUXiUr6p1O+FKbv4SJ9uSeSeXiED3SbDYF
	g3+A1NAx9j6yqoTi/SNC/K2qh4ahTkwtse5jScgp7xDBPJWw9w69hbNhWJa5Ia5S1qglLp8QudC
	gctyeQMBm/TnXVUsyV6I3S84foTkKXXcb0toVq+ArLVE1ielhBRTF1q8ORX1b3KrGlChDUyotcF
	vKRJy/rYwPq/xZWgqxYjEyhKtnh2q/z+uq+7C9yTKAMTvINn64bRunq3qniReChaZ+7qeZJ0mRn
	GZG5TJ/nhkQDm3mpIwvWrAIAbtPqt70t5YCbJrUvdKo71H8MVD7txDKCSkANG7eNeQimC1we1A3
	rd5hFyWAPswhjfYBjXm+SZNSSfqx46t32U0st0KcRuUNbh0NTt8zAwKAD0jv79xMRfjWqAuCBoB
	TWxf5b0VDOImxfubycq10i/2U3AHq46dnqCX8EtH5A/w2AIiv4LrHT/zz44ES5iYRCrG34xKENE
	9qbbkwKd1JFkMEnVVYzef8D5ffH3pYqbKmdasbeqkk3kTMEIFrRtm/oVrFK/MMrnF+wX+mxvHWL
	lmElzR5b//Uvqb2OsQLF7MbSiVBf
X-Received: by 2002:a05:600c:4ecc:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490426d4d7fmr160170825e9.17.1779608949829;
        Sun, 24 May 2026 00:49:09 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b3e0-e401-c487-9725-5e6f-67f3.310.pool.telefonica.de. [2a02:3100:b3e0:e401:c487:9725:5e6f:67f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904179826dsm75306345e9.2.2026.05.24.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 00:49:08 -0700 (PDT)
Date: Sun, 24 May 2026 09:49:07 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: entry: use byte load for KASAN VMAP stack shadow
Message-ID: <ahKsgJ4qT7zC5Isz@unknown748F3CBA5068>
References: <20260522211503.25219-1-kmehltretter@gmail.com>
 <CAD++jLnhONOMn=7hG-EC_uB80nxXfAnRMuZC2xoJjf2Xzcaiuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jLnhONOMn=7hG-EC_uB80nxXfAnRMuZC2xoJjf2Xzcaiuw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254002-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmehltretter@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 20BBB5C1A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:08:57AM +0100, Linus Walleij wrote:
> Please put this patch into Russell's patch tracker.

Done: https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9475/1

Thanks,
Karl

