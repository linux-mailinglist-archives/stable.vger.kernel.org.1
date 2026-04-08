Return-Path: <stable+bounces-233957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ds0JD6T1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:41:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF03BFBAD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3439E30416B2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA953D669E;
	Wed,  8 Apr 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njw4HuMx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADD325483
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669764; cv=pass; b=WOzSwo4arax4CMIOw8CldnjglDj9c/HrsPx/AEQsJnyGIUFBh6I8IeMNjnuRmEtYA/30Vc4LXwMkPtoJz7M9acDU7jKHtKv2T3MMCn0FU1bxSgVJdM9Am92zzy08AgwnH5AomRTe/PtCTTAvSSDmZTF9u7LG2lme/Am9YDVBrGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669764; c=relaxed/simple;
	bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M63vUEh0mk9ky8lRF/pPPd21RGIwidCXaNfLuJ0pUW4DoDeAXzBYiku0NFsyKG9Ftq5mIdRU3Cy6znxWT+vdnPchBYlspTDbaS/sN4x1H5IKu8aB7qDI7AR5crEH8DZnpRhLck9jbWD/eG+zawoUq46UPC/y84Ibpqmk+WEr7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njw4HuMx; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbff06e4a6so11164a34.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 10:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775669762; cv=none;
        d=google.com; s=arc-20240605;
        b=gy3y/7fPiRnAdyCfqDBYXigy8TXqf7sWijIRPQ+em10sosbD4Ahigme5w606hNShUr
         p6691aOM2kwyLiZzvgHkZhxdn5G5ITX107D40e6D0HxIJej2yVo7s3tP8dHcIDOR040X
         Nly6rqED0vDwKI8TTKbV93WBtCs0VFcZKF7kqE6EqJkDB8IMjz+W5WupnNbAQCLRcfyZ
         rHrW0wf6IsMbz/Ot+94oKsDz+4OXyIus5A6ESmqdyZuxezuC7WvkeVb5Do76gcmMBTCN
         YfrfUzZ7OMRF8kT7Tn4hhs9bEDSle23RJ055acWtg6XejJAL0nyW/A3uD9WnTW6kcUCY
         9FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        fh=1mEZBqUShBCgfWE1tR5fhZc4N4IGNM+Hfa2ZEkn5gTg=;
        b=KY+xfRipovCGWLOySQpVw+nmgbJP+LPxxTK32Rznnwu/2qxwsSYYWnKUXpk/axqIUV
         7s3t7crpfm17qFbEJ3pR3wfiiWQJwY83AP0fv3XWzCgJ8zy9bTpP8zIcfdokfkUThG+O
         y2Q0lHnAIIUnajdVpl1vGEEvXMN5dVN5yb9bwLomw+9YIeOY2AuqaoLvXLaWO1Kn+q5A
         y7dYA3a7H47wSzEtJejoP2m/HfpGSMXcmbpL/Dgnw1BfTx25F+cSgK3ANuSwhVSVAoLP
         uV7+D7dQIB6ZaIHUOqcweMpSaJFmU0amR4nYiNbWeSZ0caqW5lrXW2bQfSh78BN6m0Lx
         65mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775669762; x=1776274562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        b=njw4HuMxtsv/QsfaK/hV+JlfmS/9Rxv7xSDZdRaRRV7MH3tHyzlIJYpOJMmsFpN2pR
         93m4oHUNYzxUUL8jS1uaKr/aNp6DxYOZrC4LHJv5mNkiyU6B+34ItcB9RF+uz8xb9Qy9
         EawUB5N0too7FanC9vc59CRHZWvBrLYXyyNmjLVkDYUbNeVGG9JkDxybi2YiO5/H98uz
         KYezJoSQ9aB8VMX7Y7q5+4YFwNAECMXgYTGl6Ha4V+2jQcKZ608wl14TXqCpR99a+H2Z
         18Mvi1IQQt5AuO4+gWbkc8U/WoXwYeXa/CWjaObCIOs3Yk9CsbKfb66XMxjpEX2Flgrw
         yEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669762; x=1776274562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        b=ZYRrZPQom3QFpBx/+3932dT+xmPb/g4GSNKkYtEAFPhbpMOjtRi4w9tT+ZuAYc+b8F
         zyF8ScpBTEeOhNfZh+N+mbI3YZKh9hQnFWetGNQunCH0HpSD5pDTYoPk/yA1VOhNwFDc
         58WXr4W0iP4qhQjtrHAk3F8skpYTuVDj8zxEx6lIa0Fr9/OGi9lmKlPX4lwCIp4LAy6I
         IgVMSaCg2j9ou6ZRKLs6oOogyFPigAbSw6xAdBDnyQl27EGhg5hWa62B/8O/7u9VSBX4
         t58Uy6I8Bhe3QNjGIZ+MC3VH0NTABlrWbvqxPaVj242HOiEf1mr5JLeNtn3lq5mm94ZW
         Zl+g==
X-Forwarded-Encrypted: i=1; AJvYcCX38QrG7waS8QY8otcPYXUGZLhgwyAk+tsemQZHruTNOR96PF9PzpcEbg/Id7ohasMo+tKZE1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4VC5+XWSCr6pe3LxnOwtkSvyNb7uQdvdCoyOo5xwS4DWe9gZ
	gyaIUg7ekEsmXw6yGPU9NuQ844j6v/dlnifExYuwp6wVicPgG1uQVyDXHSBHrlyQ6g1Vhu6hLTu
	wryv162dl0JLKLxLcai2p1qZu6OVuDlA=
X-Gm-Gg: AeBDiesEdOuz49jfFcSg9rfsI8e0WJYvnNld4TdkrKRMknp0xAMCWSf3Gl+kk4z9mJW
	IYp0UvlgRNOV+x7la9CE6DwVgkIbTVh1mCCYHg97WvBEBRRPjhKlRR416dT0c3E/dIumOQ5jGDf
	pSv5JhIaK0SUUenYP/rZTZ9MoyC3fNb+JIyx7ejzMDTcqEHRcJ15wzAV4sVS2dNzM53wzBl2Rvw
	h1UzKH8REed4R60KhYA43A8orSBp8kel7lkyWG0IIzIgqowYHX+j/ai86OL2cibchaLdtkB43hK
	HRq4Fzuz7FXNmrE04k6JePABGl8ftbUV3vtTCQ==
X-Received: by 2002:a05:6820:993:b0:67e:d62:3d16 with SMTP id
 006d021491bc7-6821d237e42mr11887737eaf.12.1775669762076; Wed, 08 Apr 2026
 10:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403200732.497307-1-devnexen@gmail.com> <20260408170206.GI469338@kernel.org>
In-Reply-To: <20260408170206.GI469338@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 8 Apr 2026 18:35:51 +0100
X-Gm-Features: AQROBzA4BkTik_A3H5i7-wdhUsPm4frrCXgC-oXbnU0n_oa2ffPQRz-T3wexVIQ
Message-ID: <CA+XhMqzdEUiG4RHf8FbTZnS+dKwT+-MjEcMEStD1kA5Dc+d6VQ@mail.gmail.com>
Subject: Re: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()
To: Simon Horman <horms@kernel.org>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Shinas Rasheed <srasheed@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233957-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17CF03BFBAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On Wed, 8 Apr 2026 at 18:02, Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Apr 03, 2026 at 09:07:32PM +0100, David Carlier wrote:
> > napi_build_skb() can return NULL on allocation failure. In
> > __octep_vf_oq_process_rx(), the result is used directly without a NULL
> > check in both the single-buffer and multi-fragment paths, leading to a
> > NULL pointer dereference.
> >
> > Add NULL checks after both napi_build_skb() calls, properly advancing
> > descriptors and consuming remaining fragments on failure.
> >
> > Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> Hi David,
>
> I appreciate that this is on the fast path, and thus I expect it
> is performance critical. But this patch largely duplicates code
> already present in the same function. Would it be possible
> refactor things a bit - e.g. using helpers - to make the change
> a bit cleaner while not hurting performance?
>
> If so, I'd suggest splitting patch(es) that refactor the code
> from the patch that fixes the bug.
>
> ...

Yes, valid points, I'll submit the v2 tomorrow. Cheers !

